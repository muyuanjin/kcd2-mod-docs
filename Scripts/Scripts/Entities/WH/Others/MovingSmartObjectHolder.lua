MovingSmartObjectHolder =
{
	Properties =
	{
		bMovingSmartObject = true,
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( MovingSmartObjectHolder, SmartObjectHolder )