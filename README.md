# kcd2-mod-docs

[中文](#中文)

A collection of resources and documentation for modding Kingdom Come: Deliverance 2 (KCD2).

## Official Resources

- [Official Modding Guide](https://www.deepsilver.com/games/kingdom-come-deliverance-ii/news/modding-in-kingdom-come-deliverance-2)
- [Official Modding Wiki (YouTrack)](https://warhorse.youtrack.cloud/articles/KM) — also mirrored offline in [official-wiki/](official-wiki/README.md) (snapshot 2026-06-23, 78 articles)

## Quick Start: Three-Layer Stack

Per official docs, KCD2 entity behavior is scripted in **Lua + XGEN AI + Skald** — not everything is modifiable through Lua alone.

| Doc | Topic |
|-----|-------|
| [MODDING_STACK.md](MODDING_STACK.md) | Stack overview, tools vs retail game |
| [official-wiki/](official-wiki/README.md) | Full official KM wiki (Skald, XGEN AI, tables, publishing) |
| [MODDING_EXPERIENCE.md](MODDING_EXPERIENCE.md) | Optional notes from kcd2db / advanced mod research |

## Table of Contents

*   [official-wiki](#official-wiki)
*   [CryEngine](#cryengine)
*   [lua\_dump\_state](#lua_dump_state)
*   [Scripts](#scripts)
*   [Libs/Tables](#libstables)
*   [script\_bind\_2025\_01\_14](#script_bind_2025_01_14)
*   [DISASSEMBLY](#disassembly)
*   [CONSOLE](#console)
*   [Links](#links)

## official-wiki

[official-wiki/](official-wiki/README.md) is an **offline snapshot** of the [official YouTrack KM wiki](https://warhorse.youtrack.cloud/articles/KM) (78 Markdown articles, 320 images, exported 2026-06-23). Use it for full-text search and stable links when YouTrack is slow or unavailable.

Quick entry points: [Modding Tools (KM-A-55)](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-55%20The%20Modding%20Tools/README.md) · [Lua/XGEN/Skald (KM-A-15)](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-19%20Modifying%20game%20data/KM-A-15%20Modifying%20LUA%20entities%20and%20scripts/README.md) · [Skald (KM-A-18)](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-18%20Skald/README.md) · [Installing mods (KM-A-56)](official-wiki/KM-A-56%20Installing%20mods/README.md).

## CryEngine

The `CryEngine` directory contains a link to the CryEngine repository: [https://github.com/ValtoGameEngines/CryEngine](https://github.com/ValtoGameEngines/CryEngine).

**Important Note:** KCD2 uses an earlier version of CryEngine (either an unknown source version less than 5.1, or a modified source version less than 5.4). If anyone knows the specific CryEngine version used by KCD2, please let me know!

Therefore, the engine source code is provided for reference only. Many function offsets have changed (verified offsets are in [DISASSEMBLY.md](DISASSEMBLY.md)). This information is primarily useful for creating DLL injection mods.

## lua\_dump\_state

The `lua_dump_state` directory contains output from the in-game `lua_dump_state` console command (see [CryEngine docs](https://www.cryengine.com/docs/static/engines/cryengine-3/categories/9895942/pages/9218195)). It dumps defined Lua symbols and values into `LuaState.txt`. Run **after loading a save into the world** (not from the main menu). Current snapshot targets retail `release_1_5`.

## Scripts

The `Scripts` directory contains data extracted from retail `Data/Scripts.pak` (game branch `release_1_5`, pak date 2026-04-22, 26415 files). See [Scripts/README.md](Scripts/README.md).

## Libs/Tables

Database tables from retail `Data/Tables.pak` (same game branch/date, 1738 files). See [Libs/Tables/README.md](Libs/Tables/README.md).

Separate pak from `Scripts.pak`. Equipment/buff modding often reads `Libs/Tables/item/` and `Libs/Tables/rpg/`.

## script\_bind\_2025\_01\_14

Lua binding documentation from the official modding tools (`Tools/modding/docs/`). Includes `C_ScriptBindXGenAIModule`, `C_ScriptBindActor`, `C_ScriptBindInventory`, etc.

## DISASSEMBLY

[DISASSEMBLY.md](DISASSEMBLY.md) — how to locate `gEnv` and verified virtual-function offsets for native/ASI mods (e.g. [kcd2db](https://github.com/muyuanjin/kcd2db)).

## DLL

Store different versions of `WHGame.dll` for disassembly. Current retail snapshot: `DLL/WHGame_release_1_5.dll`; older builds: `WHGame_V1.2.x.dll`. When using Cheat Engine to search byte patterns, set base address to `0x180000000` and enable "Scan all memory".

## CONSOLE

[CONSOLE.md](CONSOLE.md) — CryEngine console notes, including `System.AddCCommand` placeholder rules.

## Links

[LINKS.md](LINKS.md) — tutorials, tools, and community mods.

---
<a name="中文"></a>
# kcd2-mod-docs

《天国：拯救 2》模组制作资源与文档合集。

## 官方资源

- [官方模组指南](https://www.deepsilver.com/games/kingdom-come-deliverance-ii/news/modding-in-kingdom-come-deliverance-2)
- [官方模组 Wiki (YouTrack)](https://warhorse.youtrack.cloud/articles/KM) — 离线快照见 [official-wiki/](official-wiki/README.md)（2026-06-23，78 篇文章）

## 快速入门：三层技术栈

官网写明：KCD2 实体功能由 **Lua + XGEN AI + Skald** 共同脚本化，并非仅靠 Lua 即可修改一切。

| 文档 | 内容 |
|------|------|
| [MODDING_STACK.md](MODDING_STACK.md) | 技术栈概览、工具版 vs 零售版 |
| [official-wiki/](official-wiki/README.md) | 官方 KM Wiki 全文（Skald、XGEN AI、表、发布） |
| [MODDING_EXPERIENCE.md](MODDING_EXPERIENCE.md) | 可选：kcd2db / 进阶 mod 研究笔记 |

## 目录

*   [official-wiki](#official-wiki-1)
*   [CryEngine](#cryengine-1)
*   [lua\_dump\_state](#lua_dump_state-1)
*   [Scripts](#scripts-1)
*   [Libs/Tables](#libstables-1)
*   [script\_bind\_2025\_01\_14](#script_bind_2025_01_14-1)
*   [DISASSEMBLY](#disassembly-1)
*   [CONSOLE](#console-1)
*   [Links](#links-1)

## official-wiki

[official-wiki/](official-wiki/README.md) 是 [官方 YouTrack KM Wiki](https://warhorse.youtrack.cloud/articles/KM) 的**离线快照**（78 篇 Markdown、320 张图，导出日期 2026-06-23），便于全文检索与稳定引用。

常用入口：[模组工具 KM-A-55](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-36%20Technical%20Overview/KM-A-55%20The%20Modding%20Tools/README.md) · [Lua/XGEN/Skald KM-A-15](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-37%20Modding%20-%20Game%20Data/KM-A-19%20Modifying%20game%20data/KM-A-15%20Modifying%20LUA%20entities%20and%20scripts/README.md) · [Skald KM-A-18](official-wiki/KM-A-1%20Modding%20Kingdom%20Come%20Deliverance%202/KM-A-83%20Walkthroughs/KM-A-18%20Skald/README.md) · [安装 mod KM-A-56](official-wiki/KM-A-56%20Installing%20mods/README.md)。

## CryEngine

`CryEngine` 目录指向 [ValtoGameEngines/CryEngine](https://github.com/ValtoGameEngines/CryEngine)。

**重要提示：** KCD2 使用较早/修改过的 CryEngine 分支。引擎源码仅供对照；大量偏移与公开版不一致（已验证偏移见 [DISASSEMBLY.md](DISASSEMBLY.md)），主要用于 DLL/ASI 注入类 mod。

## lua\_dump\_state

游戏内 `lua_dump_state` 命令输出，转储 Lua 符号到 `LuaState.txt`。请在**读档进入世界后**执行（勿在主菜单）。当前快照对应零售版 `release_1_5`。

## Scripts

零售版 `Data/Scripts.pak` 解包（`release_1_5`，2026-04-22，26415 文件）。见 [Scripts/README.md](Scripts/README.md)。

## Libs/Tables

零售版 `Data/Tables.pak` 解包（同版本/日期，1738 文件）。见 [Libs/Tables/README.md](Libs/Tables/README.md)。

与 `Scripts.pak` 独立。装备/Buff mod 常查 `Libs/Tables/item/`、`Libs/Tables/rpg/`。

## script\_bind\_2025\_01\_14

官方 modding tools 中的 Lua 绑定文档，含 `XGenAIModule`、`Actor`、`Inventory` 等。

## DISASSEMBLY

[DISASSEMBLY.md](DISASSEMBLY.md) — 定位 `gEnv` 与已验证虚函数偏移（如 [kcd2db](https://github.com/muyuanjin/kcd2db)）。

## DLL

存放各版本 `WHGame.dll` 供反汇编。当前零售版：`DLL/WHGame_release_1_5.dll`；旧版：`WHGame_V1.2.x.dll`。Cheat Engine 建议基址 `0x180000000`，勾选「扫描所有内存」。

## 控制台

[CONSOLE.md](CONSOLE.md) — 含 `System.AddCCommand` 占位符说明。

## 链接

[LINKS.md](LINKS.md) — 教程、工具与社区 mod。