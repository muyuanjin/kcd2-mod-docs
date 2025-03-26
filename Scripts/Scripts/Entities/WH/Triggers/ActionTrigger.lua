-- =============================================================================
-- This is a trigger, that is used to start player action (stance, unstance or animation) on target SO
-- =============================================================================
ActionTrigger =
{
    Properties =
    {
        Click = {
            esActionType = "Stance",
            sAction = "sitting",
            sActionTags = "",
            sAnimationResourceOverride = "", -- optional custom resource used for Anination

            sSlaveLinkName = "", -- optional link marking slave entity to be used for Animation or Unstance

            Synchro = {
                sKeyContextLinkName = "",
                sKeyName = "",
                sTimeout = "",
                nNumParticipants = 2
            },

            bDelayedReportUse = false, -- for Animations and JoinedAnimation the ReportUse to the base (messages, concept graph signal, ...) is postponed after the animation ends
            sTriggerPointId = "",  -- when non empty, the ReportUse to the base is postponed until the anim event with corresponding identifier
            bAllowTorch = false,  -- when true, the player is allowed to keep torch in hand. Used only for one-shot animations
            bSaveLock = false;  -- when true, the save lock is added during the animation. Used only for one-shot animations
            bDisableFocusCamera = true;  -- when true the disable focus camera during the animation. Used only for one-shot animations


            bCheckOwner = false, -- without the check, the trigger usage is always legal regardless of the owner
            bAllowNoOwner = true, -- trigger usage is legal if the trigger has no owner or player is the owner, otherwise it is legal only for player
            UseNotOwnerMessage = "@ui_hud_use_item_not_owner",
        },
        Hold = {
            esActionType = "None",
            sAction = "",
            sActionTags = "",
            sAnimationResourceOverride = "", -- optional custom resource used for Anination

            sSlaveLinkName = "",  -- optional link marking slave entity to be used for Animation or Unstance

            Synchro = {
                sKeyContextLinkName = "",
                sKeyName = "",
                sTimeout = "",
                nNumParticipants = 2
            },

            bDelayedReportUse = false, -- for Animations and JoinedAnimation the ReportUse to the base (messages, concept graph signal, ...) is postponed after the animation ends
            sTriggerPointId = "",  -- when non empty, the ReportUse to the base is postponed until the anim event with corresponding identifier
            bAllowTorch = false,  -- when true, the player is allowed to keep torch in hand Used only for one-shot animations
            bSaveLock = false;  -- when true, the save lock is added during the animation. Used only for one-shot animations
            bDisableFocusCamera = true;  -- when true the disable focus camera during the animation. Used only for one-shot animations

            bCheckOwner = false, -- without the check, the trigger usage is always legal regardless of the owner
            bAllowNoOwner = true, -- trigger usage is legal if the trigger has no owner or player is the owner, otherwise it is legal only for player
            UseNotOwnerMessage = "@ui_hud_use_item_not_owner",
        }
    }
}

-- =============================================================================
function ActionTrigger:ReportUse(user,item,action)
    local link = self:GetLinkedSmartObject();

    -- todo: action
    if action.esActionType == "Stance" then
        PlayerStateHandler.ChangeStance(link.smartObject.__this, action.sAction);
    elseif action.esActionType == "Unstance" then
        PlayerStateHandler.ChangeUnstance(link.smartObject.__this, action.sAction, action.sSlaveLinkName);
    elseif action.esActionType == "Animation" and link then
        PlayerStateHandler.PlayAnimationAction(link.smartObject.__this, action.sAction, action.sActionTags, self.id, action == self.Properties.Hold, action.sSlaveLinkName, action.sAnimationResourceOverride, action.sTriggerPointId, action.bAllowTorch, action.bSaveLock, action.bDisableFocusCamera);
    elseif action.esActionType == "Animation" and not link then
        PlayerStateHandler.PlayAnimationAction(INVALID_WUID, action.sAction, action.sActionTags, self.id, action == self.Properties.Hold, action.sSlaveLinkName, action.sAnimationResourceOverride, action.sTriggerPointId, action.bAllowTorch, action.bSaveLock, action.bDisableFocusCamera);
    elseif action.esActionType == "JoinedUnstance" then
        PlayerStateHandler.ChangeUnstanceJoined(link.smartObject.__this, action.sAction, action.Synchro, action.sSlaveLinkName);
    elseif action.esActionType == "JoinedAnimation" then
        PlayerStateHandler.PlayAnimationActionJoined(link.smartObject.__this, action.sAction, action.sActionTags, action.Synchro, self.id, action == self.Properties.Hold, action.sSlaveLinkName, action.sAnimationResourceOverride, action.sTriggerPointId, action.bAllowTorch, action.bSaveLock, action.bDisableFocusCamera);
    end

    if not action.bDelayedReportUse and action.sTriggerPointId == "" then
        TriggerBase.ReportUse(self,user,item,action)
    end
end

-- =============================================================================
function ActionTrigger:IsEnabled(user)
    local baseEnabled, baseReason = TriggerBase.IsEnabled(self,user);
    if not baseEnabled then
        return false, baseReason
    end

    if self.Properties.Click.esActionType == "None" then
        return true, nil
    end

    local link = self:GetLinkedSmartObject();
    if not link then
        if self.Properties.Click.esActionType == "Animation" then
            return true, nil
        else
            return false, nil
        end
    end

    if self.Properties.Click.esActionType == "Stance" then
        return not XGenAIModule.IsStanceBlocked(link.smartObject.__this), nil
    elseif self.Properties.Click.esActionType == "Unstance" or self.Properties.Click.esActionType == "JoinedUnstance" then
        return not XGenAIModule.IsUnstanceBlocked(link.smartObject.__this, self.Properties.Click.sAction), nil
    elseif self.Properties.Click.esActionType == "Animation" or self.Properties.Click.esActionType == "JoinedAnimation" then
        return not XGenAIModule.IsOneshotBlocked(link.smartObject.__this, self.Properties.Click.sAnimationResourceOverride), nil
    end
end

-- =============================================================================
function ActionTrigger:IsEnabledHold(user)
    local baseEnabled, baseReason = TriggerBase.IsEnabledHold(self,user);
    if not baseEnabled then
        return false, baseReason;
    end

    if self.Properties.Hold.esActionType == "None" then
        return true, nil
    end

    local link = self:GetLinkedSmartObject();
    if not link then
        if self.Properties.Hold.esActionType == "Animation" then
            return true, nil
        else
            return false, nil
        end
    end

    if self.Properties.Hold.esActionType == "Stance" then
        return not XGenAIModule.IsStanceBlocked(link.smartObject.__this), nil
    elseif self.Properties.Hold.esActionType == "Unstance" or self.Properties.Hold.esActionType == "JoinedUnstance" then
        return not XGenAIModule.IsUnstanceBlocked(link.smartObject.__this, self.Properties.Hold.sAction), nil
    elseif self.Properties.Hold.esActionType == "Animation" or self.Properties.Hold.esActionType == "JoinedAnimation" then
        return not XGenAIModule.IsOneshotBlocked(link.smartObject.__this, self.Properties.Hold.sAnimationResourceOverride), nil
    end
end

-- =============================================================================
function ActionTrigger:GetHint(user)
    if self:IsLegal() then
        return self.Runtime.ClickMessage;
    else
        return self.Properties.Click.UseNotOwnerMessage;
    end
end

-- =============================================================================
function ActionTrigger:GetHintHold(user)
    if self:IsLegalHold() then
        return self.Runtime.HoldMessage;
    else
        return self.Properties.Hold.UseNotOwnerMessage;
    end
end

-- =============================================================================
function ActionTrigger:IsUsable(user)
    if not TriggerBase.IsUsable(self,user) then
        return false
    end

    if self.Properties.Click.esActionType == "None" then
        return true
    end

    local link = self:GetLinkedSmartObject();
    if not link then
        if self.Properties.Click.esActionType == "Animation" then
            return true
        else
            return false
        end
    end

    if self.Properties.Click.esActionType == "Stance" then
        if user.player and not user.player:CanChangeStanceObject(link.smartObject.__this) then
            return false
        end
        return XGenAIModule.IsStanceAvailable(link.smartObject.__this)
    elseif self.Properties.Click.esActionType == "Unstance" or self.Properties.Click.esActionType == "JoinedUnstance" then
        return XGenAIModule.IsUnstanceAvailable(link.smartObject.__this, self.Properties.Click.sAction)
    elseif self.Properties.Click.esActionType == "Animation" or self.Properties.Click.esActionType == "JoinedAnimation" then
        return XGenAIModule.IsOneshotAvailable(link.smartObject.__this, self.Properties.Click.sAnimationResourceOverride)
    end
end

-- =============================================================================
function ActionTrigger:IsUsableHold(user)
    if not TriggerBase.IsUsableHold(self,user) then
        return false
    end

    if self.Properties.Hold.esActionType == "None" then
        return true
    end

    local link = self:GetLinkedSmartObject();
    if not link then
        if self.Properties.Hold.esActionType == "Animation" then
            return true
        else
            return false
        end
    end

    if self.Properties.Hold.esActionType == "Stance" then
        if user.player and not user.player:CanChangeStanceObject(link.smartObject.__this) then
            return false
        end
        return XGenAIModule.IsStanceAvailable(link.smartObject.__this)
    elseif self.Properties.Hold.esActionType == "Unstance" or self.Properties.Hold.esActionType == "JoinedUnstance" then
        return XGenAIModule.IsUnstanceAvailable(link.smartObject.__this, self.Properties.Hold.sAction)
    elseif self.Properties.Hold.esActionType == "Animation" or self.Properties.Hold.esActionType == "JoinedAnimation" then
        return XGenAIModule.IsOneshotAvailable(link.smartObject.__this, self.Properties.Hold.sAnimationResourceOverride)
    end
end

-- =============================================================================
function ActionTrigger:GetLinkedSmartObject()
    local linkCount = self:CountLinks();

    for i = 0,(linkCount - 1) do
        local link, linkName = self:GetLink(i);
        if link and linkName == "" then
           return link;
        end
    end

    return nil;
end

-- =============================================================================
function ActionTrigger:GetOwner()
    local link = self:GetLinkedSmartObject();
    local owner = XGenAIModule.GetOwner(link.smartObject.__this);
    return owner;
end

-- =============================================================================
function ActionTrigger:IsLegal()
    return self:IsLegalImpl(self.Properties.Click.bCheckOwner, self.Properties.Click.bAllowNoOwner);
end

-- =============================================================================
function ActionTrigger:IsLegalHold()
    return self:IsLegalImpl(self.Properties.Hold.bCheckOwner, self.Properties.Hold.bAllowNoOwner);
end

-- =============================================================================
function ActionTrigger:IsLegalImpl(checkOwner, allowNoOwner)
    if (checkOwner) then
        local owner = self:GetOwner();
        if (owner == __null) then
            return allowNoOwner; -- trigger with no owner may be used both legally and illegally depending on the trigger's property
        elseif (owner == player.this.id) then
            return true; -- player is always using the trigger legally
        else
            return false;
        end
    end

    return true;
end

-- =============================================================================
function ActionTrigger:OnNPCStateSearchDone(isHold, user)
    if isHold then
        if self.Properties.Hold.bDelayedReportUse and self.Properties.Hold.sTriggerPointId == "" then
            TriggerBase.ReportUse(self, user, {}, self.Properties.Hold);
        end
    else
        if self.Properties.Click.bDelayedReportUse and self.Properties.Click.sTriggerPointId == "" then
            TriggerBase.ReportUse(self, user, {}, self.Properties.Click);
        end
    end
end

-- =============================================================================
function ActionTrigger:OnTriggerPoint(isHold, user)
    if isHold then
        if self.Properties.Hold.sTriggerPointId ~= "" then
            TriggerBase.ReportUse(self, user, {}, self.Properties.Hold);
        end
    else
        if self.Properties.Click.sTriggerPointId ~= "" then
            TriggerBase.ReportUse(self, user, {}, self.Properties.Click);
        end
    end
end

-- =============================================================================
function ActionTrigger:OpenInventory(user, action)
    local link = self:GetLinkedSmartObject();
    if action.esActionType == "Animation" and link ~= nil then
        local hostResourcesStarted =PlayerStateHandler.HostResourcesPlayAnimationAction(link.smartObject.__this, action.sAction, action.sActionTags, self.id, action == self.Properties.Hold, action.sSlaveLinkName, action.sAnimationResourceOverride, action.bSaveLock, action.bDisableFocusCamera);
        if not hostResourcesStarted then
            -- hosting resources faild, skipping opening the inventory
            return;
        end
    else
        TriggerBase.OpenInventory(self, user, action);
    end
end

-- =============================================================================
function ActionTrigger:OnResourcesHosted(isHold, user)
    if isHold then
        TriggerBase.OpenInventory(self, user, self.Properties.Hold);
    else
		TriggerBase.OpenInventory(self, user, self.Properties.Click);
    end
end

-- =============================================================================
function ActionTrigger:OnResourcesHostingInterrupted(isHold, user)
    PlayerStateHandler.EndHostResourcesPlayAnimationAction();
end

-- =============================================================================
function ActionTrigger:OnInventoryClosed()
    local i, v = next(self.usedItems)
    if i == nil then
        -- do nothing if no item has been selected
        PlayerStateHandler.EndHostResourcesPlayAnimationAction();
        return;
    end

    TriggerBase.OnInventoryClosed(self);
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/TriggerBase.lua")
table.Merge(ActionTrigger, TriggerBase)