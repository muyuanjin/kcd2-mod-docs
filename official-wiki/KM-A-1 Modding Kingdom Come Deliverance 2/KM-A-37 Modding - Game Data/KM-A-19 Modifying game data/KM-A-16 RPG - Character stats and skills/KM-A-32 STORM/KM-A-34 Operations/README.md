# Operations
List of some of the operations we use - per task

### Abilities

[KM-A-21](../../KM-A-21 Stats and skills/README.md)

```xml
<addPerk ID="1" />
<addPerk name="nazevPerku" />

<removePerk ID="1" />
<removePerk name="nazevPerku" />

<autolearnPerks reliability="1" />

<setAttribute stat="stat" value="10" />
<setAttribute stat="stat" minValue="10" maxValue="12" />
<setAttribute skill="skill" value="10" />
<setAttribute skill="skill" minValue="10" maxValue="12" />

<setAttribute stat="strength" scaleWith="combatLevel" minValue="10" maxValue="18" />

<modAttribute stat="stat" mod="2" />
<modAttribute stat="stat" minMod="-2" maxMod="4" />
<modAttribute skill="skill" mod="2" />
<modAttribute skill="skill" minMod="-2" maxMod="4" />

<removeSkill skill="skill" />
```

### Characters

```xml
<setGenericCharacterNamePattern pattern="GENERIC_MAN_*" />
```

### Contexts

```xml
<addContext name="Battle" />
<removeContext name="Battle" />
<addContextPreset name="battle" />
<removeContextPreset name="battle" />
<clearContexts />
```

### Names

```xml
<setUiName name="soul_ui_name_bandit" />
```

### Reputations

```xml
<setReputation reputation="-1" />
```

### Roles

```xml
<addRole name="EVENT_CRIME_SCENE_BANDITA" />
<removeRole name="SOLDIER_MLUVI_V_BOJI" />
<addMetarole name="NPC_TRAGEDIE_NA_DANEMARKU" />
```

### Appearance

```xml
<setHead name="m_head_079_b00" />
<setHair name="m_hair_005_black" />
<setBody name="m_body_tan_01" />
<setBeard name="m_beard_00" />
<setUnderwear name="m_underwear04_m01" />
```

### Equipment
```xml
<setInventory preset="inventory_crimeScene_villager" />
<setEquipDirectives onlyDefault="1" undressToInventory="1"/>
<setLootInventory preset="inventory_animal_bull" />
<setReincarnationParams combatLevelCoef="2"  />
```