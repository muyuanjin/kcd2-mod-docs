Script.ReloadScript( "SCRIPTS/Entities/Items/PickableItem.lua")
Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

Book =
{
	Properties =
	{
		bIsDirectlyReadable = false,
		bNotPickable = false,

		Physics = {
			bRigidBody = false,
		},
		fUsabilityDistance = 1.75,

	},

	-- [MR] increase priority so that it is possible to select the book when
	-- NPC is reading it at the same time [KCD2-118264]
	InteractorPriority = 3,

	ContentText 	= "",
	ContentImages 	= "",
	ContentChanged	= false,
	ContentScramble	= 1.0,
	ContentLayout   = 0,

	GfxName = "GeneralBook",	-- name of swf
	SubMtlId = 1,		-- id of submaterial (probably in .mtl file)
	TexSlot = 11,		-- texture slot (I think that they are defined in MaterialHelpers.cpp:s_TexSlotSemantics)

	aiListeners = {},

	fUseAngle = 0.10,

	Model = "objects/characters/assets/book/book_01.cdf",
	AnimOpen="open",
	AnimClose="close",
	AnimPageNext="list_next",
	AnimPagePrev="list_prev",
	PageAnimationTransitionTime=0.4,

	nUserId=0,

	bIsUsable,
}

-- =============================================================================
function Book:OnReset()

	self.bIsUsable = true
	-- create instance table (so it is not shared between entities)
	self.aiListeners = {}
end

-- =============================================================================
function Book:RegisterAiListener(aiListener)
	table.insert(self.aiListeners, aiListener)
end

-- =============================================================================
function Book:UnregisterAiListener(aiListener)
	table.RemoveValue(self.aiListeners, aiListener)
end

-- =============================================================================
function Book:ResetChild()
end

-- =============================================================================
function Book:IsCrossCenteringEnabled()
	if self.Properties.bIsDirectlyReadable then
		return false
	else
		return true
	end
end

-- =============================================================================
function Book:OnPropertyChange()
    PickableItem.OnPropertyChange( self )
    UsableItem.OnPropertyChange( self )
end

-- =============================================================================
function Book:GetActions( user, firstFast )
	if (user == nil) then
		return {}
	end

	if( self.Properties.bIsDirectlyReadable )
	then
		output = {}

		if self:IsUsable(user) == 0 then
			return {}
		end

		local canUseMinigame = Minigame.CanUseMinigame(user.id);
		AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_book_start_use" ):action( "use" ):func( Book.OnUsed ):enabled( canUseMinigame ):interaction( inr_bookReading ) )

		return output
	else
		return PickableItem.GetActions( self, user, firstFast )
	end
end

-- =============================================================================
function Book:IsUsable(user)

	if not self.bIsUsable then
		return 0
	end

	if( self.Properties.bIsDirectlyReadable )
	then

		dist = self:GetDistance(user.id)
		if (dist > self.Properties.fUsabilityDistance) then
			return 0
		end

		if (not user) then
			return 0; -- canot be used by AI
		end

		if (self.nUserId ~= 0) then
			return 0
		end

		local useAngle = self.fUseAngle
		if (useAngle < -1 and useAngle > 1) then
			return 0
		end

		-- get book position
		local myPos = g_Vectors.temp_v1
		self:GetWorldPos(myPos)

		-- get vector to player
		local vecToPlayer = g_Vectors.temp_v2
		user:GetWorldPos(vecToPlayer)
		vecToPlayer = VectorUtils.Subtract(myPos,vecToPlayer)

		-- get book direction
		local myDirection = g_Vectors.temp_v3
		self:GetDirectionVector( 2, myDirection )

		-- get direction deviation
		vecToPlayer = VectorUtils.Normalize(vecToPlayer)
		myDirection = VectorUtils.Normalize(myDirection)

		local dp = VectorUtils.DotProduct2D(myDirection,vecToPlayer)

		if (dp < useAngle) then
			return 0
		end
		
		local canUseBook = Minigame.CanStartReadingMinigame(self.id)
		if not canUseBook then
			return 0
		end

		return 1
	else
		return 0
	end
end

-- =============================================================================
function Book:OnSave(storage)
	storage.bIsUsable = self.bIsUsable
	storage.aiListeners = self.aiListeners
end

-- =============================================================================
function Book:OnLoad(storage)
	self.bIsUsable = storage.bIsUsable
	self.aiListeners = storage.aiListeners
end

-- =============================================================================
function Book:SetUsable(usable)
	self.bIsUsable = usable
end

-- =============================================================================
function Book:OnUsed(user, slot)
	if( self.Properties.bIsDirectlyReadable )
	then
		if (user) then
			if (self.nUserId == 0) then
				self:ActivateOutput( "OnUse", true )

				for _, aiListener in ipairs(self.aiListeners) do
					-- There is no common:wuid, send Entity id instead.
					XGenAIModule.SendMessageToEntityData(aiListener, 'book:onUsed', { book = self.id })
				end

				local resourceObjectId = self:GetLinkedSmartObject();
				PlayerStateHandler.StartMinigame(self.id, E_MinigameType_Reading, resourceObjectId, 'reading', E_Urgency_Instant);
			end
		end

		--self:StopAnimation(0,0)
		--self:StartAnimation(0, "open")
		--self:SetAnimationSpeed( 0, 0, 1 )
		--self:CharacterUpdateOnRender( 0, true )
		--self:CharacterUpdateAlways( 0, true )
		--self:Activate(1)
	else
		PickableItem.OnUsed( self, user, slot )
	end
end

-- =============================================================================
function Book:GetLinkedSmartObject()
    local slotWuid = self.item:GetSlot(true);
    local links = XGenAIModule.FindLinks(slotWuid, "");

    if links[1] == nil then
        return nil;
    end

    return links[1];
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(Book, UsableItem)
EntityCommon.DeriveOverride(Book, PickableItem)