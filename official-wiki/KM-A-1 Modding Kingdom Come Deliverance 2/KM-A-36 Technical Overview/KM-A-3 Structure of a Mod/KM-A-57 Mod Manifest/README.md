# Mod Manifest
mod.manifest is a file placed in root of the mod folder, necessary for the mod to function properly. It is a simple XML file with several properties:

```
<kcd_mod>
	<info>
		<name>Human-readable mod name</name>
		<modid>machine_readable_mod_name</modid>
		<description>Description of the mod</description>
		<author>Author name</author>
		<version>0.1</version>
		<created_on>2025-01-20</created_on>
	</info>
  <supports>
    <version>1.1*</version>
    <version>1.2*</version>
  </supports>
</kcd_mod>
```

**name**, **description**, **author**, **version** are all optional and are only ever read by humans, so there are no strict formatting requirements. Name and version are saved verbatim into the savegame, which will help us (Warhorse) when we receive a bug report with save attached - we will be able to identify which mods in which versions were used.

**created_on** is technically also optional, however some tools require this field to exist in a specific format (YYYY-MM-DD). The game does not require this field and the mod will work fine without it.

**modid** is <span style="background-color:moccasin;">necessary</span> - it is the <span style="background-color:moccasin;">main identifier</span> of the mod. Many files in the mod need to contain the modid in their name in order to work correctly. In case that modid is not provided in manifest, it is auto-generated from **name**, however that is not recommended - you should provide modid explicitly. <span style="background-color:mistyrose;">ModId can only contain lowercase characters and underscore.</span>

**supports** is an optional list of versions supported by your mod. If the current version of the game is not in this list, the mod will be automatically disabled. The version is compared as a string to the version in **wh_sys_version** (in system.cfg of the game). If you modify any major file in the game, you should limit the supported versions to those you actually tested.

* beware that major versions are released without the minor version number (**1.1**, **1.2**), so using **1.2.**\* won't work, as the versions are compared as strings. Use **1.1**\*, **1.2**\*, etc...