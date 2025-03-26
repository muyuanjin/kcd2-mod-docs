BasicAIActions = {}

-- =============================================================================
function BasicAIActions:ForceUsable(user)
	if (not user) then
		return false; -- canot be used by AI
	end

	if not user.actor:CanInteractWith(self.id) then
		return false
	end

	return true
end

-- =============================================================================
-- when firstFast is true method returns only first action
function BasicAIActions:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	output = {}

	if not user.actor:CanInteractWith(self.id) then
		return {}
	end

	local useAction = "use"

	if user.human:IsPickpocketing() == true then
		return {}
	end

	-- grabbing corpse or knock outed actor
	-- Women can't grab bodies
    if (user.actor:CanGrabCorpse(self.id) and EntityUtils.GetScriptProperty(self, "disableGrabBody") == nil and not IsFemale(user)) then
    	local canBeGrabbed = not self.soul:HasScriptContext("crime_greyOutGrabBody")
        if AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_grab" ):action( "grab_body" ):func( BasicAIActions.OnGrabCorpse ):interaction( inr_pickupCorpse ):enabled(canBeGrabbed) ) then
            return output
        end
    end

	if self.actor:IsDead() == false and self.actor:IsUnconscious() == false then
		local canKill = user.actor:CanStealthKill(self.id)
		local disableReason = ""
		if (canKill == SAT_KillDisabledNoDagger) then
			disableReason = "@ui_hud_stealth_kill_no_dagger"
		end
		if (canKill == SAT_KillEnabled or canKill == SAT_KillDisabled or canKill == SAT_KillDisabledNoDagger) then
			if AddInteractorAction( output, firstFast,
				Action():hint( "@ui_hud_stealth_kill" ):action( "stealth_kill" ):actionMap("combat"):hintType( AHT_HOLD ):func( BasicAIActions.OnStealthKill ):interaction( inr_stealthKill ):enabled( canKill==SAT_KillEnabled ):reason(disableReason) ) then
				return output
			end
		end

		local canKnockout = user.actor:CanStealthKnockout(self.id)
		if (canKnockout == SAT_KnockoutEnabled or canKnockout == SAT_KnockoutDisabled) then
			if AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_knock_out" ):action( "knock_out" ):actionMap("combat"):func( BasicAIActions.OnKnockout ):interaction( inr_knockOut ):enabled( canKnockout==SAT_KnockoutEnabled ) ) then
				return output
			end
		end

		local canPullDown = user.actor:CanHorsePullDown(self.id)
		if (canPullDown == HPS_Enabled or canPullDown == HPS_Disabled) then
			if AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_horse_pulldown" ):action( "horse_pulldown" ):actionMap("combat"):func( BasicAIActions.OnHorsePullDown ):interaction( inr_pullDown ):enabled( canPullDown==HPS_Enabled ) ) then
				return output
			end
		end
		
		if (self:ActorCanTalk(user)) then
			local hintEnabledVal = self:GetCanTalkHintType()

			if AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_talk" ):action( "talk" ):uiOrder(0):func( BasicAIActions.OnTalk ):interaction( inr_talk ):enabled( hintEnabledVal )) then
				return output
			end
			
		end

		if (user.soul:HaveSkill('thievery') and self.human:CanBeRobbed() and not (user.player:IsSitting() or user.player:IsLaying()) and not IsFemale(user)) then
			local canUseMinigame = Minigame.CanUseMinigame(user.id, E_MUF_CombatDanger)
			if AddInteractorAction( output, firstFast,
				Action():hint( "@ui_hud_basic_steal" ):action( "pickpocketing" ):uiOrder(6):hintType( AHT_HOLD ):func( BasicAIActions.OnPickpocketing ):interaction( inr_steal ):enabled(canUseMinigame) ) then
				return output
			end
		end

	else -- Dead or unconscious
		local canMercyKill = user.actor:CanDoMercyKill(self.id)
		if (canMercyKill == MKS_Enabled or canMercyKill == MKS_Disabled) then
			local hint = "@ui_hud_mercy_kill"
			if (self.actor:IsUnconscious() == true) then
				hint = "@ui_hud_mercy_kill_unconscious"
			end
			if AddInteractorAction( output, firstFast, Action():hint( hint ):action( "mercy_kill" ):actionMap("combat"):hintType( AHT_HOLD ):func( BasicAIActions.OnMercyKill ):interaction( inr_mercyKill ):enabled( canMercyKill==MKS_Enabled ) ) then
				return output
			end
		end

		if(self:AddLootAction(output, user, firstFast) == true) then
			return output
		end
	end

	return output
end

-- =============================================================================
function BasicAIActions:ActorCanTalk(user)
	local isInCombatMode = self.soul:IsInCombatMode()
	local actorHasDialog = self.actor:CanTalk(user.id)
	local isInArrangedFight = self.soul:HasScriptContext("combat_arrangedFight") and not self.soul:HasScriptContext("combat_suppressedDialogInArrangedFight") -- KCD2-382877
	
	return actorHasDialog and (not isInCombatMode or (isInCombatMode and isInArrangedFight))
end

-- =============================================================================
function BasicAIActions:GetCanTalkHintType()
	local bDialogRestricted = self.soul:IsDialogRestricted(player.id)
	local bIsInCombatDanger = player.soul:IsInCombatDanger()
	local bIsInTenseCircumstance = player.soul:IsInTenseCircumstance()
	
	if bDialogRestricted then
		return false
	end

	local bypassCrimeRestiction = self.soul:HasScriptContext("speech_bypassGreyOutByCrime");
	if bypassCrimeRestiction then
		return true
	end
	
	if (bIsInCombatDanger or bIsInTenseCircumstance) then
		return false
	end

	return true
end

-- =============================================================================
-- Used in StartDialog command to determine if the NPC has E active, just combines
-- functions, so we don't have to call all of them via C++
function BasicAIActions:TestActorCanTalk()
	local actorCanTalk = self:ActorCanTalk(player)
	local canTalkHintType = self:GetCanTalkHintType()

	return actorCanTalk and canTalkHintType
end

-- =============================================================================
function BasicAIActions:GetChatActions(user)
	if (user == nil) then
		return {}
	end

	output = {}

	local isEnabled = (not user.soul:IsInCombatDanger()) or user.player:IsCombatChatTarget(self.id)

	local chatFunc = {}
	local showInitHint = false
	local showReplyHint = false
	local chatHint = {}
	if (self.actor:CanChat(user.id)) then
		showInitHint = true
		chatFunc = BasicAIActions.OnChat
	elseif (self.actor:HasChatRequest()) then
		showReplyHint = self.actor:IsWaitingForDialogueReply()
		chatFunc = BasicAIActions.OnChatRequestAccepted
	elseif (self.actor:HasAcceptedChat()) then
		showReplyHint = self.actor:IsWaitingForDialogueReply()
		chatFunc = BasicAIActions.OnChatOpen
	end

	local canFollow = user.actor:CanFollow(self.id) and not user.actor:IsFollowing(self.id)
	if canFollow then
		local followHint = "@ui_hud_follow_start"
		AddInteractorAction(output, false, Action():hint(followHint):action("focus_follow_init_interactor_press"):hintType(AHT_PRESS):uiOrder(5):func(BasicAIActions.OnFollow):interaction(inr_chatFollow):enabled(isEnabled):actionMap("focus_follow_init_interactor"):hintClass(AHC_FOLLOW))
	end

	if showInitHint then
		chatHint = "@ui_hud_chat_init"
		if not canFollow then			
			AddInteractorAction(output, false, Action():hint(chatHint):action("chat_init_with_focus"):hintType(AHT_PRESS):uiOrder(5):func(BasicAIActions.OnChatWithFocus):interaction(inr_chatFollow):enabled(true):actionMap("chat_init_interactor"):hintClass(AHC_CHAT))
		end
		AddInteractorAction(output, false, Action():action("chat_init_interactor_press"):hintType(AHT_PRESS):uiOrder(5):func(BasicAIActions.OnChat):interaction(inr_chatFollow):enabled(isEnabled):uiVisible(false):actionMap("chat_init_interactor"):hintClass(AHC_CHAT))
	elseif showReplyHint then
		chatHint = "@ui_hud_chat_reply"
		AddInteractorAction(output, false, Action():hint(chatHint):action("chat_init_interactor_press"):hintType(AHT_PRESS):uiOrder(5):func(chatFunc):interaction(inr_chatFollow):enabled(isEnabled):actionMap("chat_init_interactor"):hintClass(AHC_CHAT))
	end



	return output
end

-- =============================================================================
function BasicAIActions:OnTalk(user, slotId)
	DebugUtils.Log("OnTalk: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	self.actor:RequestDialog(user.id,'',false,true)
end

-- =============================================================================
function BasicAIActions:OnChat(user, slotId)
	DebugUtils.Log("OnChat: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	self.actor:DoChat(user.id, false)
end

-- =============================================================================
function BasicAIActions:OnChatWithFocus(user, slotId)
	DebugUtils.Log("OnChatWithFocus: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	self.actor:DoChat(user.id, true)
end

-- =============================================================================
function BasicAIActions:OnChatRequestAccepted(user, slotId)
	DebugUtils.Log("OnChatRequestAccepted: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	self.actor:AcceptChatRequest()
end

-- =============================================================================
function BasicAIActions:OnChatOpen(user, slotId)
	DebugUtils.Log("OnOpen: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	self.actor:OpenChat(user.id)
end

-- =============================================================================
function BasicAIActions:OnFollow(user, slotId)
	DebugUtils.Log("OnFollow: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.actor:StartFollow(self.id)
end

-- =============================================================================
function BasicAIActions:OnStealthKill(user, slotId)
	DebugUtils.Log("OnStealthKill: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.actor:RequestStealthKill(self.id)
end

-- =============================================================================
function BasicAIActions:OnKnockout(user, slotId)
	DebugUtils.Log("OnKnockout: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.actor:RequestKnockOut(self.id)
end

-- =============================================================================
function BasicAIActions:OnHorsePullDown(user, slotId)
	DebugUtils.Log("OnHorsePullDown: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.actor:RequestHorsePullDown(self.id)
end

-- =============================================================================
function BasicAIActions:OnMercyKill(user, slotId)
	DebugUtils.Log("OnMercyKill: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.actor:RequestMercyKill(self.id)
end

-- =============================================================================
function BasicAIActions:OnLoot(user, slotId)
	DebugUtils.Log("OnLoot: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	self.actor:RequestItemExchange(user.id)
end

-- =============================================================================
function BasicAIActions:OnGrabCorpse(user, slotId)
	DebugUtils.Log("OnGrabCorpse: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.actor:RequestGrabCorpse(self.id)
end

-- =============================================================================
function BasicAIActions:OnPickpocketing(user, slotId)
	DebugUtils.Log("OnPickpocketing: %s->%s", EntityUtils.GetName(user), EntityUtils.GetName(self))
	user.human:RequestPickpocketing(self.id)
end