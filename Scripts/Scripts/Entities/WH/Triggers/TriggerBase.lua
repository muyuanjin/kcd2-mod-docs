-- =============================================================================
-- Common base for all trigger types. Not an entity by itself
-- =============================================================================
TriggerBase =
{
	Properties =
	{
		object_Model = "objects/special/primitive_cylinder.cgf",
		sWH_AI_EntityCategory = "",
		bQuestSystemTrigger = false,
		InteractorPriorityOverride = -1,
		Click = {
			bIsActive = true,
			UseMessage = "@ui_hud_use_item",
			sSendMessageTo = "", -- if not filled, will send through link
			Item = {
				guidItemClassId = "",
				bAllowUseWithoutItem = false,
				sAliasToBarkWithoutItem = "",
				bDeleteAfterUse = false,
			},
			InventoryFilter = "", -- If filled, inventory will open upon click, which will allow player to use a single item with this trigger
			InventoryMultiFilter = "", -- If filled, inventory will open upon click, and player can select multiple ui item stacks with amount for each
			Angle = {
				fApproachDirection = 0,
				fAngleTolerance = 180,
			},
			bRequireTargetHaveDialog = false,
			fActiveDistance = -1,
			fActiveMinDistance = -1,
			fZToleration = -1,
			bIsActiveWhileCarryingCorpse = false,
			bIsActiveInCombat = false,
			bIsActiveInTenseCircumstance = false, -- Crime natlak
			sRequiredSoulAbility = "",  -- required ability from Tables/rpg/soul_ability.xml
			guidRequiredScriptPerk = "",  -- required perk from Tables/rpg/perk_script.xml
		},
		Hold = {
			bIsActive = false,
			UseMessage = "",
			sSendMessageTo = "", -- if not filled, will send through link
			Item = {
				guidItemClassId = "",
				bAllowUseWithoutItem = false,
				sAliasToBarkWithoutItem = "",
				bDeleteAfterUse = false,
			},
			InventoryFilter = "", -- If filled, inventory will open upon click, which will allow player to use a single item with this trigger
			InventoryMultiFilter = "", -- If filled, inventory will open upon click, and player can select multiple ui item stacks with amount for each
			Angle = {
				fApproachDirection = 0,
				fAngleTolerance = 180,
			},
			bRequireTargetHaveDialog = false,
			fActiveDistance = -1,
			fActiveMinDistance = -1,
			fZToleration = -1,
			bIsActiveWhileCarryingCorpse = false,
			bIsActiveInCombat = false,
			bIsActiveInTenseCircumstance = false, -- Crime natlak
			sRequiredSoulAbility = "",  -- required ability from Tables/rpg/soul_ability.xml
			guidRequiredScriptPerk = "",  -- required perk from Tables/rpg/perk_script.xml
		},
		Script = {
			Misc = "",
		},
	},
	Editor =
	{
		Icon = "Trigger.bmp",
	},
	InteractorPriority = 4,
}

-- =============================================================================
function TriggerBase:UpdateMaterial(gameMode)
	-- Set either nodraw or transparent material
	local cvarValue = System.GetCVar("wh_ent_ShowHelperObjects")
	local showInEditMode = cvarValue > 0
	local showInGameAndGameMode = cvarValue > 1
	if ((System.IsEditor() and showInEditMode and not gameMode) or showInGameAndGameMode) then
		self:SetMaterial("objects/intermediates/poses/poses_nomultimaterial")
	else
		self:SetMaterial("materials/special/nodraw")
	end
end

-- =============================================================================
function TriggerBase:OnEditorSetGameMode(gameMode)
	self:UpdateMaterial(gameMode)
end

-- =============================================================================
function TriggerBase:OnReset()
	local Properties = self.Properties

	self:LoadObject(0, Properties.object_Model)

	self:UpdateMaterial(false)

	if Properties.InteractorPriorityOverride < 0 then
		self.interactionTrigger:SetPriority(self.InteractorPriority)
	else
		self.interactionTrigger:SetPriority(Properties.InteractorPriorityOverride)
	end

	self:PhysicalizeThis()

	local flagstab = { flags_mask=geom_collides }
	self:SetPhysicParams(PHYSICPARAM_FLAGS, flagstab)

	local flagstab = { flags_mask=geom_collides }
	self:SetPhysicParams(PHYSICPARAM_PART_FLAGS, flagstab)

	local filtering = { collisionClassIgnore = -1 }; -- LUA uses 32bit floats, we need integer with all bits set to 1
	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )

	self.Runtime = {
		ClickAvailable = (Properties.Click.bIsActive),
		HoldAvailable = (Properties.Hold.bIsActive),
		ClickMessage = Properties.Click.UseMessage,
		HoldMessage = Properties.Hold.UseMessage
	}
end

-- =============================================================================
function TriggerBase:OnSpawn()
	self:OnReset()
end

-- =============================================================================
function TriggerBase:OnPropertyChange()
	self:OnReset()
end

-- =============================================================================
function TriggerBase:OnLoad(table)
	if(table.Runtime ~= nil) then
		self.Runtime = table.Runtime
	else
		local Properties = self.Properties
		self.Runtime = {
			ClickAvailable = (Properties.Click.bIsActive),
			HoldAvailable = (Properties.Hold.bIsActive),
			ClickMessage = Properties.Click.UseMessage,
			HoldMessage = Properties.Hold.UseMessage
		}
	end
end

-- =============================================================================
function TriggerBase:NeedSerialize()
	local Properties = self.Properties
	if((self.Runtime.ClickAvailable ~= Properties.Click.bIsActive) or
	   (self.Runtime.HoldAvailable ~= Properties.Hold.bIsActive) or
	   (self.Runtime.ClickMessage ~= Properties.Click.UseMessage) or
	   (self.Runtime.HoldMessage ~= Properties.Hold.UseMessage)) then
		return true
	end

	return false
end

-- =============================================================================
function TriggerBase:OnSave(table)
	table.Runtime = self.Runtime
end

-- =============================================================================
function TriggerBase:OnUsed(user)
	self.currentActionProperties = self.Properties.Click
	self:OnAction( user, self.Properties.Click )
end

-- =============================================================================
function TriggerBase:OnUsedHold(user)
	self.currentActionProperties = self.Properties.Hold
	self:OnAction( user, self.Properties.Hold )
end

-- =============================================================================
function TriggerBase:OnAction(user,action)
	local item
	if (action.Item.guidItemClassId ~= "") then
		item = user.inventory:FindItem(action.Item.guidItemClassId)
		if not item then
			self:UserNoItem(user)
			return 0
		elseif action.Item.bDeleteAfterUse then
			user.inventory:DeleteItem(item,1)
		end
	end

	if( action.InventoryFilter ~= "" or action.InventoryMultiFilter~="") then
		self.inventoryUser = user
		self.inventoryAction = action
		self.usedItems = {}
		self:OpenInventory(user, action)
	else
		local items = {}
		if item then
			items = {{['id'] = item}}
		end
		self:ReportUse(user,items,action)
   end
end

-- =============================================================================
function TriggerBase:OpenInventory(user, action)
	if (action.InventoryFilter ~= "") then
		user.actor:OpenItemSelectionFilter(self.id, action.InventoryFilter); --delays "ReportUse" after inventory is closed
	else
		user.actor:OpenItemMultiselectionFilter(self.id, action.InventoryMultiFilter); --delays "ReportUse" after inventory is closed
	end
end

-- =============================================================================
function TriggerBase:OnInventoryItemUsed(id)
	local i, v = next(self.usedItems)
	-- keep indexed from 0
	if i == nil then
		self.usedItems[0] = {["id"] = id}
	else
		self.usedItems[#self.usedItems+1] = {["id"] = id}
	end
end

-- =============================================================================
function TriggerBase:OnInventoryClosed()
	local usedItems = self.usedItems
	local invUser = self.inventoryUser
	self.usedItems = nil
	self.inventoryUser = nil
	self:ReportUse( invUser, usedItems, self.inventoryAction )
end

-- =============================================================================
function TriggerBase:_GetSendTargets(user,action)
	local target = action.sSendMessageTo
	local link = self:GetLink(0)
	if( target == "player" ) then
		return {player.this.id} -- player should always have this.id
	elseif( target ~= "" ) then
    local entity = System.GetEntityByName(target);
    if entity.this ~= nil then -- a random entity might not have this.id, if it wasn't given AI puppet
      return {System.GetEntityByName(target).this.id}
     else
      return {}
    end
	elseif( not link ) then
		return {}
	else
		links = {}
		for i = 0,(self:CountLinks()-1) do
			local link = self:GetLink(i)
			if link and link.this ~= nil and link.this.id ~= nil then
				links[i+1] = link.this.id
			end
		end
		return links
	end
end

-- =============================================================================
-- can be overriden
function TriggerBase:ReportUse(user,items,action)
	local itemToSend = 0
	if items[0] ~= nil then
		itemToSend = Framework.WUIDToMsg(items[0].id)
	end
	local selfId = Framework.WUIDToMsg( XGenAIModule.GetMyWUID(self) )
	local sendTargets = self:_GetSendTargets(user,action)
	for k,v in pairs(sendTargets) do
		XGenAIModule.SendMessageToEntityArray(v, "interactionModule:itemSelection", items)
		XGenAIModule.SendMessageToEntity( v, "interactionModule:onInteraction", "target('"..self:GetName().."'),usedItem("..itemToSend.."),id("..selfId.."), isHoldAction("..((action==self.Properties.Hold) and "true" or "false")..")")
	end

	if action == self.Properties.Click then
		self.interactionTrigger:SetPressed()
	else
		self.interactionTrigger:SetHeld()
	end
end

-- =============================================================================
function TriggerBase:UserNoItem(user)
	XGenAIModule.SendMessageToEntity(user.this.id,"dialog:monologRequest","alias("..self.Properties.Item.sAliasToBarkWithoutItem..")")
end

-- =============================================================================
function TriggerBase:GetActions(user, firstFast)

	output = {}
	if ( self:IsUsable(user) ) then
		local isEnabled, disabledReason, disabledBarkMetarole = self:IsEnabled(user);
		if AddInteractorAction( output, firstFast, Action():hint(self:GetHint(user)):action("trigger_use"):func(TriggerBase.OnUsed):interaction(inr_scriptTrigger ):enabled(isEnabled):reason(disabledReason):disabledBarkMetarole(disabledBarkMetarole) ) then return output end
	end
	if ( self:IsUsableHold(user) ) then
		local isEnabledHold, disabledReasonHold = self:IsEnabledHold(user);
		if AddInteractorAction( output, firstFast, Action():hint(self:GetHintHold(user)):action("trigger_use_hold"):func(TriggerBase.OnUsedHold):interaction(inr_scriptTrigger ):hintType( AHT_HOLD ):enabled(isEnabledHold):reason(disabledReasonHold) ) then return output end
	end
	return output
end

-- =============================================================================
function TriggerBase:IsActionAvailable(user,action)
	if (not user) then
		return false  -- cannot be used by AI
	elseif (action.Item.guidItemClassId ~= "" and not action.Item.bAllowUseWithoutItem and not user.inventory:FindItem(action.Item.guidItemClassId)) then
		--Dump("Disabled by item check")
		return false -- cannot be used without specified item
	elseif ((action == self.Properties.Click and not self:IsEnabledFromQuestSystem(false)) or (action == self.Properties.Hold and not self:IsEnabledFromQuestSystem(true))) then
		--Dump("Disabled by quest system check")
		return false
	elseif ((action == self.Properties.Click and not self:IsEnabledBySoulAbility(false)) or (action == self.Properties.Hold and not self:IsEnabledBySoulAbility(true))) then
		--Dump("Disabled by missing soul ability")
		return false
	elseif ((action == self.Properties.Click and not self:IsEnabledByScriptPerk(false)) or (action == self.Properties.Hold and not self:IsEnabledByScriptPerk(true))) then
		--Dump("Disabled by missing script perk")
		return false
	elseif( action.Angle.fAngleTolerance < 180 and ( math.acos( VectorUtils.DotProduct2D( VectorUtils.Rotate2D(self:GetWorldDir(),math.rad(action.Angle.fApproachDirection)), VectorUtils.GetDirection( self:GetPos(), user:GetPos() ) ) ) > math.rad(action.Angle.fAngleTolerance) ) ) then
		--Dump("Disabled by angle check")
		return false -- cannot be used from different angle than specified
	elseif( action.bRequireTargetHaveDialog and not self:_CheckDialog(user,action) ) then
		--Dump("Disabled by dialog check")
		return false -- cannot be used IF the target isn't human, that has a dialog with user
	elseif( action.fActiveDistance ~= -1 and VectorUtils.Distance(self:GetWorldPos(),player:GetWorldPos()) > action.fActiveDistance ) then
		return false
	elseif( action.fActiveMinDistance ~= -1 and VectorUtils.Distance(self:GetWorldPos(),player:GetWorldPos()) < action.fActiveMinDistance ) then
		return false
	elseif( action.fZToleration ~= -1 and math.abs(VectorUtils.Subtract(self:GetWorldPos(),player:GetWorldPos()).z) > action.fZToleration) then
		return false
	else
		return true
	end
end

-- =============================================================================
function TriggerBase:IsEnabledFromQuestSystem(holdEnabled)
	if not self.Properties.bQuestSystemTrigger then
		return true
	end

	if holdEnabled then
		return self.interactionTrigger:IsHoldEnabled()
	else
		return self.interactionTrigger:IsPressEnabled()
	end
end

-- =============================================================================
function TriggerBase:IsEnabledBySoulAbility(holdEnabled)
	-- checks if player has given soul ability and enables the interactor accordingly 
	-- this type of interactor is also usable from quest system
	local enabledByAbility = false
	local enabledFromQuestSystem = false
	
	if holdEnabled then
		local holdAbility = self.Properties.Hold.sRequiredSoulAbility
		if holdAbility == "" then
			return true
		end

		enabledFromQuestSystem = self.interactionTrigger:IsHoldEnabled()
		enabledByAbility = player.soul:HasAbility(holdAbility)
	else
		local clickAbility = self.Properties.Click.sRequiredSoulAbility
		if clickAbility == "" then
			return true
		end

		enabledFromQuestSystem = self.interactionTrigger:IsPressEnabled()
		enabledByAbility = player.soul:HasAbility(clickAbility)
	end

	return (enabledByAbility or enabledFromQuestSystem)
end

-- =============================================================================
function TriggerBase:IsEnabledByScriptPerk(holdEnabled)
	-- checks if player has given script perk and enables the interactor accordingly 
	-- this type of interactor is also usable from quest system
	local enabledByPerk = false
	local enabledFromQuestSystem = false

	if holdEnabled then
		local holdPerk = self.Properties.Hold.guidRequiredScriptPerk
		if holdPerk == "" then
			return true
		end

		enabledFromQuestSystem = self.interactionTrigger:IsHoldEnabled()
		enabledByPerk = player.soul:HasPerk(holdPerk, false)
	else
		local clickPerk = self.Properties.Click.guidRequiredScriptPerk
		if clickPerk == "" then
			return true
		end

		enabledFromQuestSystem = self.interactionTrigger:IsPressEnabled()
		enabledByPerk = player.soul:HasPerk(clickPerk, false)
	end

	return (enabledByPerk or enabledFromQuestSystem)
end

-- =============================================================================
function TriggerBase:IsUsable(user)
	return self.Runtime.ClickAvailable and self.Runtime.ClickMessage ~= '' and self:IsActionAvailable(user,self.Properties.Click)
end

-- =============================================================================
function TriggerBase:IsUsableHold(user)
	return self.Runtime.HoldAvailable and self.Runtime.HoldMessage ~= '' and self:IsActionAvailable(user,self.Properties.Hold)
end

-- =============================================================================
function TriggerBase:IsEnabledByProperties(user, isActiveWhileCarryingCorpse, isActiveInCombat, isActiveInTenseCircumstance)
	if not isActiveWhileCarryingCorpse and user.actor:IsCarryingCorpse() then
		return false, '@ui_playerCantGeneral_corpseCarry'
	end
	
	local isInCombatDanger = user.soul:IsInCombatDanger() or user.soul:HasScriptContext('crime_escalationLevel_script_confrontingGeneral_player')
	if not isActiveInCombat and isInCombatDanger then
		return false, '@ui_playerCantGeneral_combat'
	end

	if not isActiveInTenseCircumstance and user.soul:IsInTenseCircumstance() then
		return false, '@ui_playerCantGeneral_tense'
	end

	return true, nil
end

-- =============================================================================
function TriggerBase:IsEnabled(user)
	return self:IsEnabledByProperties(user,
									  self.Properties.Click.bIsActiveWhileCarryingCorpse,
									  self.Properties.Click.bIsActiveInCombat,
									  self.Properties.Click.bIsActiveInTenseCircumstance)
end

-- =============================================================================
function TriggerBase:IsEnabledHold(user)
	return self:IsEnabledByProperties(user,
									  self.Properties.Hold.bIsActiveWhileCarryingCorpse,
									  self.Properties.Hold.bIsActiveInCombat,
									  self.Properties.Hold.bIsActiveInTenseCircumstance)
end

-- =============================================================================
function TriggerBase:GetHint(user)
	return self.Runtime.ClickMessage;
end

-- =============================================================================
function TriggerBase:GetHintHold(user)
	return self.Runtime.HoldMessage;
end

-- =============================================================================
function TriggerBase:_CheckDialog(user,action)
	local target = self:_GetSendTargets(user,action)[1]
	return target and target.human and target.actor:CanTalk(user.id) and not target.human.IsInDialog()
end

-- =============================================================================
function TriggerBase:PhysicalizeThis()
	local Physics =  {
		bPhysicalize = true,
		bRigidBody = false,
		Density = -1,
		Mass = -1,
	}
	EntityCommon.PhysicalizeRigid( self, 0, Physics, self.bRigidBodyActive )
end

-- =============================================================================
function TriggerBase:SetAvailable(available)
	self.Runtime.ClickAvailable = available
end

-- =============================================================================
function TriggerBase:SetAvailableHold(available)
	self.Runtime.HoldAvailable = available
end

-- =============================================================================
function TriggerBase:SetUseMessage(message)
	self.Runtime.ClickMessage = message
end

-- =============================================================================
function TriggerBase:SetHoldMessage(message)
	self.Runtime.HoldMessage = message
end

-- =============================================================================
function TriggerBase:ResetUseMessage()
	self.Runtime.ClickMessage = self.Properties.Click.UseMessage
end

-- =============================================================================
function TriggerBase:ResetHoldMessage()
	self.Runtime.HoldMessage = self.Properties.Hold.UseMessage
end
