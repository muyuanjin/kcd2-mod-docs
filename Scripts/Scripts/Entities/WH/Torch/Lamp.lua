Script.ReloadScript( "SCRIPTS/Entities/Items/PickableItem.lua")

Lamp =
{
	-- cannot by named Properties because when we spawn items properties are replaced by the ones from PickableItems
	Properties2 =
	{
		ParticleEffect = "WH_Particels.fires.candle",
		LightSource = "Lights.Standard.Light_Lantern",
		Helper = "slt_particle",
	},

	Properties =
	{
		sWH_AI_EntityCategory = "",
	},

}

-- =============================================================================
function Lamp:OnLoad(table)
	--System.Log("Lamp:OnLoad")
end

-- =============================================================================
function Lamp:OnSave(table)
	--System.Log("Lamp:OnSave")
end

-- =============================================================================
function Lamp:OnPropertyChange()
	--System.Log("Lamp:OnPropertyChange")

	self.item:Reset()

	if (self.OnReset) then
		self:OnReset()
	end
end

-- =============================================================================
function Lamp:OnDestroy()
	self:Cleanup()
end

-- =============================================================================
function Lamp:Cleanup()
	if (self.nParticleSlot) then
		self:DeleteParticleEmitter(self.nParticleSlot)
		self:FreeSlot(self.nParticleSlot)
		self.nParticleSlot = nil
	end
	if (self.nLightSlot) then
		self:FreeSlot(self.nLightSlot)
		self.nLightSlot = nil
	end
end

-- =============================================================================
function Lamp:OnReset()
	--System.Log("Lamp:OnReset")
	self:Cleanup()
	self:TurnLightOn()
end

-- =============================================================================
function Lamp:ModelReset()
	self:TurnLightOn()
end

-- =============================================================================
-- since the model of the lamp uses materials that already look like lit, keep it always lit (when spawned)
function Lamp:TurnLightOn()
	--System.Log("Lamp:OnActivate")
	if (not self.nParticleSlot) then
		self.nParticleSlot = -1
	end
	self.nParticleSlot = self:LoadParticleEffect( self.nParticleSlot, self.Properties2.ParticleEffect, self.Properties2 )

	local lp = System.GetArchetypeProperties(self.Properties2.LightSource)	
	if (not self.nLightSlot) then
		self.nLightSlot = -1
	end
	local lt = Light.GetLightDesc(lp, self.nLightSlot)
	self.nLightSlot = self:LoadLight( self.nLightSlot, lt )


	local helper_pos = self:GetSlotHelperPos(0, self.Properties2.Helper, true)
	local helper_dir = self:GetHelperDir(self.Properties2.Helper, true)
	self:SetSlotPosAndDir(self.nParticleSlot, helper_pos, helper_dir)
	self:SetSlotPosAndDir(self.nLightSlot, helper_pos, helper_dir)

	self:SetFlags(ENTITY_FLAG_CASTSHADOW, 2)
end

-- =============================================================================
Lamp.FlowEvents =
{
	Inputs =
	{
		ModelReset = { Lamp.ModelReset, "bool"},
	},
	Outputs =
	{
		ModelReset = "bool",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(Lamp, PickableItem);