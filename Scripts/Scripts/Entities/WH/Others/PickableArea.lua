PickableArea = {

	Properties={
		sWH_AI_EntityCategory = "",
		-- Used by interactor
		sUsableMessage = "@ui_pickherb",	-- message shown in HUD use message
		bHasUsableFlag = true,	-- use flag name according to picked item
	},

	Editor={
		Icon = "Seed.bmp",
		IconOnTop = 1,
	},

	-- Used by minigame
	Amount = 0,				-- amount coeficient
	GuidItemPicked = "",	-- item to be picked
	UsableName = "",		-- name shown in HUD flag, set from code
	PickingTime = 1
}

-- =============================================================================
function PickableArea:Activate(guidItemPicked, amount, pickingTime)
	--System.Log("Activate")
	self.GuidItemPicked = guidItemPicked
	self.Amount = amount
	self.UsableName = ItemManager.GetItemUIName(guidItemPicked)
	self.PickingTime = pickingTime
end

-- =============================================================================
function PickableArea:IsCrossCenteringEnabled()
	return self.Properties.bHasUsableFlag
end

-- =============================================================================
function PickableArea:GetUsableName(slot)
	return self.UsableName
end

-- =============================================================================
function PickableArea:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	output = {}

	if PickableArea.ArePickableAreasEnabledInGeneral() then

		if AddInteractorAction( output, firstFast, Action():hint( self.Properties.sUsableMessage ):action( "use" ):func( PickableArea.Gather ):interaction( inr_herbGathering ) ) then
			return output
		end

	end

	return output
end

-- =============================================================================
function PickableArea:Gather(user, slot)
	--System.Log("Use")
	Minigame.StartHerbGathering(self.id)
	return true
end

-- =============================================================================
function PickableArea.EnablePickableAreasInGeneral()

	Variables.SetGlobal('pickableAreasDisabledInGeneral', 0)

end

-- =============================================================================
function PickableArea.DisablePickableAreasInGeneral()

	Variables.SetGlobal('pickableAreasDisabledInGeneral', 1)

end

-- =============================================================================
function PickableArea.ArePickableAreasEnabledInGeneral()

	return Variables.GetGlobal('pickableAreasDisabledInGeneral') == 0

end

-- =============================================================================
PickableArea.FlowEvents =
{
	Inputs =
	{
		Hide = { PickableArea.Event_Hide, "bool" },
		UnHide = { PickableArea.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Hide = "bool",
		UnHide = "bool",
	},
}
