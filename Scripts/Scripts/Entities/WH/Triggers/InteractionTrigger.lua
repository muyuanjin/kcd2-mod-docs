-- =============================================================================
-- Basic version of TriggerBase
-- =============================================================================
InteractionTrigger = {}

function InteractionTrigger:PhysicalizeThis()
	-- dont
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/TriggerBase.lua")
table.Merge(InteractionTrigger, TriggerBase)