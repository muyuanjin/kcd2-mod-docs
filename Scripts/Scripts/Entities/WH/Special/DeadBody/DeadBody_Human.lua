-- =============================================================================
-- Entity defining properties for basic human dead bodies, directly used for animchars, further extended into SO for NPCs.
-- Derived from DeadBody_Base_Human.
-- =============================================================================

DeadBody_Human =
{
	Properties =
	{
		DeadBody =
		{
			esDeadBody_Human_Variant = 'male_lyingOnBack_01',
		},
	},

	-- unstanceName and sequenceName are defined in DeadBody_Base_Human

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function DeadBody_Human:UpdateData()
	local variant = self.Properties.DeadBody.esDeadBody_Human_Variant

	if variant == 'male_bentOverCastleWall_01' then
		self.unstanceName = 'deadBody_bentOverCastleWall_01'
		self.sequenceName = 'deadBody_male_bentOverCastleWall_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_soldier_hanging_wall_01.cgf'
	elseif variant == 'male_bentOverPalisade_01' then
		self.unstanceName = 'deadBody_bentOverPalisade_01'
		self.sequenceName = 'deadBody_male_bentOverPalisade_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_soldier_hanging_palisade.cgf'
	elseif variant == 'male_bentOverRail_01' then
		self.unstanceName = 'deadBody_bentOverRail_01'
		self.sequenceName = 'deadBody_male_bentOverRail_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_hanging_wagon_01.cgf'
	elseif variant == 'male_bentOverRail_02' then
		self.unstanceName = 'deadBody_bentOverRail_02'
		self.sequenceName = 'deadBody_male_bentOverRail_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_hanging_wagon_02.cgf'
	elseif variant == 'male_bentOverRail_03' then
		self.unstanceName = 'deadBody_bentOverRail_03'
		self.sequenceName = 'deadBody_male_bentOverRail_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_hanging_wagon_03.cgf'
	elseif variant == 'male_humanOverHorse_01' then
		self.unstanceName = 'deadBody_humanOverHorse_01'
		self.sequenceName = 'deadBody_male_humanOverHorse_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_horse_02.cgf'
	elseif variant == 'male_humanOverHorse_02' then
		self.unstanceName = 'deadBody_humanOverHorse_02'
		self.sequenceName = 'deadBody_male_humanOverHorse_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_horse_03.cgf'
	elseif variant == 'male_humanUnderHorse_01' then
		self.unstanceName = 'deadBody_humanUnderHorse_01'
		self.sequenceName = 'deadBody_male_humanUnderHorse_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_horse_01.cgf'
	elseif variant == 'male_lyingInCoffin_01' then
		self.unstanceName = 'deadBody_lyingInCoffin_01'
		self.sequenceName = 'deadBody_male_lyingInCoffin_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_coffin_01.cgf'
	elseif variant == 'male_lyingInCoffin_02' then
		self.unstanceName = 'deadBody_lyingInCoffin_02'
		self.sequenceName = 'deadBody_male_lyingInCoffin_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_coffin_02.cgf'
	elseif variant == 'male_lyingLeaningBack_01' then
		self.unstanceName = 'deadBody_lyingLeaningBack_01'
		self.sequenceName = 'deadBody_male_lyingLeaningBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_collapsed_wall_02.cgf'
	elseif variant == 'male_lyingLeaningBack_02' then
		self.unstanceName = 'deadBody_lyingLeaningBack_02'
		self.sequenceName = 'deadBody_male_lyingLeaningBack_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_collapsed_wall_03.cgf'
	elseif variant == 'male_lyingOnBack_01' then
		self.unstanceName = 'deadBody_lyingOnBack_01'
		self.sequenceName = 'deadBody_male_lyingOnBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_01.cgf'
	elseif variant == 'male_lyingOnBack_02' then
		self.unstanceName = 'deadBody_lyingOnBack_02'
		self.sequenceName = 'deadBody_male_lyingOnBack_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_03.cgf'
	elseif variant == 'male_lyingOnBack_03' then
		self.unstanceName = 'deadBody_lyingOnBack_03'
		self.sequenceName = 'deadBody_male_lyingOnBack_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_04.cgf'
	elseif variant == 'male_lyingOnBack_04' then
		self.unstanceName = 'deadBody_lyingOnBack_04'
		self.sequenceName = 'deadBody_male_lyingOnBack_04'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_05.cgf'
	elseif variant == 'male_lyingOnBack_05' then
		self.unstanceName = 'deadBody_lyingOnBack_05'
		self.sequenceName = 'deadBody_male_lyingOnBack_05'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_07.cgf'
	elseif variant == 'male_lyingOnBack_06' then
		self.unstanceName = 'deadBody_lyingOnBack_06'
		self.sequenceName = 'deadBody_male_lyingOnBack_06'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_peasant_01.cgf'
	elseif variant == 'male_lyingOnPavise_01' then
		self.unstanceName = 'deadBody_lyingOnPavise_01'
		self.sequenceName = 'deadBody_male_lyingOnPavise_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_marksman_pavise1.cgf'
	elseif variant == 'male_lyingOnPavise_02' then
		self.unstanceName = 'deadBody_lyingOnPavise_02'
		self.sequenceName = 'deadBody_male_lyingOnPavise_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_marksman_pavise2.cgf'
	elseif variant == 'male_lyingOnPavise_03' then
		self.unstanceName = 'deadBody_lyingOnPavise_03'
		self.sequenceName = 'deadBody_male_lyingOnPavise_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_marksman_pavise3.cgf'
	elseif variant == 'male_lyingOnPavise_04' then
		self.unstanceName = 'deadBody_lyingOnPavise_04'
		self.sequenceName = 'deadBody_male_lyingOnPavise_04'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_marksman_pavise4.cgf'
	elseif variant == 'male_lyingOnPavise_05' then
		self.unstanceName = 'deadBody_lyingOnPavise_05'
		self.sequenceName = 'deadBody_male_lyingOnPavise_05'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_marksman_pavise5.cgf'
	elseif variant == 'male_lyingOnRightSide_01' then
		self.unstanceName = 'deadBody_lyingOnRightSide_01'
		self.sequenceName = 'deadBody_male_lyingOnRightSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_peasant_02.cgf'
	elseif variant == 'male_lyingOnRightSide_02' then
		self.unstanceName = 'deadBody_lyingOnRightSide_02'
		self.sequenceName = 'deadBody_male_lyingOnRightSide_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_peasant_03.cgf'
	elseif variant == 'male_lyingOnStomach_01' then
		self.unstanceName = 'deadBody_lyingOnStomach_01'
		self.sequenceName = 'deadBody_male_lyingOnStomach_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_02.cgf'
	elseif variant == 'male_lyingOnStomach_02' then
		self.unstanceName = 'deadBody_lyingOnStomach_02'
		self.sequenceName = 'deadBody_male_lyingOnStomach_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_cuman_06.cgf'
	elseif variant == 'male_lyingOnStomach_03' then
		self.unstanceName = 'deadBody_lyingOnStomach_03'
		self.sequenceName = 'deadBody_male_lyingOnStomach_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_peasant_04.cgf'
	elseif variant == 'male_lyingOnStomach_04' then
		self.unstanceName = 'deadBody_lyingOnStomach_04'
		self.sequenceName = 'deadBody_male_lyingOnStomach_04'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_aulitz_collapsed_ground_brutal.cgf'
	elseif variant == 'male_sittingLeaningSide_01' then
		self.unstanceName = 'deadBody_sittingLeaningSide_01'
		self.sequenceName = 'deadBody_male_sittingLeaningSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_collapsed_wagon_01.cgf'
	elseif variant == 'male_sittingLeaningSide_02' then
		self.unstanceName = 'deadBody_sittingLeaningSide_02'
		self.sequenceName = 'deadBody_male_sittingLeaningSide_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_collapsed_wagon_02.cgf'
	elseif variant == 'male_sittingOnChairLeaningBack_01' then
		self.unstanceName = 'deadBody_sittingOnChairLeaningBack_01'
		self.sequenceName = 'deadBody_male_sittingOnChairLeaningBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_aulitz_collapsed_chair_fancy.cgf'
	elseif variant == 'male_sittingOnGroundLeaningBack_01' then
		self.unstanceName = 'deadBody_sittingOnGroundLeaningBack_01'
		self.sequenceName = 'deadBody_male_sittingOnGroundLeaningBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_dead_collapsed_wall_01.cgf'
	elseif variant == 'male_sittingOnGroundLeaningSide_01' then
		self.unstanceName = 'deadBody_sittingOnGroundLeaningSide_01'
		self.sequenceName = 'deadBody_male_sittingOnGroundLeaningSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_soldier_hanging_wall_02.cgf'
	elseif variant == 'male_standingImpaled_01' then
		self.unstanceName = 'deadBody_standingImpaled_01'
		self.sequenceName = 'deadBody_male_standingImpaled_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/male_corpse_noble_impaled_spear_tree.cgf'
	elseif variant == 'male_standingTied_01' then
		self.unstanceName = 'deadBody_standingTied_01'
		self.sequenceName = 'deadBody_male_standingTied_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_tied_tree.cgf'
	elseif variant == 'female_bentOverRail_01' then
		self.unstanceName = 'deadBody_bentOverRail_01'
		self.sequenceName = 'deadBody_female_bentOverRail_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_corpse_hanging_wagon.cgf'
	elseif variant == 'female_lyingInCoffin_01' then
		self.unstanceName = 'deadBody_lyingInCoffin_01'
		self.sequenceName = 'deadBody_female_lyingInCoffin_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_coffin_01.cgf'
	elseif variant == 'female_lyingInCoffin_02' then
		self.unstanceName = 'deadBody_lyingInCoffin_02'
		self.sequenceName = 'deadBody_female_lyingInCoffin_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_coffin_02.cgf'
	elseif variant == 'female_lyingLeaningBack_01' then
		self.unstanceName = 'deadBody_lyingLeaningBack_01'
		self.sequenceName = 'deadBody_female_lyingLeaningBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_collapsed_wall_01.cgf'
	elseif variant == 'female_lyingLeaningBack_02' then
		self.unstanceName = 'deadBody_lyingLeaningBack_02'
		self.sequenceName = 'deadBody_female_lyingLeaningBack_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_collapsed_wall_02.cgf'
	elseif variant == 'female_lyingLeaningBack_03' then
		self.unstanceName = 'deadBody_lyingLeaningBack_03'
		self.sequenceName = 'deadBody_female_lyingLeaningBack_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_collapsed_wall_04.cgf'
	elseif variant == 'female_lyingOnBack_01' then
		self.unstanceName = 'deadBody_lyingOnBack_01'
		self.sequenceName = 'deadBody_female_lyingOnBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_01.cgf'
	elseif variant == 'female_lyingOnBack_02' then
		self.unstanceName = 'deadBody_lyingOnBack_02'
		self.sequenceName = 'deadBody_female_lyingOnBack_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_02.cgf'
	elseif variant == 'female_lyingOnBack_03' then
		self.unstanceName = 'deadBody_lyingOnBack_03'
		self.sequenceName = 'deadBody_female_lyingOnBack_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_03.cgf'
	elseif variant == 'female_lyingOnLeftSide_01' then
		self.unstanceName = 'deadBody_lyingOnLeftSide_01'
		self.sequenceName = 'deadBody_female_lyingOnLeftSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_07.cgf'
	elseif variant == 'female_lyingOnRightSide_01' then
		self.unstanceName = 'deadBody_lyingOnRightSide_01'
		self.sequenceName = 'deadBody_female_lyingOnRightSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_06.cgf'
	elseif variant == 'female_lyingOnStomach_01' then
		self.unstanceName = 'deadBody_lyingOnStomach_01'
		self.sequenceName = 'deadBody_female_lyingOnStomach_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_04.cgf'
	elseif variant == 'female_lyingOnStomach_02' then
		self.unstanceName = 'deadBody_lyingOnStomach_02'
		self.sequenceName = 'deadBody_female_lyingOnStomach_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_peasant_05.cgf'
	elseif variant == 'female_sittingOnGroundLeaningBack_01' then
		self.unstanceName = 'deadBody_sittingOnGroundLeaningBack_01'
		self.sequenceName = 'deadBody_female_sittingOnGroundLeaningBack_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/female_dead_collapsed_wall_03.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Special/DeadBody/DeadBody_Base_Human.lua")
table.Merge(DeadBody_Human, DeadBody_Base_Human)
