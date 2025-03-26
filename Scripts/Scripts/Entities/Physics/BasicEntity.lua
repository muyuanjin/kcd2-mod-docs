BasicEntity = {
	Properties = {
		soclasses_SmartObjectClass = "",
      sWH_AI_EntityCategory = "",
		--bAutoGenAIHidePts = 0,
		bMissionCritical = false,
		bCanTriggerAreas = false,
		DmgFactorWhenCollidingAI = 1,

		object_Model = "objects/default/primitive_pyramid.cgf",
		Physics = {
			bPhysicalize = true, -- True if object should be physicalized at all.
			bRigidBody = true, -- True if rigid body, False if static.
			bPushableByPlayers = true,

			Density = -1,
			Mass = -1,
		},
		MultiplayerOptions = {
			bNetworked		= false,
		},

		bExcludeCover=false,
	},

	Client = {},
	Server = {},

	-- Temp.
	_Flags = {},

		Editor={
		Icon = "physicsobject.bmp",
		IconOnTop=1,
	  },

}

local Physics_DX9MP_Simple = {
	bPhysicalize = true, -- True if object should be physicalized at all.
	bPushableByPlayers = false,

	Density = 0,
	Mass = 0,

}

-- =============================================================================
function BasicEntity:OnSpawn()
	if (self.Properties.MultiplayerOptions.bNetworked == false) then
		self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
	end

	self.bRigidBodyActive = true

	self:SetFromProperties()
end

-- =============================================================================
function BasicEntity:SetFromProperties()
	local Properties = self.Properties

	if (Properties.object_Model == "") then
		do return end
	end

	self.freezable = (tonumber(Properties.bFreezable) ~= 0)

	self:SetupModel()

	-- Mark AI hideable flag.
	if (Properties.bAutoGenAIHidePts == 1) then
		self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 0); -- set
	else
		self:SetFlags(ENTITY_FLAG_AI_HIDEABLE, 2); -- remove
	end

	if (self.Properties.bCanTriggerAreas == true) then
		self:SetFlags(ENTITY_FLAG_TRIGGER_AREAS, 0); -- set
	else
		self:SetFlags(ENTITY_FLAG_TRIGGER_AREAS, 2); -- remove
	end
end

-- =============================================================================
function BasicEntity:SetupModel()
	local Properties = self.Properties
	self:LoadObject(0,Properties.object_Model)

	if (Properties.Physics.bPhysicalize == true) then
		self:PhysicalizeThis()
	end
end

-- =============================================================================
function BasicEntity:OnLoad(table)
	self.health = table.health
	self.dead = table.dead
end

function BasicEntity:OnSave(table)
	table.health = self.health
	table.dead = self.dead
end

-- =============================================================================
function BasicEntity:IsRigidBody()
	local Properties = self.Properties
	local Mass = Properties.Mass
	local Density = Properties.Density
	if (Mass == 0 or Density == 0 or Properties.bPhysicalize == false) then
  		return false
	end
	return true
end

-- =============================================================================
function BasicEntity:PhysicalizeThis()
	-- Init physics.
	local Physics = self.Properties.Physics
	if (CryAction.IsImmersivenessEnabled() == 0) then
		Physics = Physics_DX9MP_Simple
	end
	EntityCommon.PhysicalizeRigid( self,0,Physics,self.bRigidBodyActive )
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function BasicEntity:OnPropertyChange()
	-- if the properties are changed, we force a reset in the __usable
	if (self.__usable ~= nil) then
		if (self.__origUsable ~= self.Properties.bUsable or self.__origPickable ~= self.Properties.bPickable) then
			self.__usable = nil
		end
	end
	self:SetFromProperties()
end

-- =============================================================================
-- OnReset called only by the editor.
function BasicEntity:OnReset()
	self:ResetOnUsed()
	self:DrawSlot(0,1)

	local PhysProps = self.Properties.Physics
	if (PhysProps.bPhysicalize == true) then
		self:PhysicalizeThis()
		self:AwakePhysics(0)
	end
end

-- =============================================================================
function BasicEntity:Event_Remove()
	self:DrawSlot(0,0)
	self:DestroyPhysics()
	self:ActivateOutput( "Remove", true )
end

-- =============================================================================
function BasicEntity:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
	if CurrentCinematicName then
		DebugUtils.Log("%.3f %s %s : Event_Hide", _time, CurrentCinematicName, self:GetName() )
	end
end

-- =============================================================================
function BasicEntity:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
	if CurrentCinematicName then
		DebugUtils.Log("%.3f %s %s : Event_UnHide", _time, CurrentCinematicName, self:GetName() )
	end
end

-- =============================================================================
function BasicEntity:Event_Ragdollize()
	self:RagDollize(0)
	self:ActivateOutput( "Ragdollized", true )
	if (self.Event_RagdollizeDerived) then
		self:Event_RagdollizeDerived()
	end
end

-- =============================================================================
function BasicEntity.Client:OnPhysicsBreak( vPos,nPartId,nOtherPartId )
	self:ActivateOutput("Break",nPartId+1 )
end

-- =============================================================================
function BasicEntity:IsUsable(user)
	local ret = nil
	if self.__usable == nil then self.__usable = self.Properties.bUsable end

	local mp = System.IsMultiplayer()
	if(mp and mp~=0) then
		return 0
	end

	if (self.__usable == true) then
		ret = 2
	else
		local PhysProps = self.Properties.Physics
		if (self:IsRigidBody() == true and user and user.CanGrabObject) then
			ret = user:CanGrabObject(self)
		end
	end

	return ret or 0
end

-- =============================================================================
BasicEntity.FlowEvents =
{
	Inputs =
	{
		Used = { BasicEntity.Event_Used, "bool" },
		EnableUsable = { BasicEntity.Event_EnableUsable, "bool" },
		DisableUsable = { BasicEntity.Event_DisableUsable, "bool" },

		Hide = { BasicEntity.Event_Hide, "bool" },
		UnHide = { BasicEntity.Event_UnHide, "bool" },
		Remove = { BasicEntity.Event_Remove, "bool" },
		Ragdollize = { BasicEntity.Event_Ragdollize, "bool" },
	},
	Outputs =
	{
		Used = "bool",
		EnableUsable = "bool",
		DisableUsable = "bool",
		Activate = "bool",
		Hide = "bool",
		UnHide = "bool",
		Remove = "bool",
		Ragdollized = "bool",
		Break = "int",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.MakeUsable(BasicEntity)
EntityCommon.MakePickable(BasicEntity)
--EntityCommon.MakeTargetableByAI(BasicEntity)
--EntityCommon.MakeKillable(BasicEntity)
EntityCommon.AddHeavyObjectProperty(BasicEntity)
EntityCommon.AddInteractLargeObjectProperty(BasicEntity)
EntityCommon.SetupCollisionFiltering(BasicEntity)
