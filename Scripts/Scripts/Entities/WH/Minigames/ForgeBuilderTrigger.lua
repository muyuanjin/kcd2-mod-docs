Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

ForgeBuilderTrigger =
{
	Properties =
	{
		ActionHint = "ui_start_forge_builder",
		Angle = {
			fApproachDirection = 0,
			fAngleTolerance = 180,
		},
		fActiveDistance = -1,
		fActiveMinDistance = -1,
		fZToleration = -1,
	},

	Editor =
	{
		Icon = "animobject.bmp",
	},

	bUseTrigger = true
}

-- =============================================================================
function ForgeBuilderTrigger:GetActions(user, firstFast)
	output = {}

	if not self:IsActionAvailable(user, self.Properties) then
		return output
	end

	if ForgeBuilder.CanUse(user.id, self.id) == 1 and not user.soul:HasScriptContext("minigame_disabledForgeBuilder") then
		local canUseMinigame = Minigame.CanUseMinigame(user.id);
		AddInteractorAction( output, firstFast, Action():hint(self.Properties.ActionHint):action( "use" ):interaction( inr_forgeBuilder ):func( ForgeBuilderTrigger.OnUsed ):enabled(canUseMinigame) )
	end

	return output
end

-- =============================================================================
function ForgeBuilderTrigger:OnUsed( user, slot )
	ForgeBuilder.StartMinigame(user.id, self.id);
end

-- =============================================================================
function ForgeBuilderTrigger:IsActionAvailable(user, properties)
	if(properties.Angle.fAngleTolerance < 180 and (math.acos(VectorUtils.DotProduct2D(VectorUtils.Rotate2D(self:GetWorldDir(),math.rad(properties.Angle.fApproachDirection)), VectorUtils.GetDirection( self:GetPos(), user:GetPos()))) > math.rad(properties.Angle.fAngleTolerance))) then
		--Dump("Disabled by angle check")
		return false -- cannot be used from different angle than specified
	elseif(properties.fActiveDistance ~= -1 and VectorUtils.Distance(self:GetWorldPos(),user:GetWorldPos()) > properties.fActiveDistance) then
		return false
	elseif(properties.fActiveMinDistance ~= -1 and VectorUtils.Distance(self:GetWorldPos(),user:GetWorldPos()) < properties.fActiveMinDistance) then
		return false
	elseif(properties.fZToleration ~= -1 and math.abs(VectorUtils.Subtract(self:GetWorldPos(),user:GetWorldPos()).z) > properties.fZToleration) then
		return false
	else
		return true
	end

end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(ForgeBuilderTrigger, UsableItem);