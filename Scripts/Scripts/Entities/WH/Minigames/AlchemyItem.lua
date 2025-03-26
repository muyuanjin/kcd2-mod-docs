AlchemyItem =
{
	Server = {},
	Client = {},

	Properties =
	{
		bSaved_by_game = false,
		sWH_AI_EntityCategory = "",
		soclasses_SmartObjectClass = "",
		object_Model = "",
		alchemy_type = 0,
		slot_name = "",
		bInteractableThroughCollision = false,
		bInteractiveCollisionClass = false,
		bUpdateOnlyByScript = false, -- JFilek, option to register to update only when required
	},

	Editor =
	{
		Icon = "animobject.bmp",
		ShowBounds = 1,
		IconOnTop = 1,
	},

	bUseableMsgChanged = 0,
	nUserId = 0,
	usables = {},
	InteractorPriority = 2,
}

-- =============================================================================
-- OnPropertyChange called only by the editor.
function AlchemyItem:OnPropertyChange()
	self:Reset()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
-- OnInit called only by the editor.
function AlchemyItem:OnInit()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function AlchemyItem:OnReset()
	self:Reset()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function AlchemyItem:OnSpawn()
	self:Reset()
end

-- =============================================================================
function AlchemyItem:LoadModel()
	if (self.Properties.object_Model and self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
	end
end

-- =============================================================================
function AlchemyItem:ResetChild()

end

-- =============================================================================
function AlchemyItem:Reset()
	self:LoadModel()
	self:ResetChild()

	self:PhysicalizeThis()
	self.nUserId = 0

	self.usables = {
		"ui_in_alchem_flag_dish",
		"ui_in_alchem_flag_hourglass",
		"ui_in_alchem_flag_mortar",
		"ui_in_alchem_flag_pestle",
		"ui_in_alchem_flag_distillator",
		"ui_in_alchem_flag_empty_glass",
		"ui_in_alchem_flag_kettle",
		"",
		"",
		"",
		"",
		"",
		"",
		"ui_in_alchem_flag_alcohol",
		"ui_in_alchem_flag_oil",
		"ui_in_alchem_flag_wine",
		"ui_in_alchem_flag_water",
		"ui_in_alchem_flag_empty_glass",
		"ui_in_alchem_flag_bellows",
		"x",
		"",
	}

	-- JFilek set proper update policy for on demand updates
	if (self.Properties.bUpdateOnlyByScript == true) then
		self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
	end
end

-- =============================================================================
function AlchemyItem:PhysicalizeThis()
	local	Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= false, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= 0,
			Mass 				= 5,
		}

	EntityCommon.PhysicalizeRigid( self, 0, Physics, true )
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AlchemyItem:IsCrossCenteringEnabled()
	return Alchemy.IsCrossCenteringEnabled(self.nUserId, self.Properties.alchemy_type)
end

-- =============================================================================
function AlchemyItem:IsUsableMsgChanged()
	return self.bUseableMsgChanged
end

-- =============================================================================
function AlchemyItem:GetActions(user, firstFast)
	-- prepare container for actions
	output = {}

	-- check basic conditions
	if (user == nil) then
		return output
	end

	if (self.nUserId == 0) then
		return output
	end

	-- reset bUseableMsgChanged
	self.bUseableMsgChanged = 0

	-- get action hint
	local usableIdx = Alchemy.GetUsableFor(self.nUserId, self.Properties.alchemy_type)
	local hintText = ""
	if (usableIdx == 0) then
		hintText = "@ui_hud_undefined"
	elseif (usableIdx == 1) then
		hintText = "@ui_hud_alchemy_pour_water"
	elseif (usableIdx == 2) then
		hintText = "@ui_hud_alchemy_pour_wine"
	elseif (usableIdx == 3) then
		hintText = "@ui_hud_alchemy_pour_oil"
	elseif (usableIdx == 4) then
		hintText = "@ui_hud_alchemy_pour_spiritus"
	elseif (usableIdx == 5) then
		hintText = "@ui_hud_alchemy_turn_clock"
	elseif (usableIdx == 6) then
		hintText = "@ui_hud_alchemy_move_down"
	elseif (usableIdx == 7) then
		hintText = "@ui_hud_alchemy_move_up"
	elseif (usableIdx == 8) then
		hintText = "@ui_hud_alchemy_lay"
	elseif (usableIdx == 9) then
		hintText = "@ui_hud_alchemy_crush"
	elseif (usableIdx == 10) then
		hintText = "@ui_hud_alchemy_pour_out"
	elseif (usableIdx == 11) then
		hintText = "@ui_hud_alchemy_distill"
	elseif (usableIdx == 12) then
		hintText = "@ui_hud_alchemy_melt"
	elseif (usableIdx == 13) then
		hintText = "@ui_hud_alchemy_melt_and_distill"
	elseif (usableIdx == 14) then
		hintText = "@ui_hud_alchemy_take"
	elseif (usableIdx == 15) then
		hintText = "@ui_hud_alchemy_insert"
	elseif (usableIdx == 16) then
		hintText = "@ui_hud_alchemy_return"
	elseif (usableIdx == 17) then
		hintText = "@ui_hud_alchemy_use"
	elseif (usableIdx == 18) then
		hintText = "@ui_hud_alchemy_prepare_flask"
	end

	local isVisible = Alchemy.IsUsableVisibleFor(self.nUserId, self.Properties.alchemy_type)
	if not isVisible then 
		return output
	end
	

	-- is item currently enabled?
	local actionEnabled = Alchemy.IsUsableEnabledFor(self.nUserId, self.Properties.alchemy_type)
	local disableReason = ""
	
	if not actionEnabled then
		disableReason = Alchemy.GetDisableReason(self.nUserId, self.Properties.alchemy_type)
	end

	local isHold = Alchemy.IsUsableByHold(self.nUserId, self.Properties.alchemy_type)

	-- create action
	if isHold then
		AddInteractorAction( output, firstFast, Action():hint( hintText ):action( "alch_use" ):actionMap( "alchemy" ):interaction( inr_use_alch ):enabled( actionEnabled ):hintType(AHT_HOLD):func(AlchemyItem.OnUse):reason(disableReason) )
	else
		AddInteractorAction( output, firstFast, Action():hint( hintText ):action( "alch_use" ):actionMap( "alchemy" ):interaction( inr_use_alch ):enabled( actionEnabled ):hintType(AHT_RELEASE):func(AlchemyItem.OnUse):reason(disableReason) )
	end

	-- return
	return output
end

-- =============================================================================
function AlchemyItem:OnUse()
	
	Alchemy.OnUse(self.nUserId)
end

-- =============================================================================
function AlchemyItem:GetUsableName(slot)
	--return Alchemy.GetFlagTextFor(self.nUserId, self.Properties.alchemy_type)
	--return self.item:GetUIName()

	local name = self.usables[self.Properties.alchemy_type + 1]
	if (name == "") then
		return Alchemy.GetFlagTextFor(self.nUserId, self.Properties.alchemy_type)
	else
		return name
	end
end

-- =============================================================================
function AlchemyItem:SetInteractiveCollisionType()
	local filtering = {}

	if(self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
function AlchemyItem:OnUsed(user)
	--Alchemy.UseItem(user.id, self.Properties.alchemy_type)
end
