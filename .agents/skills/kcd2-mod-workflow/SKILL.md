---
name: kcd2-mod-workflow
description: "General Kingdom Come: Deliverance 2 mod workflow support for parsing, inspecting, modifying, creating, validating, and packaging ordinary KCD2 mods. Use when working with KCD2 mod folders, mod.manifest files, mod.cfg files, Data/*.pak archives, Localization/*.pak archives, table patch XML files, modid-specific Lua files under scripts/mods, extracted Scripts.pak or Tables.pak data, mod_order.txt, or release-ready mod packaging."
---

# KCD2 Mod Workflow

## Overview

Use this skill to work on regular KCD2 data mods from source inspection through release packaging. Keep changes compatible with the game's mod loader: preserve game-relative paths, prefer merge/patch formats where available, and validate the final folder before delivery.

## Workflow

1. Identify the mod target: existing mod folder, loose source files, extracted game data, or a release package.
2. Read `mod.manifest` first when present. Treat `<modid>` as the canonical id; folder name may differ.
3. Locate relevant data by path: `data/`, `Localization/`, `mod.cfg`, `mod_order.txt`, and any `.pak` archives.
4. Choose the narrowest edit mechanism. Prefer table patch files and mod-specific script files over replacing large base files.
5. Package release data with a KM-compatible pak builder: either an official verified desktop flow or `scripts/kcd2_pak.py pack`, which follows the `kcd-toolkit` PAK Builder pattern.
6. Validate the result with the script in `scripts/kcd2_pak.py` and, when possible, game logs containing `[Mod]`.

## Load References As Needed

- For folder layout, manifest rules, load order, and release structure, read `references/mod-structure.md`.
- For XML table patches, item/RPG edits, and extracted table data, read `references/data-editing.md`.
- For Lua entry points and script overrides, read `references/lua-scripts.md`.
- For pak creation, inspection, and validation commands, read `references/packaging.md`.

## Common Tasks

### Inspect or Parse a Mod

List the root files, read the manifest, inspect pak entries, and summarize what game-relative paths are changed. Use:

When invoking bundled scripts, resolve `scripts/kcd2_pak.py` relative to this skill directory;

```bash
python scripts/kcd2_pak.py check /path/to/mod_folder
python scripts/kcd2_pak.py list /path/to/mod_folder/data/some.pak
```

### Modify a Mod

Work in a source directory rather than editing a packed archive in place. Unpack paks into a temporary working tree, change the smallest relevant file, then repack. Preserve original path casing unless a reference source proves the game expects a different path.

### Create a Mod

Create a root folder with `mod.manifest`, optional `mod.cfg`, and source folders mirroring game data. Use a lowercase underscore-only `modid`, and reuse that id in files that require it, such as table patches and `scripts/mods/<modid>.lua`.

### Package a Mod

Pack the contents of a staging `data/` directory into a release mod folder. The script writes paths relative to the selected source directory and defaults to the `kcd-toolkit` PAK Builder compression method.

```bash
python scripts/kcd2_pak.py pack /path/to/staging/data /path/to/release/mod_folder/data/mod_data.pak
python scripts/kcd2_pak.py check /path/to/release/mod_folder
```

After packaging, use `check` and `list` to inspect the archive. Do not package the `data/` directory itself as the top-level entry; package its contents so archive paths mirror the game's `Data/` contents.
