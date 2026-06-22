# Inventory presets
Inventory preset is a set of items generated from a set of rules. Inventory presets are used to generate NPC inventories, treasure chest, and even shop stock. All inventory presets are defined in \*data/libs/tables/item/InventoryPreset.xml\*.

An inventory preset contains a list of sources and a selection method. References can be:

* **InventoryPresetRef** - another inventory preset
* **ClothingPresetRef** - a clothing preset, defined in \*data/libs/tables/item/clothing_preset.xml\*
* **WeaponPresetRef** - a weapon preset, defined in \*data/libs/tables/item/weapon_preset.xml\*
* **PresetItem** - a specific item

From all of these sources, items are selected according to selection method:

* **All** - All items from all sources are selected
* **OneChild** - All items from one random source are selected. If child nodes have CombatLevel specified, and this preset is beeing generated for an NPC inventory, then only sources that have the closest combat level will be considered for selection. Randomness can be weighted by Weight attribute in children
* **AmountCount** - Randomly select **ModeValue** +- **ModeValueVariation** items from all sources, taking Weight into account
* **AmountFraction** - Randomly select **ModeValue** +- **ModeValueVariation** % of items from all sources, taking Weight into account

### Properties

Common properties on InventoryPresetRef, ClothingPresetRef, WeaponPresetRef, PresetItem:

* **Name** - Name of the referenced source. It refers to the Name property in a corresponding table, based on the source type.
* **Weight** - If this InventoryPreset used some randomizing mode, this property is used to weigh the randomizing algorithm. Does nothing for **All** selection mode.
* **CombatLevel** - Works only for **OneChild** selection mode, see above for explanation.

Common properties available on InventoryPreset, WeaponPreset, ClothingPreset and PresetItem:

* **Quality** - sets the quality of the generated item - Valid values are integers 1 to 4.
* **Health** and **HealthVariation** - The health of the generated item is randomly generated between **Health** and **Health+HealthVariation**. Valid values are 0 to 1.
* **Condition** and **ConditionVariation** - The health of the generated item is randomly generated between **Condition** and **Condition+ConditionVariation**. Valid values are 0 to 1.
  Not all properties can be used at once. If **Quality** is specified, health will be generated from quality and (optionally) condition.

Additional Properties on PresetItem

* Amount - amount of items generated

## Patching

<span style="background-color:mistyrose;">Doesn't work before patch 1.3</span>
Inventory presets table supports patching both at the level of inventory presets, and the level of individual preset sources (with some limitations here).

Patching an inventory preset works just like any other patch, create a table named **InventoryPreset\_\_modid.xml** in the correct folder. You can add new sources by including a source with a Name that is not present in the original file, or modify existing source by using the same Name. It is not possible to remove a source from the original with this patch file (in some selection modes, you can get around this limitation by setting weight to 0, which will effectively remove it).

```
<?xml version="1.0" encoding="us-ascii"?>
<database >
  <InventoryPresets version="2">
    <InventoryPreset Name="inventory_taboryUCesty_shop_stork_special" Mode="All">
			<InventoryPresetRef Name="inventory_commonBathhouseTailorKits" /> <!-- Adds new Inventory preset as a source  -->
			<PresetItem Name="bandage_classic" Amount="20" /> <!-- Modifies existing PresetItem, increasing amount to 20 -->
    </InventoryPreset>
  </InventoryPresets>
</database>
```