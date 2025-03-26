ChickensWhite =
{
	Properties = {
		Boid =
		{
			object_Model = "objects/characters/animals/hen_v2/hen_v2_white.cdf",
		}
	},
}

-- =============================================================================
ChickensWhite.FlowEvents =
{
	Inputs =
	{
		Activate = { ChickensWhite.Event_Activate, "bool" },
		Deactivate = { ChickensWhite.Event_Deactivate, "bool" },
	},
	Outputs =
	{
		Activate = "bool",
		Deactivate = "bool",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(ChickensWhite, Chickens)