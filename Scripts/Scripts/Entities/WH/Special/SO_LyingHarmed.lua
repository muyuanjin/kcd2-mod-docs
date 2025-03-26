-- =============================================================================
-- Entity defining properties for wounded lying NPCs usable for custom dialogs, derived from SmartObjectHolder
-- =============================================================================

SO_LyingHarmed =
{
	Properties =
	{
		LyingHarmed = {
			esLyingHarmedPose = 'male_lyingWounded_01',
		},
	},
	unstanceName = 'lyingWounded_01',
}

-- =============================================================================
function SO_LyingHarmed:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
function SO_LyingHarmed:OnSpawn()
	self:Reset()
end

-- =============================================================================
function SO_LyingHarmed:Reset()
	if self.Properties.LyingHarmed.esLyingHarmedPose == 'male_lyingWounded_01' then
		self.unstanceName = 'lyingWounded_01'
	elseif self.Properties.LyingHarmed.esLyingHarmedPose == 'male_lyingWounded_02' then
		self.unstanceName = 'lyingWounded_02'
	elseif self.Properties.LyingHarmed.esLyingHarmedPose == 'male_lyingWounded_03' then
		self.unstanceName = 'lyingWounded_03'
	elseif self.Properties.LyingHarmed.esLyingHarmedPose == 'male_lyingWounded_04' then
		self.unstanceName = 'lyingWounded_04'
	elseif self.Properties.LyingHarmed.esLyingHarmedPose == 'male_lyingWounded_05' then
		self.unstanceName = 'lyingWounded_05'
	elseif Properties.LyingHarmed.esLyingHarmedPose == 'male_lyingInjured_bed_low' then
		self.unstanceName = 'lyingInjured_bedLow'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( SO_LyingHarmed, SmartObjectHolder )
