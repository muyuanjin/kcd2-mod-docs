-- this entity is dummy for sequence root

SequenceObject =
{
	bSaved_by_game = false,
	Properties =
	{
	},

	Editor =
	{
		Icon = "sequence.bmp"
	},
}

-- =============================================================================
-- OnPropertyChange called only by the editor.
-- this fuction is here to avoid warning written to console
function SequenceObject:OnPropertyChange()
end
