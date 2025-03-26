-- =============================================================================
-- Entity defining properties for party sitting NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_Party_Sitting =
{
	Properties =
	{
		Party =
		{
			esParty_Sitting_Variant = 'male_talking_01',
		},
	},

	unstanceName = 'party_sitting_talking_01',

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_Party_Sitting:UpdateData()
	local variant = self.Properties.Party.esParty_Sitting_Variant

	if variant == 'male_talking_01' then
		self.unstanceName = 'party_sitting_talking_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_sitting_on_table_talk_var03.cgf'
	elseif variant == 'male_drunk_drinking_pickingCup_01' then
		self.unstanceName = 'party_sitting_drunk_drinking_pickingCup_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_drunk_sit_on_table_drink.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_Party_Sitting, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_Party_Sitting, SmartObjectHolder)
