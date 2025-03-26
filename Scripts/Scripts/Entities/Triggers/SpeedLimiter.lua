SpeedLimiter =
{
	Properties =
	{
		bEnabled			= true,
		bOnlyPlayers		= 1,
		bAllowSprint		= 0,
		bAllowRun			= 1,
	},

	Editor={
		Model="Editor/Objects/T.cgf",
		Icon="forbiddenarea.bmp",
		ShowBounds = 1,
		IsScalable = false,
		IsRotatable = false
	},
}

-- =============================================================================
function SpeedLimiter:OnPropertyChange()
	self:OnReset()
end

-- =============================================================================
function SpeedLimiter:OnReset()
	self.enabled = nil

	self.inside={}
	self.insideCount=0

	self.triggered=nil

	self:Enable(self.Properties.bEnabled == true)
end

-- =============================================================================
function SpeedLimiter:Enable(enable)
	self.enabled=enable
end

-- =============================================================================
function SpeedLimiter:OnSpawn()
	self:OnReset()
end

-- =============================================================================
function SpeedLimiter:OnSave(props)
    props.enabled = self.enabled
	props.triggered =	self.triggered
end

-- =============================================================================
function SpeedLimiter:OnLoad(props)
  	self:OnReset()
	self.enabled = props.enabled
	self.triggered = props.triggered
end

-- =============================================================================
function SpeedLimiter:CanTrigger(entityId)
	local entity=System.GetEntity(entityId)

	if (not entity) then return; end

	local Properties = self.Properties

	if (Properties.bOnlyPlayers ~= 0 and (not entity.actor or not entity.actor:IsPlayer())) then
		return false
	end

	return true
end

-- =============================================================================
function SpeedLimiter:Trigger(entityId, enter)
	local entity=System.GetEntity(entityId)
	if (not entity) then return; end
	local bAllowSprint = true
	local bAllowRun = true

	if (enter) then
		bAllowSprint = self.Properties.bAllowSprint
		bAllowRun = self.Properties.bAllowRun
	end

	entity.actor:SetMovementRestriction(bAllowSprint, bAllowRun)
	--local linkedEntity = entity.actor:GetLinkedEntity()
	--if (linkedEntity) then
	--	linkedEntity.actor:SetMovementRestriction(bAllowSprint, bAllowRun)
	--end
end

-- =============================================================================
function SpeedLimiter:OnEnterArea(entity, areaId)
	if (not self.enabled) then return; end
	if (not self:CanTrigger(entity.id)) then
		return
	end

	self.inside[entity.id]=true
	self.insideCount=self.insideCount+1

	self:Trigger(entity.id, true)
	self.triggered=true
end

-- =============================================================================
function SpeedLimiter:OnLeaveArea(entity, areaId)
	if (not self.enabled) then return; end
	if (not self:CanTrigger(entity.id)) then
		return
	end

	self.inside[entity.id]=nil
	self.insideCount=self.insideCount-1

	self:Trigger(entity.id, false)
end