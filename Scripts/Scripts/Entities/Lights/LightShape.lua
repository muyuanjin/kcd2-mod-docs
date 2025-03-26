LightShape =
{
	Properties =
	{
		bDisableGI = 0,
		geom_file = "",
	},

	Editor=
	{
		ShowBounds=0,
	},
}

-- =============================================================================
function LightShape:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
end

-- =============================================================================
function LightShape:OnInit()
	self:CreateLightShape()
	self:Activate(1)
end

-- =============================================================================
function LightShape:CreateLightShape()
	local props = self.Properties
	if(props.bDisableGI==1) then
		self:LoadLightShape( 0,props.geom_file,1)
	else
		self:LoadLightShape( 0,props.geom_file,0)
	end
end

-- =============================================================================
function LightShape:OnLoad(props)
	local bCurrentlyHasLightShape = self:IsSlotValid(0)
	if (not bCurrentlyHasLightShape) then
		self:CreateLightShape()
	end
end

-- =============================================================================
function LightShape:OnPropertyChange()
	local props = self.Properties
	if (props.geom_file ~= self.geom_file) then
		self.geom_file = props.goem_file
		self:CreateLightShape()
	end
	self:OnReset()
end

-- =============================================================================
function LightShape:OnUpdate(dt)
	if (System.IsEditor()) then
		self:CreateLightShape()
	end
end

-- =============================================================================
function LightShape:OnReset()
	local bCurrentlyHasLightShape = self:IsSlotValid(0)
	if (not bCurrentlyHasLightShape) then
		self:CreateLightShape()
	end
end