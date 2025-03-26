-- =============================================================================
-- Entity defining properties for hanged human dead bodies by real NPCs, derived from DeadBody_Base_Human and SmartObjectHolder.
-- =============================================================================

SO_DeadBody_Human_Hanged =
{
	Properties =
	{
		DeadBody =
		{
			esDeadBody_Human_Hanged_Variant = 'male_hanged_01',
			bPickableByPlayer = false,
		},
	},

	-- unstanceName is defined in DeadBody_Base_Human

	-- Can be set to use some prop item in left hand (some hanged corpses have tied hands so they use rope item)
	useItem_left = false,

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_DeadBody_Human_Hanged:UpdateData()
	self.useItem_left = false

	local variant = self.Properties.DeadBody.esDeadBody_Human_Hanged_Variant

	if variant == 'male_hanged_01' then
		self.unstanceName = 'deadBody_hanged_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/behavior_hangmale_loop.cgf'
	elseif variant == 'male_hanged_02' then
		self.unstanceName = 'deadBody_hanged_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/quest_hangman_death_loop_gallows_03.cgf'
	elseif variant == 'male_hanged_03' then
		self.unstanceName = 'deadBody_hanged_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/quest_hangman_death_loop_gallows_04.cgf'
	elseif variant == 'male_hanged_shortRope_01' then
		self.unstanceName = 'deadBody_hanged_shortRope_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_behavior_hangmale_halter_short_loop.cgf'
	elseif variant == 'male_hanged_handcuffed_01' then
		self.unstanceName = 'deadBody_hanged_handcuffed_01'
		self.useItem_left = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/quest_hangman_death_loop_gallows_01.cgf'
	elseif variant == 'male_hanged_handcuffed_02' then
		self.unstanceName = 'deadBody_hanged_handcuffed_02'
		self.useItem_left = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/quest_hangman_death_loop_gallows_02.cgf'
	elseif variant == 'female_hanged_01' then
		self.unstanceName = 'deadBody_hanged_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_behavior_hangmale_loop.cgf'
	elseif variant == 'female_hanged_shortRope_01' then
		self.unstanceName = 'deadBody_hanged_shortRope_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_behavior_hangmale_short_halter_loop.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Special/DeadBody/DeadBody_Base_Human.lua")
table.Merge(SO_DeadBody_Human_Hanged, DeadBody_Base_Human)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
table.Merge(SO_DeadBody_Human_Hanged, SmartObjectHolder)
