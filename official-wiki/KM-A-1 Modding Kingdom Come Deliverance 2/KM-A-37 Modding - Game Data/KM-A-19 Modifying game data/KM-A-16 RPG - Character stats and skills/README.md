# RPG - Character stats and skills
There are multiple ways we handle RPG in KCD2, we will try to explain the most basic ones:

* **RPG Params/Constants**: Global constants that determine certain thresholds, stat increases/decreases, etc. They are the foundation of the RPG system and are overridden by some perks. The whole list can be found at [KM-A-20](KM-A-20 RPG Constants Params/README.md)
* **Soul Skills/Stats/DerivStats**: These are the soul's RPG stats (soul is a combination of an AI brain and an entity), these stats usually change during the gameplay, but some are also used as dynamic soul properties. This category includes things like Vision, Hearing, Agility, Strength, Morale, HorseSellingValue etc. The whole list can be found at [KM-A-21](KM-A-21 Stats and skills/README.md)

### Modify RPG constants

We can modify constants in two ways:

#### Table patch

RPG param differences from default values are stored inside `Data/libs/Tables/rpg/rpg_param.xml`, the values that aren't stored here have a default value that has been set in Code.

If we want to change a certain param, we must create a table patch (as explained in [KM-A-17](../../../KM-A-83 Walkthroughs/KM-A-17 Adding a new Item/README.md)), this table patch should be named `rpg_param__<our_modid>.xml` (depending on your own mod) and will contain:

```xml
<?xml version="1.0" encoding="us-ascii"?>
<database xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="barbora" xsi:noNamespaceSchemaLocation="../database.xsd">
	<rpg_params version="1">
		<rpg_param rpg_param_key="HerbGatherXP" rpg_param_value="20" />
	</rpg_params>
</database>
```

Don't forget to follow the structure of the base file (`Data/libs/Tables/rpg/`) so it properly patches, if you can't detect the change - check kcd.log

#### LUA

You can also change RPG params via LUA as such:

* `RPG.Help('Herb')` - outputs RPG Params containing "Herb"
* `x = RPG.HerbGatherXP` - stores RPG Param `HerbGatherXP` value to variable `x`
* `RPG.HerbGatherXP = 20` - changes RPG Param to value `20`

### Modify soul skills/stats/derivstats

Skills/stats/derivstats can be set dynamically during gameplay or statically when an NPC spawns

#### Buffs

Buffs are mainly used to adjust the entity's RPG during gameplay dynamically, e.g. lower player's stats after punishment, combat injuries, bleeding, drunkness, etc.

Buffs are stored inside `Data/libs/Tables/rpg/buff.xml` and an entry looks like this:

```xml
<buff buff_class_id="20" buff_desc="buff_pillory_desc" buff_exclusivity_id="1" buff_id="1ab50a60-821b-4c19-ace3-c296d73566da" buff_lifetime_id="0" buff_name="crime_punishment_pillory_medium" buff_params="charisma-4,con+0.4,plr+2" buff_ui_name="buff_pillory" buff_ui_type_id="2" buff_ui_visibility_id="3" duration="2400" icon_id="pillory" implementation="Cpp:BasicTimed" is_persistent="true" slot_buff_ui_name="buff_pillory" />
```

The main modifiers are contained in the parameter `buff_params`, in this case `charisma-4,con+0.4,plr+2` - so this buff lowers charisma by 4, increases conspicuousness by 0.4 and pillory by 0.2. The `Implementation` parameter chooses what C++ class should handle the buff's logic and modify the soul it's attached to (or the game itself).
All the other parameters should be pretty self-explanatory.

Referenced stats can be found at [KM-A-21](KM-A-21 Stats and skills/README.md)

If we wish to modify such a buff, we can create a patch table `buff__<our_modid>.xml` and instead, increase agility:

```xml
<?xml version="1.0" encoding="utf-8"?>
<database xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" name="barbora" xsi:noNamespaceSchemaLocation="../database.xsd">
	<buffs version="1">
    <buff buff_class_id="20" buff_desc="buff_pillory_desc" buff_exclusivity_id="1" buff_id="1ab50a60-821b-4c19-ace3-c296d73566da" buff_lifetime_id="0" buff_name="crime_punishment_pillory_medium" buff_params="agility+10" buff_ui_name="buff_pillory" buff_ui_type_id="2" buff_ui_visibility_id="3" duration="2400" icon_id="pillory" implementation="Cpp:BasicTimed" is_persistent="true" slot_buff_ui_name="buff_pillory" />
	</buffs>
</database>
```

#### STORM

To generate NPC's initial RPG/Inventories/Roles/Dialogues/etc. we use an internal technology called STORM, we won't go too in-depth here (you can read more about it over at [KM-A-32](KM-A-32 STORM/README.md)), but we can use it to modify NPC's starting stats. It runs through every soul in the game when the game loads (or a soul spawns) and based on selectors and operations generates their RPG/Inventories/etc.

The whole STORM structure can be found at `Data/libs/Storm` (or `IPL_GameData.pak/Libs/Storm`.

We want to modify RPG, that's located under "abilities", so let's look into `Storm/abilities/base` and find `dude.xml` - that is Henry's RPG. In this file, we can find a rule named `player_henry` that adds different perks and sets attributes.

```xml
...
		<rule name="player_henry">
			<selectors>
				<hasName name="player_henry"/>
			</selectors>
		
			<operations>
        ...
        <setAttribute stat="agility" value="5" />
        ...
			</operations>
		</rule>
...
```

Storm files cannot be easily patched, however we can make use of how storm works - it applies all operations in the order they were loaded. We can patch storm root file and add a custom file `storm__<modid>.xml` placed in `data\libs\storm\`

```xml
<?xml version="1.0"?>
<storm>
  <tasks>
    <task name="abilities" class="abilities">
      <source path="new_custom_file.xml" />
    </task>
  </tasks>
</storm>
```

Then we create a file `new_custom_file.xml` with a new rule. Sice the above patch adds new_custom_file.xml at the end of the abilities task, this new rule will be applied after all rules from the base game, therefore it can overwrite any previous changes.

```xml
<?xml version="1.0"?>
<storm>
	<rules>
		<rule name="player_henry_modded">
			<selectors>
				<hasName name="player_henry"/>
			</selectors>
			<operations>
				<setAttribute stat="strength" value="27" />
			</operations>
		</rule>	
	</rules>
</storm>
```