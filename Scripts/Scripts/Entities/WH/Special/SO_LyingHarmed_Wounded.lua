-- =============================================================================
-- Entity defining properties for harmed npcs without healing and dialogue, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_LyingHarmed_Wounded =
{
	Properties =
	{
		LyingHarmed_Wounded =
		{
			esLyingHarmed_Wounded_Variant = 'male_lyingWounded_01_bed_low',
		},
	},

	unstanceName = 'lyingWounded_01_bedLow',

}

function SO_LyingHarmed_Wounded:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
function SO_LyingHarmed_Wounded:OnSpawn()
	self:Reset()
end

-- =============================================================================
function SO_LyingHarmed_Wounded:Reset()
	local variant = self.Properties.LyingHarmed_Wounded.esLyingHarmed_Wounded_Variant

	if variant == 'male_lyingWounded_01_bed_low' then
		self.unstanceName = 'woundedLying_1_bedLow'
	elseif variant == 'male_lyingWounded_02_bed_low' then
		self.unstanceName = 'woundedLying_2_bedLow'
	elseif variant == 'male_lyingWounded_03_bed_low' then
		self.unstanceName = 'woundedLying_3_bedLow'
	elseif variant == 'male_lyingWounded_04_bed_low' then
		self.unstanceName = 'woundedLying_4_bedLow'
	elseif variant == 'male_lyingWounded_05_bed_low' then
		self.unstanceName = 'woundedLying_5_bedLow'
	elseif variant == 'male_lyingWounded_sick_bed_low' then
		self.unstanceName = 'beSick_bedLow'
	elseif variant == 'male_sittingWounded_bench' then
		self.unstanceName = 'Sitting_shitty'
	elseif variant == 'male_lyingWounded_hunter_bed_low' then
		self.unstanceName = 'WoundedLying_Hunter_bedLow'
	elseif variant == 'male_lyingInjured_bed_low' then
		self.unstanceName = 'lyingInjured_bedLow'
	elseif variant == 'male_lyingInjured_bed_high' then
		self.unstanceName = 'lyingInjured_bedHigh'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_LyingHarmed_Wounded, SmartObjectHolder)
