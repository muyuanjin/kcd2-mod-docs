Script.ReloadScript( "SCRIPTS/Entities/WH/Stash/AnimStash.lua")

CartStash =
{
	Properties =
	{
		object_Model = "objects/manmade/common_furniture/chests/chest-rustic-a-wagon.cga", 	-- use only .cga models!!!! (.cgf does not contain slot for lockpicking)
		fUseDistance 	= 1.5,
		fUseLockpickDistance = 1.5,
	},
	
	LockType 		= "cartChest",	-- anim tag
}

-- =============================================================================
function CartStash:Event_Open()
	self.__super.Event_Open(self)
	Cart.BlockByStash(self.id)
end

-- =============================================================================
function CartStash:Event_StartLockPicking()
	self.__super.Event_StartLockPicking(self)
	Cart.BlockByStash(self.id)
end

-- =============================================================================
function CartStash:IsUsable(user)
	if(not self.__super.IsUsable(self, user)) then
		return 0
	end

	if(Cart.IsEntityOnMovingCart(self.id)) then
		return 0
	end

	return 1
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(CartStash, Stash);