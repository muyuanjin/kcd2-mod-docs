DetailMovementSmartObject =
{
	Properties =
	{
		MovementDetails = {
			esMovementSpeed = 'b_Walk',
			fContinualSuccessDistance = 10,
		},
	},
	
	movementSpeed = 'Walk',
}


-- =============================================================================
function DetailMovementSmartObject:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
function DetailMovementSmartObject:OnSpawn()
	self:Reset()
end

-- =============================================================================
function DetailMovementSmartObject:Reset()
	if self.Properties.MovementDetails.esMovementSpeed == 'a_RelaxedWalk' then
		self.movementSpeed = 'RelaxedWalk'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'b_Walk' then
		self.movementSpeed = 'Walk'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'c_AlertedWalk' then
		self.movementSpeed = 'AlertedWalk'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'd_Run' then
		self.movementSpeed = 'Run'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'e_FastRun' then
		self.movementSpeed = 'FastRun'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'f_SlowSprint' then
		self.movementSpeed = 'SlowSprint'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'g_ModerateSprint' then
		self.movementSpeed = 'ModerateSprint'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'h_Sprint' then
		self.movementSpeed = 'Sprint'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'i_SlowestDash' then
		self.movementSpeed = 'SlowestDash'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'j_SlowDash' then
		self.movementSpeed = 'SlowDash'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'k_ModerateDash' then
		self.movementSpeed = 'ModerateDash'
	elseif self.Properties.MovementDetails.esMovementSpeed == 'l_Dash' then
		self.movementSpeed = 'Dash'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( DetailMovementSmartObject, SmartObjectHolder )