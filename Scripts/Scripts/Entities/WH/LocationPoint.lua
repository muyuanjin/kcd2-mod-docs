LocationPoint = {
	type = "LocationPoint",

	Editor = {
		Icon = "TagPoint.bmp",
	},

	Properties = {
		-- entity property --
		bSaved_by_game = false,
		guidLocationId = "",
	},
}

-- =============================================================================
function LocationPoint:OnReset()
	RPG.AddLocationPoint(self.id)
end

-- =============================================================================
function LocationPoint:OnInit()
	RPG.AddLocationPoint(self.id)
end