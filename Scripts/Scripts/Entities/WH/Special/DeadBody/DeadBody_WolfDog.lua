-- =============================================================================
-- Entity defining properties for basic dead dog and wolf bodies, usable for animchars (tho currently not supported), further extended into SO for NPCs.
-- Uses GhostsController interface.
-- =============================================================================

DeadBody_WolfDog =
{
	Editor =
	{
		Icon = "DeadBody.bmp",
	},

	Properties =
	{
		DeadBody =
		{
			esDeadBody_WolfDog_Variant = 'wolfDog_lyingOnRightSide_01',
			fAddDirt = 0.0,
			AddBlood =
			{
				fTorso = 0.0,
			},
		},
	},

	unstanceName = '', -- Used by real NPCs

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function DeadBody_WolfDog:UpdateData()
	local variant = self.Properties.DeadBody.esDeadBody_WolfDog_Variant

	if variant == 'wolfDog_lyingOnRightSide_01' then
		self.unstanceName = 'deadBody_lyingOnRightSide_01'
		self.ghostsData['ghostDummy'] = 'objects/intermediates/poses/dead/corpse_dog_01.cgf'
	end
end

-- =============================================================================
function DeadBody_WolfDog:ApplyDirtAndBlood(actor)
	local dirt = self.Properties.DeadBody.fAddDirt
	if dirt > 0 then
		actor:AddDirt(-1)
		actor:AddDirt(dirt)
	end
	
	local blood = self.Properties.DeadBody.AddBlood
	if blood.fTorso > 0 then
		actor:AddBlood(-1, 'dog_torso')
		actor:AddBlood(blood.fTorso, 'dog_torso')
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Others/GhostsController.lua")
table.Merge(DeadBody_WolfDog, GhostsController)
