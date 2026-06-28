# KCD2 Packaging

Use this reference when turning loose mod files into a release-ready folder.

## Pak Format

KCD2 `.pak` files are ZIP-format archives renamed to `.pak`. Follow the official KM publishing page for folder layout and in-game validation. The docs verify Windows Explorer on Windows 10 and Total Commander for creating working archives, and warn that 7-Zip-created ZIP archives do not work for this purpose.

Do not use ad hoc `zip`, PowerShell, 7-Zip, or WinRAR commands as substitutes. Use either the documented desktop flow or this skill's script, which follows the same core approach as `altire-dev/kcd-toolkit`'s KCD PAK Builder: Python `zipfile`, deflated entries, relative paths from the chosen target directory, optional split archives, and optional nested-pak skipping.

For regular data mods:

- Pack loose files under `<mod_folder>/data/` into one or more `<mod_folder>/data/*.pak` files.
- Pack localization files under `<mod_folder>/localization/` or `<mod_folder>/Localization/` into language paks when needed.
- Do not leave release data as loose files in `data/`, `Data/`, `localization/`, or `Localization/`.
- Keep `mod.manifest` and optional `mod.cfg` loose at the mod root.

## Script Commands

The bundled script can pack, inspect, validate, and unpack:

```bash
python scripts/kcd2_pak.py pack /path/to/staging/data /path/to/release/mod/data/mod_data.pak
python scripts/kcd2_pak.py list /path/to/release/mod/data/mod_data.pak
python scripts/kcd2_pak.py check /path/to/release/mod
python scripts/kcd2_pak.py unpack /path/to/release/mod/data/mod_data.pak /tmp/mod_data
```

When packing from `<mod_folder>/data`, the archive should contain paths like `scripts/mods/<modid>.lua` or `libs/tables/...`, not `data/scripts/...`.

Useful options:

```bash
python scripts/kcd2_pak.py pack staging/data release/mod/data/mod_data.pak --max-size-mb 1900
python scripts/kcd2_pak.py pack staging/data release/mod/data/mod_data.pak --include-nested-paks
python scripts/kcd2_pak.py pack staging/data release/mod/data/mod_data.pak --compression stored
```

Default `--compression deflated` matches `kcd-toolkit` PAK Builder. `--compression stored` is available for no-compression archives when a workflow requires that interpretation.

## Final Packaging Procedure

1. Build the loose source tree under a staging directory such as `staging/<modid>/data/`.
2. Create a separate release mod folder with loose `mod.manifest` and optional `mod.cfg`.
3. Run `python scripts/kcd2_pak.py pack staging/<modid>/data release/<modid>/data/<modid>_data.pak`.
4. Repeat for localization paks when needed.
5. Run `python scripts/kcd2_pak.py check release/<modid>`.
6. Test in the published game, not only the modding tools build.

## Release Checklist

- `mod.manifest` exists and contains a valid lowercase underscore `modid`.
- Every `.pak` in `data/` uses a supported compression method: `deflated` or `stored`.
- Internal pak paths mirror game data paths.
- No unintended loose files remain under `data/`, `Data/`, `localization/`, or `Localization/`.
- `supports` matches only tested game versions when the mod changes major/shared files.
- If `mods/mod_order.txt` is used during testing, it includes this mod's manifest id.
