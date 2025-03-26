ChickensBrownLight =
{
	Properties = {
		Boid =
		{
			object_Model = "objects/characters/animals/hen_v2/hen_v2.cdf",
		}
	},
}

-- =============================================================================
ChickensBrownLight.FlowEvents =
{
	Inputs =
	{
		Activate = { ChickensBrownLight.Event_Activate, "bool" },
		Deactivate = { ChickensBrownLight.Event_Deactivate, "bool" },
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
table.Merge(ChickensBrownLight, Chickens)
