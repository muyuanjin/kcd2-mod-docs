-- =============================================================================
-- Entity defining properties for party lying NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_Party_Lying =
{
	Properties =
	{
		Party =
		{
			esParty_Lying_Variant = 'male_drunk_resting_01',
		},
	},

	unstanceName = 'party_lying_drunk_resting_01',

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_Party_Lying:UpdateData()
	local variant = self.Properties.Party.esParty_Lying_Variant

	if variant == 'male_drunk_resting_01' then
		self.unstanceName = 'party_lying_drunk_resting_01'
		self.ghostsData['ghostDummy'] = 'objects/characters/humans/male/body/male_body_test.cgf'
	elseif variant == 'male_drunk_resting_02' then
		self.unstanceName = 'party_lying_drunk_resting_02'
		self.ghostsData['ghostDummy'] = 'objects/characters/humans/male/body/male_body_test.cgf'
	elseif variant == 'male_drunk_resting_03' then
		self.unstanceName = 'party_lying_drunk_resting_03'
		self.ghostsData['ghostDummy'] = 'objects/characters/humans/male/body/male_body_test.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_Party_Lying, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_Party_Lying, SmartObjectHolder)
