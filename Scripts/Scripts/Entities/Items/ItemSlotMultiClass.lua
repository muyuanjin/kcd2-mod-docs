Script.ReloadScript( "Scripts/Entities/Items/ItemSlot.lua")

ItemSlotMultiClass = {

	Properties={
		nRestockPeriodDays 		= 0, -- [0, 0, 1] multiclass item slot does not support restock
		nDestockPeriodDays 		= 0, -- [0, 65535, 1] in how many days does the item destock after being taken, 0 to disable destock
	}

}

EntityCommon.DeriveOverride(ItemSlotMultiClass, ItemSlot)
