UIShopLinkNode =
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
function UIShopLinkNode:OnSpawn()
	UI.OnShopLinkNodeSpawn(self.id)
end

-- =============================================================================
function UIShopLinkNode:OnDestroy()
	UI.OnShopLinkNodeDespawn(self.id)
end
	