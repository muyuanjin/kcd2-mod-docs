BasicAnimal =
{
	collisionClass = gcc_npc_ignored_type,

	physicsParams =
	{
		additionalPhysicsMass = 1.0,

		Living =
		{
				min_slide_angle = 89.0,
				max_climb_angle = 89.0,
				min_fall_angle = 89.0,
				max_jump_angle = 89.0,
		}
	},

	Properties =
	{
		bCanHoldInformation = false
	}
}

-- =============================================================================
function BasicAnimal:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	if (self.actor:GetHealth() <= 0) then
		return self:AddAnimalLootAction(user, firstFast)
	end
	return {}
end

-- =============================================================================
function BasicAnimal:AddAnimalLootAction(user, firstFast)
	output = {}

	if (self.soul:HasScriptContext("animal_disableLootButcherActions")) then
		return {}
	end

	-- show loot action only if butcher is not available or if there is something in the inventory event without butchering
	if (self.actor:CanBeButchered()) then
		if (self.actor:HasItemsInInventory()) then
			self:AddLootAction(output, user, firstFast)
			if (firstFast) then
				return output
			end
		end

		if (self.actor:IsPlayerInButcheringDistance()) then
			local enabled = user.soul:IsInTenseCircumstance() == false
			AddInteractorAction(output, firstFast, 
				Action():hint("@ui_hud_butcher"):action("butcher"):hintType(AHT_HOLD):func(BasicAnimal.OnButcher):enabled(enabled):reason("@ui_butcher_tensecircumstance"))
		end
	else
		self:AddLootAction(output, user, firstFast)
	end

	return output
end

-- =============================================================================
function BasicAnimal:OnReset(bFromInit, bIsReload)
	BasicActor.Reset(self, bFromInit, bIsReload)
	self:SetColliderMode(4)
end

-- =============================================================================
function BasicAnimal:OnUsed(user)
	if (self.actor:GetHealth() <= 0) then
		self.actor:RequestItemExchange(user.id)
	end
end

-- =============================================================================
function BasicAnimal:ForceUsable(user)
	if (not user) then
		return false; -- canot be used by AI
	end

	if not user.actor:CanInteractWith(self.id) then
		return false
	end

	return true
end

-- =============================================================================
function BasicAnimal:OnButcher(user)
	self.actor:Butcher(user.id)
end

-- =============================================================================
function BasicAnimal:IsUsable(user)
	if (not user) then
		return 0; -- canot be used by AI
	end

	return 1
end

table.Merge(BasicAnimal, BasicActor)
