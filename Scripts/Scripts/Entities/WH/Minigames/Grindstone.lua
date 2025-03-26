Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

Grindstone =
{
	Server = {},
	Client = {},

	Properties =
	{
		bSaved_by_game = false,
		sWH_AI_EntityCategory = "",
		object_Model = "objects/characters/assets/grindstone/grindstone.cdf",

		nDifficulty			= 1,			-- count of holes per round
		fSpeedMultiplier 	= 1,			-- direction and speed of the wheel

		guidSmartObjectType = "",
     	soclass_SmartObjectHelpers = ""
	},

	Editor =
	{
		Icon = "animobject.bmp",
	},

	user_id = nil,
}

-- =============================================================================
function Grindstone:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	output = {}

	if firstFast == false then
		self.bUseableMsgChanged = 0
	end

	if self:IsUsable(user) == 0 then
		return {}
	end

	if (self.nUserId == 0) then								-- nobody is using it => make it usable
		local canUseMinigame = Minigame.CanUseMinigame(user.id)
		AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_use_grindstone" ):action( "use" ):func( Grindstone.OnUsed ):enabled( canUseMinigame ):interaction( inr_sharpening ) )
	elseif (self.nUserId ~= user:GetRawId()) then			-- someone else is using it => show it as disabled
		AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_use_grindstone" ):action( "use" ):enabled( false ):reason( "@ui_reason_grindstone_occupied" ) )
	end

	return output
end

-- =============================================================================
function Grindstone:OnUsed(user)
	if (user) then
		if (user.soul:IsInCombatDanger()) then
			return
		end

		if (self.nUserId == 0) then
			self:ActivateOutput( "OnUse", true )
			if (user.class == "Player") then	-- for player, sharpening starts after selecting weapon in inventory GUI
				user.actor:OpenItemSelectionSharpening( self.id )
				self.user_id = user.id;
				self.bUseableMsgChanged = 1;
			else
				--Sharpening.Start(user.id, self.id)
			end
		end
	end
end

-- =============================================================================
function Grindstone:IsUsable(user)
	if (not user) then
		return 0; -- canot be used by AI
	end

	-- Women can't use grindstones
	if(IsFemale(user)) then
		return 0
	end

	if (self.nUserId ~= 0 and self.nUserId ~= user.id) then
		return 0
	end

	local myDirection = g_Vectors.temp_v1
	local vecToPlayer = g_Vectors.temp_v2
	local myPos = g_Vectors.temp_v3

	myDirection = self:GetDirectionVector(0)

	user:GetWorldPos(vecToPlayer)
	self:GetWorldPos(myPos)

	vecToPlayer = VectorUtils.Subtract(myPos,vecToPlayer)
	local len = VectorUtils.Length(vecToPlayer)

	if(len > 1.8) then
		return 0
	end

	vecToPlayer = VectorUtils.Normalize(vecToPlayer)
	vecToPlayer = VectorUtils.Rotate90AroundZ(vecToPlayer)

	local dp = VectorUtils.DotProduct2D(myDirection,vecToPlayer)

	--System.Log(" "..dp.." "..len)

	if(dp > 0.6) then
		return 1
	end

	return 0
end

-- =============================================================================
function Grindstone:OnInventoryItemUsed( itemId )
	Sharpening.Start( self.user_id, self.id, itemId );
	
	XGenAIModule.SendMessageToEntityData(player.this.id, 'tutorial:onGrindstoneUse', true)
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(Grindstone, UsableItem)
