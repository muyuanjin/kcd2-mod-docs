-- =============================================================================
-- Entity defining properties for basic dead dog and wolf bodies by real NPCs, derived from DeadBody_WolfDog nad SmartObjectHolder.
-- =============================================================================

SO_DeadBody_WolfDog =
{
	-- All properties are inherited from DeadBody_WolfDog
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Special/DeadBody/DeadBody_WolfDog.lua")
table.Merge(SO_DeadBody_WolfDog, DeadBody_WolfDog)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
table.Merge(SO_DeadBody_WolfDog, SmartObjectHolder)
