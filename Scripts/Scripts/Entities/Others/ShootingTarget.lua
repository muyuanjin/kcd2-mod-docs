--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2006.

ShootingTarget =
{
	Client = {},
	Server = {},

	Properties=
	{
		fileModel 								= "objects/manmade/task_specific_props/combat/archery/target_small.cgf",
		iPhysicalizeMode						= 0,	--0 = don't physicalize, ever
														--1 = physicalize on spawn
														--2 = physicalize on hit by player only
														--3 = physicalize on hit by anybody
		iHitScoreValue 							= 1,	-- defines score value per hit for competitions where hit placement on target is irrelevant
		hitMsgListener							= "",
		bSaved_by_game							= false,

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			Density 			= 20,
			Mass 				= -1,
		},
		isShootingTarget 						= true,	-- True if entity hit with missile weapon should by process by RPG event
	},
	Editor=
	{
		Icon		="ShootingTarget.bmp",
	},
	shotDown		 = 0,	-- for tracking targets that can only be scored once
	origRot,				-- starting rotation of the entity, for reset purposes
	origPos,				-- starting position of the entity, for reset purposes
	listener				-- hitMsgListener wuid reference
}
ACTIVATION_TIMER = 0
TURN_TIMER = 1

-- =============================================================================
function ShootingTarget:OnLoad(table)
	self.shotDown = table.shotDown
end

-- =============================================================================
function ShootingTarget:OnSave(table)
	table.shotDown = self.shotDown
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function ShootingTarget:OnPropertyChange()
	if (self.Properties.fileModel ~= "") then
		self:LoadObject(0, self.Properties.fileModel)
	end
	self:OnReset()
end

-- =============================================================================
-- OnReset called only by the editor.
function ShootingTarget:OnReset()
	self:Init()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function ShootingTarget:OnSpawn()
	self:Init()
end

function ShootingTarget:Init()
	self.origPos = self:GetPos()
	self.origRot = self:GetAngles()
	if (self.Properties.fileModel ~= "") then
		self:LoadObject(0, self.Properties.fileModel)
	end
	--turn on collisions only
	self:PhysicalizeThis()
	self.shotDown = 0
	--turn on physics from start
	if ( self.Properties.iPhysicalizeMode == 1) then
		local physics = self.Properties.Physics
		EntityCommon.PhysicalizeRigid( self, 0, physics, true )
	end
end

function ShootingTarget:ResetPosition()
	self:SetPos(self.origPos)
	self:SetAngles(self.origRot)
	self.shotDown = 0

	if ( self.Properties.iPhysicalizeMode > 1 ) then
		--inactivate physics
		local physics = self.Properties.Physics
		EntityCommon.PhysicalizeRigid( self, 0, physics, false )
	end
end

-- =============================================================================
function ShootingTarget:PhysicalizeThis()
	local physics = self.Properties.Physics
	EntityCommon.PhysicalizeRigid( self, 0, physics, false )
end


-- =============================================================================
function ShootingTarget.Client:OnHit(hit)
	local phys_mode=self.Properties.iPhysicalizeMode
	--0 = don't physicalize, ever
	--1 = physicalize on spawn
	--2 = physicalize on hit by player only
	--3 = physicalize on hit by anybody

	if (self.shotDown == 0) then
		--notify listener
		if (self.Properties.hitMsgListener ~= '') then
			local listener = self.listener or XGenAIModule.GetMyWUID(System.GetEntityByName(self.Properties.hitMsgListener))
			local hitMsgData =
			{
				hitScore = self.Properties.iHitScoreValue,
				shooter = System.GetEntity(hit.attackerId).this.id
			}
			XGenAIModule.SendMessageToEntityData(listener,"shootingTargetHitData",hitMsgData)
		end
	end

	if( phys_mode < 1 or  (hit.attackerId ~= player.id and phys_mode == 2) ) then
		--stay static
		return
	else
		self:AddPhysicalImpulse(hit)
		if ( phys_mode > 1 ) then
			self.shotDown = 1
		end
	end
end

function ShootingTarget:AddPhysicalImpulse(hit)
	--temp solution to lacking kinetic energy data circumvention
	local maxSkill = 30
	local shooterSkill = System.GetEntity(hit.attackerId).soul:GetSkillLevel("marksmanship")
	local normalizedSkill = shooterSkill/maxSkill

	local physics = self.Properties.Physics
	local strength = 1 + normalizedSkill*5  --PLACEHOLDER solution to lacking impact kinetic energy data
	EntityCommon.PhysicalizeRigid( self, 0, physics, true )
	self:AddImpulse(-1, hit.pos, hit.dir, strength, 1)
end

-- =============================================================================
function ShootingTarget:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
end

-- =============================================================================
function ShootingTarget:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
end