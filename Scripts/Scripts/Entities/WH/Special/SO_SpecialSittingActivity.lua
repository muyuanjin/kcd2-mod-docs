-- =============================================================================
-- Entity used for various special activities for sitting NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_SpecialSittingActivity =
{
	Properties =
	{
		SpecialSittingActivity =
		{
			esSpecialSittingActivity_Variant = 'female_noTable_crying',
		},
	},

	unstanceName = 'specialSittingActivity_female_noTable_crying',

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_SpecialSittingActivity:UpdateData()
	local variant = self.Properties.SpecialSittingActivity.esSpecialSittingActivity_Variant

	if variant == 'female_noTable_crying' then
		self.unstanceName = 'specialSittingActivity_female_noTable_crying'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_sitting_on_table_talk_var03.cgf'
	elseif variant == 'male_noTable_nervous' then
		self.unstanceName = 'specialSittingActivity_male_noTable_nervous'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_sitting_on_table_talk_var03.cgf'
	elseif variant == 'male_noTable_drinking_01' then
		self.unstanceName = 'specialSittingActivity_male_noTable_drinking_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_drunk_sit_on_table_drink.cgf'
	elseif variant == 'male_noTable_drinking_02' then
		self.unstanceName = 'specialSittingActivity_male_noTable_drinking_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_drunk_sit_on_table_drink.cgf'
	elseif variant == 'male_noTable_sad' then
		self.unstanceName = 'specialSittingActivity_male_noTable_sad'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_sitting_on_table_talk_var03.cgf'
	elseif variant == 'male_table_eatingSausage' then
		self.unstanceName = 'specialSittingActivity_male_table_eatingSausage'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_drunk_sit_on_table_drink.cgf'
	elseif variant == 'dialog_neutral' then
		self.unstanceName = 'ingameDialogPose_sitting'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_sitting_on_table_talk_var03.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_SpecialSittingActivity, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_SpecialSittingActivity, SmartObjectHolder)
