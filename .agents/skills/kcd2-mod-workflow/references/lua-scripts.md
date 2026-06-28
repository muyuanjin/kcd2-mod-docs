# KCD2 Lua and Script Mods

Use this reference for Lua entry points and script data edits.

## Mod Lua Entry Point

A mod-specific Lua entry file can be placed at:

```text
scripts/mods/<modid>.lua
```

It is loaded after `scripts/main.lua`. Use the same `modid` as `mod.manifest`. Keep side effects explicit and scoped; avoid overwriting global functions unless that is the intended compatibility tradeoff.

## Searching Game Scripts

In repositories with extracted scripts, use:

```bash
rg "function_name|class_name|cvar_name" Scripts script_bind_2025_01_14 official-wiki
```

Common reference areas:

- `Scripts/Scripts/`: Lua systems and helpers.
- `Scripts/Entities/`: entity Lua files.
- `Scripts/AI/`: XGEN/MBT behavior data.
- `Scripts/Quests/`: Skald quest graphs and dialogue/module data.
- `script_bind_2025_01_14/`: official Lua binding HTML from modding tools.
- `lua_dump_state/`: runtime Lua symbols from `lua_dump_state`.

## Editing Strategy

- Prefer a new `scripts/mods/<modid>.lua` file for mod initialization.
- Override copied base Lua files only when a hook or mod entry script cannot solve the task.
- If replacing a base file, preserve the exact game-relative path inside the pak.
- Document compatibility risks when changing shared scripts, AI behavior trees, or quest data.

## Runtime Checks

Use `kcd.log` and search for `[Mod]`, Lua errors, script loading lines, and missing file warnings. If the mod is not mentioned, first check folder location, `mod.manifest`, and `mod_order.txt`.
