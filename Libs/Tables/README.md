# Libs/Tables

Game database tables extracted from the retail `Data/Tables.pak`.

## Source

| Field | Value |
|-------|-------|
| Pak | `Data/Tables.pak` |
| Game branch | `release_1_5` (`wh_sys_version` 1.5.5) |
| Pak timestamp | 2026-04-22 |
| Files | 1738 |

Re-extract when the game updates `Tables.pak`:

```powershell
# From repo root. Replace <GameRoot> with your KingdomComeDeliverance2 install.
python -c "import zipfile, shutil; from pathlib import Path; repo=Path('.').resolve(); pak=Path('<GameRoot>/Data/Tables.pak'); out=repo/'Libs'/'Tables'; shutil.rmtree(out, ignore_errors=True); out.mkdir(parents=True, exist_ok=True); z=zipfile.ZipFile(pak); names=[n for n in z.namelist() if n.startswith('Libs/Tables/') and not n.endswith('/')];
[ (lambda t: (t.parent.mkdir(parents=True, exist_ok=True), t.write_bytes(z.read(n))))(out/Path(n).relative_to('Libs/Tables')) for n in names ]; print(len(names), 'files')"
```

`Tables.pak` is an uncompressed ZIP. CryEngine Resource Compiler (`Tools/rc/`) can also unpack paks in modding tools.

## Layout (top folders)

| Folder | Role |
|--------|------|
| `ai/` | XGEN brains, SmartEntity templates, AI body tables |
| `rpg/` | Buffs, skills, perks, soul stats |
| `item/` | Item classes, equipment slots, presets, inventories |
| `combat/` | Combat tuning tables |
| `skald/` | Dialogue / Skald metadata |
| `ui/` | Menus, tutorials, achievements |
| `action/` | Player action maps |
| others | `animation/`, `music/`, `minigame/`, `Character/`, … |

Both `.xml` (source) and `.tbl` (compiled runtime) are included when shipped in the pak.

## Related repo paths

- Behavior trees: [Scripts/AI/](../../Scripts/AI/) (from `Scripts.pak`, separate pak)
- Modding notes: [MODDING_STACK.md](../../MODDING_STACK.md), [official-wiki/](../../official-wiki/README.md)