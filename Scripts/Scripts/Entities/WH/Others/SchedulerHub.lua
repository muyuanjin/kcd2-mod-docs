-- this entity is dummy for a scheduler hub, which doesn't have real entity

SchedulerHub =
{
	Properties =
	{
		bIsStupidHub = false,
		bIgnoreDeadEnds = false,
		esHubType = "default",
	},
}

function SchedulerHub:GetEditorIcon(tst)
	return "SchedulerHub/" .. self.Properties.esHubType .. ".bmp"
end