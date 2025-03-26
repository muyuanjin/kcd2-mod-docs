-- =============================================================================
-- Entity defining properties for DeadBody, derived from SmartObjectHolder
-- =============================================================================

SO_DiggingSpot =
{
	Properties =
	{
		DiggingSpot = {
			bGetShovelFromInventory = false,
		},
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( SO_DiggingSpot, SmartObjectHolder )
