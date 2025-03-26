InventoryDummyHorse = {
    ActionController = "Animations/Mannequin/ADB/inv_horse_controllerdefs.xml",
    AnimDatabase3P = "Animations/Mannequin/ADB/inv_horse_database.adb",
	
	Properties = 
	{
		bIsDummy = true,
		ControlProfile = 2, -- 2 == hidden, start hidden, hide status is controlled by Apse
	},
	physicsParams =
	{
		enabled = 0,
	},
}

-- =============================================================================
function InventoryDummyHorse:RegisterAI(bForce)
	-- do nothing (null AI don't have AI objects)
end

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(
	InventoryDummyHorse,
	Horse
)

EntityCommon.MakeSpawnable(InventoryDummyHorse)