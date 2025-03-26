-- =============================================================================
-- Entity defining properties for HostageSituation module, derived from SmartObjectHolder, using GhostsController interface
-- =============================================================================

SO_HostageSituation =
{
	Properties =
	{
		HostageSituation =
		{
			esHostageSituation_Variant = 'maleHoldsFemale',
		},
	},

	useRealWeapon = true,

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_HostageSituation:UpdateData()
	local variant = self.Properties.HostageSituation.esHostageSituation_Variant

	if variant == 'maleHoldsFemale' then
		self.useRealWeapon = true
--		self.unstanceName = 'waiting_armAkimbo'
--		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/male/quest_wedding_stand_talk.cgf'
	elseif variant == 'femaleHoldsFemale' then
		self.useRealWeapon = false
--		self.unstanceName = 'waiting_armsCrossed'
--		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/party/female/quest_wedding_dance_var02.cgf'
	end
end

-- =============================================================================
function SO_HostageSituation:GetAnimationSet(kidnapper)
	local variant = self.Properties.HostageSituation.esHostageSituation_Variant

	if variant == 'maleHoldsFemale' then
		if kidnapper then
			return {
				HoldHostage_Tense = 'hostageSituation_maleHoldsFemale_kidnapper_holdHostage_tense',
				HoldHostage_Calm = 'hostageSituation_maleHoldsFemale_kidnapper_holdHostage_calm',
				KidnapperReleasesHostage_BothToIdle = 'Quest_HostageSituation_KidnapperReleasesHostage_BothToIdle',
				KidnapperReleasesHostage_HostageKillsKidnapper = 'Quest_HostageSituation_KidnapperReleasesHostage_HostageKillsKidnapper',
				KidnapperKillsHostage_KidnapperToIdle = '',
				KidnapperKillsHostage_KidnapperToCombat = 'Quest_HostageSituation_KidnapperKillsHostage_KidnapperToCombat',
				KidnapperGetsHit_KidnapperToCombat_HostageToGround = 'Quest_HostageSituation_KidnapperGetsHit_KidnapperToCombat_HostageToGround',
				KidnapperGetsHit_KidnapperDies_HostageToGround = 'Quest_HostageSituation_KidnapperGetsHit_KidnapperDies_HostageToGround',
				HostageGetsHit_HostageDies_KidnapperToCombat = 'Quest_HostageSituation_HostageGetsHit_HostageDies_KidnapperToCombat',
			}
		else
			return {
				HoldHostage_Tense = 'hostageSituation_maleHoldsFemale_hostage_holdHostage_tense',
				HoldHostage_Calm = 'hostageSituation_maleHoldsFemale_hostage_holdHostage_calm',
				KidnapperReleasesHostage_BothToIdle = 'Quest_HostageSituation_KidnapperReleasesHostage_BothToIdle',
				KidnapperReleasesHostage_HostageKillsKidnapper = 'Quest_HostageSituation_KidnapperReleasesHostage_HostageKillsKidnapper',
				KidnapperKillsHostage_KidnapperToIdle = '',
				KidnapperKillsHostage_KidnapperToCombat = 'Quest_HostageSituation_KidnapperKillsHostage_KidnapperToCombat',
				KidnapperGetsHit_KidnapperToCombat_HostageToGround = 'Quest_HostageSituation_KidnapperGetsHit_KidnapperToCombat_HostageToGround',
				KidnapperGetsHit_KidnapperDies_HostageToGround = 'Quest_HostageSituation_KidnapperGetsHit_KidnapperDies_HostageToGround',
				HostageGetsHit_HostageDies_KidnapperToCombat = 'Quest_HostageSituation_HostageGetsHit_HostageDies_KidnapperToCombat',
			}
		end
	elseif variant == 'femaleHoldsFemale' then
		if kidnapper then
			return {
				HoldHostage_Tense = 'hostageSituation_femaleHoldsFemale_kidnapper_holdHostage_tense',
				KidnapperReleasesHostage_BothToIdle = 'Quest_FemmeFatal_Kidnapper_KidnapperReleasesHostage_BothToIdle',
				KidnapperKillsHostage_KidnapperToIdle = 'Quest_FemmeFatal_Kidnapper_KidnapperKillsHostage_KidnapperToIdle',
			}
		else
			return {
				HoldHostage_Tense = 'hostageSituation_femaleHoldsFemale_hostage_holdHostage_tense',
				KidnapperReleasesHostage_BothToIdle = 'Quest_FemmeFatal_Hostage_KidnapperReleasesHostage_BothToIdle',
				KidnapperKillsHostage_KidnapperToIdle = 'Quest_FemmeFatal_Hostage_KidnapperKillsHostage_KidnapperToIdle',
			}
		end
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(SO_HostageSituation, GhostsController)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
EntityCommon.DeriveOverride(SO_HostageSituation, SmartObjectHolder)
