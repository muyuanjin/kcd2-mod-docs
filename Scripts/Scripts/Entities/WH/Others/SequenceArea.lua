SequenceArea =
{
	type = "SequenceArea",

	Properties =
	{
		bSaved_by_game = false,
		bHide_Items = true,
		bHide_Actors = true,
		bHide_Other_Entities = false,
		bCreate_Obstacle = true,
	},

	Editor =
	{
		Icon = "Sequencearea.bmp",
		IconOnTop = 1,
	},
}

-- =============================================================================
-- OnPropertyChange called only by the editor.
-- this fuction is here to avoid warning written to console
function SequenceArea:OnPropertyChange()
end
