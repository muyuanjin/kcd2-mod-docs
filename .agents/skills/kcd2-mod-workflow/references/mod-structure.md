# KCD2 Mod Structure

Use these rules for ordinary data mods.

## Root Layout

A manually installed mod is an unpacked folder under the game's `mods/` directory. The mod root normally contains:

```text
<mod_folder>/
  mod.manifest
  mod.cfg              # optional cvar settings
  data/
    *.pak
  Localization/
    <language>_xml.pak # optional text localization
    <language>.pak     # optional voiceover localization
```

Development work may use loose files, but the published game loads game data from `.pak` archives. The regular loose-file exceptions are `mod.manifest` and `mod.cfg`.

## Manifest

`mod.manifest` is XML. The important fields are:

```xml
<kcd_mod>
  <info>
    <name>Readable name</name>
    <modid>machine_readable_id</modid>
    <description>Description</description>
    <author>Author</author>
    <version>0.1</version>
    <created_on>2026-01-01</created_on>
  </info>
  <supports>
    <version>1.5*</version>
  </supports>
</kcd_mod>
```

`modid` is required in practice and should contain only lowercase letters and underscores. Use it consistently in `mod_order.txt`, table patch names, quest graph names, Storm patch names, and Lua mod entry files.

`supports` is optional, but if present it is matched as a string against `wh_sys_version`. Use broad tested patterns such as `1.5*`; avoid patterns that cannot match released version strings.

## Load Order

Without `mods/mod_order.txt`, Steam Workshop mods load first, then local `mods/` folders alphabetically. If `mod_order.txt` exists, only listed mod ids are loaded, in file order. Later-loaded mods win when two mods override the same game path.

## Override Paths

Files inside paks must mirror paths from the game's data paks. A file at the same game-relative path overrides the base file. For shared systems, prefer mergeable patch formats instead of full-file replacement.

Common special paths:

- `scripts/mods/<modid>.lua`: Lua file loaded after `scripts/main.lua`.
- `data/libs/tables/.../<tablename>__<modid>.xml`: table patch file.
- `data/quests/<modid>.xml`: concept graph loaded with main game graphs.
- `data/libs/Storm/storm__<modid>.xml`: Storm root patch merged with the game root.

Preserve path casing from the source data when editing existing files. When creating new files, match the examples from official docs or nearby extracted game data.
