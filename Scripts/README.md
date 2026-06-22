# Scripts (extracted game data)

Lua scripts, Skald quest graphs, XGEN behavior trees, and entity scripts from retail `Data/Scripts.pak`.

## Source

| Field | Value |
|-------|-------|
| Pak | `Data/Scripts.pak` |
| Game branch | `release_1_5` (`wh_sys_version` 1.5.5) |
| Pak timestamp | 2026-04-22 |
| Files | 26415 |

## Top-level layout

| Folder | Count (approx.) | Contents |
|--------|-----------------|----------|
| `Quests/` | 24000+ | Skald concept graphs, dialogues, modules |
| `AI/` | 1400+ | XGEN / MBT behavior trees |
| `Scripts/` | 400+ | Lua gameplay code (`Scripts/Scripts/main.lua`, utils, systems) |
| `Entities/` | 140+ | Per-entity Lua (`Entities/...`) |

## Re-extract

```powershell
# From repo root. Replace <GameRoot> with your KingdomComeDeliverance2 install.
python -c "import zipfile, shutil, time; from pathlib import Path; repo=Path('.').resolve(); pak=Path('<GameRoot>/Data/Scripts.pak'); out=repo/'Scripts'; shutil.rmtree(out, ignore_errors=True); out.mkdir(parents=True, exist_ok=True); z=zipfile.ZipFile(pak); names=[n for n in z.namelist() if not n.endswith('/')];
import os
for i,n in enumerate(names,1):
 p=out/n; p.parent.mkdir(parents=True, exist_ok=True); p.write_bytes(z.read(n))
print(len(names),'files')"
```

## Related

- Database tables: [../Libs/Tables/README.md](../Libs/Tables/README.md) (`Tables.pak`, separate extract)
- Official docs: [../official-wiki/README.md](../official-wiki/README.md), [../MODDING_STACK.md](../MODDING_STACK.md)