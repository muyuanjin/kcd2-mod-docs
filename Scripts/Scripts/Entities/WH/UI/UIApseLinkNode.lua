UIApseLinkNode =
{
	Properties =
	{
	},

	Editor =
	{
		Icon = "Flash.bmp"
	},
}

-- =============================================================================
function UIApseLinkNode:OnSpawn()
	UI.OnApseLinkNodeSpawn(self.id)
end

-- =============================================================================
function UIApseLinkNode:OnDestroy()
	UI.OnApseLinkNodeDespawn(self.id)
end
