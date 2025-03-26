-- =============================================================================
-- Base template with properties for human DeadBody entities, don't use on its own. Uses GhostsController interface.
-- =============================================================================

DeadBody_Base_Human =
{
	Editor =
	{
		Icon = "DeadBody.bmp",
	},

	Properties =
	{
		DeadBody =
		{
			bRagdollOnly = false,
			bRagdollOnly_DontPosition = false,
			bLootableByPlayer = true,
			fAddDirt = 0.0,
			AddBlood =
			{
				fHead = 0.0,
				fTorso = 0.0,
				fArm_left = 0.0,
				fArm_right = 0.0,
				fLeg_left = 0.0,
				fLeg_right = 0.0,
			},
		},
	},

	unstanceName = '', -- Used by real NPCs
	sequenceName = '', -- Trackview used by animchars
}

-- =============================================================================
function DeadBody_Base_Human:ApplyDirtAndBlood(actor)
	local dirt = self.Properties.DeadBody.fAddDirt
	if dirt > 0 then
		actor:AddDirt(-1)
		actor:AddDirt(dirt)
	end
	
	local blood = self.Properties.DeadBody.AddBlood
	if blood.fHead > 0 then
		actor:AddBlood(-1, 'head')
		actor:AddBlood(blood.fHead, 'head')
	end
	if blood.fTorso > 0 then
		actor:AddBlood(-1, 'torso')
		actor:AddBlood(blood.fTorso, 'torso')
	end
	if blood.fArm_left > 0 then
		actor:AddBlood(-1, 'arm_left')
		actor:AddBlood(blood.fArm_left, 'arm_left')
	end
	if blood.fArm_right > 0 then
		actor:AddBlood(-1, 'arm_right')
		actor:AddBlood(blood.fArm_right, 'arm_right')
	end
	if blood.fLeg_left > 0 then
		actor:AddBlood(-1, 'leg_left')
		actor:AddBlood(blood.fLeg_left, 'leg_left')
	end
	if blood.fLeg_right > 0 then
		actor:AddBlood(-1, 'leg_right')
		actor:AddBlood(blood.fLeg_right, 'leg_right')
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(DeadBody_Base_Human, GhostsController)
