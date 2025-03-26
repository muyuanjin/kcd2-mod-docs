Script.ReloadScript( "Scripts/Entities/Physics/BasicEntity.lua" )

Chair =
{
	Properties =
	{
		bSaved_by_game = false,
--		guidSmartObjectType = "",
--		soclass_SmartObjectHelpers = "",
--		sWH_AI_EntityCategory = "",
--		usabilityDistance = 1.75,

		object_Model="objects/props/furniture/chairs_benches/tripod_chair_01.cgf",

		bUsable_by_player = true,

		Script = {
			Misc = '',
		},
	},

--	bIsBeingUsed = false,
}

--[[
-- =============================================================================
function Chair:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	local soEntity = self:GetLinkTarget("so_chair")
	XGenAIModule.SendMessageToEntity(soEntity.this.id, "player:getUsableMessage")


	output = {}

	if not self.bIsBeingUsed then
		AddInteractorAction(output, firstFast, Action():hint("@ui_hud_sit"):action("use"):hintType(AHT_RELEASE):func(Chair.OnUse):interaction(inr_chair))
	else
		AddInteractorAction(output, firstFast, Action():hint("@ui_hud_sit"):action("use"):enabled(false))
	end

	return output

end
--]]


--[[
-- =============================================================================
function Chair:IsUsable(user)

	local myDirection = g_Vectors.temp_v1
	local vecToPlayer = g_Vectors.temp_v2
	local myPos = g_Vectors.temp_v3

	myDirection = self:GetDirectionVector(0)

	user:GetWorldPos(vecToPlayer)
	self:GetWorldPos(myPos)

	vecToPlayer = VectorUtils.Subtract(myPos,vecToPlayer)
	local len = VectorUtils.Length(vecToPlayer)

	if(len <= self.Properties.usabilityDistance) then
		return 1
	end
	return 0
end

-- =============================================================================
function Chair:OnUse()
	local soEntity = self:GetLinkTarget("so_chair")
	XGenAIModule.SendMessageToEntityData(player.this.id, "player:request", {target = soEntity.this.id, mode = "use"})
end

-- =============================================================================
function Chair:OnReset()
	self.bIsBeingUsed = false
end
--]]

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( Chair, BasicEntity )