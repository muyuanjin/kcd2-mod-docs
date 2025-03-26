Shop =
{
	Properties =
	{
		iShopId	= 0,
		sShopName = "", -- JFilek, added option to set the shop by name, name has higher priority then id if filled
		guidSmartObjectType = "", -- added by MV, tryng for an SO
		soclass_SmartObjectHelpers = "",
		soclasses_SmartObjectClass = "",
		sWH_AI_EntityCategory = "",
		bOwnerIsSpawned = false,
	},

	Editor =
	{
		Icon = "bug.bmp"
	},
}

-- =============================================================================
function Shop:OnPropertyChange()
	Shops.OnPropertyChange(self.id)
end
