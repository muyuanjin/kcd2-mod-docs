Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

WHCartMountPoint =
{
  Properties =
	{
		bSaved_by_game = false,
		object_Model = "objects/special/primitive_cylinder.cgf",
		fUseAngle = 0.92,
		fUseDistance = 2.2,
		bCartFrontSeat = true,
	},

	Editor=
	{
		Icon		="Ladder.bmp",
		IconOnTop 	= 1,
	},

	bUseTrigger = true
}

-- =============================================================================
function WHCartMountPoint:OnEnablePhysics()
	-- When loading streamable layer, OnLevelLoaded has been sent way before.
	-- Nevertheless, interactive collision class must be set for the entity
	self:SetInteractiveCollisionType()
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function WHCartMountPoint:OnPropertyChange()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
-- OnReset called only by the editor.
function WHCartMountPoint:OnReset()
	self:Reset()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function WHCartMountPoint:SetInteractiveCollisionType()
	local filtering = {}
	filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
function WHCartMountPoint:IsUsable(user)
	local entityDir = g_Vectors.temp_v1
	local playerDir = g_Vectors.temp_v2
	local dirToPlayer = g_Vectors.temp_v3
	local entityPos = g_Vectors.temp_v4
	local playerPos = g_Vectors.temp_v5

	entityDir = self:GetDirectionVector(1)
	playerDir = user:GetDirectionVector(1)
	user:GetWorldPos(playerPos)
	self:GetWorldPos(entityPos)
	dirToPlayer = VectorUtils.Subtract(playerPos, entityPos)
	local dist = VectorUtils.LengthSquared(dirToPlayer)
	local zDist = math.abs(dirToPlayer.z - entityPos.z)
	dirToPlayer.z = 0
	dirToPlayer = VectorUtils.Normalize(dirToPlayer)
	entityDir = VectorUtils.Normalize(entityDir)

	-- Distance limit
	local useDistance = self.Properties.fUseDistance
	if (dist > useDistance * useDistance) then
		return 0
	end

	-- Entity front
	local entityRot = VectorUtils.DotProduct2D(entityDir, dirToPlayer)
	if (entityRot < self.Properties.fUseAngle) then
		return 0
	end

	-- Player front
	playerDir.z = 0
	local playerRot = VectorUtils.DotProduct2D(playerDir, VectorUtils.Negate(dirToPlayer))
	if (playerRot < self.Properties.fUseAngle) then
		return 0
	end

--	System.Log("IsUsable: z="..tostring(dirToPlayer.z)
--			..", entRot="..tostring(entityRot)
--			..", playerRot="..tostring(playerRot)
--			..", dist="..tostring(dist)
--			..", zDist="..tostring(zDist))
	
	local parent = self:GetParent()
	if (parent) then
		return Cart.CanPlayerMount(parent.id, self.Properties.bCartFrontSeat);
	end

	return 0
end

-- =============================================================================
function WHCartMountPoint:GetActions(user, firstFast)
	output = {}
	if (self:IsUsable(user) == 1) then
		AddInteractorAction( output, firstFast, Action():hint("ui_hud_mount"):action("use"):func(WHCartMountPoint.OnMount):interaction(inr_Cart))
	end

	return output
end

-- =============================================================================
function WHCartMountPoint:OnMount(user, slot)
	local parent = self:GetParent()
	if (parent) then
		System.Log("WHCartMountPoint:OnMount")
		Cart.MountPlayer(parent.id, self.Properties.bCartFrontSeat);
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(WHCartMountPoint, UsableItem);