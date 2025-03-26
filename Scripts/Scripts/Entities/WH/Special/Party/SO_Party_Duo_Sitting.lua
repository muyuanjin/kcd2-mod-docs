-- =============================================================================
-- Entity defining properties for two synchronized party sitting NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_Party_Duo_Sitting =
{
	Properties =
	{
		Party =
		{
			esParty_Duo_Sitting_Variant = 'male_male_talkingAndDrinkingAndCheering_pickingCup_01',
		},
	},

	unstanceName_leader = 'party_duo_sitting_talkingAndDrinkingAndCheering_pickingCup_01_leader',
	unstanceName_minion = 'party_duo_sitting_talkingAndDrinkingAndCheering_pickingCup_01_minion',
	gesturesFragmentID_leader = 'Party_Duo_Sitting_TalkingAndDrinkingAndCheering_PickingCup_01_Gestures_Leader',
	gesturesFragmentID_minion = 'Party_Duo_Sitting_TalkingAndDrinkingAndCheering_PickingCup_01_Gestures_Minion',
	gesturesCount = 0,

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_Party_Duo_Sitting:UpdateData()
	local variant = self.Properties.Party.esParty_Duo_Sitting_Variant
	self.gesturesCount = 1

	if variant == 'male_male_talkingAndDrinkingAndCheering_pickingCup_01' then
		self.unstanceName_leader = 'party_duo_sitting_talkingAndDrinkingAndCheering_pickingCup_01_leader'
		self.unstanceName_minion = 'party_duo_sitting_talkingAndDrinkingAndCheering_pickingCup_01_minion'
		self.gesturesFragmentID_leader = 'Party_Duo_Sitting_TalkingAndDrinkingAndCheering_PickingCup_01_Gestures_Leader'
		self.gesturesFragmentID_minion = 'Party_Duo_Sitting_TalkingAndDrinkingAndCheering_PickingCup_01_Gestures_Minion'
		self.gesturesCount = 0
--		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'male_male_drunk_talkingAndDrinkingAndCheering_pickingCup_01' then
		self.unstanceName_leader = 'party_duo_sitting_drunk_talkingAndDrinkingAndCheering_pickingCup_01_leader'
		self.unstanceName_minion = 'party_duo_sitting_drunk_talkingAndDrinkingAndCheering_pickingCup_01_minion'
		self.gesturesFragmentID_leader = 'Party_Duo_Sitting_Drunk_TalkingAndDrinkingAndCheering_PickingCup_01_Gestures_Leader'
		self.gesturesFragmentID_minion = 'Party_Duo_Sitting_Drunk_TalkingAndDrinkingAndCheering_PickingCup_01_Gestures_Minion'
--		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_Party_Duo_Sitting, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_Party_Duo_Sitting, SmartObjectHolder)
