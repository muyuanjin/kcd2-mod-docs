Stash =
{
	Server = {},
	Client = {},

	Properties =
	{
		guidSmartObjectType = "", -- added by Bazilisk (needed for Smart object properties)
		soclass_SmartObjectHelpers = "",
		sWH_AI_EntityCategory = "",
		sOpenMessage = "@ui_open_stash",


		object_Model = "objects/characters/assets/chest/chest_fancy_b.cdf", 	-- use only .cga models!!!! (.cgf does not contain slot for lockpicking)

		Lock =
		{
			bLocked = false, -- default state
			bCanLockPick = true,
			bCanUnlockWithDynamicKey = true, -- master key to all locks in home or shop generated in code while looting / pickpocketing. Disable to enable only legacy guid keys
			fLockDifficulty = 1,
			bLockDifficultyOverride = false,
			esLockFanciness = "Common",
			bLockFancinessOverride = false,
			bSendMessage = false,	-- send signals to AI
			guidItemClassId = "", --["item used as a key"]
		},

		Sounds =
		{
			snd_Open = "",
			snd_Close = "",
		},
		Animation =
		{
			anim_Open="open",
			anim_Close="close",
			bOpenOnly = false,	-- keeps stash closed so it is opened everytime it is used (does not go to open state)
		},

		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= -1,
		},

		Phase = {
			esStashPhaseChangeEvent = "Never", -- Never, PlayerTakesItem, StashIsEmpty, StashHasSomething
			object_PhaseModel = "",
		},

		fUseDistance 	= 2.5,
		fUseLockpickDistance = 2.0,
		fUseLockpickAngle = 0.8,
		bSkipAngleCheck = false,
		fUseAngle = 0.7,
		fUseZOffset = 0,

		Database = {
			iMinimalShopItemPrice	= 0, -- from this price we put items to stash in shop
			sInventoryPreset 		= "",
			sGeneratedInventory		= "", -- JFilek inventory assigned by search over AI links
			nRestockPeriodDays 		= 7, -- in how many days does the item restock after being taken, 0 to disable restock
			bReadOnly 				= false,
		},

		Script = {
			bTutorial = false,
			fTutorialMaxThievery = 15, -- for tutorial chest only, prevents unlimited leveling of thievery skill
			fTutorialMaxThieveryOpenLimit = 10, -- for tutorial chest only, prevents unlimited leveling of thievery skill
			Misc = '',
			bAllowUsageInCombatDanger = true,
		},

		bInteractableThroughCollision = false,
		sPickPlaceAnimTag="", -- tag that is valid for the PickFrom and PlaceTo animation fragments. if empty, animation will not play when used for ChangeEquipmentAction
		bOwnedByHome = true, -- Automatically create an ownership link from home if placed in one
		esChestContextLabel = "none", --["Context of the stash meant for automatic inventory generation"]
    },


	Editor=
	{
		Icon		="stash.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},

	nDirection 		= -1, -- -1 closed, 0 nothing, 1=open
	bOpenAfterUnlock= 0, -- flag that we should open after lockpick
	bUseSameAnim 	= 0, -- when anim_Close is not defined
	bNoAnims 		= 0, -- true when both anims are empty
	nSoundId 		= 0,
	bLocked 		= false, -- current state
	bOpened			= 0,
	bNeedUpdate 	= 0, -- updated when animating
	bUseableMsgChanged = 0,
	inventoryId		= 0, -- internal inventory id (used when not linked to other stash by MasterStash link)
	nUserId = 0,					 -- is set from C_Minigame::Start and C_Minigame::Stop
	LockType 		= "chest",	-- anim tag
	fTutorialOpenCount = 0, -- for tutorial chest only
	bFirstUpdateAfterResetAnimation = false, -- WH[JF] deactivation after load in the first update
	objectPhaseChanged = false
}

-- =============================================================================
function Stash:OnLoad(table)
	self.bOpened = 0
	self.bNeedUpdate = 0
	self.curAnim = ""
	self.nDirection = -1
	self.fTargetTime = 0

	if table.interactive ~= nil then
		self.interactive = table.interactive
	else
		self.interactive = true
	end

	-- tutorial
	if table.fTutorialOpenCount ~= nil then
		self.fTutorialOpenCount = table.fTutorialOpenCount
	else
		self.fTutorialOpenCount = 0
	end

	-- Whether the stash is being used by some NPC/player shouldn't be persistent
	self.beingUsedByNPC = false
	self.beingUsedByPlayer = false

	if table.objectPhaseChanged ~= nil then
		self.objectPhaseChanged = table.objectPhaseChanged
	else
		self.objectPhaseChanged = false
	end
	if self.objectPhaseChanged then
		self:LoadPhaseModel()
	else
		self:LoadOriginalModel()
	end
	-- Load model destroy character physics, need to rephysicalize
	self:PhysicalizeThis()

	-- start from default pose
	self:ResetAnimationWithActivation()
end

-- =============================================================================
function Stash:ResetAnimationWithActivation()
	self:ResetAnimation(0, -1)
	-- one frame activation to reset animation on the chest
	self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 0) 
	self:Activate(1)
	self.bFirstUpdateAfterResetAnimation = true
end

-- =============================================================================
function Stash:NeedSerialize()
	if (not self.interactive) then		
		return true
	end

	if (self.objectPhaseChanged == true) then		
		return true
	end

	-- tutorial
	if (self.fTutorialOpenCount > 0) then		
		return true
	end

	return false
end

-- =============================================================================
function Stash:OnSave(table)
	if (not self.interactive) then	
		table.interactive = self.interactive
	end

	if (self.objectPhaseChanged == true) then		
		table.objectPhaseChanged = self.objectPhaseChanged
	end

	-- tutorial
	if (self.fTutorialOpenCount > 0) then		
		table.fTutorialOpenCount = self.fTutorialOpenCount
	end
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function Stash:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function Stash:OnReset(toGame)
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function Stash:OnSpawn()
	self:Reset()
end

-- =============================================================================
function Stash:LoadOriginalModel()
	self:LoadObject(0, self.Properties.object_Model)
	self.objectPhaseChanged = false	
end

-- =============================================================================
function Stash:LoadPhaseModel()
	self:LoadObject(0, self.Properties.Phase.object_PhaseModel)
	self.objectPhaseChanged = true	
end

-- =============================================================================
function Stash:Reset()
	self.bLocked = false
	self.bOpened = 0
	self.bUseSameAnim = (self.Properties.Animation.anim_Close == "") or (self.Properties.Animation.anim_Close == self.Properties.Animation.anim_Open)
	if (self.Properties.object_Model ~= "") then
		self:LoadOriginalModel()
	end

	self.bNoAnims = self.Properties.Animation.anim_Open == "" and self.Properties.Animation.anim_Close == ""

	self:PhysicalizeThis()

	self.nDirection = -1 -- set closed by default
	self.curAnim = ""
	self.fTargetTime = 0

	-- lock
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

	if (self.Properties.Lock.bLocked == true) then
		self:Lock()
	end

	self.interactive = true

	self.beingUsedByNPC = false
	self.beingUsedByPlayer = false

	-- JFilek
	self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
end

-- =============================================================================
function Stash:PhysicalizeThis()
	local Physics = self.Properties.Physics
	EntityCommon.PhysicalizeRigid( self, 0, Physics, true )
end

-- =============================================================================
function Stash:IsUsable(user)
	if (not user) then
		return 0 -- canot be used by AI
	end

	local vecFromPlayer = g_Vectors.temp_v2
	local myPos = g_Vectors.temp_v3

	user:GetWorldPos(vecFromPlayer)
	self:GetWorldPos(myPos)

	vecFromPlayer.x = myPos.x - vecFromPlayer.x
	vecFromPlayer.y = myPos.y - vecFromPlayer.y
	vecFromPlayer.z = myPos.z - (vecFromPlayer.z + self.Properties.fUseZOffset)

	local lengthsq = VectorUtils.LengthSquared(vecFromPlayer)
	local usedistsq = self.Properties.fUseDistance*self.Properties.fUseDistance
	if(lengthsq > usedistsq) then
		return 0
	end

	if (self.Properties.bSkipAngleCheck == true) then
		return 1
	end

	local useAngle = self.Properties.fUseAngle
	local myDirection = g_Vectors.temp_v1

	myDirection = self:GetDirectionVector()
--	CryAction.PersistantArrow(myPos, 0.2, myDirection, {0.5,0.5,1}, "LockInteractorDir", 0.1)
--	CryAction.PersistantArrow(myPos, 0.2, vecFromPlayer, {0.5,0.5,0}, "LockInteractorDirFromPlayer", 0.1)

	vecFromPlayer.z = 0 -- DotProduct2D() ignores Z, but we need unit size of the vector
	vecFromPlayer = VectorUtils.Normalize(vecFromPlayer)

	local dp = VectorUtils.DotProduct2D(myDirection,vecFromPlayer)

	if (dp < useAngle) then
		return 0
	end

	return 1
end

-- =============================================================================
function Stash:IsUsableMsgChanged()
	local ret = self.bUseableMsgChanged
	self.bUseableMsgChanged = 0
	return ret
end

-- =============================================================================
function Stash:IsUsableHold(user)
	if (self.nUserId == 0) and (self.Properties.Lock.bCanLockPick == true) and (self.bLocked == true) then
		return user.soul:IsInCombatDanger()
	end

	return 0
end

-- =============================================================================
-- when firstFast is true method returns only first action
function Stash:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	local isUsable = self:IsUsable(user)
	if (firstFast and isUsable==0) then
		return {}
	end

	local inventoryToOpen = self:GetInventoryToOpen()

	if (inventoryToOpen == 0) then
		return {}
	end

	output = {}

	local actionEnabled = (not user.soul:IsInCombatDanger() or self.Properties.Script.bAllowUsageInCombatDanger) and not self.beingUsedByNPC 

	local usesStealUiPrompt = self:UsesStealUiPrompt()

	if (self.bOpened == 1) then
		AddInteractorAction( output, firstFast, Action():hint( "@ui_close_stash" ):action( "use" ):enabled( actionEnabled ):func( Stash.OnUsed ):interaction( inr_stashClose ) ) 
	else
		if (self.bLocked == true) then
			if self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
				AddInteractorAction( output, firstFast, Action():hint("@ui_hud_unlock_and_open"):enabled(actionEnabled):action("use"):func(Stash.OnUsed):interaction(inr_stashUnlock))
			end 
			if ((self.nUserId == 0) and (self.Properties.Lock.bCanLockPick == true) and user.soul:HaveSkill('thievery') and (EntityCommon.IsUsableForLockpick(user, self) == 1)) then
				local canLockpicking = Minigame.CanUseMinigame(user.id, E_MUF_CombatDanger)
				AddInteractorAction(output, firstFast, Action():hint( '@' .. Crime.BuildLockpickPromptStrName(self.Properties.Lock.fLockDifficulty)):action("use_other"):hintType(AHT_HOLD):enabled(canLockpicking):func(Stash.OnUsedHold):interaction(inr_stashLockpick))
			end
		else
			if (EntityModule.CanUseInventory(inventoryToOpen)) and (self.interactive) then
				 AddInteractorAction(output, firstFast, Action():hint(Pick(usesStealUiPrompt, "@ui_open_stash_crime", self.Properties.sOpenMessage)):hintType(Pick(usesStealUiPrompt, AHT_HOLD, AHT_RELEASE)):enabled(actionEnabled ):action("use"):func(Stash.OnUsed):interaction(inr_stashOpen))
			end
		end
	end

	return output
end

-- =============================================================================
function Stash:GetUsableEvent()
	if( (self.bOpened ~= 1) and (self.bLocked == true) and (self.Properties.Lock.bCanLockPick == true) and (self.nUserId ~= 0) )
	then
		return "use_stop"
	else
		return "use"
	end
end

-- =============================================================================
function Stash:OnItemRemoved(stashIsEmpty)
	if (not self.beingUsedByPlayer) then
		return
	end

	if (self.Properties.Phase.esStashPhaseChangeEvent == "PlayerTakesItem") or
	   (self.Properties.Phase.esStashPhaseChangeEvent == "StashIsEmpty" and stashIsEmpty) or
	   (self.Properties.Phase.esStashPhaseChangeEvent == "StashHasSomething" and stashIsEmpty) then
		self:LoadPhaseModel()
	end
end

-- =============================================================================
function Stash:OnItemAdded(itemWuid)
	if (self.Properties.Phase.esStashPhaseChangeEvent == "StashHasSomething" and self.objectPhaseChanged) then
		self:LoadOriginalModel()
	end
end

-- =============================================================================
function Stash:AssignInventory()
	local stashInformation = StashInventoryCollector.GetStashInformation(self)
	local generatedInventory = StashInventoryGenerator.GetInventoryFromData(stashInformation)

	EditorUtil.AssignInventoryToStash(self.id, generatedInventory)
	--Dump("Assigning inventory '" .. generatedInventory)
end

-- =============================================================================
function Stash:Open(user)
	local inventoryToOpen = self:GetInventoryToOpen()

	XGenAIModule.LootInventoryBegin(inventoryToOpen)
	user.actor:OpenItemTransferStore(self.id, inventoryToOpen)

	if user == player then
		Crime.ProduceAiSoundOnDudePosition(enum_sound.door, 1)
		self.beingUsedByPlayer = true
    else
    	self.beingUsedByPlayer = false
    end
    -- here and not in OnOpen because of KCD2-367717
    self.stash:ReportOpened(self.beingUsedByPlayer)

	self:Event_Open()
end

-- =============================================================================
function Stash:GetInventoryToOpen()
	local masterInventoryId = self.stash:GetMasterInventory()
	if Framework.IsValidWUID(masterInventoryId) then
		return masterInventoryId
	else
		return self.inventoryId
	end
end

-- =============================================================================
function Stash:Close()
	-- here and not in OnOpen because of KCD2-367717
	self.stash:ReportClosed()
	
	self:Event_Close()
end

-- =============================================================================
function Stash:OnInventoryClosed()
	self:Close()
end

-- =============================================================================
function Stash:OnUsed(user, slot)
	--System.Log("OnUsed")
	if (self.nDirection == 0 or self.bNeedUpdate == 1) then
		return
	end

	if (user.soul:IsInCombatDanger() and self.Properties.Script.bAllowUsageInCombatDanger == false) then
		return
	end

	local nNewDirection = -self.nDirection

	if (nNewDirection == 1) then
		if (user.player) then
			if (self.bLocked == false) then
				self:Open(user)
			elseif self.lockBase:PlayerHoldsKey(self.Properties.Lock.guidItemClassId) then
				self:Unlock()
				self:Open(user)
			end
		end
	else
		self:Close()
	end
end

-- =============================================================================
function Stash:OnUsedHold(user, slot)
	--System.Log("OnUsedHold")

	if (self.nDirection == 0 or self.bNeedUpdate == 1) then
		return
	end

	local nNewDirection = -self.nDirection
	if (nNewDirection == 1) then
		if ((self.Properties.Lock.bCanLockPick == true) and (self.bLocked == true) and (EntityCommon.IsUsableForLockpick(user, self) == 1)) then
			Minigame.StartLockPicking(self.id)
			self:Event_StartLockPicking()
		end
	end
end

-- =============================================================================
function Stash:GenerateLockData()

	local model2lockData = {
		["chest_fancy_a"]  = {difficulty = 11.8, fanciness = "Fancy"},
		["chest_fancy_b"]  = {difficulty = 15.6, fanciness = "Fancy"},
		["chest_fancy_c"]  = {difficulty = 15.8, fanciness = "Fancy"},
		["chest_fancy_d"]  = {difficulty = 17.4, fanciness = "Fancy"},
		["chest_royal_a"]  = {difficulty = 17.2, fanciness = "Fancy"},
		["chest_rustic_a"] = {difficulty = 11.2, fanciness = "Common"},
		["chest_rustic_b"] = {difficulty = 7.2,  fanciness = "Common"},
		["chest_rustic_c"] = {difficulty = 15.2, fanciness = "Fancy"},
		["chest_rustic_d"] = {difficulty = 15.2, fanciness = "Fancy"},
		["chest_shabby_a"] = {difficulty = 6,    fanciness = "Common"},
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
function Stash:GetLockDifficulty()

	return self.Properties.Lock.fLockDifficulty

end

-- =============================================================================
function Stash:Lock()
	self.bLocked=true
	self.lockBase:ReportLocked()
	self:ResetAnimationWithActivation()
	--System.Log("Stash: Locked")
end

-- =============================================================================
function Stash:Unlock()
	self.bLocked=false
	self.lockBase:ReportUnlocked()
	--System.Log("Stash: Unlocked")

	if (self.bOpenAfterUnlock == 1) then
		self.bOpenAfterUnlock = 0
		self:Open()
	end
end

-- =============================================================================
function Stash:OnOpen()
	--System.Log("Stash: Opened")
	self.bOpened = 1
	self.bUseableMsgChanged = 1
	self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 2) 

	if (self.Properties.Animation.bOpenOnly == true) then
		self.bOpened = 0 -- instatn close
		self.nDirection = -1 -- closed direction
	end

end

-- =============================================================================
function Stash:OnClose()
	--System.Log("Stash: Closed")
	self.bOpened = 0
	self.bUseableMsgChanged = 1
	self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 2) 

	-- If the stash is a smart object:
    if self.this ~= nil then
        local selfId = Framework.WUIDToMsg(XGenAIModule.GetMyWUID(self))
        -- kind of weird that this msg is sent regardless of who opened the chest
        XGenAIModule.SendMessageToEntity(self.this.id, "stashInfo:onClosedByPlayer",  "id(".. selfId ..")" )
    end

    if (self.beingUsedByPlayer) then
    	self.beingUsedByPlayer = false

    	-- tutorial chest locks itself, but not infinitely
    	if self.Properties.Script.bTutorial then
    		if (player.soul:GetSkillLevel("thievery") < self.Properties.Script.fTutorialMaxThievery) then 
    			self:Lock()
    		elseif (self.fTutorialOpenCount < self.Properties.Script.fTutorialMaxThieveryOpenLimit) then
    			self:Lock()
    			self.fTutorialOpenCount = self.fTutorialOpenCount + 1
    		elseif (self.fTutorialOpenCount == self.Properties.Script.fTutorialMaxThieveryOpenLimit) then
    			XGenAIModule.SendMessageToEntity(player.this.id, "dialog:monologRequest", "alias('lockpickingTutorial_tutorialChestDone')")
    			-- update one last time to not repeat the bark
    			self.fTutorialOpenCount = self.fTutorialOpenCount + 1
    		end
    	end
    end
end

-- =============================================================================
function Stash:OnLockpicked()
	self:Open(player)
end

-- =============================================================================
function Stash.Server:OnUpdate(dt)

	if (self.bFirstUpdateAfterResetAnimation) then
		self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 2)
		self.bFirstUpdateAfterResetAnimation = false;
	end

	if (self.bNeedUpdate == 0) then
	  return
	end

	if (self.bNoAnims ~= 0 or (self.curAnim ~= "" and self.nDirection ~= 0)) then
		local curTime = self:GetAnimationTime(0,0)
		if ( (not self:IsAnimationRunning(0,0)) or ( curTime> 0.9999 )) then	 --current time se pocita jako 0-zacatek a 1-konec, tj je uplne jedno, jaky je target time, protoze ten je v sekundach
			--self:StopAnimation(0,0)     --3.7 cryengine doesn't support this anymore, if I stop it it gets reset
			self.curAnim = ""
			if (self.nDirection == -1) then
				-- fully closed
				self:OnClose()

				--self:Activate(0)
				self.bNeedUpdate = 0
				EntityCommon.BroadcastEvent(self, "Close")
			else
				-- fully open
				self:OnOpen()

				--self:Activate(0)
				self.bNeedUpdate = 0
				EntityCommon.BroadcastEvent(self, "Open")
			end
	  end
	end
end

-- =============================================================================
function Stash:DoPlayAnimation(direction, forceTime, useSound)
	if (self.nDirection == direction) then
		return
	end

	-- stop animation
	local curTime = 0

	local len = 0
	local bNeedAnimStart = 1
	if (self.curAnim~="" and self:IsAnimationRunning(0,0)) then
		curTime = self:GetAnimationTime(0,0)
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
		if direction == -2 then
			direction = -1
			animDirection = 1
			animName = 'take_item'
		end
		if direction == 2 then
			direction = -1
			animDirection = 1
			animName = 'insert_item'
		end

		if (not self.bNoAnims) then
			self:StopAnimation(0,0)
			self:StartAnimation(0, animName)
			-- self:SetAnimationSpeed( 0, 0, animDirection )

			if (forceTime) then
				self:SetAnimationTime(0,0,forceTime)
			else
				-- now we have to match the times
				local percentage = 0.0
				if (len > 0.0) then
					percentage = 1.0 - curTime / len
					if (percentage > 1.0) then
					  percentage = 1.0
					end
				end
				if (animDirection == -1) then
					percentage = 1.0 - percentage
				end
				--curTime = self:GetAnimationLength(0, animName) * percentage
				self:SetAnimationTime(0,0,percentage)
			end
		end
		self.curAnim = animName
		self.fTargetTime = self:GetAnimationLength(0, self.curAnim)
		if (direction == -1 and self.bUseSameAnim) then
			self.fTargetTime = 0
		end
	else
	  -- self:SetAnimationSpeed(0,0, direction)
	end

	self.nDirection = direction
	self:ForceCharacterUpdate(0, true)
	self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_FORCE_UPDATE, 0) 
	self:Activate(1)
	self.bNeedUpdate = 1

	-- play sound after enabling the portal so sound doesn't get culled
	local sndName = self.Properties.Sounds.snd_Open
	if (direction == -1) then
	  sndName = self.Properties.Sounds.snd_Close
	end

	if ((useSound == nil or useSound) and sndName ~= "") then
		AudioUtils.PlayAudioTrigger(self, sndName)
	end

end

-- =============================================================================
-- Events
-- =============================================================================
function Stash:Event_Unlock()
	self:Unlock()
	EntityCommon.BroadcastEvent(self, "Unlock")
end

-- =============================================================================
function Stash:Event_Lock()
	self:Lock()
	EntityCommon.BroadcastEvent(self, "Lock")
end

-- =============================================================================
function Stash:Event_Open()
	--System.Log("Stash: Open Event")
	self:DoPlayAnimation(1)
end

-- =============================================================================
function Stash:Event_Close()
	--System.Log("Stash: Close Event")
	self:DoPlayAnimation(-1)
end

-- =============================================================================
function Stash:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
end

-- =============================================================================
function Stash:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
end

-- =============================================================================
function Stash:Event_StartLockPicking()
end

-- =============================================================================
Stash.FlowEvents =
{
	Inputs =
	{
		Close = { Stash.Event_Close, "bool" },
		Open = { Stash.Event_Open, "bool" },
		Lock = { Stash.Event_Lock, "bool" },
		Unlock = { Stash.Event_Unlock, "bool" },
		Hide = { Stash.Event_Hide, "bool" },
		UnHide = { Stash.Event_UnHide, "bool" },
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
function Stash:SetInteractive (value)

	self.interactive = value

end

-- =============================================================================
function Stash:UsesStealUiPrompt()

	-- Ownership
	local ownerWuid = EntityModule.GetInventoryOwner(self:GetInventoryToOpen())
	if ownerWuid == __null then

		return false

	end

	-- Player is owner
	if ownerWuid == player.this.id then

		return false

	end

	return not RPG.IsPublicEnemy(ownerWuid)

end

-- =============================================================================
function Stash:SetBeingUsedByNPC(beingUsedByNPC)
	self.beingUsedByNPC = beingUsedByNPC
end

function Stash:SetBeingUsedByPlayer(beingUsedByPlayer)
	self.beingUsedByPlayer = beingUsedByPlayer
end
