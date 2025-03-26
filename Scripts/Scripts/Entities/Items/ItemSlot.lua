ItemSlot = {

	Properties={
		-- CommonEditorProperties --
		sWH_AI_EntityCategory = "",
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		bOnlyNPC = false,
		
		-- ItemSlot properties --
		guidItemClassId = "0",	-- GUID of item class in database
		icfItemClassFilter = "", --Text of item class filter (example: weapon.weapon_class_id=1)
		bSpawnOnStart = true,
		bHasItemPhysics = false, -- whether the item should be physicalized when in slot
		nRestockPeriodDays = 7, -- in how many days does the item restock after being taken, 0 to disable restock

		sManipulationAnimTag = "",

		bInteractiveCollisionClass = false,
		bInvisibleContent = false,
		bDisableDynamicSpawning = false,
		bOwnedByHome = true, -- Automatically create an ownership link from home if placed in one

		bSaveBorrowedItem = true,

		nQuality = 0,
		ItemHealth = -1;
		Condition = -1,

	Script = {
		Misc = '',
	},

	},

	Editor={
		Icon = "ItemSlot.bmp",
		IconOnTop = 1,
	},
}
