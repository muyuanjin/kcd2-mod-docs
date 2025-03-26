UsableItem =
{
	-- Petra: if those tables are present, in derived entity, script state functions (those in EScriptStateFunctions) from derived entity not in Server/Client table are not loaded !!!
	--Server = {},
	--Client = {},

	Properties =
	{
		soclasses_SmartObjectClass = "",
		object_Model = "",

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= -1,
		},

		-- not editable per instance for now
		--fUseAngle			= 0.7,			-- (-1,1) -0.9 excludes front, 0.99 for not turning
		--fMinUseDistance	= 1,
	},

	Editor=
	{
		Icon		= "animobject.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},

	bUseableMsgChanged = 0,
	nUserId = 0,					 -- is set from C_Minigame::Start and C_Minigame::Stop

	fUseAngle = 0.7,
	fMinUseDistance = 0.7,
	bUseTrigger = false
}

-- =============================================================================
-- OnPropertyChange called only by the editor.
function UsableItem:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function UsableItem:OnReset()
	--System.Log("UsableItem:OnReset")
	self.nUserId = 0
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function UsableItem:OnSpawn()
	self:Reset()
end

-- =============================================================================
function UsableItem:LoadModel()

	if (self.Properties.object_Model and self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
	end
end

-- =============================================================================
function UsableItem:ResetChild()

end

-- =============================================================================
function UsableItem:Reset()
	--System.Log("UsableItem:Reset")

	self:LoadModel()

	self:PhysicalizeThis()
	self.nUserId = 0

	self:ResetChild();		-- called in derived class instead of Reset(), otherwise this function is overwritten

	if self.bUseTrigger == true then
		self:SetupTrigger();
	end
end

-- =============================================================================
function UsableItem:PhysicalizeThis()
	local Physics = self.Properties.Physics
	if (Physics) then
		EntityCommon.PhysicalizeRigid( self, 0, self.Properties.Physics, true )
	end
end

-- =============================================================================
function UsableItem:IsUsable(user)
	if (not user) then
		return 0; -- canot be used by AI
	end

	if (self.nUserId ~= 0 and self.nUserId ~= user:GetRawId()) then
		return 0
	end

	return 1
end

-- =============================================================================
function UsableItem:IsUsableMsgChanged()
	return self.bUseableMsgChanged
end

-- =============================================================================
function UsableItem:GetUsableMessage(idx)
	self.bUseableMsgChanged = 0

	if (self.nUserId == 0) then
		return "@ui_hud_start_use"
	else
		return "@ui_hud_stop_use"
	end
end

-- =============================================================================
function UsableItem:OnUsed(user)
end

-- =============================================================================
-- Events
-- =============================================================================
function UsableItem:Event_Use(sender)
	System.Log("UsableItem.Event_Use "..tostring(sender.id))
	--self:OnUsed(sender)
end

-- =============================================================================
function UsableItem:Event_User(sender, entityId)
	System.Log("UsableItem.Event_User "..tostring(entityId))
	--self:OnUsed(sender)
end

-- =============================================================================
function UsableItem:SetupTrigger()
	local flagstab = { flags=geom_colltype_ray, flags_mask=-1, flags_collider_mask=-1 }
	self:SetPhysicParams(PHYSICPARAM_PART_FLAGS, flagstab)

	local cvarValue = System.GetCVar("wh_ent_ShowHelperObjects")
	local showInEditMode = cvarValue > 0
	if (System.IsEditor() and showInEditMode) then
		self:SetMaterial("objects/intermediates/poses/poses_nomultimaterial")
	else
		self:SetMaterial("materials/special/nodraw")
	end	
end

-- =============================================================================
UsableItem.FlowEvents =
{
	Inputs =
	{
		Use = { UsableItem.Event_Use, "entityid" },
		User = { UsableItem.Event_User, "entityid" },
	},
	Outputs =
	{
		OnUse = "bool",
	},
}
