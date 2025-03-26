GeomEntity =
{
	Properties =
	{
		bSaved_by_game = false,
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		bInteractiveCollisionClass = false,
		sWH_AI_EntityCategory = "",
		bUpdateOnlyByScript = false, -- JFilek, option to register to update only when required
		bAlwaysLoaded = false, -- WH[PD] Saveload not implemented for this!

		Script = {
			Misc = ''
		},

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= -1,
		},
	},

 Editor={
 Icon="physicsobject.bmp",
 IconOnTop=1,
	},

	Client = {},
	Server = {},
}

-- =============================================================================
function GeomEntity.Client:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
end

-- =============================================================================
function GeomEntity.Server:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function GeomEntity:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function GeomEntity:OnReset(toGame)
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function GeomEntity:OnSpawn()
	self:Reset()
end

-- =============================================================================
function GeomEntity:Reset()
	self:PhysicalizeThis()
	-- JFilek set proper update policy for on demand updates
	if (self.Properties.bUpdateOnlyByScript == true) then
		self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
	end
end

-- =============================================================================
function GeomEntity:PhysicalizeThis()
	local Physics = self.Properties.Physics
	EntityCommon.PhysicalizeRigid( self, 0, Physics, true )
end


-- =============================================================================
function GeomEntity.Client:OnPhysicsBreak( vPos,nPartId,nOtherPartId )
	self:ActivateOutput("Break",nPartId+1 )
end

-- =============================================================================
function GeomEntity:Event_Remove()
	self:DrawSlot(0,0)
	self:DestroyPhysics()
	self:ActivateOutput( "Remove", true )
end

-- =============================================================================
function GeomEntity:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
end

-- =============================================================================
function GeomEntity:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
end

-- =============================================================================
function GeomEntity:OnLoad(table)
	self.health = table.health
	self.dead = table.dead
	if(table.bAnimateOffScreenShadow) then
		self.bAnimateOffScreenShadow = table.bAnimateOffScreenShadow
	else
		self.bAnimateOffScreenShadow = false
	end
end

-- =============================================================================
function GeomEntity:OnSave(table)
	table.health = self.health
	table.dead = self.dead
	if(self.bAnimateOffScreenShadow) then
		table.bAnimateOffScreenShadow = self.bAnimateOffScreenShadow
	else
		table.bAnimateOffScreenShadow = false
	end
end

-- =============================================================================
function GeomEntity.Client:OnLevelLoaded()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function GeomEntity:OnPropertyChange()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function GeomEntity:OnEnablePhysics()
	-- When loading streamable layer, OnLevelLoaded has been sent way before.
	-- Nevertheless, interactive collision class must be set for the entity
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function GeomEntity:SetInteractiveCollisionType()
	local filtering = {}

	if(self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
GeomEntity.FlowEvents =
{
	Inputs =
	{
		Hide = { GeomEntity.Event_Hide, "bool" },
		UnHide = { GeomEntity.Event_UnHide, "bool" },
		Remove = { GeomEntity.Event_Remove, "bool" },
	},
	Outputs =
	{
		Hide = "bool",
		UnHide = "bool",
		Remove = "bool",
		Break = "int",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.MakeTargetableByAI(GeomEntity)
EntityCommon.MakeKillable(GeomEntity)
EntityCommon.MakeRenderProxyOptions(GeomEntity);