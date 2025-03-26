-- =============================================================================
-- Entity defining properties for cheering NPCs, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_CheeringSpot_Standing =
{
	Properties =
	{
		CheeringSpot =
		{
			esCheeringSpot_Standing_Variant = 'random',
			bDisable_Force_Look = false,
		},
	},

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_CheeringSpot_Standing:UpdateData()
	self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/tournament_crowd_05_happy_04.cgf'
end

-- =============================================================================
function SO_CheeringSpot_Standing:GetGenderVariantLimit(gender)
	if gender == enum_humanGender.male then
		return 5
	else
		return 2
	end
end

-- =============================================================================
function SO_CheeringSpot_Standing:GetVariantData(gender, storedVariant)
	local variant = self.Properties.CheeringSpot.esCheeringSpot_Standing_Variant

	-- When random variant is selected, check whether there is any storedVariant with acceptable value to be used
	if variant == 'random' and storedVariant ~= nil and string.find(storedVariant, '^variant_0%d$') ~= nil then
		variant = storedVariant
	end

	-- Check if selected variant is acceptable for given gender, if not it will be randomized
	if variant ~= 'random' then
		local variant_number = tonumber(string.sub(variant, -2, -1))
		if variant_number == nil or variant_number > self:GetGenderVariantLimit(gender) or variant_number == 0 then
			variant = 'random'
		end
	end

	-- Pick variant for random selection
	if variant == 'random' then
		variant = 'variant_0' .. math.random(self:GetGenderVariantLimit(gender))
	end

	-- Return variant data
	if variant == 'variant_01' then
		return {
			variant = variant,
			unstanceName = 'cheering_standing_01',
			animationTag = 'tournamentCrowd_standing_1',
		}
	elseif variant == 'variant_02' then
		return {
			variant = variant,
			unstanceName = 'cheering_standing_02',
			animationTag = 'tournamentCrowd_standing_2',
		}
	elseif variant == 'variant_03' then
		return {
			variant = variant,
			unstanceName = 'cheering_standing_03',
			animationTag = 'tournamentCrowd_standing_3',
		}
	elseif variant == 'variant_04' then
		return {
			variant = variant,
			unstanceName = 'cheering_standing_04',
			animationTag = 'tournamentCrowd_standing_4',
		}
	else
		return {
			variant = variant,
			unstanceName = 'cheering_standing_05',
			animationTag = 'tournamentCrowd_standing_5',
		}
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_CheeringSpot_Standing, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_CheeringSpot_Standing, SmartObjectHolder)
