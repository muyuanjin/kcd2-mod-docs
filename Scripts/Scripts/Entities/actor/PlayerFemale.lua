Script.ReloadScript( "SCRIPTS/Entities/actor/Player.lua")

PlayerFemale =
{
	ActionController = "Animations/Mannequin/ADB/wh_female_controllerdefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/wh_female_database.adb",
	OpponentMnTag = "relatedFemale",
	CombatOpponentMnTag = "oppFemale",

	type = "PlayerFemale",
	defaultSoulClass = "NPC_Female",
	defaultSoulArchetype = "NPC_Female",

	Properties =
	{
		fileModel = "Objects/Characters/humans/female/skeleton/female.cdf",
		clientFileModel = "Objects/Characters/humans/female/skeleton/female.cdf", -- pouzite pro multiplayer, pokud je player client ukaze to tenhle model
		esClothingConfig = "female2",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(PlayerFemale, Player)