-- =============================================================================
-- Trigger to use indulgence box to pay penance and improve the reputation
IndulgenceBoxTrigger = {
    Properties = {
        Hold = {
            bIsActive = true,
            UseMessage = "@kajicna_p_slozit_odpustek_VfYM",
        }
    }
}

-- =============================================================================
function IndulgenceBoxTrigger:ReportUse(user,item,action)
     local enabled, disabledReason,prompt = self:IsPenanceMeaningful(user);
    if not enabled then
        Game.SendInfoText(disabledReason, false);
        return;
    end

    -- remove the money from player 
    local price = RPG.GetIndulgencePrice();
    player.inventory:DeleteItemOfClass("5ef63059-322e-4e1b-abe8-926e100c770e", price);
    Game.ShowItemsTransfer("5ef63059-322e-4e1b-abe8-926e100c770e", -price);
    RPG.ReconcileWithPublicFriends();
    Game.SendInfoText('@reputation_penance_paid',false)

    player.soul:AddPerk('43412723-c906-474a-a8de-3711a011a8c7') -- KCD2-377090

    TriggerBase.ReportUse(self,user,item,action)
end

-- =============================================================================
function IndulgenceBoxTrigger:IsEnabledHold(user)
    local enabled, disabledReason,prompt = self:IsPenanceMeaningful(user);

    self:SetHoldMessage(prompt);

    local baseEnabled, baseReason = TriggerBase.IsEnabledHold(self,user);
    if not baseEnabled then
        return baseEnabled, baseReason;
    end

    if not enabled then
        return false, disabledReason;
    end
end

-- =============================================================================
function IndulgenceBoxTrigger:IsPenanceMeaningful(user)
    local price = RPG.GetIndulgencePrice() / 10;
    if price > 0 then
        local promptText = StrFormat('@kajicna_p_slozit_odpustek_VfYM %d @kajicna_p_grosu_AZTL', price);
        local enabled = player.inventory:GetMoney() >= price;
        local disabledReason = '@kajicna_p_nemas_dost_penez_gDSg';
        if enabled then
            return true,nil,promptText;
        else
            return false,disabledReason,promptText;
        end
    else
        local promptText = '@kajicna_p_slozit_odpustek_VfYM';
        local disabledReason = '@kajicna_p_tvoje_reputace__Saiv';
        return false, disabledReason,promptText;
    end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/TriggerBase.lua")
table.Merge(IndulgenceBoxTrigger, TriggerBase)