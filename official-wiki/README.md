# Official Modding Wiki (Offline Snapshot)

[中文](#中文)

Offline mirror of Warhorse's **Kingdom Come: Deliverance 2** modding knowledge base on YouTrack.

| | |
|---|---|
| **Live wiki** | [https://warhorse.youtrack.cloud/articles/KM](https://warhorse.youtrack.cloud/articles/KM) |
| **Snapshot date** | 2026-06-23 |
| **Articles** | 78 `README.md` pages |
| **Images** | 320 `.png` files |
| **Source** | Exported from `KCD2-Modding` (YouTrack KM export) |

Internal links use **relative paths** (e.g. `KM-A-3 Structure of a Mod/README.md`) and work inside this folder tree. Open any article in a Markdown viewer or IDE preview.

## Start Here

| Topic | Local path | YouTrack |
|-------|------------|----------|
| Wiki home | [KM-A-1 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/README.md) | [KM](https://warhorse.youtrack.cloud/articles/KM) |
| Installing mods (players) | [KM-A-56 …/README.md](KM-A-56%20Installing%20mods/README.md) | [KM-A-56](https://warhorse.youtrack.cloud/articles/KM-A-56/Installing-mods) |
| Technical overview | [KM-A-36 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/README.md) | — |
| Modding tools | [KM-A-55 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-55%20The%20Modding%20Tools/README.md) | [KM-A-55](https://warhorse.youtrack.cloud/articles/KM-A-55/The-Modding-Tools) |
| Structure of a mod | [KM-A-3 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/README.md) | [KM-A-3](https://warhorse.youtrack.cloud/articles/KM-A-3/Structure-of-a-Mod) |
| Publishing a mod | [KM-A-58 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-58%20Publishing%20a%20mod/README.md) | [KM-A-58](https://warhorse.youtrack.cloud/articles/KM-A-58/Publishing-a-mod) |
| Lua + XGEN AI + Skald | [KM-A-15 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-19%20Modifying%20game%20data/KM-A-15%20Modifying%20LUA%20entities%20and%20scripts/README.md) | [KM-A-15](https://warhorse.youtrack.cloud/articles/KM-A-15/Modifying-LUA-entities-and-scripts) |
| Skald walkthrough | [KM-A-18 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-18%20Skald/README.md) | [KM-A-18](https://warhorse.youtrack.cloud/articles/KM-A-18/Skald) |
| Tourist mode example | [KM-A-31 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-29%20Quest%20System/KM-A-31%20Example%20Tourist%20mode/README.md) | [KM-A-31](https://warhorse.youtrack.cloud/articles/KM-A-31/Example-Tourist-mode) |
| Database tables | [KM-A-12 …/README.md](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/KM-A-12%20Database%20tables/README.md) | [KM-A-12](https://warhorse.youtrack.cloud/articles/KM-A-12/Database-tables) |

## Top-Level Sections

Under [KM-A-1 Modding Kingdom Come Deliverance 2/](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/README.md):

| Section | Focus |
|---------|-------|
| [KM-A-36 Technical Overview](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/README.md) | Tools, mod layout, publishing |
| [KM-A-37 Modding - Game Data](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/README.md) | Lua, RPG tables, quests, events, items |
| [KM-A-38 Modding - Visuals](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-38%20Modding%20-%20Visuals/README.md) | Character art, environment art, pipelines |
| [KM-A-83 Walkthroughs](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/README.md) | Step-by-step tutorials (Skald, cvars, items, RPG) |
| [KM-A-87 Modding rules](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-87%20Modding%20rules/README.md) | Workshop / publishing rules |

Standalone player guide: [KM-A-56 Installing mods](KM-A-56%20Installing%20mods/README.md).

## Related Docs in This Repo

Community summaries and extracted game data complement this snapshot:

- [MODDING_STACK.md](../MODDING_STACK.md) — brief stack overview with links back here
- [MODDING_EXPERIENCE.md](../MODDING_EXPERIENCE.md) — optional advanced research notes
- [Scripts/](../Scripts/) · [Libs/Tables/](../Libs/Tables/) — retail pak extracts (`release_1_5`)

---
<a name="中文"></a>
# 官方模组 Wiki（离线快照）

本目录是 Warhorse YouTrack 知识库 [**KM — Modding Kingdom Come: Deliverance 2**](https://warhorse.youtrack.cloud/articles/KM) 的离线副本，便于在无网络或需要全文检索时查阅。

| | |
|---|---|
| **在线原文** | [https://warhorse.youtrack.cloud/articles/KM](https://warhorse.youtrack.cloud/articles/KM) |
| **快照日期** | 2026-06-23 |
| **文章** | 78 篇 `README.md` |
| **图片** | 320 张 `.png` |

文内链接为相对路径，在本目录树内可正常跳转。

## 常用入口

- **玩家安装 mod**：[KM-A-56 Installing mods](KM-A-56%20Installing%20mods/README.md)
- **模组工具与环境**：[KM-A-55 The Modding Tools](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-55%20The%20Modding%20Tools/README.md)
- **Mod 目录结构**：[KM-A-3 Structure of a Mod](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/README.md)
- **Lua / XGEN AI / Skald 说明**：[KM-A-15](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-19%20Modifying%20game%20data/KM-A-15%20Modifying%20LUA%20entities%20and%20scripts/README.md)
- **Skald 教程**：[KM-A-18 Skald](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-18%20Skald/README.md)
- **Tourist Mode 范例**：[KM-A-31](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-29%20Quest%20System/KM-A-31%20Example%20Tourist%20mode/README.md)
- **数据库表**：[KM-A-12 Database tables](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/KM-A-12%20Database%20tables/README.md)

完整目录从 [KM-A-1 首页](KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/README.md) 进入；社区提炼见仓库根目录 [MODDING_STACK.md](../MODDING_STACK.md) 等文档。