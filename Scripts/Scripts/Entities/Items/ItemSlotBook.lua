Script.ReloadScript( "Scripts/Entities/Items/ItemSlot.lua")

ItemSlotBook = {
	Properties = {
		fUsabilityDistance = 1.75,
		fUseAngle = 0.10,
	}
}

EntityCommon.DeriveOverride(ItemSlotBook, ItemSlot)
