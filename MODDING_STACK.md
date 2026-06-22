# KCD2 Modding Stack

[中文](#中文)

KCD2 modding spans three cooperating layers. Official docs state:

> Entities and their basic functionality in KCD2 are scripted in LUA together with XGEN AI and Skald (so not everything is modifiable just via LUA).

Source: [Modifying LUA entities and scripts](https://warhorse.youtrack.cloud/articles/KM-A-15/Modifying-LUA-entities-and-scripts) ([local snapshot](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-19%20Modifying%20game%20data/KM-A-15%20Modifying%20LUA%20entities%20and%20scripts/README.md)).

## Layer Overview

| Layer | What it covers | When you need it |
|-------|----------------|------------------|
| **Lua** | Entity scripts, mod init, console commands | Entry point for most script mods |
| **XGEN AI** | NPC behavior trees (MBT), smart objects | NPC logic, AI-driven gameplay |
| **Skald** | Quest/concept graphs, dialogues, localization | Quests, dialogues, RPG graph flows |

Pure Lua is enough for many small mods (hotkeys, persistence, console tools). Quest flows, NPC brains, and table-driven RPG logic are documented in the official wiki — start with [KM-A-36 Technical Overview](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/README.md).

## Modding Tools vs Published Game

Install **Kingdom Come: Deliverance II Modding Tools** from Steam (separate app; requires an activated KCD2 key). The tools mirror the published game's folder layout but run as a development build:

- Loads **loose files** from `Data/` and `mods/` (published game loads `.pak` only, except `mod.manifest` / `mod.cfg`)
- Includes `Editor.exe` (CryEngine Sandbox) under `Bin/Win64ReleaseSteamLTO_DLL/`
- Includes Skald under `Tools/Skald/`
- Does **not** load Steam Workshop mods from the retail app ID

See [The Modding Tools](https://warhorse.youtrack.cloud/articles/KM-A-55/The-Modding-Tools) ([local](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-55%20The%20Modding%20Tools/README.md)).

## Mod Layout

Pak contents and special files (`scripts/mods/<modid>.lua`, table patches, concept graphs, etc.) are defined in the official wiki:

- [KM-A-3 Structure of a Mod](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/README.md)
- [KM-A-12 Database tables](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/KM-A-12%20Database%20tables/README.md)

## Official Walkthroughs

| Topic | Article |
|-------|---------|
| Skald editor | [KM-A-18](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-18%20Skald/README.md) |
| Tourist mode (buff + quest graph) | [KM-A-31](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-29%20Quest%20System/KM-A-31%20Example%20Tourist%20mode/README.md) |
| Simple cvar mod | [KM-A-8](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-8%20Simple%20mod%20-%20Modifying%20cvars%20(console%20variables)/README.md) |

## Related Docs in This Repo

- [official-wiki/](official-wiki/README.md) — offline mirror of the official YouTrack KM wiki
- [script_bind_2025_01_14/](script_bind_2025_01_14/) — Lua bindings shipped with official modding tools
- [Scripts/](Scripts/) — extracted `Scripts.pak` (`release_1_5`, 2026-04-22)
- [Libs/Tables/](Libs/Tables/) — extracted `Tables.pak` (same version/date)
- [DISASSEMBLY.md](DISASSEMBLY.md) — native/DLL injection offsets (ASI mods)

---
<a name="中文"></a>
# KCD2 模组技术栈

KCD2 模组开发涉及三层协作技术。官网 mod 文档写明：

> Entities and their basic functionality in KCD2 are scripted in LUA together with XGEN AI and Skald (so not everything is modifiable just via LUA).

出处：[Modifying LUA entities and scripts](https://warhorse.youtrack.cloud/articles/KM-A-15/Modifying-LUA-entities-and-scripts)（[本地快照](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-19%20Modifying%20game%20data/KM-A-15%20Modifying%20LUA%20entities%20and%20scripts/README.md)）。

## 三层概览

| 层级 | 职责 | 何时需要 |
|------|------|----------|
| **Lua** | 实体脚本、mod 初始化、控制台命令 | 大多数脚本 mod 的入口 |
| **XGEN AI** | NPC 行为树（MBT）、智能对象 | NPC 逻辑、AI 驱动玩法 |
| **Skald** | 任务/概念图、对话、本地化 | 任务、对话、RPG 图流程 |

纯 Lua 足以完成许多小型 mod。任务流、NPC 大脑、表驱动 RPG 逻辑见官方 wiki，从 [KM-A-36 技术概览](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/README.md) 入手。

## 模组工具 vs 正式版游戏

在 Steam 安装 **Kingdom Come: Deliverance II Modding Tools**（独立应用；需已激活的 KCD2 密钥）。工具目录结构与正式版一致，但属于开发构建：

- 从 `Data/` 和 `mods/` 加载**散文件**（正式版除 `mod.manifest` / `mod.cfg` 外只读 `.pak`）
- `Bin/Win64ReleaseSteamLTO_DLL/` 下有 `Editor.exe`（CryEngine Sandbox）
- `Tools/Skald/` 下有 Skald 编辑器
- **不会**加载零售版 Steam 应用下的 Workshop 订阅 mod

详见 [The Modding Tools](https://warhorse.youtrack.cloud/articles/KM-A-55/The-Modding-Tools)（[本地](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-55%20The%20Modding%20Tools/README.md)）。

## Mod 目录结构

pak 内容与特殊文件（`scripts/mods/<modid>.lua`、表补丁、概念图等）以官方文档为准：

- [KM-A-3 Structure of a Mod](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/README.md)
- [KM-A-12 Database tables](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-3%20Structure%20of%20a%20Mod/KM-A-12%20Database%20tables/README.md)

## 官方教程

| 主题 | 文章 |
|------|------|
| Skald 编辑器 | [KM-A-18](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-18%20Skald/README.md) |
| Tourist Mode（Buff + 任务图） | [KM-A-31](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-29%20Quest%20System/KM-A-31%20Example%20Tourist%20mode/README.md) |
| 简单 cvar mod | [KM-A-8](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-8%20Simple%20mod%20-%20Modifying%20cvars%20(console%20variables)/README.md) |

## 本仓库相关文档

- [official-wiki/](official-wiki/README.md)
- [script_bind_2025_01_14/](script_bind_2025_01_14/)
- [Scripts/](Scripts/)
- [Libs/Tables/](Libs/Tables/)
- [DISASSEMBLY.md](DISASSEMBLY.md)