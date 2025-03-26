-- =============================================================================
-- Entity defining properties for party standing NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_Party_Standing =
{
	Properties =
	{
		Party =
		{
			esParty_Standing_Variant = 'male_talking_01',
		},
	},

	unstanceName_male = 'party_standing_talking_01_male',
	unstanceName_female = 'party_standing_talking_01_female',
	holdingItem = false,

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_Party_Standing:UpdateData()
	local variant = self.Properties.Party.esParty_Standing_Variant
	self.holdingItem = false

	if variant == 'male_talking_01' then
		self.unstanceName_male = 'party_standing_talking_01_male'
		self.unstanceName_female = 'party_standing_talking_01_female'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'male_talkingAndDrinking_holdingCup_01' then
		self.unstanceName_male = 'party_standing_talkingAndDrinking_holdingCup_01_male'
		self.unstanceName_female = 'party_standing_talkingAndDrinking_holdingCup_01_female'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drink_var01.cgf'
	elseif variant == 'male_talkingAndDrinking_holdingCup_02' then
		self.unstanceName_male = 'party_standing_talkingAndDrinking_holdingCup_02'
		self.unstanceName_female = 'party_standing_talkingAndDrinking_holdingCup_02'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drink_var02.cgf'
	elseif variant == 'male_drinking_holdingCup_01' then
		self.unstanceName_male = 'party_standing_drinking_holdingCup_01_male'
		self.unstanceName_female = 'party_standing_drinking_holdingCup_01_female'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_drink.cgf'
	elseif variant == 'male_dancing_01' then
		self.unstanceName_male = 'party_standing_dancing_01_male'
		self.unstanceName_female = 'party_standing_dancing_01_female'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_dance_var01.cgf'
	elseif variant == 'male_playingLute_holdingLute_01' then
		self.unstanceName_male = 'party_standing_playingLute_holdingLute_01'
		self.unstanceName_female = 'party_standing_playingLute_holdingLute_01'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/characters/humans/male/body/male_body_test.cgf'
	elseif variant == 'male_playingFlute_holdingFlute_01' then
		self.unstanceName_male = 'party_standing_playingFlute_holdingFlute_01'
		self.unstanceName_female = 'party_standing_playingFlute_holdingFlute_01'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/characters/humans/male/body/male_body_test.cgf'
	elseif variant == 'male_drunk_talking_01' then
		self.unstanceName_male = 'party_standing_drunk_talking_01'
		self.unstanceName_female = 'party_standing_drunk_talking_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drunk.cgf'
	elseif variant == 'male_drunk_talkingAndDrinking_holdingCup_01' then
		self.unstanceName_male = 'party_standing_drunk_talkingAndDrinking_holdingCup_01'
		self.unstanceName_female = 'party_standing_drunk_talkingAndDrinking_holdingCup_01'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk_drink_drunk.cgf'
	elseif variant == 'male_drunk_drinking_holdingCup_01' then
		self.unstanceName_male = 'party_standing_drunk_drinking_holdingCup_01'
		self.unstanceName_female = 'party_standing_drunk_drinking_holdingCup_01'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_drink_drunk.cgf'
	elseif variant == 'female_talking_01' then
		self.unstanceName_male = 'party_standing_talking_01_male'
		self.unstanceName_female = 'party_standing_talking_01_female'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_stand_talk.cgf'
	elseif variant == 'female_talking_02' then
		self.unstanceName_male = 'party_standing_talking_02'
		self.unstanceName_female = 'party_standing_talking_02'
		self.ghostsData['ghostDummy'] = 'objects/characters/humans/female/body/female_body.cgf'
	elseif variant == 'female_talkingAndDrinking_holdingCup_01' then
		self.unstanceName_male = 'party_standing_talkingAndDrinking_holdingCup_01_male'
		self.unstanceName_female = 'party_standing_talkingAndDrinking_holdingCup_01_female'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_stand_talk_drink_var01.cgf'
	elseif variant == 'female_talkingAndDrinking_holdingCup_02' then
		self.unstanceName_male = 'party_standing_talkingAndDrinking_holdingCup_02'
		self.unstanceName_female = 'party_standing_talkingAndDrinking_holdingCup_02'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_stand_talk_drink_var02.cgf'
	elseif variant == 'female_drinking_holdingCup_01' then
		self.unstanceName_male = 'party_standing_drinking_holdingCup_01_male'
		self.unstanceName_female = 'party_standing_drinking_holdingCup_01_female'
		self.holdingItem = true
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_stand_drink.cgf'
	elseif variant == 'female_dancing_01' then
		self.unstanceName_male = 'party_standing_dancing_01_male'
		self.unstanceName_female = 'party_standing_dancing_01_female'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_dance_var01.cgf'
	elseif variant == 'female_dancing_02' then
		self.unstanceName_male = 'party_standing_dancing_02'
		self.unstanceName_female = 'party_standing_dancing_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_dance_var02.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_Party_Standing, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_Party_Standing, SmartObjectHolder)
