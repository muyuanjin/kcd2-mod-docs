Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

DiceInteractor =
{
	--Server = {},
	--Client = {},

	Properties =
	{
		-- sWH_AI_EntityCategory = "",
		object_Model = "objects/manmade/task_specific_props/entertainment/games/dice/dice_board.cgf",
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

	diceAvailable = true,
}

-- =============================================================================
function DiceInteractor:GetActions(user, firstFast)
   if (user == nil or (not self.diceAvailable) ) then
     return {}
   end

   output = {}

   local canUseMinigame = Minigame.CanUseMinigame(user.id);
   AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_play_dice" ):action( "use" ):func( DiceInteractor.OnUsed ):enabled(canUseMinigame):interaction( inr_dice ) )

   return output
end

-- =============================================================================
function DiceInteractor:OnUsed(user)
 	if (user) then
    --Minigame.StartDiceByName("test_dice01")
    --self:ActivateOutput( "OnUse", true )
	  local link = self:GetLink(0)
	  XGenAIModule.SendMessageToEntity(link.this.id, "dice:init", "forceDialog(true)")
 	end
end

function DiceInteractor:SetDiceAvailable(availability)
	self.diceAvailable = availability
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(DiceInteractor, UsableItem)
