-- =============================================================================
-- This is a trigger, that is used to interact with a bed.
-- Provides additional test if player can currently sleep
-- =============================================================================
BedTrigger =
{
}

-- =============================================================================
function BedTrigger:ReportUse(user,item,action)
    if self:IsLyingAction(action) then
        -- for click test if player can sleep
        local canSleep, cannotSleepReason = self:CanSleep(user, true);
        if not canSleep then
            Game.SendInfoText(cannotSleepReason, false);
            return;
        end
    end

    ActionTrigger.ReportUse(self,user,item,action)
end

-- =============================================================================
function BedTrigger:IsEnabled(user)
    if self:IsLyingAction(self.Properties.Click) then
        local canSleep, cannotSleepReason = self:CanSleep(user, false);
        if not canSleep then
            return false, cannotSleepReason;
        end
    end

    local baseEnabled, baseReason = ActionTrigger.IsEnabled(self,user);
    return baseEnabled, baseReason;
end

-- =============================================================================
function BedTrigger:IsEnabledHold(user)
    if self:IsLyingAction(self.Properties.Hold) then
        local canSleep, cannotSleepReason = self:CanSleep(user, false);
        if not canSleep then
            return false, cannotSleepReason;
        end
    end

    local baseEnabled, baseReason = ActionTrigger.IsEnabledHold(self,user);
    return baseEnabled, baseReason;
end

-- =============================================================================
function BedTrigger:IsLyingAction(action)
    return action.esActionType == "Stance" and action.sAction == "lying";
end

-- =============================================================================
function BedTrigger:CanSleep(user, accurateResult)
    if user.player then
        local result;
        local messageType;
        if accurateResult then
            result, messageType = user.player.CanSleep();
        else
            result, messageType = user.player.CanSleepFast();
        end

        if not result then
            local reason = SkipTime.GetSkipTimeMessageUIString(messageType);
            return false, reason;
        end
    end

    return true, nil;
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/ActionTrigger.lua")
table.Merge(BedTrigger, ActionTrigger)