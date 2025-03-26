-- Crytek Source File.
-- Copyright (C), Crytek Studios, 2001-2005.

Script.ReloadScript("scripts/Utils/InteractorAction.lua")

AnimDoor =
{
	Server = {},
	Client = {},
	Properties =
	{
		sWH_AI_EntityCategory = "Door",
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		soclasses_SmartObjectClass = "",
		esNavCompoment = "Door",
		esDoorAnimSet = "",
		bInteractiveCollisionClass = true,
		bNoCrimeDoorLink  = false,
		Lock =
		{
			bLocked = false, -- default state
			fLockDifficulty = 0.5, -- fLockDifficulty is referenced from code.
			bLockDifficultyOverride = false,
			esLockFanciness = "Common",
			bLockFancinessOverride = false,
			bCanLockPick = true,
			bCanUnlockWithDynamicKey = true, -- master key to all locks in home or shop generated in code while looting / pickpocketing. Disable to enable only legacy guid keys
			bSendMessage = false, -- send signals to AI
			esLockTypes = "none/none", -- none/none manual/none manual/key key/key (last is not realistic)
			bLockReversed = false,
			guidItemClassId = "", --["item used as a key"]
			bLockInside = false, 	-- lock every time when entering the interior
			bLockOutside = false, -- when leaving the interior
			bDoLockOnMissingHomeArea = true,

			bNeverLockByPassingNPC = true,
			fKeepUnlockedFrom = 7.5,
			fKeepUnlockedTo = 19.5,
		},
		object_Model = "",
		Sounds =
		{
			snd_Open = "Sounds/environment:doors:door_wood_1_open",
			snd_Close = "Sounds/environment:doors:door_wood_1_close",
		},
		Animation =
		{
			anim_Open = "Open",
			anim_Close = "Close",
		},
		Physics = {
			bPhysicalize = true, -- True if object should be physicalized at all.
			bRigidBody = false, -- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density = -1,
			Mass = -1,
		},
		fUseDistance = 2.0,
		bActivatePortal = false,
		bNoFriendlyFire = false,
		fUseLockpickDistance = 2.0,
		fUseLockpickAngle = 0.8,
	},
	Editor =
	{
		Icon = "Door.bmp",
		ShowBounds = 1,
	},
	nDirection = -1, -- -1 closed, 0 nothing, 1=open
	bUseSameAnim = 0,
	bNoAnims = 0,
	nSoundId = 0,
	bLocked = false, -- current state
	bNeedUpdate = 0,
	bUseableMsgChanged = 0,
	nUserId = 0; -- is set from C_Minigame::Start and C_Minigame::Stop
	LockType = "door"; -- anim tag r_door or l_door according to side
	nUpdateAfterLoad = 0, -- WH[JFilek] extend update by one frame after a load so it can proccess instant animation

	-- WH[matej.marko]: added last anim being played to save/load correct animation
	lastAnim = ""
}

-- =============================================================================
function AnimDoor:OnLoad(table)
	if(table.bLocked ~= nil) then
		self.bLocked = table.bLocked
	else
		self.bLocked = self.Properties.Lock.bLocked
	end
	self.bNeedUpdate = 0
	-- start from default pose
	self:ResetAnimation(0, -1)
	self:DoStopSound()
	self.curAnim = ""
	self.fTargetTime = 0

	-- do not save this property, since it is set from the tree
	self.unlockedDueExpected = false
	if(table.lockedDueToPrivate ~= nil) then
		self.lockedDueToPrivate = table.lockedDueToPrivate
	else
		self.lockedDueToPrivate = false
	end

	if(table.shouldLockOverride_onEnter ~= nil) then
		self.shouldLockOverride_onEnter = table.shouldLockOverride_onEnter
	else
		self.shouldLockOverride_onEnter = self.Properties.Lock.bLockInside
	end

	if(table.shouldLockOverride_onExit ~= nil) then
		self.shouldLockOverride_onExit  = table.shouldLockOverride_onExit
	else
		self.shouldLockOverride_onExit = self.Properties.Lock.bLockOutside
	end
	
	if(table.lockpickable ~= nil) then
		self.lockpickable = table.lockpickable
	else
		self.lockpickable = self.Properties.Lock.bCanLockPick
	end

	if(table.suspiciousInteractionTimestamp ~= nil) then
		self.suspiciousInteractionTimestamp = table.suspiciousInteractionTimestamp
	end

	if ((self.bLocked == true) and AI) then
			self:Lock()
	end


	-- deactivate portal by default
	if (self.portal) then
			System.ActivatePortal(self:GetWorldPos(), 0, self.id)
	end

	local newDirection = -1
	if(table.nDirection ~= nil) then
		newDirection = table.nDirection
	end
	
	if(table.lastAnim ~= nil) then
		self.lastAnim = table.lastAnim
	else
		self.lastAnim = ""
	end

	-- valid new direction - only valid values are -1 and 1
	if ((newDirection ~= 1 and newDirection ~= -1)) then
		newDirection = -1 -- default value is closed
	end

	-- update anim state of the doors when was used before load
	if (newDirection ~= self.nDirection or self.inUse ~= 0) then
		-- need to set set according to newDirection
		-- play last frame of opening animation
		-- WH[JF]: Added updating 2 frames: 
		-- 1. update is for animationprocessing and computing bbox in the character
		-- 2. update is for updating AABB in the render proxy (it is copied from character)
		self.nUpdateAfterLoad = 2
		self:DoPlayAnimation(newDirection, 1.0, false, self.lastAnim); -- will also activate portal
		self.curAnim = ""
	end

	self.inUse = 0; -- inUse is set in DoPlayAnimation and reseted in Server.OnUpdate.
end

-- =============================================================================
function AnimDoor:NeedSerialize()
	-- lock stuff
	if (self.bLocked ~= self.Properties.Lock.bLocked) then
		return true
	end

	if (self.lockedDueToPrivate) then
		return true
	end

	if(self.shouldLockOverride_onEnter ~= self.Properties.Lock.bLockInside) then
		return true
	end

	if(self.shouldLockOverride_onExit ~= self.Properties.Lock.bLockOutside) then
		return true
	end

	if (self.lockpickable ~= self.Properties.Lock.bCanLockPick) then
		return true
	end

	if (self.suspiciousInteractionTimestamp ~= nil) then		
		return true
	end

	if (self.nDirection ~= -1) then
		return true
	end

	if (self.lastAnim ~= "") then
		return true
	end

	return false
end

-- =============================================================================
function AnimDoor:OnSave(table)
	-- lock stuff
	if (self.bLocked ~= self.Properties.Lock.bLocked) then
		table.bLocked = self.bLocked
	end

	if (self.lockedDueToPrivate) then
		table.lockedDueToPrivate  = self.lockedDueToPrivate
	end

	if(self.shouldLockOverride_onEnter ~= self.Properties.Lock.bLockInside) then
		table.shouldLockOverride_onEnter = self.shouldLockOverride_onEnter
	end

	if(self.shouldLockOverride_onExit ~= self.Properties.Lock.bLockOutside) then
		table.shouldLockOverride_onExit  = self.shouldLockOverride_onExit
	end

	if (self.lockpickable ~= self.Properties.Lock.bCanLockPick) then
		table.lockpickable = self.lockpickable
	end

	if (self.suspiciousInteractionTimestamp ~= nil) then		
		table.suspiciousInteractionTimestamp = self.suspiciousInteractionTimestamp
	end

	if (self.nDirection ~= -1) then
		table.nDirection = self.nDirection
	end

	if (self.lastAnim ~= "") then
		table.lastAnim = self.lastAnim
	end
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function AnimDoor:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function AnimDoor:OnReset()
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function AnimDoor:OnSpawn()
	self:Reset()
end

-- =============================================================================
function AnimDoor:IsAccessedFromFront()
	local playerPos = player:GetWorldPos()
	local doorPos = self:GetWorldPos()
	local doorDir = self:GetWorldDir()

	local dot = ((doorPos.x - playerPos.x) * doorDir.x) + ((doorPos.y - playerPos.y) * doorDir.y)

	local playerSide
	if dot < 0 then
		--player from back
		return false
	else
		--player from front
		return true
	end
end

-- =============================================================================
function AnimDoor:IsRightDoor()
	return string.match(self.Properties.object_Model, "right") ~= nil
end

-- =============================================================================
function AnimDoor:Reset()
	if (self.portal) then
		System.ActivatePortal(self:GetWorldPos(), 0, self.id)
	end

	self.bLocked = false
	self.portal = self.Properties.bActivatePortal == true
	self.bUseSameAnim = self.Properties.Animation.anim_Close == ""
	if (self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
	end

	self.bNoAnims = self.Properties.Animation.anim_Open == "" and self.Properties.Animation.anim_Close == ""

	self:PhysicalizeThis()
	self:DoStopSound()

	-- state setting, closed
	self.nDirection = -1
	self.curAnim = ""
	self.inUse = 0

	self.suspiciousInteractionTimestamp = nil

	-- is the npc expecting the player in its home
	self.unlockedDueExpected = false
	-- should the door be locked since the area is private (e.g. shop is closed)
	self.lockedDueToPrivate = false

	-- runtime copy of bLockInside / bLockOutside
	self.shouldLockOverride_onEnter = self.Properties.Lock.bLockInside == true
	self.shouldLockOverride_onExit  = self.Properties.Lock.bLockOutside == true

	self.lockpickable = self.Properties.Lock.bCanLockPick == true

	local shouldGenerateLockData = self.Properties.Lock.bLockDifficultyOverride == false or self.Properties.Lock.bLockFancinessOverride == false
	if shouldGenerateLockData then
		local lockData = self:GenerateLockData()
		if self.Properties.Lock.bLockDifficultyOverride == false then
			self.Properties.Lock.fLockDifficulty = lockData.difficulty
		end	
		if self.Properties.Lock.bLockFancinessOverride == false then
			self.Properties.Lock.esLockFanciness = lockData.fanciness
		end
	end

	-- ShouldBeLocked requires the properties set above
	-- default state of lock is the same if npc would be leaving
	if self.Properties.Lock.bLocked == true or self:ShouldBeLocked(false) then
		self:Lock()
	end

	self:SetInteractiveCollisionType()

	self.Properties.Lock.lockpickTime = nil;

	-- JFilek
	self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
end

-- =============================================================================
function AnimDoor:SetInteractiveCollisionType()
	local filtering = {}

	if (self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering)
end

-- =============================================================================
function AnimDoor:SetPhysicalFlags(userId, enable)

	if (not userId) then
		return
	end

	local userEntity = System.GetEntity(userId)
	if (not userEntity) then
		return
	end

	local flagstab = { flags_mask=0, flags=0 }

	if (enable) then
		flagstab.flags = pef_always_shoot_ray_down
	else
		flagstab.flags_mask = pef_always_shoot_ray_down
	end

	userEntity:SetPhysicParams(PHYSICPARAM_FLAGS, flagstab)
end

-- =============================================================================
function AnimDoor.Client:OnLevelLoaded()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AnimDoor:OnEnablePhysics()
	-- When loading streamable layer, OnLevelLoaded has been sent way before.
	-- Nevertheless, interactive collision class must be set for the entity
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AnimDoor:PhysicalizeThis()
	local Physics = self.Properties.Physics
	-- we don't want any door to be rigid right now
	Physics.bRigidBody = false

	EntityCommon.PhysicalizeRigid(self, 0, Physics, true)
end

-- =============================================================================
function AnimDoor:IsUsable(user)
	if (not user) then
		return 0
	end

	if (user.id ~= player.id) then
		return 1
	end

	if (self.inUse == 1) then
		return 0
	end

	if ((self.bLocked == true) and (self.nDirection == -1)) then
		--TFatal("locked, what do?")

		if self:IsOnKeySide() == 1 and self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
			return 1
		end

		if self:IsAccessedFromFront() then
			if (self.Properties.Lock.esLockTypes == "manual/none") and (self.Properties.Lock.bLockReversed == true) then
				--TFatal("locked from other side")
				return 0
			end
		else
			if (self.Properties.Lock.esLockTypes == "manual/none") and (self.Properties.Lock.bLockReversed == false) then
				--TFatal("locked from other side")
				return 0
			end
		end
		--TFatal("locked, but can open, I quess")
	end

	local useDistance = self.Properties.fUseDistance
	if (useDistance <= 0.0) then
		return 0
	end

	local delta = g_Vectors.temp_v1
	local mypos, bbmax = self:GetWorldBBox()

	mypos = VectorUtils.Sum(mypos, bbmax)
	mypos = VectorUtils.Scale(mypos, 0.5)
	user:GetWorldPos(delta)

	delta = VectorUtils.Subtract(delta, mypos)

	local useDistance = self.Properties.fUseDistance
	if (VectorUtils.LengthSquared(delta) < useDistance * useDistance) then
		return 1
	else
		return 0
	end
end

-- =============================================================================
function AnimDoor:IsUsableMsgChanged()
	return self.bUseableMsgChanged
end

-- =============================================================================
function AnimDoor:IsOnKeySide()
		local frontSide = self:IsAccessedFromFront()
	if (self.Properties.Lock.esLockTypes == "manual/key") and ((self.Properties.Lock.bLockReversed == false and not frontSide) or (self.Properties.Lock.bLockReversed == true and frontSide)) or (self.Properties.Lock.esLockTypes == "key/key") then
		return 1
	else
		return 0
	end
end

-- =============================================================================
-- when firstFast is true method returns only first action
function AnimDoor:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	if not self:IsInteractive() then
		return {}
	end

	output = {}

	if self:IsUsable(user) == 1 then
		if (self.bLocked == true) and (self:IsOnKeySide() == 1) then
			if self.nUserId == 0 and self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
				AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_unlock_and_open" ):action( "use" ):hintType( AHT_RELEASE ):func( AnimDoor.OnUsed ):interaction( inr_doorUnlock ) )
			end
		else
			if self.nDirection == -1 then
				AddInteractorAction( output, firstFast, Action():hint( "@ui_door_open" ):action( "use" ):func( AnimDoor.OnUsed ):interaction( inr_doorOpen ) )
			else
				AddInteractorAction( output, firstFast, Action():hint( "@ui_door_close" ):action( "use" ):func( AnimDoor.OnUsed ):interaction( inr_doorClose ) )
			end
		end
	end

	-- locked door
	if self.lockpickable and (self.bLocked == true) and self:IsOnKeySide() == 1 and (self.nUserId == 0) and (user.soul:HaveSkill('thievery')) and (EntityCommon.IsUsableForLockpick(user, self) == 1) then
		local isEnabled = not player.soul:IsInTenseCircumstance()
		AddInteractorAction( output, firstFast, Action():hint( '@' .. Crime.BuildLockpickPromptStrName(self.Properties.Lock.fLockDifficulty) ):action( "use_other" ):hintType( AHT_HOLD ):func( AnimDoor.Lockpick ):interaction( inr_doorLockpick ):enabled(isEnabled) )
	end

	return output
end

-- =============================================================================
function AnimDoor:IsInteractive()
	return self.animDoor:IsInteractive();
end

-- =============================================================================
function AnimDoor:Lockpick(user, slot)
	if self.lockpickable and (self.bLocked == true) and self:IsOnKeySide() == 1 and (self.nUserId == 0) and (EntityCommon.IsUsableForLockpick(user, self) == 1) then
		Minigame.StartLockPicking(self.id)
	end
end

-- =============================================================================
function AnimDoor:OnUsed(user, slot)
	if (self.nDirection == 0) then
		return 0
	end

	-- WH[mmarko]: Interactivity may have changed since the last call to GetActions
	if not self:IsInteractive() then
		return;
	end

	-- WH[patrik.papso] we want to spawn a crime volume only when opening the door (in case NPC despawned it via AI reaction)
	local openingDoor = self.nDirection == -1

	local direction = -self.nDirection

	if self.bLocked == true then

		if self:IsOnKeySide() == 1 then
			--TFatal("standing from key side")
			if self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
					self:Unlock()
					self:DoPlayAnimation(direction, nil, nil, nil, true, user.id)
					self:ProduceAiSound()
				end

			--TFatal("minigame ended or none")
		else
			--TFatal("standing from manual side, can open now")

			if (user.id == player.id) then
				--TFatal("will open now")
				self:Unlock()
				self:DoPlayAnimation(direction, nil, nil, nil, true, user.id)
				self:ProduceAiSound()
			end
		end
	else
		--TFatal("not locked")
		if (user.id == player.id) then
			--TFatal("will open now")
			self:DoPlayAnimation(direction, nil, nil, nil, true, user.id)
			self:ProduceAiSound()
		end
	end

	if user.id == player.id and openingDoor then
		local links = XGenAIModule.FindLinks(self.this.id, 'crime_doNotSpawnSuspiciousDoorVolume') 
		if next(links) == nil then
		self:SpawnSuspiciousVolume()
	end
end
end

-- =============================================================================
function AnimDoor:GetSuspiciousVolume()
    local links = XGenAIModule.FindLinks(self.this.id, "crime_suspiciousDoor_reverse");
    if next(links) == nil then
		return nil
	else
		return links[1]
	end  
end

-- =============================================================================
function AnimDoor:SpawnSuspiciousVolume()
	local doorPos = self:GetPos()
	local suspiciousDoorVolume = XGenAIModule.SpawnPerceptibleVolume(doorPos, 0.8, 1.5, 0.001, 1, 'crime_suspiciousDoor', '24h', true, false)
	XGenAIModule.AddLink(suspiciousDoorVolume, self.this.id, 'crime_suspiciousDoor')
	--XGenAIModule.IgnorePerception(player.id, self.this.id, '24h', true, false)
	self.suspiciousInteractionTimestamp = Calendar.GetGameTime()
end

-- =============================================================================
function AnimDoor:DespawnSuspiciousVolume()
	local volume = self:GetSuspiciousVolume()
	if volume ~= nil then
		XGenAIModule.DespawnPerceptibleVolume(volume)
	end
end

-- =============================================================================
function AnimDoor:EnableLockpick()
	self.lockpickable = true
end

-- =============================================================================
function AnimDoor:DisableLockpick()
	self.lockpickable = false
end

-- =============================================================================
-- Beware: This function can be called from engine. Both function name and parameters must be synced with code.
function AnimDoor:Lock(dontClose)
	if not dontClose and self:IsOpen() then
		self:Close()
	end

	self.bLocked = true
	self.lockBase:ReportLocked()
end

-- =============================================================================
-- Beware: This function can be called from engine. Both function name and parameters must be synced with code.
function AnimDoor:Unlock()
	self.bLocked = false
	self.lockBase:ReportUnlocked()
end

-- =============================================================================
-- Beware: This function can be called from engine. Both function name and parameters must be synced with code.
-- forceOpen - ignore that door is being used, open it with force!
function AnimDoor:Open(forceOpen)
	-- Ignore open request when door in use
	if not self:IsInUse() or forceOpen then
		if self.nDirection == -1 then
			-- use the same animation as it would be, when opened by player
			self:DoPlayAnimation(1, nil, nil, nil, nil, player.id)
		end
	end

	if self:IsLocked() then
		self:Unlock();
	end
end

-- =============================================================================
-- Beware: This function can be called from engine. Both function name and parameters must be synced with code.
function AnimDoor:Close(forceClose)
	if not self:IsInUse() or forceClose then
		if self.nDirection == 1 then
			self:DoPlayAnimation(-1, nil, nil, nil, nil, player.id)
		end
	end
end

-- =============================================================================
function AnimDoor:SetShouldBeLockedOverride(doLock)
	if doLock then
		self.shouldLockOverride_onEnter = true
		self.shouldLockOverride_onExit = true
	else
		self.shouldLockOverride_onEnter = self.Properties.Lock.bLockInside == true
		self.shouldLockOverride_onExit  = self.Properties.Lock.bLockOutside == true
	end
end

-- =============================================================================
function AnimDoor.Server:OnUpdate(dt)
	if (self.bNeedUpdate == 0) then
		return
	end
	if (self.bNoAnims ~= 0 or (self.curAnim ~= "" and self.nDirection ~= 0)) then
		local curTime = self:GetAnimationTime(0, 0)

		if (not self:IsAnimationRunning(0, 0) or (math.abs(curTime - 1) < 0.0001)) then
			if (self.nUpdateAfterLoad > 0) then
				self.nUpdateAfterLoad = self.nUpdateAfterLoad - 1
				return
			end

			self.curAnim = ""
			-- self:StopAnimation(0,0); -- 3.7 cryengine doesn't support this, if I stop the animation, it gets reset
			if (self.nDirection == -1) then
				-- fully closed
				--System.Log("Closed")
				-- deactivate portal when fully closed
				if (self.portal) then
					System.ActivatePortal(self:GetWorldPos(), 0, self.id)
				end
				-- JF: Disabling force update when animation ends
				self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 2)
				self:SetPhysicalFlags(self.lastUsedBy, false)
				self.bNeedUpdate = 0
				self.inUse = 0
				EntityCommon.BroadcastEvent(self, "Close")

				if (self.animDoor ~= nil) then
					self.animDoor:ReportClosed(self.lastUsedBy)
				end
			else
				-- fully open
				--System.Log("Opened")
				-- JF: Disabling force update when animation ends
				self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 2)
				self:SetPhysicalFlags(self.lastUsedBy, false)
				self.bNeedUpdate = 0
				self.inUse = 0
				EntityCommon.BroadcastEvent(self, "Open")

				if (self.animDoor ~= nil) and (self.lastUsedBy ~= nil) then
					self.animDoor:ReportOpened(self.lastUsedBy)
				end
			end
		end
	end
end

-- =============================================================================
function AnimDoor:DoPlaySound(sndName)
	--REINST
	-- self:DoStopSound()
	-- if (sndName and sndName ~= "") then
	-- local sndFlags=bor(SOUND_DEFAULT_3D, 0)
	-- g_Vectors.temp = self:GetDirectionVector(1)
	-- self.nSoundId=self:PlaySoundEvent(sndName, g_Vectors.v000, g_Vectors.temp, sndFlags, 0, SOUND_SEMANTIC_MECHANIC_ENTITY)
	-- end
end

-- =============================================================================
function AnimDoor:DoStopSound()
	--REINST
	-- if(self.nSoundId ~= 0 and Sound.IsPlaying(self.nSoundId)) then
	-- self:StopSound(self.nSoundId)
	-- end
	-- self.nSoundId = 0
end

-- =============================================================================
function AnimDoor:BuildNPCAnimationName(userId, customAnim)
	local animName

	if customAnim == nil then
		local isOpened = self:IsOpen()
		animName = self.animDoor:GetUserAnimName(userId, isOpened, not isOpened, self:IsAccessedFromFront());
	else
		-- NPC is opening the door from tree via custom animation
		animName = ''
	end

	return animName
end

-- =============================================================================
function AnimDoor:BuildObjectAnimationName(userId, customAnim)
	local animName

	if customAnim == nil then
		local isOpened = self:IsOpen()
		animName = self.animDoor:GetObjectAnimName(userId, isOpened, not isOpened, self:IsAccessedFromFront());
	else
		-- NPC is opening the door from tree via custom animation
		animName = customAnim
	end

	return animName
end

-- =============================================================================
-- TODO: input via table?
-- TODO: This function should be called ChangeState instead of DoPlayAnimation since it plays the animation and also handles the states
--[[
	direction:
	   0 - nothing
	  -1 - close
	   1 - open
--]]
function AnimDoor:DoPlayAnimation(direction, forceTime, useSound, customAnim, usePlayerAnim, userId)
	-- WH[adam.sporka] update before animation, namely determine the material for audio
	if (self.animDoor ~= nil) then
		self.animDoor:UpdateBeforeAnimation(userId)
	end

	--Dump("Hello, I am a door and I am: "..self.nDirection.." and I will be: "..direction.." and to get there I will use: "..customAnim)
	local suspiciousVolume = self:GetSuspiciousVolume()
	if suspiciousVolume ~= nil then
		self:DespawnSuspiciousVolume()
	end

	self.inUse = 1
	if (self.animDoor ~= nil) then
		self.animDoor:ReportManipulationStart()
	end
	--self.bLocked = false
	-- stop animation
	local curTime = 0
	self.lastUsedBy = userId

	local len = 0
	local bNeedAnimStart = 1
	if (self.curAnim ~= "" and self:IsAnimationRunning(0, 0)) then
		curTime = self:GetAnimationTime(0, 0)
		len = self:GetAnimationLength(0, self.curAnim)
		bNeedAnimStart = not self.bUseSameAnim
	end

	if (bNeedAnimStart) then
		local animDirection = direction
		local animName = self.Properties.Animation.anim_Open
		if (direction == -1 and not self.bUseSameAnim) then
			animName = self.Properties.Animation.anim_Close
			animDirection = -animDirection
		end

		-- WH[michal.vrtilek] custom animation code
		animName = self:BuildObjectAnimationName(userId, customAnim)
		if usePlayerAnim then
			local npcAnim = self:BuildNPCAnimationName(userId, customAnim)
			player.actor:StartInteractiveActionByName(npcAnim, self.id, true, 1)
			self:SetPhysicalFlags(self.lastUsedBy, true)

			if self.Properties.Lock.bSendMessage == true then
				if (self.nDirection == 1) then
					XGenAIModule.SendMessageToEntity(self.this.id, "door:onOpenOnClose", "action('onClose')")
				else
					XGenAIModule.SendMessageToEntity(self.this.id, "door:onOpenOnClose", "action('onOpen')")
				end
			end
		end

		animDirection = 1
		self.lastAnim = animName
		-- WH[michal.vrtilek] end of custom animation code

		if (not self.bNoAnims) then
			self:StopAnimation(0, 0)
			self:StartAnimation(0, animName)
			self:SetAnimationSpeed(0, 0, animDirection)

			if (forceTime) then
				self:SetAnimationTime(0, 0, forceTime)
			else
				local relativeTime = Pick(animDirection == 1, curTime, 1.0 - curTime)
				self:SetAnimationTime(0, 0, relativeTime)
			end
		end
		self.curAnim = animName
		self.fTargetTime = self:GetAnimationLength(0, self.curAnim)
	else
		self:SetAnimationSpeed(0, 0, direction)
	end

	self.nDirection = direction
	--self:ForceCharacterUpdate(0, true) -- WH[tomas.vahalik] do not force full skeleton update
	-- JF: Enable force update to ensure that AnimDoor GameObject will be active during animating
	self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 0) 
	self:Activate(1)
	self.bNeedUpdate = 1

	-- activate portal on opening and on closing!
	if (self.portal) then
		System.ActivatePortal(self:GetWorldPos(), 1, self.id)
	end

	-- play sound after enabling the portal so sound doesn't get culled
	local sndName = self.Properties.Sounds.snd_Open
	if (direction == -1) then
		sndName = self.Properties.Sounds.snd_Close
	end
	-- MB: sound is animation event
	--if (useSound == nil or useSound) then
	--	self:DoPlaySound(sndName)
	--end
end

-- =============================================================================
function AnimDoor:IsInUse()
	return self.inUse == 1
end

-- =============================================================================
function AnimDoor:IsLocked()
	return self.bLocked == true
end

-- =============================================================================
function AnimDoor:GetLockDifficulty()
	return self.Properties.Lock.fLockDifficulty
end

-- =============================================================================
function AnimDoor:IsOpen()
	return self.nDirection > 0
end

-- =============================================================================

function AnimDoor:ShouldBeLocked(isEntering)
	return (isEntering and self.shouldLockOverride_onEnter) or (not isEntering and self.shouldLockOverride_onExit)
end

-- =============================================================================
function AnimDoor:SetUnlockedDueExpected(isExpected)
	self.unlockedDueExpected = isExpected
end

-- =============================================================================
function AnimDoor:SetLockedDueToPrivate(isPrivate)
	if isPrivate then
		self:Lock()
	else
		self:Unlock()
	end

	self.lockedDueToPrivate = isPrivate
end

-- =============================================================================
function AnimDoor:DoLockOnMissingHomeArea()
	return self.bDoLockOnMissingHomeArea == true
end

-- =============================================================================
function AnimDoor:GenerateLockData()
	local model2lockData = {
		["doors/lvl1_door_a_left"] = {difficulty = 3.3, fanciness = "Common"},
		["doors/lvl1_door_a_left_plague"] = {difficulty = 3.3, fanciness = "Common"},
		["doors/lvl1_door_a_right"] = {difficulty = 3.3, fanciness = "Fancy"},

		["doors/lvl2_door_a_left"] = {difficulty = 6.5, fanciness = "Fancy"},
		["doors/lvl2_door_a_right"] = {difficulty = 6.5, fanciness = "Fancy"},
		["doors/lvl2_door_townhouse_d_red_left"] = {difficulty = 9.2, fanciness = "Fancy"},
		["doors/lvl2_door_townhouse_d_red_right"] = {difficulty = 9.2, fanciness = "Common"},
		["doors/lvl2_door_townhouse_d_wooda_left"] = {difficulty = 9.2, fanciness = "Fancy"},
		["doors/lvl2_door_townhouse_d_wooda_right"] = {difficulty = 9.2, fanciness = "Fancy"},
		["doors/lvl2_door_townhouse_d_woodb_left"] = {difficulty = 7.6, fanciness = "Common"},
		["doors/lvl2_door_townhouse_d_woodb_right"] = {difficulty = 7.6, fanciness = "Fancy"},
		["doors/lvl2_door_townhouse_d_woodc_left"] = {difficulty = 7.4, fanciness = "Common"},
		["doors/lvl2_door_townhouse_d_woodc_right"] = {difficulty = 7.4, fanciness = "Common"},

		["doors/lvl3_door_cave_right"] = {difficulty = 10.6, fanciness = "Common"},
		["doors/lvl3_door_e_left"] = {difficulty = 7.2, fanciness = "Common"},
		["doors/lvl3_door_e_right"] = {difficulty = 7.2, fanciness = "Fancy"},
		["doors/lvl3_door_prison_left"] = {difficulty = 18.7, fanciness = "Common"},
		["doors/lvl3_door_prison_right"] = {difficulty = 18.7, fanciness = "Common"},
		["doors/lvl3_door_townhouse_b_black_left"] = {difficulty = 10.6, fanciness = "Common"},
		["doors/lvl3_door_townhouse_b_black_right"] = {difficulty = 10.6, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_b_green_left"] = {difficulty = 11.4, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_b_green_right"] = {difficulty = 11.4, fanciness = "Common"},
		["doors/lvl3_door_townhouse_b_wooda_left"] = {difficulty = 11, fanciness = "Common"},
		["doors/lvl3_door_townhouse_b_wooda_right"] = {difficulty = 11, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_b_woodb_left"] = {difficulty = 10, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_b_woodb_right"] = {difficulty = 10, fanciness = "Common"},
		["doors/lvl3_door_townhouse_d_left"] = {difficulty = 11.2, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_d_right"] = {difficulty = 11.2, fanciness = "Common"},
		["doors/lvl3_door_townhouse_g_black_left"] = {difficulty = 11.6, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_g_black_right"] = {difficulty = 11.6, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_g_red_left"] = {difficulty = 13.6, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_g_red_right"] = {difficulty = 13.6, fanciness = "Common"},
		["doors/lvl3_door_townhouse_g_wooda_left"] = {difficulty = 13.6, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_g_wooda_right"] = {difficulty = 13.6, fanciness = "Common"},
		["doors/lvl3_door_townhouse_g_woodb_left"] = {difficulty = 14, fanciness = "Fancy"},
		["doors/lvl3_door_townhouse_g_woodb_right"] = {difficulty = 14, fanciness = "Fancy"},
		["doors/lvl3_doors_double_a_left"] = {difficulty = 14.6, fanciness = "Common"},
		["doors/lvl3_doors_double_a_right"] = {difficulty = 14.6, fanciness = "Fancy"},

		["doors/lvl4_door_townhouse_g_left"] = {difficulty = 16.8, fanciness = "Fancy"},
		["doors/lvl4_door_townhouse_g_right"] = {difficulty = 16.8, fanciness = "Fancy"},
		["doors/lvl4_doors_double_a_left"] = {difficulty = 15.4, fanciness = "Fancy"},
		["doors/lvl4_doors_double_a_right"] = {difficulty = 15.4, fanciness = "Fancy"},
		["doors/lvl4_doors_f_v1_left"] = {difficulty = 16.5, fanciness = "Fancy"},
		["doors/lvl4_doors_f_v1_right"] = {difficulty = 16.5, fanciness = "Fancy"},
		["doors/lvl4_doors_f_v2_left"] = {difficulty = 16.8, fanciness = "Fancy"},
		["doors/lvl4_doors_f_v2_right"] = {difficulty = 16.8, fanciness = "Fancy"},
		["doors/lvl4_doors_f_v3_left"] = {difficulty = 16, fanciness = "Fancy"},
		["doors/lvl4_doors_f_v3_right"] = {difficulty = 16, fanciness = "Common"},
		["doors/lvl4_doors_g_left"] = {difficulty = 16, fanciness = "Common"},
		["doors/lvl4_doors_g_right"] = {difficulty = 16, fanciness = "Fancy"},
		["doors/lvl4_doors_townhouse_j_left"] = {difficulty = 13.8, fanciness = "Common"},
		["doors/lvl4_doors_townhouse_j2_left"] = {difficulty = 13.8, fanciness = "Fancy"},
		["doors/lvl4_doors_townhouse_j4_right"] = {difficulty = 13.4, fanciness = "Fancy"},
		["doors/lvl4_doors_townhouse_j5_right"] = {difficulty = 13.4, fanciness = "Common"},
	}

	for nameSnippet, lockData in pairs(model2lockData) do
		if string.match(self.Properties.object_Model, nameSnippet) ~= nil then
			return {
				difficulty = lockData.difficulty / 20.0,
				fanciness = lockData.fanciness
			}
		end
	end

	return {difficulty = 0, fanciness = "Common"}

end

-- =============================================================================
function AnimDoor:ProduceAiSound()
	local crimeDoorSoundMod = RPG.CrimeDoorSoundMod

	Crime.ProduceAiSoundOnDudePosition(enum_sound.door, crimeDoorSoundMod)
end

-- =============================================================================
-- Events
-- =============================================================================
function AnimDoor:Event_Unlock()
	self:Unlock()
	EntityCommon.BroadcastEvent(self, "Unlock")
end

-- =============================================================================
function AnimDoor:Event_Lock()
	self:Lock()
	EntityCommon.BroadcastEvent(self, "Lock")
end

-- =============================================================================
function AnimDoor:Event_Open()
	--self:Open()
	self:DoPlayAnimation(1)
end

-- =============================================================================
function AnimDoor:Event_Close()
	--self:Close()
	self:DoPlayAnimation(-1)
end

-- =============================================================================
function AnimDoor:Event_Hide()
	self:Hide(1)
	self:ActivateOutput("Hide", true)
end

-- =============================================================================
function AnimDoor:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput("UnHide", true)
end

-- =============================================================================
AnimDoor.FlowEvents =
{
	Inputs =
	{
		Close = { AnimDoor.Event_Close, "bool" },
		Open = { AnimDoor.Event_Open, "bool" },
		Lock = { AnimDoor.Event_Lock, "bool" },
		Unlock = { AnimDoor.Event_Unlock, "bool" },
		Hide = { AnimDoor.Event_Hide, "bool" },
		UnHide = { AnimDoor.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Close = "bool",
		Open = "bool",
		Lock = "bool",
		Unlock = "bool",
		Hide = "bool",
		UnHide = "bool",
	},
}

-- =============================================================================
function AnimDoor:DumpState()
	Dump({
		-- static
		lockProperties = self.Properties.Lock,
		-- dynamic lock
		isLocked = self.bLocked,
		interactive = self:IsInteractive(),
		lockpickable = self.lockpickable,
		unlockedDueExpected = self.unlockedDueExpected,
		lockedDueToPrivate  = self.lockedDueToPrivate,
		shouldLockOverride_onEnter = self.shouldLockOverride_onEnter,
		shouldLockOverride_onExit  = self.shouldLockOverride_onExit,
		-- other dynamic
		inUse = self.inUse,
	})
end
