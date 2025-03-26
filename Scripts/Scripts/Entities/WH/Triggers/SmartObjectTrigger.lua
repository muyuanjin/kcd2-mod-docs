-- =============================================================================
-- this is a smart object holder, which also acts as trigger
-- =============================================================================
SmartObjectTrigger =
{
    Properties =
    {
        guidSmartObjectType = "",
        soclass_SmartObjectHelpers = "",
    }
}

-- =============================================================================
function SmartObjectTrigger:_GetSendTargets(user,action)
    if( guidSmartObjectType == '' ) then
        return TriggerBase._GetSendTargets(self, user, action)
    end

    local myWuid = XGenAIModule.GetMyWUID(self)
    return {myWuid}
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/TriggerBase.lua")
table.Merge(SmartObjectTrigger, TriggerBase)
