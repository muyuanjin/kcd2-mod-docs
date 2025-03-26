InventoryDummyDog = {
    ActionController = "Animations/Mannequin/ADB/inv_dog_controllerdefs.xml",
    AnimDatabase3P = "Animations/Mannequin/ADB/inv_dog_database.adb",

	UseMannequinAGState = true,

	defaultSoulArchetype = "Dog",
	defaultSoulClass = "dog",

	Properties = {
		esNavigationType = "MediumSizedCharacters",
		sWH_AI_EntityCategory = "",
		bWH_PerceptorObject = true,
		bWH_PerceptibleObject = true,
		bWH_ListenerObject = true,
		bWH_RequiresHome = false,
		NPC = {
			eiNPCCategory = 1,
			aianchorHome = "",
		},
		fileModel = "objects/characters/animals/dog/dog.cdf",
		esClothingConfig = "dog",
		bNotPlayerMountable = false,
		bIsDummy = true,
		ControlProfile = 2, -- 2 == hidden, start hidden, hide status is controlled by Apse
	},

	physicsParams =
	{
		enabled = 0,
	},
}

-- =============================================================================
function InventoryDummyDog:GetActions(user, firstFast)
	return {}
end

-- =============================================================================
function InventoryDummyDog:IsUsable(user)
	return 0
end

-- =============================================================================
function InventoryDummyDog:RegisterAI(bForce)
	-- do nothing (null AI don't have AI objects)
end

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(
	InventoryDummyDog,
	BasicAnimal,
	BasicAI
)

EntityCommon.MakeSpawnable(InventoryDummyDog)