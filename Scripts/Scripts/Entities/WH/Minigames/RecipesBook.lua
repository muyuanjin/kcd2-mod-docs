Script.ReloadScript( "SCRIPTS/Entities/Items/PickableItem.lua")
Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

-- NOTE: difference from Book: not closed state, text is not set to gfx, but its already inside, movie clips with pages are set
RecipesBook =
{
	Properties =
	{
		sWH_AI_EntityCategory = "",
		--guidItemClassId = "",		-- RecipesBook should not be PickableItem (because PickableItem has limited range at which it can be used). It would be difficult to modify C_DocumentItem to do not be PickableItem, so commenting this line is just a quick-fix ensuring that Interactor will not apply the range restrains on RecipesBook.
		--object_Model = "objects/props/alchemy/book/alchemy_book.cgf",		-- this is commented in order to force all alchemy tables to use the same book defined by RecipesBook.Model
		bHasHerbal = false,			-- is true for alchemy book, false for cooking book
		alchemy_type = 19,
		slot_name = "dummy_alchemy_book",

		-- not editable per instance for now
		--fUseAngle			= 0.7,			-- (-1,1) -0.9 excludes front, 0.99 for not turning
		--fMinUseDistance	= 1,
	},

	Editor =
	{
		Icon = "ledge.bmp",
	},

	bDoublePage	= false,

	GfxName = "AlchemyBook",
	--SubMtl = "pages",
	--TexSlot = 11,

	SubMtl = "book01",	-- submaterial in cgf for pages
	SubMtlId = 1,		-- id of submaterial (probably in .mtl file)
	TexSlot = 11,		-- texture slot (I think that they are defined in MaterialHelpers.cpp:s_TexSlotSemantics)

	Model = "objects/characters/assets/book/book_01.cdf",
	AnimOpen="alchemy_place_book",
	AnimClose="alchemy_close_book",
	AnimPageNext="alchemy_flip_alchemy_book_fwd",
	AnimPagePrev="alchemy_flip_alchemy_book_bwd",
	PageAnimationTransitionTime=0.4,
	InteractorPriority = 2,
}

-- =============================================================================
function RecipesBook:LoadModel()
	if (self.Model) then
		self:LoadObject(0, self.Model)
	end
end

-- =============================================================================
function RecipesBook:ResetChild()
	--System.Log("RecipesBook:Reset")
end

-- =============================================================================
function RecipesBook:GetUsableName(slot)
	return self.item:GetUIName()
end

-- =============================================================================
function RecipesBook:GetActions(user, firstFast)
	-- prepare container for actions
	output = {}

	-- check basic conditions
	if (user == nil) then
		return output
	end

	if (self.nUserId == 0) then
		return output
	end

	self.bUseableMsgChanged = 0

	local actionEnabled = Alchemy.IsUsableEnabledFor(self.nUserId, 19)

	-- create action
	AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_read" ):action( "alch_use" ):actionMap( "alchemy" ):interaction( inr_use_alch ):enabled( actionEnabled ):hintType(AHT_RELEASE):func(RecipesBook.OnUse) )

	-- return
	return output
end

-- =============================================================================
function RecipesBook:OnUse()
	
	Alchemy.OnUse(self.nUserId)
end

-- =============================================================================
function RecipesBook:GetUsableName(slot)
	return "ui_in_alchem_flag_book"
end

-- =============================================================================
function RecipesBook:IsCrossCenteringEnabled()
	return false
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(RecipesBook, UsableItem)
EntityCommon.DeriveOverride(RecipesBook, PickableItem)
