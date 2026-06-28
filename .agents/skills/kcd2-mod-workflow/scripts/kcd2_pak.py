#!/usr/bin/env python3
"""Pack, inspect, validate, and unpack ordinary KCD2 .pak archives.

The pack command follows the same core approach as kcd-toolkit's KCD PAK
Builder: write a ZIP archive with deflated entries and paths relative to the
selected target directory. The official KM docs still remain the source of
truth for folder layout and in-game validation.
"""

from __future__ import annotations

import argparse
import re
import shutil
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree

MODID_RE = re.compile(r"^[a-z_]+$")
DEFAULT_MAX_PAK_MB = 1900
COMPRESSION_BY_NAME = {
    "deflated": zipfile.ZIP_DEFLATED,
    "stored": zipfile.ZIP_STORED,
}
COMPRESSION_LABELS = {
    zipfile.ZIP_STORED: "stored",
    zipfile.ZIP_DEFLATED: "deflated",
    getattr(zipfile, "ZIP_BZIP2", -1): "bzip2",
    getattr(zipfile, "ZIP_LZMA", -1): "lzma",
}
SUPPORTED_COMPRESSIONS = {zipfile.ZIP_STORED, zipfile.ZIP_DEFLATED}


def fail(message: str) -> int:
    print(f"ERROR: {message}", file=sys.stderr)
    return 1


def iter_files(root: Path):
    for path in sorted(root.rglob("*")):
        if path.is_file():
            yield path


def is_relative_to(path: Path, base: Path) -> bool:
    try:
        path.relative_to(base)
        return True
    except ValueError:
        return False


def part_path(output: Path, index: int) -> Path:
    return output.with_name(f"{output.stem}-part{index}{output.suffix}")


def output_family(output: Path) -> list[Path]:
    part_re = re.compile(rf"^{re.escape(output.stem)}-part\d+{re.escape(output.suffix)}$")
    return [output, *sorted(path for path in output.parent.glob(f"{output.stem}-part*{output.suffix}") if part_re.match(path.name))]


def remove_stale_outputs(output: Path) -> None:
    for path in output_family(output):
        if path.exists():
            path.unlink()


def collect_pack_files(source: Path, outputs: set[Path], include_nested_paks: bool) -> list[Path]:
    files = []
    for path in iter_files(source):
        resolved = path.resolve()
        if resolved in outputs:
            continue
        if not include_nested_paks and path.suffix.lower() == ".pak":
            continue
        files.append(path)
    return files


def write_pak(output: Path, source: Path, files: list[Path], compression: int) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(output, "w", compression=compression) as pak:
        for path in files:
            pak.write(path, path.relative_to(source).as_posix())


def command_pack(args: argparse.Namespace) -> int:
    source = Path(args.source).resolve()
    output = Path(args.output).resolve()
    if not source.is_dir():
        return fail(f"source is not a directory: {source}")
    if output.suffix.lower() != ".pak":
        return fail("output path must end with .pak")
    if args.max_size_mb < 10 or args.max_size_mb > 51250:
        return fail("max size must be between 10 and 51250 MB")

    max_size_bytes = args.max_size_mb * 1024 * 1024
    possible_outputs = {output, *(part_path(output, i) for i in range(10000))}
    files = collect_pack_files(source, possible_outputs, args.include_nested_paks)
    if not files:
        return fail("source contains no files to pack")

    compression = COMPRESSION_BY_NAME[args.compression]
    chunks: list[list[Path]] = []
    chunk: list[Path] = []
    chunk_size = 0
    for path in files:
        size = path.stat().st_size
        if chunk and chunk_size + size > max_size_bytes:
            chunks.append(chunk)
            chunk = []
            chunk_size = 0
        chunk.append(path)
        chunk_size += size
    if chunk:
        chunks.append(chunk)

    remove_stale_outputs(output)

    written: list[Path] = []
    if len(chunks) == 1:
        write_pak(output, source, chunks[0], compression)
        written.append(output)
    else:
        for index, files_chunk in enumerate(chunks):
            target = part_path(output, index)
            write_pak(target, source, files_chunk, compression)
            written.append(target)

    for pak_path in written:
        print(f"packed {pak_path}")
    print(f"files: {len(files)}")
    print(f"compression: {args.compression}")
    print(f"relative root: {source}")
    return 0


def command_list(args: argparse.Namespace) -> int:
    pak_path = Path(args.pak)
    if not pak_path.is_file():
        return fail(f"pak not found: {pak_path}")
    with zipfile.ZipFile(pak_path) as pak:
        for info in pak.infolist():
            method = COMPRESSION_LABELS.get(info.compress_type, f"method-{info.compress_type}")
            print(f"{method:10} {info.file_size:10} {info.filename}")
    return 0


def command_unpack(args: argparse.Namespace) -> int:
    pak_path = Path(args.pak).resolve()
    output = Path(args.output).resolve()
    if not pak_path.is_file():
        return fail(f"pak not found: {pak_path}")
    output.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(pak_path) as pak:
        for info in pak.infolist():
            target = (output / info.filename).resolve()
            if not is_relative_to(target, output):
                return fail(f"unsafe archive path: {info.filename}")
            if info.is_dir():
                target.mkdir(parents=True, exist_ok=True)
            else:
                target.parent.mkdir(parents=True, exist_ok=True)
                with pak.open(info) as source, target.open("wb") as destination:
                    shutil.copyfileobj(source, destination)
    print(f"unpacked -> {output}")
    return 0


def read_modid(manifest: Path) -> tuple[str | None, list[str]]:
    issues: list[str] = []
    try:
        root = ElementTree.parse(manifest).getroot()
    except ElementTree.ParseError as exc:
        return None, [f"manifest XML parse error: {exc}"]
    modid_node = root.find("./info/modid")
    modid = (modid_node.text or "").strip() if modid_node is not None else ""
    if not modid:
        issues.append("manifest is missing info/modid")
    elif not MODID_RE.match(modid):
        issues.append("modid should contain only lowercase letters and underscores")
    return modid or None, issues


def check_pak(path: Path) -> list[str]:
    issues: list[str] = []
    try:
        with zipfile.ZipFile(path) as pak:
            for info in pak.infolist():
                if info.compress_type not in SUPPORTED_COMPRESSIONS:
                    method = COMPRESSION_LABELS.get(info.compress_type, f"method-{info.compress_type}")
                    issues.append(f"{path}: unsupported compression {method}: {info.filename}")
                parts = Path(info.filename).parts
                if parts and parts[0].lower() in {"data", "localization"}:
                    issues.append(f"{path}: entry includes top-level {parts[0]!r}: {info.filename}")
    except zipfile.BadZipFile:
        issues.append(f"{path}: not a valid zip/pak archive")
    return issues


def pak_dirs(mod_root: Path) -> list[Path]:
    return [mod_root / name for name in ("data", "Data", "localization", "Localization")]


def command_check(args: argparse.Namespace) -> int:
    mod_root = Path(args.mod_root).resolve()
    if not mod_root.is_dir():
        return fail(f"mod root is not a directory: {mod_root}")

    issues: list[str] = []
    manifest = mod_root / "mod.manifest"
    if manifest.is_file():
        modid, manifest_issues = read_modid(manifest)
        issues.extend(manifest_issues)
        print(f"manifest: {manifest}")
        if modid:
            print(f"modid: {modid}")
    else:
        issues.append("missing mod.manifest")

    for pak in sorted(pak for directory in pak_dirs(mod_root) for pak in directory.glob("*.pak")):
        print(f"pak: {pak}")
        issues.extend(check_pak(pak))

    for loose_dir in pak_dirs(mod_root):
        if loose_dir.is_dir():
            loose = [p for p in iter_files(loose_dir) if p.suffix.lower() != ".pak"]
            if loose:
                issues.append(f"{loose_dir.name}/ contains {len(loose)} loose non-pak files")

    if issues:
        print("issues:")
        for issue in issues:
            print(f"- {issue}")
        return 1
    print("ok")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="command", required=True)

    pack = sub.add_parser("pack", help="pack a directory as a KCD-compatible .pak")
    pack.add_argument("source", help="directory whose contents become the pak root")
    pack.add_argument("output", help="output .pak path")
    pack.add_argument(
        "--max-size-mb",
        type=int,
        default=DEFAULT_MAX_PAK_MB,
        help=f"split into -partN.pak files above this uncompressed size; default {DEFAULT_MAX_PAK_MB}",
    )
    pack.add_argument(
        "--include-nested-paks",
        action="store_true",
        help="include .pak files found below the source directory",
    )
    pack.add_argument(
        "--compression",
        choices=sorted(COMPRESSION_BY_NAME),
        default="deflated",
        help="zip compression method; default matches kcd-toolkit PAK Builder",
    )
    pack.set_defaults(func=command_pack)

    list_cmd = sub.add_parser("list", help="list pak entries and compression methods")
    list_cmd.add_argument("pak")
    list_cmd.set_defaults(func=command_list)

    unpack = sub.add_parser("unpack", help="safely unpack a .pak")
    unpack.add_argument("pak")
    unpack.add_argument("output")
    unpack.set_defaults(func=command_unpack)

    check = sub.add_parser("check", help="validate a mod folder for common packaging issues")
    check.add_argument("mod_root")
    check.set_defaults(func=command_check)
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
