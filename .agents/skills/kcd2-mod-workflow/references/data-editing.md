# KCD2 Data Editing

Use this reference for XML table and extracted data changes.

## Source Discovery

When a repository contains extracted retail data, search these locations first:

- `Libs/Tables/`: extracted `Data/Tables.pak` table XML/TBL files.
- `Scripts/`: extracted `Data/Scripts.pak` Lua, XGEN, Skald, entity, and quest data.
- `official-wiki/`: offline official documentation, examples, and table descriptions.

Useful commands:

```bash
rg "item_id_or_stat" Libs/Tables Scripts official-wiki
find Libs/Tables -iname "*buff*.xml" -o -iname "*item*.xml"
```

## Table Patch Pattern

For table edits, prefer a mod-specific patch file instead of copying the entire base table. The usual path pattern is:

```text
data/libs/tables/<category>/<tablename>__<modid>.xml
```

Examples:

- `data/libs/tables/item/item__my_mod.xml`
- `data/libs/tables/rpg/buff__my_mod.xml`
- `data/libs/tables/rpg/rpg_param__my_mod.xml`

Use the base file as a schema/template. Keep only the entries needed for the mod when the table format supports patching. Do not edit generated extracted snapshots in place unless the user's goal is to refresh the snapshot itself.

## Safer Editing Rules

- Preserve XML element and attribute names exactly as shown in base files.
- Reuse existing ids and enum values only after confirming their meaning in nearby tables.
- Prefer additive entries with a unique mod id/name prefix for new items, buffs, presets, and localization keys.
- When modifying global constants or shared RPG tables, include a narrow `supports` range in `mod.manifest`.
- Check for collisions by searching for the same id across the mod and extracted base data.

## Validation

After editing, parse XML with a real XML parser where possible. Then package and inspect the pak to confirm the internal path starts at the game-relative root, not at the local source folder name.
