-- =============================================================================
-- Entity defining properties for harmed npcs for healing and their healers, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_LyingHarmed_Healing =
{
	Properties =
	{
		LyingHarmed_Healing =
		{
			esLyingHarmed_Healing_Variant = 'male_lyingInjured_bed_low',
		},
	},

	unstanceName = 'lyingInjured_bedLow',

}
-- =============================================================================
function SO_LyingHarmed_Healing:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
function SO_LyingHarmed_Healing:OnSpawn()
	self:Reset()
end

-- =============================================================================
function SO_LyingHarmed_Healing:Reset()
	local variant = self.Properties.LyingHarmed_Healing.esLyingHarmed_Healing_Variant

	if variant == 'male_lyingInjured_bed_low' then
		self.unstanceName = 'lyingInjured_bedLow'
	elseif variant == 'male_lyingInjured_bed_low_injured' then
		self.unstanceName = 'injured'
	elseif variant == 'male_lyingInjured_bed_high' then
		self.unstanceName = 'lyingInjured_bedHigh'
	elseif variant == 'male_sittingInjured_groundSitPlace_treating' then
		self.unstanceName = 'sittingInjured'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_LyingHarmed_Healing, SmartObjectHolder)
