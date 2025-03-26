-- =============================================================================
-- This is a trigger, that is used to interact with a water tube. It additionally checks whether player is sufficiently dirty
-- =============================================================================
WaterTubeActionTrigger =
{
    Properties = {
        fMinDirtBloodBody = 0.6,
        fMinDirtBloodClothing = 0.6,
		guidSoap = "",
		Click = {
			CannotWashReason = "",
		}
    }
}

-- =============================================================================
function WaterTubeActionTrigger:IsEnabled(user)
    local baseEnabled, baseReason = ActionTrigger.IsEnabled(self,user);
    if not baseEnabled then
        return false, baseReason;
    end

    local CanWash, cannotWashReason = self:CanWash(user);
    if not CanWash then
        return false, cannotWashReason;
    end

    return true, nil;
end

-- =============================================================================
function WaterTubeActionTrigger:CanWash(user)
    local fragrance = player.soul:GetDerivedStat('frg');

    if fragrance > 0.2 or user.actor:IsMoreDirty(self.Properties.fMinDirtBloodClothing) or user.actor:IsBodyMoreDirty(self.Properties.fMinDirtBloodBody) then
        return true, nil;
    end

    return false, self.Properties.Click.CannotWashReason;
end

-- =============================================================================
function WaterTubeActionTrigger:IsEnabledHold(user)
	local link = self:GetLinkedSmartObject();
    if not link then
        if self.Properties.Hold.esActionType == "Animation" then
            return true, nil
        else
            return false, nil
        end
    end

    local CanWash, cannotWashReason = self:CanWashWithSoap(user);
    if not CanWash then
        return false, cannotWashReason;
    end

    return true, nil;
end

-- =============================================================================
function WaterTubeActionTrigger:CanWashWithSoap(user)
	if (self.Properties.guidSoap ~= "") then
		local item = user.inventory:FindItem(self.Properties.guidSoap)
		if item then
			return true, nil;
		end
	end
	
	return false, '@notifikac_nejdriv_si_seze_UIEY';
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/ActionTrigger.lua")
table.Merge(WaterTubeActionTrigger, ActionTrigger)