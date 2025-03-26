-- =============================================================================
-- Entity defining properties for waiting NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_WaitingSpot =
{
	Properties =
	{
		WaitingSpot =
		{
			esWaitingSpot_Variant = 'male_armAkimbo',
		},
		MovementDetails = {
			esMovementSpeed = 'b_Walk',
		},
	},

	unstanceName_male = 'waiting_armAkimbo',
	unstanceName_female = 'waiting_holdingArm',
	movementSpeed = 'Walk',

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_WaitingSpot:UpdateData()
	local variant = self.Properties.WaitingSpot.esWaitingSpot_Variant
	local movementSpeedVariant = self.Properties.MovementDetails.esMovementSpeed

	if variant == 'male_armAkimbo' then
		self.unstanceName_male = 'waiting_armAkimbo'
		self.unstanceName_female = 'waiting_holdingArm'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drink_var01.cgf'
	elseif variant == 'male_armsCrossed' then
		self.unstanceName_male = 'waiting_armsCrossed'
		self.unstanceName_female = 'waiting_holdingArm'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_dance_var01.cgf'
	elseif variant == 'male_nervous_armsAkimbo' then
		self.unstanceName_male = 'waiting_nervous_armsAkimbo'
		self.unstanceName_female = 'waiting_nervous_lookingAround'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drink_var01.cgf'
	elseif variant == 'male_nervous_armOnChin' then
		self.unstanceName_male = 'waiting_nervous_armOnChin'
		self.unstanceName_female = 'waiting_nervous_lookingAround'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_dance_var01.cgf'
	elseif variant == 'male_nervous_lookingAround' then
		self.unstanceName_male = 'waiting_nervous_lookingAround'
		self.unstanceName_female = 'waiting_nervous_lookingAround'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drunk.cgf'
	elseif variant == 'male_alarmed' then
		self.unstanceName_male = 'waiting_alarmed'
		self.unstanceName_female = 'waiting_nervous_lookingAround'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'female_holdingArm' then
		self.unstanceName_male = 'waiting_armAkimbo'
		self.unstanceName_female = 'waiting_holdingArm'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_dance_var02.cgf'
	elseif variant == 'female_nervous_lookingAround' then
		self.unstanceName_male = 'waiting_nervous_lookingAround'
		self.unstanceName_female = 'waiting_nervous_lookingAround'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_stand_talk.cgf'
	end
	
	if movementSpeedVariant == 'a_RelaxedWalk' then
		self.movementSpeed = 'RelaxedWalk'
	elseif movementSpeedVariant == 'b_Walk' then
		self.movementSpeed = 'Walk'
	elseif movementSpeedVariant == 'c_AlertedWalk' then
		self.movementSpeed = 'AlertedWalk'
	elseif movementSpeedVariant == 'd_Run' then
		self.movementSpeed = 'Run'
	elseif movementSpeedVariant == 'e_FastRun' then
		self.movementSpeed = 'FastRun'
	elseif movementSpeedVariant == 'f_SlowSprint' then
		self.movementSpeed = 'SlowSprint'
	elseif movementSpeedVariant == 'g_ModerateSprint' then
		self.movementSpeed = 'ModerateSprint'
	elseif movementSpeedVariant == 'h_Sprint' then
		self.movementSpeed = 'Sprint'
	elseif movementSpeedVariant == 'i_SlowestDash' then
		self.movementSpeed = 'SlowestDash'
	elseif movementSpeedVariant == 'j_SlowDash' then
		self.movementSpeed = 'SlowDash'
	elseif movementSpeedVariant == 'k_ModerateDash' then
		self.movementSpeed = 'ModerateDash'
	elseif movementSpeedVariant == 'l_Dash' then
		self.movementSpeed = 'Dash'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_WaitingSpot, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_WaitingSpot, SmartObjectHolder)
