UIForgeBuilderLinkNode =
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
function UIForgeBuilderLinkNode:OnSpawn()
	UI.OnForgeBuilderLinkNodeSpawn(self.id)
end

-- =============================================================================
function UIForgeBuilderLinkNode:OnDestroy()
	UI.OnForgeBuilderLinkNodeDespawn(self.id)
end
