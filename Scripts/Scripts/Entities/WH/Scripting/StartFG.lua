StartFG =
{
	Server = {},
	Client = {},

	Properties =
	{
		bSaved_by_game = false,
		object_Model = "",
	},


	Editor=
	{
		Icon		="stash.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},

}

-- =============================================================================
-- OnReset called only by the editor.
function StartFG:OnReset()
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function StartFG:OnSpawn()
	self:Reset()
end

-- =============================================================================
function StartFG:Reset()
end

-- =============================================================================
-- Events
StartFG.FlowEvents =
{
	Inputs =
	{
	},
	Outputs =
	{
		Activate = "bool",
	},
}
