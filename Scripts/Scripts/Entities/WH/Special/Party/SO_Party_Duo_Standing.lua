-- =============================================================================
-- Entity defining properties for two synchronized party standing NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_Party_Duo_Standing =
{
	Properties =
	{
		Party =
		{
			esParty_Duo_Standing_Variant = 'male_male_talking_01',
		},
	},

	unstanceName_leader = 'party_duo_standing_talking_01_leader',
	unstanceName_minion = 'party_duo_standing_talking_01_minion',
	gesturesFragmentID_leader = '',
	gesturesFragmentID_minion = '',
	gesturesCount = 0,
	holdingItem = false,

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_Party_Duo_Standing:UpdateData()
	local variant = self.Properties.Party.esParty_Duo_Standing_Variant
	self.gesturesFragmentID_leader = ''
	self.gesturesFragmentID_minion = ''
	self.gesturesCount = 0
	self.holdingItem = false

	if variant == 'male_male_talking_01' then
		self.unstanceName_leader = 'party_duo_standing_talking_01_leader'
		self.unstanceName_minion = 'party_duo_standing_talking_01_minion'
		-- self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'male_male_talking_02' then
		self.unstanceName_leader = 'party_duo_standing_talking_02_leader'
		self.unstanceName_minion = 'party_duo_standing_talking_02_minion'
		-- self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'male_male_talkingAndDrinkingAndCheering_holdingCup_01' then
		self.unstanceName_leader = 'party_duo_standing_talkingAndDrinkingAndCheering_holdingCup_01_leader'
		self.unstanceName_minion = 'party_duo_standing_talkingAndDrinkingAndCheering_holdingCup_01_minion'
		self.gesturesFragmentID_leader = 'Party_Duo_Standing_TalkingAndDrinkingAndCheering_HoldingCup_01_Gestures_Leader'
		self.gesturesFragmentID_minion = 'Party_Duo_Standing_TalkingAndDrinkingAndCheering_HoldingCup_01_Gestures_Minion'
		self.gesturesCount = 3
		self.holdingItem = true
		-- self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'male_male_drunk_talkingAndDrinkingAndCheering_holdingCup_01' then
		self.unstanceName_leader = 'party_duo_standing_drunk_talkingAndDrinkingAndCheering_holdingCup_01_leader'
		self.unstanceName_minion = 'party_duo_standing_drunk_talkingAndDrinkingAndCheering_holdingCup_01_minion'
		self.gesturesFragmentID_leader = 'Party_Duo_Standing_Drunk_TalkingAndDrinkingAndCheering_HoldingCup_01_Gestures_Leader'
		self.gesturesFragmentID_minion = 'Party_Duo_Standing_Drunk_TalkingAndDrinkingAndCheering_HoldingCup_01_Gestures_Minion'
		self.gesturesCount = 2
		self.holdingItem = true
		-- self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_dance_var02.cgf'
	elseif variant == 'male_female_dancing_01' then
		self.unstanceName_leader = 'party_duo_standing_dancing_01'
		self.unstanceName_minion = 'party_duo_standing_dancing_01'
		-- self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'male_female_dancing_02' then
		self.unstanceName_leader = 'party_duo_standing_dancing_02'
		self.unstanceName_minion = 'party_duo_standing_dancing_02'
		-- self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_Party_Duo_Standing, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_Party_Duo_Standing, SmartObjectHolder)
