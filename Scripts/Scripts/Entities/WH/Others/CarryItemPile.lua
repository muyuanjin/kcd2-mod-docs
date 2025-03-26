CarryItemPile =
{
	Editor =
	{
	-- TODO: zmenit ikonu
		Icon = "mine.bmp",
	},

	Properties =
	{
		sPickupAnimTagOverride="",	-- if not empty, will replace value from database
		sDepositAnimTagOverride="", -- if not empty, will replace value from database
		sMaterialOverride="", -- if not empty, will use the specified material (full path) for all phases of the pile
		guidItemClassId="0",
		guidCarryItemPileId="0",
		audioSwitchPackSoundOverride="", -- if not empty, will replace value from database
		nCapacity=1,
		nNumberOfItems=0, -- number of items in the stash. Once noItems == capacity, nothing more can be deposited (TODO?: give a prompt "stash is full" to the player?)
		vInteractSize={x=0.5,y=0.5,z=0.5}, -- size of the bounding box that can be interacted with - bounding box of the model (if it is assigned) is ignored!
		vInteractBoxOffset={x=0,y=0,z=0}, -- offset (from the center of the entity) of the bounding box that can be interacted with
		guidSmartObjectType = "",
		sHintPackAndPick="@ui_packandpick_item",
		sHintPickup="@ui_pickup_item",
		sHintDeposit="@ui_deposit_item",
	}
}

-- =============================================================================
function CarryItemPile:GetActions( user, firstFast )
	output = {}
	
	if CIPileBind.CanPackAndPick(user.id, self.id) == 1 then
		AddInteractorAction( output, firstFast, Action():hint( self.Properties.sHintPackAndPick ):action( "use" ):interaction( inr_carryItem ):func( CarryItemPile.OnPickUp ) )
	elseif CIPileBind.CanPickUp(user.id, self.id) == 1 then
		AddInteractorAction( output, firstFast, Action():hint( self.Properties.sHintPickup ):action( "use" ):interaction( inr_carryItem ):func( CarryItemPile.OnPickUp ) )
	elseif CIPileBind.CanDeposit(user.id, self.id) == 1 then
		AddInteractorAction( output, firstFast, Action():hint( self.Properties.sHintDeposit ):action( "deposit_item" )
			:actionMap("carry_item"):interaction( inr_carryItem ):hintType(AHT_PRESS):func( CarryItemPile.OnDeposit ) )
	end

	return output
end

-- =============================================================================
function CarryItemPile:OnDeposit( user, slot )
	CIPileBind.Deposit(user.id, self.id)
end

-- =============================================================================
function CarryItemPile:OnPickUp( user, slot )
	CIPileBind.PickUp(user.id, self.id)
end
