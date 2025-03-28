# kcd2-mod-docs
[中文](#中文)
A collection of resources and documentation for modding Kingdom Come: Deliverance 2 (KCD2).

## [Official Modding Guide](https://kingdomcomerpg.com/en/news/modding-in-kcdii)

## [Official Modding Docs](https://warhorse.youtrack.cloud/articles/KM)

## Table of Contents

*   [CryEngine](#cryengine)
*   [lua\_dump\_state](#lua_dump_state)
*   [Scripts](#scripts)
*   [Links](#links)

## CryEngine

The `CryEngine` directory contains a link to the CryEngine repository: [https://github.com/ValtoGameEngines/CryEngine](https://github.com/ValtoGameEngines/CryEngine).

**Important Note:** KCD2 uses an earlier version of CryEngine (either an unknown source version less than 5.1, or a modified source version less than 5.4).  If anyone knows the specific CryEngine version used by KCD2, please let me know!

Therefore, the engine source code is provided for reference only. Many function offsets have changed (verified offsets are in [DISASSEMBLY](DISASSEMBLY.md)). This information is primarily useful for creating DLL injection mods.

## lua\_dump\_state

The `lua_dump_state` directory contains the output of the `lua_dump_state` command (see [https://www.cryengine.com/docs/static/engines/cryengine-3/categories/9895942/pages/9218195](https://www.cryengine.com/docs/static/engines/cryengine-3/categories/9895942/pages/9218195)) run in the KCD2 V1.2.2 console.  This command dumps the current state of the Lua memory (defined symbols and values) into the file `LuaState.txt`.

## Scripts

The `Scripts` directory contains the extracted contents of the `KingdomComeDeliverance2\Data\Scripts.pak`(KCD2 V1.2.2) file.  These Lua scripts are a crucial reference for understanding game logic and modding.

## script_bind_2025_01_14
Lua binding documentation in the official modding tools

## DLL
Store different versions of DLL files for disassembly. When using Cheat Engine to search for byte patterns, it is recommended to set the base address to 0x180000C00, right-click on the scan options, and check "Scan all memory".

## Links

The [LINKS](LINKS.md) contains a collection of links to online tutorials and resources related to KCD2 modding.

---
<a name="中文"></a>
# kcd2-mod-docs

用于 Kingdom Come: Deliverance 2 (KCD2) modding 的资源和文档集合。

## [官方模组指南](https://kingdomcomerpg.com/en/news/modding-in-kcdii)

## [官方模组文档](https://warhorse.youtrack.cloud/articles/KM)

## 目录

*   [CryEngine](#cryengine)
*   [lua\_dump\_state](#lua_dump_state)
*   [Scripts](#scripts)
*   [Links](#links)

## CryEngine

`CryEngine` 目录包含指向 CryEngine 仓库的链接：[https://github.com/ValtoGameEngines/CryEngine](https://github.com/ValtoGameEngines/CryEngine).

**重要提示：** KCD2 使用的是 CryEngine 的早期版本（要么是小于 5.1 的未知源代码版本，要么是小于 5.4 的修改过的源代码版本）。 如果有人知道 KCD2 使用的 CryEngine 具体版本，请务必告知我！

因此，提供的引擎源代码仅供参考。 许多函数偏移量已更改（已验证的偏移量位于 `Disassembly.md` 中）。 此信息主要用于创建 DLL 注入形式的 mod。

## lua\_dump\_state

`lua_dump_state` 目录包含在 KCD2 1.2.2 控制台中运行 `lua_dump_state` 命令（参见 [https://www.cryengine.com/docs/static/engines/cryengine-3/categories/9895942/pages/9218195](https://www.cryengine.com/docs/static/engines/cryengine-3/categories/9895942/pages/9218195)）的输出。 此命令将 Lua 内存的当前状态（定义的符号和值）转储到文件 `LuaState.txt` 中。

## Scripts

`Scripts` 目录包含从 `KingdomComeDeliverance2\Data\Scripts.pak`(KCD2 V1.2.2) 文件中提取的内容。 这些 Lua 脚本是理解游戏逻辑和 modding 的重要参考。

## script_bind_2025_01_14
官方模组工具里的 Lua 绑定文档

## DLL
存储不同版本的DLL文件，用于反汇编，使用cheat engine打开搜索字节模式时，推荐设置基址0x180000C00 ，右键扫描选项，勾选“扫描所有内存”

## Links

[LINKS](LINKS.md)  包含指向与 KCD2 modding 相关的在线教程和资源的链接集合。

