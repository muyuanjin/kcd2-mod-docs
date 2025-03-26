-- =============================================================================
-- Entity defining properties for basic dead horse bodies by real NPCs, derived from DeadBody_Horse nad SmartObjectHolder.
-- =============================================================================

SO_DeadBody_Horse =
{
	-- All properties are inherited from DeadBody_Horse
}

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/WH/Special/DeadBody/DeadBody_Horse.lua")
table.Merge(SO_DeadBody_Horse, DeadBody_Horse)
Script.ReloadScript("Scripts/Entities/WH/Others/SmartObjectHolder.lua")
table.Merge(SO_DeadBody_Horse, SmartObjectHolder)
