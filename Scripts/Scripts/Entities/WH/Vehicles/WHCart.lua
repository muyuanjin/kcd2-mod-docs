WHCart =
{
	Properties =
	{
		bSaved_by_game = true,
		guidSmartObjectType = "DEF0005E-0000-0000-0000-DEF00000005E",
		soclass_SmartObjectHelpers = "Cart",
		bMovingSmartObject = true,
		bIsQuestCart = false,
		sCartType = "fourWheeled"
	},

	Editor=
	{
		Icon		= "vehicle.bmp",
		IconOnTop 	= 1,
	},

	isQuestCart = false,
	cartType = "fourWheeled",
}

-- =============================================================================
function WHCart:OnLoad(table)
	self.isQuestCart = table.isQuestCart
	self.cartType = table.cartType
end

-- =============================================================================
function WHCart:OnSave(table)
	table.isQuestCart = self.isQuestCart
	table.cartType = self.cartType
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function WHCart:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function WHCart:OnReset()
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function WHCart:OnSpawn()
	self:Reset()
end

-- =============================================================================
function WHCart:Reset()
	self.isQuestCart = self.Properties.bIsQuestCart
	self.cartType = self.Properties.sCartType
end

-- =============================================================================
-- =                            PROPERTIES GETTERS                             =
-- =============================================================================
function WHCart:GetIsQuestCart()
	return self.isQuestCart
end

-- =============================================================================
function WHCart:GetCartType()
	return self.cartType
end