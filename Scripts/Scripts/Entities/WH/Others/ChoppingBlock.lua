ChoppingBlock =
{
	Server = {},
	Client = {},

	Properties =
	{
		sWH_AI_EntityCategory = "",
		object_Model = "objects/props/misc/wood_stock_anim/wood_stock_anim.cgf",

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= -1,
		},

		Cutting = {
			Effect = "particles_woodcutting.cutting.wood_split",
			Effect2 = "particles_woodcutting.cutting.wood_chip",
			--upDir = {x=0,y=0,z=1},
			--upDir = {x=1,y=0,z=0},
			pos = {x=0,y=0,z=0},
		},
	},


	Editor=
	{
		Icon		="animobject.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},

	m_upDir = {x=1,y=0,z=0},

}

-- =============================================================================
function ChoppingBlock:OnLoad(table)

end

-- =============================================================================
function ChoppingBlock:OnSave(table)

end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function ChoppingBlock:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function ChoppingBlock:OnReset()
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function ChoppingBlock:OnSpawn()
	self:Reset()
end

-- =============================================================================
function ChoppingBlock:Reset()
	System.Log("ChoppingBlock:Reset")
	if (self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
		self:PreLoadParticleEffect(self.Properties.Cutting.Effect)
		self:PreLoadParticleEffect(self.Properties.Cutting.Effect2)
	end

	if (self.Properties.Cutting.pos.x == 0) and (self.Properties.Cutting.pos.y == 0) and (self.Properties.Cutting.pos.z == 0) then
		self.Properties.Cutting.pos = self:GetPos()
	end

	self:PhysicalizeThis()
end

-- =============================================================================
function ChoppingBlock:PhysicalizeThis()
	local Physics = self.Properties.Physics
	EntityCommon.PhysicalizeRigid( self, 0, Physics, true )
end

-- =============================================================================
function ChoppingBlock:RunCuttingEffect()
	Particle.SpawnEffect(self.Properties.Cutting.Effect, self.Properties.Cutting.pos, self.m_upDir)
end

-- =============================================================================
function ChoppingBlock:RunCuttingEffect2()
	Particle.SpawnEffect(self.Properties.Cutting.Effect2, self.Properties.Cutting.pos, self.m_upDir)
end

-- =============================================================================
-- Events
-- =============================================================================
function ChoppingBlock:Event_EffPos(sender, pos)
	self.Properties.Cutting.pos = pos
end

-- =============================================================================
function ChoppingBlock:Event_EffSpawn(sender)
	self:RunCuttingEffect()
end

-- =============================================================================
function ChoppingBlock:Event_Eff2Spawn(sender)
	self:RunCuttingEffect2()
end

-- =============================================================================
function ChoppingBlock:Event_LogEntityId(sender, entityId)
	self.logEntity = System.GetEntity(entityId)
end

-- =============================================================================
function ChoppingBlock:Event_LogHide(sender, hide)
	local intHide = hide and 1 or 0

	if self.logEntity ~= nil then
		self.logEntity:Hide(intHide)

		self:ActivateOutput("LogVisible", hide)

	end
end

-- =============================================================================
ChoppingBlock.FlowEvents =
{
	Inputs =
	{
		EffectPos = { ChoppingBlock.Event_EffPos, "Vec3" },
		EffectSpawn = { ChoppingBlock.Event_EffSpawn, "void" },
		Effect2Spawn = { ChoppingBlock.Event_Eff2Spawn, "void" },

		LogEntityId = { ChoppingBlock.Event_LogEntityId, "int"},
		LogHide = { ChoppingBlock.Event_LogHide, "bool" },
	},

	Outputs =
	{
		LogVisible = "bool",
	},

}
