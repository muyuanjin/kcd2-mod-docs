-- =============================================================================
-- Entity defining properties for basic human dead bodies by real NPCs, derived from DeadBody_Human and SmartObjectHolder.
-- =============================================================================

SO_DeadBody_Human =
{
	Properties =
	{
		DeadBody =
		{
			bPickableByPlayer = true,
		},
	},

	-- unstanceName is defined in DeadBody_Base_Human

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Special/DeadBody/DeadBody_Human.lua")
table.Merge(SO_DeadBody_Human, DeadBody_Human)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
table.Merge(SO_DeadBody_Human, SmartObjectHolder)
