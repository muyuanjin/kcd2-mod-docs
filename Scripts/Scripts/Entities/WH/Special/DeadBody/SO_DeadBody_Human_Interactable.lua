-- =============================================================================
-- Entity defining properties for real NPC human dead bodies that can be interacted with by other NPCs, derived from DeadBody_Base_Human and SmartObjectHolder.
-- =============================================================================

SO_DeadBody_Human_Interactable =
{
	Properties =
	{
		DeadBody =
		{
			esDeadBody_Human_Interactable_Variant = 'male_looting_male_lyingOnBack_01',
			bPickableByPlayer = false,
			bAlwaysFastForwardIntoInteracting = true,
		},
	},

	-- unstanceName is defined in DeadBody_Base_Human and is used as a base static unstance for corpse outside of interaction
	unstanceName_beingInteracted = 'deadBody_male_looting_male_lyingOnBack_01_beingInteracted', -- Unstance used by the corpse when being interacted by some NPC
	unstanceName_interactant = 'deadBody_male_looting_male_lyingOnBack_01_interactant', -- Unstance used by the NPC when interacting with corpse

	-- ghostsData table is initiated in GhostsController:OnSpawn function
}

-- =============================================================================
function SO_DeadBody_Human_Interactable:UpdateData()
	local variant = self.Properties.DeadBody.esDeadBody_Human_Interactable_Variant

	if variant == 'male_looting_male_lyingOnBack_01' then
		self.unstanceName = 'deadBody_male_looting_male_lyingOnBack_01_beingInteracted_waiting'
		self.unstanceName_beingInteracted = 'deadBody_male_looting_male_lyingOnBack_01_beingInteracted'
		self.unstanceName_interactant = 'deadBody_male_looting_male_lyingOnBack_01_interactant'
		self.ghostsData['ghostDummy_body'] = 'objects/intermediates/poses/dead/dead_peasant_01.cgf'
		self.ghostsData['ghostDummy_interactant'] = 'objects/intermediates/poses/dead/quest_corpse_robber_loop_m.cgf'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Special/DeadBody/DeadBody_Base_Human.lua")
table.Merge(SO_DeadBody_Human_Interactable, DeadBody_Base_Human)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
table.Merge(SO_DeadBody_Human_Interactable, SmartObjectHolder)
