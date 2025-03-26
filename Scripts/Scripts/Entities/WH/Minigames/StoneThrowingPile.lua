Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

StoneThrowingPile =
{
	Editor =
	{
		Icon = "mine.bmp",
	},

	Properties =
	{
		esOrientation="left",
		esThrowType="hole",
		guidSmartObjectType = "",
	},

	bUseTrigger = true
}

-- =============================================================================
function StoneThrowingPile:GetActions( user, firstFast )
	output = {}

	if StoneThrowing.CanUse(user.id, self.id) == 1 then
		local canUseMinigame = Minigame.CanUseMinigame(user.id, E_MUF_CombatDanger);
		AddInteractorAction( output, firstFast, Action():hint( "@ui_start_stone_throwing" ):action( "use" ):interaction( inr_stoneThrowing ):func( StoneThrowingPile.OnUsed ):enabled(canUseMinigame) )
	end

	return output
end

-- =============================================================================
function StoneThrowingPile:OnUsed( user, slot )
	StoneThrowing.StartMinigame(user.id, self.id)
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( StoneThrowingPile, UsableItem );