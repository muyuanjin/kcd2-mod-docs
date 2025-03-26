InventoryDummyPlayerFemale = {

	ActionController = "Animations/Mannequin/ADB/wh_female_controllerdefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/wh_female_database.adb",

	defaultSoulArchetype = "NPC_Female",

	Properties = {
		fileModel = "Objects/Characters/humans/female/skeleton/female.cdf",
		esClothingConfig = "female2",
	},

}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/AI/InventoryDummyPlayer.lua")
table.Merge(InventoryDummyPlayerFemale, InventoryDummyPlayer)