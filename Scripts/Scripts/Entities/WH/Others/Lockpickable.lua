Lockpickable =
{
	Server = {},
	Client = {},

	Properties =
	{
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		sWH_AI_EntityCategory = "",

		object_Model = "Objects/manmade/food/food/egg.cgf", -- Currently there is no dedicated model for the lock (pillory has the lock as part of the whole animated character), so we use invisible egg since it has similar size

		Lock =
		{
			bLocked = true, -- default state
			bCanLockPick = true,
			fLockDifficulty = 0.1,
			esLockFanciness = "Common",
			bSendMessage = false,	-- send signals to AI
			guidItemClassId = "", --["item used as a key"]
		},

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= -1,
		},

		Phase = {
			bChangeAfterPlayerInteract = false,
			object_ModelAfterInteract = "",
		},

		fUseDistance 	= 1.5,
		fUseLockpickDistance = 1.5,
		fUseLockpickAngle = 0.8,
		bSkipAngleCheck = false,
		fUseAngle = 0.3,
		fUseXOffset = 0,
		fUseYOffset = 0,
		fUseZOffset = 0,
		fUseSlotRotationAngle = 0, -- rotation of interactor

		bInteractableThroughCollision = false,
		sPickPlaceAnimTag="", -- tag that is valid for the PickFrom and PlaceTo animation fragments. if empty, animation will not play when used for ChangeEquipmentAction
		bOwnedByHome = true -- Automatically create an ownership link from home if placed in one
    },


	Editor=
	{
		Icon		="lockpickable.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},

	nSoundId 		= 0,
	bLocked 		= false, -- current state
	bNeedUpdate 	= 0, -- updated when animating
	bUseableMsgChanged = 0,
	nUserId = 0,					 -- is set from C_Minigame::Start and C_Minigame::Stop
	LockType 		= "pillory",	-- anim tag
}

-- =============================================================================
function Lockpickable:OnLoad(table)
	if(table.bLocked ~= nil) then
		self.bLocked = table.bLocked
	else
		self.bLocked = self.Properties.Lock.bLocked
	end
	self.bNeedUpdate = 0
	-- start from default pose
	self:DoStopSound()
	self.fTargetTime = 0

	if(table.interactive ~= nil) then
		self.interactive = table.interactive
	else
		self.interactive = true
	end

	-- ! maybe we need add load phase system !

	if (self.bLocked == true and AI) then
		self:Lock()
	end
end

-- =============================================================================
function Lockpickable:OnSave(table)

	if (self.bLocked ~= self.Properties.Lock.bLocked) then
		table.bLocked = self.bLocked
	end

	if (not self.interactive) then		
		table.interactive = self.interactive
	end

	-- ! maybe we need add save phase system !
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function Lockpickable:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function Lockpickable:OnReset(toGame)
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function Lockpickable:OnSpawn()
	self:Reset()
end

-- =============================================================================
function Lockpickable:Reset()
	self.bLocked = false
	if (self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
	end

	self:PhysicalizeThis()
	self:DoStopSound()

	-- lock
	if (self.Properties.Lock.bLocked == true) then
		self:Lock()
	end

	self.interactive = true
end

-- =============================================================================
function Lockpickable:PhysicalizeThis()
	local Physics = self.Properties.Physics
	EntityCommon.PhysicalizeRigid( self, 0, Physics, true )
end

-- =============================================================================
function Lockpickable:IsUsable(user)
	if (not user) then
		return 0 -- canot be used by AI
	end

	local playerPos = g_Vectors.temp_v2
	user:GetWorldPos(playerPos)

	local interactorLocalPos = g_Vectors.temp_v3
	interactorLocalPos.x = self.Properties.fUseXOffset
	interactorLocalPos.y = self.Properties.fUseYOffset
	interactorLocalPos.z = self.Properties.fUseZOffset
	local interactorPos = self:ToGlobal(-1, interactorLocalPos)

--	CryAction.PersistantSphere(interactorPos, 0.02, {0,1,1}, "LockInteractorPos", 0.1)

	local vecFromPlayer = VectorUtils.Subtract(interactorPos, playerPos)

	local lengthsq = VectorUtils.LengthSquared(vecFromPlayer)
	local usedistsq = self.Properties.fUseDistance * self.Properties.fUseDistance
	if(lengthsq > usedistsq) then
		return 0
	end

	if (self.Properties.bSkipAngleCheck == true) then
		return 1
	end

	local useAngle = self.Properties.fUseAngle

	local myDirection = self:GetDirectionVector()
    local rotatedMyDir = VectorUtils.RotateAround(myDirection, { x = 0, y = 0, z = 1}, math.rad(self.Properties.fUseSlotRotationAngle))
--	CryAction.PersistantArrow(interactorPos, 0.2, rotatedMyDir, {0.5,0.5,1}, "LockInteractorDir", 0.1)

	vecFromPlayer.z = 0
	vecFromPlayer = VectorUtils.Normalize(vecFromPlayer)
--	CryAction.PersistantArrow(interactorPos, 0.2, vecFromPlayer, {0.5,0.5,0}, "LockInteractorDirFromPlayer", 0.1)

	local dp = VectorUtils.DotProduct2D(rotatedMyDir,vecFromPlayer)

	if (dp < useAngle) then
		return 0
	end

	return 1
end

-- =============================================================================
function Lockpickable:IsUsableMsgChanged()
	local ret = self.bUseableMsgChanged
	self.bUseableMsgChanged = 0
	return ret
end

-- =============================================================================
function Lockpickable:IsUsableHold(user)
	if (self.nUserId == 0) and (self.Properties.Lock.bCanLockPick == true) and (self.bLocked == true) then
		return user.soul:IsInCombatDanger()
	end

	return 0
end

-- =============================================================================
-- when firstFast is true method returns only first action
function Lockpickable:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	local isUsable = self:IsUsable(user)
	if (firstFast and isUsable==0) then
		return {}
	end

	output = {}

	if self.bLocked == true and self.nUserId == 0 and self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
		AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_unlock" ):action( "use" ):func( Lockpickable.OnUsed ):interaction( inr_lockpickableUnlock ) )
	end

	if ((self.nUserId == 0) and (self.Properties.Lock.bCanLockPick == true) and (self.bLocked == true) and user.soul:HaveSkill('thievery') and (EntityCommon.IsUsableForLockpick(user, self) == 1)) then
		local canUseMinigame = Minigame.CanUseMinigame(user.id);
		AddInteractorAction( output, firstFast, Action():hint( '@' .. Crime.BuildLockpickPromptStrName(self.Properties.Lock.fLockDifficulty) ):action( "use" ):hintType( AHT_HOLD ):enabled( canUseMinigame ):func( Lockpickable.OnUsedHold ):interaction( inr_lockpickableLockpick ) )
	end

	return output
end

-- =============================================================================
function Lockpickable:GetUsableEvent()
	if((self.bLocked == true) and (self.Properties.Lock.bCanLockPick == true) and (self.nUserId ~= 0) )
	then
		return "use_stop"
	else
		return "use"
	end
end

-- =============================================================================
function Lockpickable:OnUsed(user, slot)
	if self.bLocked == true and user.id == player.id and self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
		self:Unlock()
	end
end

-- =============================================================================
function Lockpickable:OnUsedHold(user, slot)
	--System.Log("OnUsedHold")

	if (self.nDirection == 0 or self.bNeedUpdate == 1) then
		return
	end

	if ((self.Properties.Lock.bCanLockPick == true) and (self.bLocked == true) and (EntityCommon.IsUsableForLockpick(user, self) == 1)) then
		Minigame.StartLockPicking(self.id)
	end
end

-- =============================================================================
function Lockpickable:GetLockDifficulty()
	return self.Properties.Lock.fLockDifficulty
end

-- =============================================================================
function Lockpickable:Lock()
	self.bLocked=true
	self.lockBase:ReportLocked()
	--System.Log("Lockpickable: Locked")
end

-- =============================================================================
function Lockpickable:Unlock()
	self.bLocked=false
	self.lockBase:ReportUnlocked()
	--System.Log("Lockpickable: Unlocked")
end

-- =============================================================================
function Lockpickable:DoPlaySound(sndName)
	self:DoStopSound()
	if (sndName and sndName ~= "") then
		local sndFlags=bor(SOUND_DEFAULT_3D, 0)
		g_Vectors.temp = self:GetDirectionVector(1)
		self.nSoundId=self:PlaySoundEvent(sndName, g_Vectors.v000, g_Vectors.temp, sndFlags, SOUND_SEMANTIC_MECHANIC_ENTITY)
	end
end

-- =============================================================================
function Lockpickable:DoStopSound()
	if(self.nSoundId ~= 0 and Sound.IsPlaying(self.nSoundId)) then
		self:StopSound(self.nSoundId)
	end
	self.nSoundId = 0
end

-- =============================================================================
-- Events
-- =============================================================================
function Lockpickable:Event_Unlock()
	self:Unlock()
	EntityCommon.BroadcastEvent(self, "Unlock")
end

-- =============================================================================
function Lockpickable:Event_Lock()
	self:Lock()
	EntityCommon.BroadcastEvent(self, "Lock")
end

-- =============================================================================
function Lockpickable:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
end

-- =============================================================================
function Lockpickable:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
end

-- =============================================================================
Lockpickable.FlowEvents =
{
	Inputs =
	{
		Lock = { Lockpickable.Event_Lock, "bool" },
		Unlock = { Lockpickable.Event_Unlock, "bool" },
		Hide = { Lockpickable.Event_Hide, "bool" },
		UnHide = { Lockpickable.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Lock = "bool",
		Unlock = "bool",
		Hide = "bool",
		UnHide = "bool",
	},
}

-- =============================================================================
function Lockpickable:SetInteractive (value)

	self.interactive = value

end

-- =============================================================================
function Lockpickable:SetBeingUsedByNPC(beingUsedByNPC)
	self.beingUsedByNPC = beingUsedByNPC
end

function Lockpickable:SetBeingUsedByPlayer(beingUsedByPlayer)
	self.beingUsedByPlayer = beingUsedByPlayer
end
