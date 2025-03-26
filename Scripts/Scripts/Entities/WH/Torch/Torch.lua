Script.ReloadScript( "SCRIPTS/Entities/Items/PickableItem.lua")

Torch =
{
	Server = {},

	-- cannot by named Properties because when we spawn items properties are replaced by the ones from PickableItems
	Properties2 =
	{
		ParticleEffect = "WH_Particels.fires.torch_trailer",
		HighVisibilityParticleEffect = "WH_Particels.fires.torch_longdistance",
		BurningOutParticleEffect = "WH_Particels.fires.torch_burn_out",
		nBurningOutLightSourceStyle = 22,
		fBurningOutAnimSpeed = 30,
		bActive=true,	-- Activate on startup
		fPreBurnoutDurationSec = 5.0,
		fBurnoutDurationSec = 20.0,
	},

	Properties =
	{
		sHelper = "slt_particle",
		sWH_AI_EntityCategory = "",
	},

	States = { "Active", "Idle", "PreBurnOut", "BurningOut" },
	
	fBurnOutTime = 0.0,
	bIsBurning = false,
}

-- the burnout light is placed slightly above (in the sense of global coordinates) the torch in order to illuminate the torch itself
-- and to cast shorter shadows on the objects around (e.g. stones) when it is on the ground
fBurnoutLightOffset = 0.05 

-- =============================================================================
function Torch:OnLoad(table)
	if (self:IsInState("Active")) then
		self:OnActivate()
	else
		self:OnIdle()
	end
end

-- =============================================================================
function Torch:OnSave(table)
	--System.Log("Torch:OnSave")
end

-- =============================================================================
function Torch:OnPropertyChange()
	--System.Log("Torch:OnPropertyChange")

	self.item:Reset()

	if (self.OnReset) then
		self:OnReset()
	end
end

-- =============================================================================
function Torch:OnReset()
	--System.Log("Torch:OnReset")
	self.bIsBurning = false
	self:GotoState( "Idle" )
	if (self.Properties2.bActive == true) then
		self:GotoState( "Active" )
	end
end

-- =============================================================================
function Torch:OnDestroy()
	self.bIsBurning = false
	self:Cleanup()
end

-- =============================================================================
function Torch:Cleanup()
	if (self.nParticleSlot) then
		self:DeleteParticleEmitter(self.nParticleSlot)
		self:FreeSlot(self.nParticleSlot)
		self.nParticleSlot = nil
	end
	if (self.nParticleSlotBurnout) then
		self:DeleteParticleEmitter(self.nParticleSlotBurnout)
		self:FreeSlot(self.nParticleSlotBurnout)
		self.nParticleSlotBurnout = nil
	end
	if (self.nLightSlot) then
		self:FreeSlot(self.nLightSlot)
		self.nLightSlot = nil
	end
end

-- =============================================================================
function Torch:Event_Enable()
	self:GotoState( "Active" )
	self:ActivateOutput( "Enable", true )
end

-- =============================================================================
function Torch:Event_Disable()
	self:GotoState( "Idle" )
	self:ActivateOutput( "Disable", true )
end

-- =============================================================================
function Torch:Event_GroundCollision()
	if (self:IsInState("PreBurnOut")) then
		self:GotoState("BurningOut")
	end
	self:ActivateOutput("GroundCollision", true )
end

-- =============================================================================
function Torch:Enable()
	self:GotoState("Active")
end

-- =============================================================================
function Torch:Disable()
	self:GotoState("Idle")
end

-- =============================================================================
function Torch:GroundCollision()
	self:GotoState("GroundCollision")
end

-- =============================================================================
function Torch:StartPreBurnOut()
	self:GotoState("PreBurnOut")
end

-- =============================================================================
function Torch:StartBurnOut()
	self:GotoState("BurningOut")
end

-- =============================================================================
function Torch:OnActivate()
	--System.Log("Torch:OnActivate")
	if (not self.nParticleSlot) then
	  self.nParticleSlot = -1
	end

	local holdingEntity = self.item:GetEntityHoldingInHand();
	if( holdingEntity and holdingEntity.soul:HasScriptContext('HighVisibilityTorch') ) then
		self.nParticleSlot = self:LoadParticleEffect( self.nParticleSlot, self.Properties2.HighVisibilityParticleEffect, self.Properties2 )
	else
		self.nParticleSlot = self:LoadParticleEffect( self.nParticleSlot, self.Properties2.ParticleEffect, self.Properties2 )
	end

	local helper_pos = self:GetSlotHelperPos(0, self.Properties.sHelper, true)
	local helper_dir = self:GetHelperDir(self.Properties.sHelper, true)
	self:SetSlotPosAndDir(self.nParticleSlot, helper_pos, helper_dir)

	self.bIsBurning = true
	if (holdingEntity) then
		self.sLightArchetype = holdingEntity.human:GetTorchLightArchetype()
	end -- else it is a burning out torch, the light archetype has already been set before
end

-- =============================================================================
function Torch:OnIdle()
	-- when going from active to idle, keep the torch active - it will be burning out in case it is dropped
	-- if the torch is being holstered, the entity will be destroyed later this frame anyway, so it does not matter that it is not turned off yet
	if (self.bIsBurning == true) then
		-- just turn on update and switch to PreBurnOut in Update. Switch here would mean nested state change which would produce wrong order of OnStateChanged signals
		self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
		self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 0) 
		self:Activate(1)
	else
		self:Cleanup()
		self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 2)
	end
end

-- =============================================================================
function Torch:OnPreBurnOut()
	self.fBurnOutTime = self.Properties2.fPreBurnoutDurationSec
	self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 0)
end

-- =============================================================================
function Torch:OnBurningOut()
	if (self.nParticleSlot) then
		self:DeactivateParticleEmitter(self.nParticleSlot)
	end

	if (not self.nParticleSlotBurnout) then
		self.nParticleSlotBurnout = -1
	end

	self.nParticleSlotBurnout = self:LoadParticleEffect(self.nParticleSlotBurnout, self.Properties2.BurningOutParticleEffect, self.Properties2 )
	local helper_pos = self:GetSlotHelperPos(0, self.Properties.sHelper, true)
	local helper_dir = self:GetHelperDir(self.Properties.sHelper, true)
	self:SetSlotPosAndDir(self.nParticleSlotBurnout, helper_pos, helper_dir)

	if (not self.nLightSlot) then
		self.nLightSlot = -1
	end
	local lp = System.GetArchetypeProperties(self.sLightArchetype)
	local lt = Light.GetLightDesc(lp, self.nLightSlot)
	-- we copy everything from the base light, but make it one shot using the burnout style
	lt.style = self.Properties2.nBurningOutLightSourceStyle
	lt.anim_speed = self.Properties2.fBurningOutAnimSpeed
	lt.anim_type = "OneShot"

	self.nLightSlot = self:LoadLight( self.nLightSlot, lt )
	self:SetSlotPosAndDir(self.nLightSlot, helper_pos, helper_dir)

	self.fBurnOutTime = self.Properties2.fBurnoutDurationSec
end

-- =============================================================================
-- Active State
Torch.Server.Active =
{
	OnBeginState = function( self )
		self:OnActivate()
		-- don't cast shadows by the torch model (useful even for the fake light created by code)
		self:SetFlags(ENTITY_FLAG_CASTSHADOW, 2)
	end,
}

-- =============================================================================
-- Idle State
Torch.Server.Idle =
{
	OnBeginState = function( self )
		self:OnIdle()
	end,
	OnUpdate = function(self, dt)
		self:StartPreBurnOut()
	end,
}

-- =============================================================================
Torch.Server.PreBurnOut =
{
	OnBeginState = function( self )
		self:OnPreBurnOut()
	end,
	OnUpdate = function(self, dt)
		self.fBurnOutTime = self.fBurnOutTime - dt
		if (self.fBurnOutTime <= 0.0) then
			self:StartBurnOut()
		end
	end,
}

-- =============================================================================
Torch.Server.BurningOut =
{
	OnBeginState = function( self )
		self:OnBurningOut()
	end,
	OnUpdate = function(self, dt)
		--System.Log("Torch:BurningOutUpdate" .. tostring(self.fBurnOutTime))
		self.fBurnOutTime = self.fBurnOutTime - dt
		if (self.fBurnOutTime <= 0.0) then
			self.bIsBurning = false
			self:Disable()
		else
			-- since the torch can rotate when it is dropped on the ground, we have to update the position all the time to keep the light above the torch (see comment for fBurnoutLightOffset)
			local worldPos = self:GetSlotWorldPos(self.nParticleSlotBurnout) -- there is no GetSlotHelperPosWORLD, so we use the nParticleSlotBurnout to get the slot position in world coos
			worldPos.z = worldPos.z + fBurnoutLightOffset
			self:SetSlotWorldTM(self.nLightSlot, worldPos, self:GetSlotWorldDir(self.nLightSlot))
		end
	end,
}

-- =============================================================================
Torch.FlowEvents =
{
	Inputs =
	{
		Disable = { Torch.Event_Disable, "bool" },
		Enable = { Torch.Event_Enable, "bool" },
		GroundCollision = { Torch.Event_GroundCollision, "bool"},
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		GroundCollision = "bool",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(Torch, PickableItem);