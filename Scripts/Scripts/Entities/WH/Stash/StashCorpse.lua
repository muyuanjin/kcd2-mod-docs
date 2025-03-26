Script.ReloadScript( "SCRIPTS/Entities/WH/Stash/AnimStash.lua")

StashCorpse =
{

	Properties =
	{
		object_Model = "Objects/special/primitive_cylinder_nodrawmat.cgf", 	-- use only .cga models!!!! (.cgf does not contain slot for lockpicking)

		Animation =
		{
			anim_Open="",
			anim_Close="",
		},

		bSkipAngleCheck = true,

		Database = {
			nRestockPeriodDays = 0
		},
    },
}

-- =============================================================================
function StashCorpse:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	local isUsable = self:IsUsable(user)
	if (firstFast and isUsable==0) then
		return {}
	end

	output = {}

	if (self.bOpened == 1) then
		if AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_loot" ):action( "use" ):func( Stash.OnUsed ):interaction( inr_stashClose ) ) then
			return output
		end
	else
		if AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_loot" ):action( "use" ):func( Stash.OnUsed ):interaction( inr_stashOpen ) ) then
			return output
		end
	end

	-- Usable HOLDif
	if ((self.nUserId == 0) and (self.Properties.Lock.bCanLockPick == true) and ((self.bLocked == true) or (Framework.IsValidWUID(Shops.IsLinkedWithShop(self.id))))) then
		AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_lockpick" ):action( "use" ):hintType( AHT_HOLD ):func( Stash.OnUsedHold ):interaction( inr_stashLockpick ) )
	end

	return output
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(StashCorpse, Stash);