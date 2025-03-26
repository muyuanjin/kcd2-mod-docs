-- =============================================================================
-- Entity defining properties for basic dead horse bodies, directly used for animchars, further extended into SO for NPCs.
-- Uses GhostsController interface.
-- =============================================================================

DeadBody_Horse =
{
	Editor =
	{
		Icon = "DeadBody.bmp",
	},

	Properties =
	{
		DeadBody =
		{
			esDeadBody_Horse_Variant = 'horse_lyingOnLeftSide_01',
			bRagdollOnly = false,
			fAddDirt = 0.0,
			AddBlood =
			{
				fHead = 0.0,
				fTorso = 0.0,
				fLegs = 0.0,
			},
		},
	},

	unstanceName = '', -- Used by real NPCs
	sequenceName = '', -- Trackview used by animchars

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function DeadBody_Horse:UpdateData()
	local variant = self.Properties.DeadBody.esDeadBody_Horse_Variant

	if variant == 'horse_humanOverHorse_01' then
		self.unstanceName = 'deadBody_humanOverHorse_01'
		self.sequenceName = 'deadBody_horse_humanOverHorse_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_horse_02.cgf'
	elseif variant == 'horse_humanOverHorse_02' then
		self.unstanceName = 'deadBody_humanOverHorse_02'
		self.sequenceName = 'deadBody_horse_humanOverHorse_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_horse_03.cgf'
	elseif variant == 'horse_humanUnderHorse_01' then
		self.unstanceName = 'deadBody_humanUnderHorse_01'
		self.sequenceName = 'deadBody_horse_humanUnderHorse_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/dead_horse_01.cgf'
	elseif variant == 'horse_lyingOnLeftSide_01' then
		self.unstanceName = 'deadBody_lyingOnLeftSide_01'
		self.sequenceName = 'deadBody_horse_lyingOnLeftSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_01.cgf'
	elseif variant == 'horse_lyingOnLeftSide_02' then
		self.unstanceName = 'deadBody_lyingOnLeftSide_02'
		self.sequenceName = 'deadBody_horse_lyingOnLeftSide_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_02.cgf'
	elseif variant == 'horse_lyingOnLeftSide_03' then
		self.unstanceName = 'deadBody_lyingOnLeftSide_03'
		self.sequenceName = 'deadBody_horse_lyingOnLeftSide_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_03.cgf'
	elseif variant == 'horse_lyingOnLeftSide_04' then
		self.unstanceName = 'deadBody_lyingOnLeftSide_04'
		self.sequenceName = 'deadBody_horse_lyingOnLeftSide_04'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_yoke_01.cgf'
	elseif variant == 'horse_lyingOnLeftSide_05' then
		self.unstanceName = 'deadBody_lyingOnLeftSide_05'
		self.sequenceName = 'deadBody_horse_lyingOnLeftSide_05'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_yoke_04.cgf'
	elseif variant == 'horse_lyingOnRightSide_01' then
		self.unstanceName = 'deadBody_lyingOnRightSide_01'
		self.sequenceName = 'deadBody_horse_lyingOnRightSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_04.cgf'
	elseif variant == 'horse_lyingOnRightSide_02' then
		self.unstanceName = 'deadBody_lyingOnRightSide_02'
		self.sequenceName = 'deadBody_horse_lyingOnRightSide_02'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_yoke_02.cgf'
	elseif variant == 'horse_lyingOnRightSide_03' then
		self.unstanceName = 'deadBody_lyingOnRightSide_03'
		self.sequenceName = 'deadBody_horse_lyingOnRightSide_03'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/horse_dead_yoke_03.cgf'
	end
end

-- =============================================================================
function DeadBody_Horse:ApplyDirtAndBlood(actor)
	local dirt = self.Properties.DeadBody.fAddDirt
	if dirt > 0 then
		actor:AddDirt(-1)
		actor:AddDirt(dirt)
	end
	
	local blood = self.Properties.DeadBody.AddBlood
	if blood.fHead > 0 then
		actor:AddBlood(-1, 'horse_head')
		actor:AddBlood(blood.fHead, 'horse_head')
	end
	if blood.fTorso > 0 then
		actor:AddBlood(-1, 'horse_torso')
		actor:AddBlood(blood.fTorso, 'horse_torso')
	end
	if blood.fLegs > 0 then
		actor:AddBlood(-1, 'horse_legs')
		actor:AddBlood(blood.fLegs, 'horse_legs')
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(DeadBody_Horse, GhostsController)
