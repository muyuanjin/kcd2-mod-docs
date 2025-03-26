-- =============================================================================
-- This is a trigger, that is used to interact with a kettle
-- =============================================================================
KettleActionTrigger =
{
    Properties =
    {
		bIsWineBarrel = false,
		guidWineItemGuid = 'da94ed8b-5b3b-4e2f-8c85-34ea3d0090ea',
        Click = 
        {
            sPersistentKettleStateVariable = "",
        },
    },
}

-- =============================================================================
function KettleActionTrigger:ReportUse(user,item,action)
    local link = self:GetLinkedSmartObject();

    if action == self.Properties.Click then
        -- for click test if the item can be eaten
        local canEat, cannotEatReason = self:CanEat(user);
        if not canEat then
            Game.SendInfoText(cannotEatReason, false);
            return;
        end

        local hasEaten = user.soul:EatItem(self:GetEatItemClassId());
        if not hasEaten then
            return;
        end
    end

    ActionTrigger.ReportUse(self,user,item,action)
end

-- =============================================================================
function KettleActionTrigger:IsEnabled(user)
    local baseEnabled, baseReason, cannotEatMetarole = ActionTrigger.IsEnabled(self,user);
    if not baseEnabled then
        return false, baseReason, cannotEatMetarole;
    end

    local canEat, cannotEatReason, cannotEatMetarole = self:CanEat(user);
    if not canEat then
        return false, cannotEatReason, cannotEatMetarole;
    end

    return true, nil, nil;
end

-- =============================================================================
function KettleActionTrigger:IsEnabledHold(user)
    local baseEnabled, baseReason = ActionTrigger.IsEnabledHold(self,user);
    if not baseEnabled then
        return false, baseReason;
    end

    if not self.Properties.bIsWineBarrel and self:IsKettleVirtuallyEmpty() then
        return false, '@fireplace_cannotPoisonEmptyKettle';
    end

    return true, nil;
end

-- =============================================================================
function KettleActionTrigger:CanEat(user)
    if not self.Properties.bIsWineBarrel and self:IsKettleVirtuallyEmpty() then
        return false, '@fireplace_cannotEatFromEmptyKettle', 'HRAC_UZ_NEMUZE_JIST_Z_KOTLIKU_KOTLIK_JE_PRAZDNY';
    end

    local canEat = user.soul:CanEatItem(self:GetEatItemClassId());
    if not canEat then
        return false, '@fireplace_cannotEatPlayerFull', 'HRAC_UZ_NEMUZE_JIST_Z_KOTLIKU_HRAC_JE_PLNY';
    end

    return true, nil, nil;
end

-- =============================================================================
function KettleActionTrigger:IsKettleVirtuallyEmpty()
    local link = self:GetLinkedSmartObject();
    local kettleData = XGenAIModule.GetBrainVariable(link.smartObject.__this, self.Properties.Click.sPersistentKettleStateVariable);
    local kettleState = kettleData.state;

    -- keep the values consistent with the actual enum ( 2 - kettleState:halfEmpty, 3 - kettleState:empty)
    if kettleState == 2 or kettleState == 3 then
        return true;
    end

    return false;
end

-- =============================================================================
function KettleActionTrigger:GetEatItemClassId()
	if self.Properties.bIsWineBarrel then
		return self.Properties.guidWineItemGuid;
	else
		local link = self:GetLinkedSmartObject();
		return link:GetEatItemClassId();
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/ActionTrigger.lua")
table.Merge(KettleActionTrigger, ActionTrigger)