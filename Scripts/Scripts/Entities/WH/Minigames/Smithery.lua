Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

Smithery =
{
	Properties =
	{
	},

	Editor =
	{
		Icon = "animobject.bmp",
	},

	bUseTrigger = true
}

-- =============================================================================
function Smithery:GetActions(user, firstFast)
	output = {}

	if Blacksmithing.CanUse(user.id, self.id) == 1 and not user.soul:HasScriptContext("minigame_disabledBlacksmithing") then
		local canUseMinigame = Minigame.CanUseMinigame(user.id);
		AddInteractorAction( output, firstFast, Action():hint( "ui_start_blacksmithing" ):action( "use" ):interaction( inr_blackmisthing ):func( Smithery.OnUsed ):enabled(canUseMinigame) )
	end

	return output
end

-- =============================================================================
function Smithery:OnUsed( user, slot )
	local resourceObjectId = INVALID_WUID;
	local link = self:GetLinkedSmartObject();
	if link then
		resourceObjectId = link.smartObject.__this;
	end
	PlayerStateHandler.StartMinigame(self.id, E_MinigameType_Blacksmithing, resourceObjectId, 'blacksmithing', E_Urgency_Instant);
end

-- =============================================================================
function Smithery:GetLinkedSmartObject()
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
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(Smithery, UsableItem);