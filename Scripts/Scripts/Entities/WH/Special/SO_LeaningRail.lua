-- =============================================================================
-- Entity defining properties for LeaningRail, derived from SmartObjectHolder
-- =============================================================================

SO_LeaningRail =
{
	Properties =
	{
		LeaningRail = {
			esLeaningRail_Variant = "LeaningRail1",
		},
	},

	unstanceName = 'leaningRail1',
}

-- =============================================================================
function SO_LeaningRail:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
function SO_LeaningRail:OnSpawn()
	self:Reset()
end

-- =============================================================================
function SO_LeaningRail:Reset()
	local variant = self.Properties.LeaningRail.esLeaningRail_Variant

	if variant == 'LeaningRail1' then
		self.unstanceName = 'leaningRail1'
	elseif variant == 'LeaningRail2' then
		self.unstanceName = 'leaningRail2'
	elseif variant == 'LeaningRail3' then
		self.unstanceName = 'leaningRail3'
	elseif variant == 'LeaningRailQuest' then
		self.unstanceName = 'leaningRailQuest'	
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride(SO_LeaningRail, SmartObjectHolder )
