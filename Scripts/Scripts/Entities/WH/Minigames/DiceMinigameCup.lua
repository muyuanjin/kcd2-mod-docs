Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

DiceMinigameCup =
{
	--Server = {},
	--Client = {},

	Properties =
	{
		bSaved_by_game = false,
		-- sWH_AI_EntityCategory = "",
		object_Model = "objects/manmade/task_specific_props/entertainment/games/dice/dice_cup_b.cgf",
		-- fSizeX = 1,
		-- fSizeY = 1,
		-- fCheckerSize = 0.039,

		Physics = {
			bPhysicalize 		= false, 	-- True if object should be physicalized at all.
			bRigidBody 			= false, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= -1,
		},
	},


	Editor =
	{
		Icon = "animobject.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 0,
	},
}

function DiceMinigameCup:GetActions(user, firstFast)
	return {}
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(DiceMinigameCup, UsableItem)
