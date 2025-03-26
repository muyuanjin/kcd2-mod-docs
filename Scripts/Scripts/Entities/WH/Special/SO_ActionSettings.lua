-- =============================================================================
-- Entity that can be used to align animation and limit player camera panning in conjunction with ActionTrigger, derived from SmartObjectHolder
-- =============================================================================

SO_ActionSettings =
{
	Properties =
	{
		guidSmartObjectType = "5d76491c-c52a-42cf-ba9c-4dbdd35d475a",

		CameraLimitHorizontal = 75,
		CameraLimitVerticalMax = 70,
		CameraLimitVerticalMin = -75,
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( SO_ActionSettings, SmartObjectHolder )
