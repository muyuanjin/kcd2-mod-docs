Script.ReloadScript( "Scripts/Entities/Items/PickableItem.lua")

CarryableItem =
{
}

-- =============================================================================
function CarryableItem:GetActions( user, firstFast )
	output = {}
	-- checks the user is close enough
	if self.item:CanUse(user.id) == false then
		return output
	end
	-- checks if the item is outside of its holder and the user is idle
	if CarryableItemBind.CanPickUp(user.id, self.id) == 1 then
		AddInteractorAction( output, firstFast, Action():hint( "@ui_pickup_item" ):action( "use" ):interaction( inr_carryItem ):func( CarryableItem.OnPickUp ) )
	end

	return output
end

-- =============================================================================
function CarryableItem:OnPickUp( user, slot )
	CarryableItemBind.PickUp(user.id, self.id)
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( CarryableItem, PickableItem );