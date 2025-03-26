Battlement =
{
	Properties =
	{
		BattlementSlotWidth = 0,
		BattlementMerlonWidth = 0,
		esWallType="wall",

		vectorPoint0 = { x=0, y=0, z=0 },
		vectorPoint1 = { x=0, y=0, z=0 },
		
		bSaved_by_game = false,
	},

	Editor =
	{
		Icon="",
		ShowBounds = 1,
	},
}

-- =============================================================================
function Battlement:ShapeMinPoints()
	return 2
end

-- =============================================================================
function Battlement:ShapeMaxPoints()
	return 2
end

-- =============================================================================
function Battlement:IsShapeOnly()
	return 1
end

-- =============================================================================
function Battlement:IsClosed()
	return 0
end

-- =============================================================================
function Battlement:ExportToGame()
	return 1
end