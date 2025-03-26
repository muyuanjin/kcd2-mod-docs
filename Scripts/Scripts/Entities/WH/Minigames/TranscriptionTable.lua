Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

TranscriptionTable =
{
	Properties =
	{
		object_Model = "Objects/props/alchemy/bookstand/bookstand.cgf",

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= false, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= 100,
		},

		Script = {
			Misc = "",
			sTranscriptionBooksItemIds = "3bed7288-086a-4a62-8291-22f32291b06f|40d029c9-3b81-4758-8aa2-a6c71fc4500b|5b262db6-3fa3-4be6-b0d5-4c50f2d35a5e|5943bccf-03ce-4ced-bef7-b28f4d5f3fb1|dbf96a07-0769-4327-ae31-14a95bdfd603"
		},
	},

	Editor =
	{
		Icon = "ledge.bmp",
	},

	-- Indicates whether the object is currently usable (it is being enabled only for the quest purposes)
	bUsable = false,
}

-- =============================================================================
function TranscriptionTable:ResetChild()
	self.bUsable = false
end

-- =============================================================================
function TranscriptionTable:OnLoad(table)
	self.bUsable = false
	UsableItem:OnLoad(table)
end

-- =============================================================================
function TranscriptionTable:LoadModel()

	if (self.Properties.object_Model and self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
	end
end

-- =============================================================================
-- Returns randomly chosen transcribing book item id that is specified in the TranscriptionBooksItemIds property
function TranscriptionTable:GetRandomTranscriptionBook()
	local books = {}
	for id in string.gmatch(self.Properties.Script.sTranscriptionBooksItemIds, "[%w%-]+") do
		table.insert(books, id)
	end
	return books[math.random(#books)]
end

-- =============================================================================
function TranscriptionTable:OnUsed( user, slot )
	-- Randomize the transcribing book
	local bookEntity = self:GetLinkTarget("book")
	bookEntity.Properties.guidItemClassId = self:GetRandomTranscriptionBook()
	bookEntity.item:Reset()

	user.human:StartBookTranscription( self.id )
end

-- =============================================================================
function TranscriptionTable:GetActions( user, firstFast )
	output = {}

	if (self.nUserId ~= 0 or not self.bUsable) then
		return output
	end

	AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_start_transcribing" ):action( "use" ):interaction( inr_transcription ):func( TranscriptionTable.OnUsed ) )

	return output
end

-- =============================================================================
function TranscriptionTable:SetUsable(usable)
	self.bUsable = usable
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( TranscriptionTable, UsableItem )
