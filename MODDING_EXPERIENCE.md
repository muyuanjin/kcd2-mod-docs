# Modding Experience Notes

[中文](#中文)

Distilled lessons from [kcd2db](https://github.com/muyuanjin/kcd2db) (Lua persistence ASI) and community equipment-mod research. Focuses on **stable patterns and boundaries**, not one-off experiment logs.

## Lua Layer

### What Lua is good for

- Mod bootstrap: `Scripts/Mods/<modid>.lua` executed on game load
- Console commands via `System.AddCCommand`
- Hotkeys via `Libs/Config/defaultProfile.xml` (`consoleCMD` actions)
- Inventory enumeration: `player.inventory:GetInventoryTable()` + `ItemManager.GetItem(wuid)`
- Write-side equip helpers: `player.actor:EquipInventoryItem`, `UnequipInventoryItem`, preset GUIDs

### What Lua alone does not expose

- No script-bind API to **read** full equipped-slot state (`IsEquipped`, `GetEquippedItems`, per-slot occupancy)
- Quick-slot layout, belt-dependent weapon slots, and consumable assignments live in C++ `wh::entitymodule` (`C_EquipmentManager`, RTTR)
- `QuestSystem.*` is documented in modding-tool bindings but is **not** reliably available as a global in `Scripts/Mods/*.lua`

**Implication:** equipment-heavy mods need XGEN AI trees and/or Skald `EquipmentManager` flows, and sometimes native ASI for read models.

## XGEN AI Layer

### Proven patterns

- Store behavior trees at **`AI/...`** in mod paks (matches shipped `Scripts.pak` layout)
- Include custom brains from existing player switch trees (`AI/player/switch/switch.xml`)
- Capture equipped WUIDs with `GraphSearch` + `ItemParamFilter Param="Equip"` + `Nodalyzer`
- Bridge Lua and trees with `SetBrainVariable` / `GetBrainVariable` / `SendMessageToEntity` / `<ExecuteLua>`
- Reset tree-side accumulator arrays before each capture pass (avoid duplicate WUID buildup across polls)

### Boundaries

- MBT `EquipItem` / `UnEquipItem` can leave weapons in bad draw/holster states; prefer Skald `EquipmentManager.*` for restore semantics when possible
- `ItemParamFilter Param="Equip"` captures a **partial** equipped set relative to the full character-sheet UI
- WUID owner handles (`XGenAIModule.GetOwner`) identify the player soul, not UI slot indices

## Skald Layer

### Proven patterns

- Register custom buffs in `Libs/Tables/rpg/buff*.xml` + `buff_ai_tag*.xml`, trigger via `BuffTagTrigger` in a **loaded** graph (Tourist Mode pattern)
- Route equip through shipped semantics:
  - `CreateItemReferenceDescriptor` / `CreateItemCategoryDescriptor`
  - `EquipmentManager.EquipPlayersItem(..., EquipToSlot=<E_QuickSlotSpec>)`
  - `PlayerOutfitOverride` for static presets (not a full custom-loadout backend)
- New mod concept root: `Quests/<modid>.xml` (officially supported path, but activation must be verified in dev build)
- `Souls` vs `PlayerSouls` asset buckets matter for node types; match shipped graphs for `BuffEffect` / equipment nodes

### Boundaries

- Standalone `Quests/<modid>.xml` roots require runtime proof they enter the active concept graph
- Patching base-game quest XML (`Quests/Final/Barbora/...`) is valid for loaded-host experiments; pack overrides carefully and restore after tests
- Skald equipment nodes describe **intent** (`EquipToSlot`); they do not replace a complete slot read model

## Native / ASI Layer (kcd2db pattern)

### Architecture that survived game updates

1. **Ultimate ASI Loader** in game root
2. Signature-scan `gEnv` in `WHGame.dll` (not hard-coded addresses) — see [DISASSEMBLY.md](DISASSEMBLY.md)
3. Hook `IGame::CompleteInit` vtable entry to register Lua APIs on the game init thread
4. Expose `LuaDB` (raw bool/float/string) + `DB` wrapper (JSON via built-in `json.lua`)

### Persistence model

| Mode | Scope | Flush |
|------|-------|-------|
| Local (`LuaDB.Set` / `DB` local keys) | Per save | On save game |
| Global (`LuaDB.SetG` / `DB.G`) | Cross-save | Dirty flush on post-update |

Namespace keys with `DB.Create("YourMod")`; colons forbidden in namespace names.

### Native research notes (equipment mods)

- Player inventory vector: `C_Inventory + 0x8` (count matches Lua `GetInventoryTable()`)
- Item WUID field: `C_Item + 0x30`
- Leading `C_EquipmentManager` candidate on player soul: `C_Soul + 0x2B8` (layout evidence; not a safe public API)
- Do **not** read arbitrary Lua proxy fields from native `IScriptTable` in live game (crash-prone)
- CryEngine headers in [CryEngine/](CryEngine/) are compile-time reference only; KCD2 fork offsets diverge — verify per game version

## Development Workflow

| Task | Approach |
|------|----------|
| Rapid Lua experiments | [kcd2lua](https://github.com/yobson1/kcd2lua) VSCode bridge |
| Cross-save mod settings | [kcd2db](https://github.com/muyuanjin/kcd2db) / [Nexus 1523](https://www.nexusmods.com/kingdomcomedeliverance2/mods/1523) |
| Pack & test | Modding tools dev build (loose files) → pack `.pak` → test in retail game / Workshop |
| Script reference | This repo's [Scripts/](Scripts/) dump + [script_bind_2025_01_14/](script_bind_2025_01_14/) |
| Online debug | Dev build serves `http://localhost:1403` (API browser, CryHttp) |

Retail game must be launched through Steam (`-applaunch 1771300`) when using dev-mode flags; direct `KingdomCome.exe` can fail with "not started through Steam".

## Publishing Checklist

- Pack all content into `.pak` (uncompressed ZIP); retail game ignores loose mod files except manifest/cfg
- Include `mod.manifest` (+ optional `mod.cfg`)
- Workshop mods do not load inside modding-tools app ID — test packed mods in retail build
- Official guide: [Modding in Kingdom Come: Deliverance 2](https://www.deepsilver.com/games/kingdom-come-deliverance-ii/news/modding-in-kingdom-come-deliverance-2)

## Related

- [MODDING_STACK.md](MODDING_STACK.md)
- [official-wiki/](official-wiki/README.md)
- [DISASSEMBLY.md](DISASSEMBLY.md)
- [CONSOLE.md](CONSOLE.md)
- [LINKS.md](LINKS.md)

---
<a name="中文"></a>
# 模组实践经验

摘自 [kcd2db](https://github.com/muyuanjin/kcd2db) 与社区装备类 mod 研究，记录**稳定模式与边界**，不含一次性实验日志。

## Lua 层

### 擅长

- `Scripts/Mods/<modid>.lua` 引导加载
- `System.AddCCommand` 注册控制台命令
- `defaultProfile.xml` 绑定快捷键
- `GetInventoryTable` + `ItemManager.GetItem` 枚举背包
- `EquipInventoryItem` / 预设 GUID 等**写入**接口

### 局限

- 无**读取**完整已穿戴槽位的 script-bind API
- 快捷栏、腰带影响武器槽等逻辑在 C++ `EquipmentManager`（RTTR）
- `QuestSystem` 在 mod 初始化 Lua 中**不一定**作为全局存在

**结论：** 装备向 mod 需叠加 XGEN AI / Skald，必要时配合 native ASI 读模型。

## XGEN AI 层

### 已验证模式

- mod pak 中行为树路径为 **`AI/...`**
- 从 `AI/player/switch/switch.xml` `<IncludeTree>` 注入
- `ItemParamFilter Param="Equip"` 捕获已穿戴 WUID
- `SetBrainVariable` / `GetBrainVariable` / `SendMessageToEntity` / `<ExecuteLua>` 作桥梁
- 每次捕获前清空树侧累加数组，避免 WUID 重复堆积

### 边界

- 树内 `EquipItem`/`UnEquipItem` 可能导致拔剑/收剑异常；恢复语义优先 Skald `EquipmentManager.*`
- `Param="Equip"` 只覆盖**部分** UI 可见槽
- `GetOwner` 返回玩家 soul，不是槽位编号

## Skald 层

### 已验证模式

- `Libs/Tables/rpg/` 注册 Buff + `BuffTagTrigger`（Tourist Mode 范式）
- `EquipmentManager.EquipPlayersItem` + `E_QuickSlotSpec` 保留快捷栏意图
- `Quests/<modid>.xml` 为官方支持的 mod 概念图根（需运行时验证是否激活）
- `Souls` / `PlayerSouls` 资产桶需与节点类型匹配

### 边界

- 独立根图需证明进入活动概念图
- 修改 `Quests/Final/Barbora/...` 适合 loaded-host 实验，测完应恢复
- Skald 节点表达**意图**，不替代完整槽位读取模型

## Native / ASI（kcd2db）

1. Ultimate ASI Loader
2. 签名扫描 `gEnv`（见 [DISASSEMBLY.md](DISASSEMBLY.md)）
3. Hook `IGame::CompleteInit` 注册 Lua API
4. `LuaDB` 原始类型 + `DB` JSON 包装

| 模式 | 范围 |
|------|------|
| Local | 随存档 |
| Global | 跨存档 |

装备研究线索：`C_Inventory+0x8` 向量、`C_Item+0x30` WUID、`C_Soul+0x2B8` EquipmentManager 候选（只读证据，非公开 API）。勿在 native 侧随意读 Lua 代理表字段。

## 开发流程

| 任务 | 方式 |
|------|------|
| Lua 快速实验 | kcd2lua |
| 持久化 | kcd2db |
| 打包测试 | 工具散文件 → pak → 零售版/Workshop |
| 脚本参考 | 本仓库 Scripts/ + script_bind |

零售版建议 Steam `-applaunch 1771300` 启动。

## 发布要点

- 除 manifest/cfg 外内容须打进 `.pak`
- Workshop mod 在 modding tools 应用 ID 下不加载
- 官方指南：[Modding in Kingdom Come: Deliverance 2](https://www.deepsilver.com/games/kingdom-come-deliverance-ii/news/modding-in-kingdom-come-deliverance-2)