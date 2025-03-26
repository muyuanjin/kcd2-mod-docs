GameUtils = {}

-- =============================================================================
-- Dialog local variables
-- =============================================================================
-- This can be used within the sequences' exit scripts
-- so that we don't need to care about var context
function GameUtils.SetLocalVar(varname, value)
	Variables.SetLocal(varname, g_varContext, value)
end

-- =============================================================================
-- This can be used within the sequences' exit scripts
-- so that we don't need to care about var context
function GameUtils.GetLocalVar(varname)
	return Variables.GetLocal(varname, g_varContext)
end

-- =============================================================================
-- Save/Load
-- =============================================================================
function GameUtils.DisableSave(lockName, reason)
	local uiReason
	if reason == enum_disableSaveReason.script then
		uiReason = '@ui_cant_save_script'
	elseif reason == enum_disableSaveReason.minigame then
		uiReason = '@ui_cant_save_minigame'
	elseif reason == enum_disableSaveReason.battle then
		uiReason = '@ui_cant_save_combat'
	elseif reason == enum_disableSaveReason.combat then
		uiReason = '@ui_cant_save_combat'
	else
		uiReason = '@ui_cant_save_other'
	end

	Game.AddSaveLock(lockName, uiReason)
end

-- =============================================================================
function GameUtils.EnableSave(lockName)
	Game.RemoveSaveLock(lockName)
end

-- =============================================================================
-- Misc
-- =============================================================================
function GameUtils.ConvertGameGuidToLyrGuid(guid)
	local swap = {10, 11, 12, 13, 15, 16, 17, 18, 9, 5, 6, 7, 8, 14, 1, 2, 3, 4, 19, 35, 36, 33, 34, 24, 31, 32, 29, 30, 27, 28, 25, 26, 22, 23, 20, 21}
	local res = {}

	for i = 1, #guid do
		local ix = swap[i]
		res[i] = guid:sub(ix, ix)
	end
	return table.concat(res)
end

-- =============================================================================
function GameUtils.ConvertLyrGuidToGameGuid(guid)
	local swap = {15, 16, 17, 18, 10, 11, 12, 13, 9, 1, 2, 3, 4, 14, 5, 6, 7, 8, 19, 35, 36, 33, 34, 24, 31, 32, 29, 30, 27, 28, 25, 26, 22, 23, 20, 21}
	local res = {}

	for i = 1, #guid do
		local ix = swap[i]
		res[i] = guid:sub(ix, ix)
	end
	return table.concat(res)
end

-- =============================================================================
function GameUtils.HideHorseCutscene()
	local horse = player.player:GetPlayerHorse()
	if horse == __null then return end

	horse = assert(XGenAIModule.GetEntityByWUID(horse), "Cannot locate player's horse entity")

	player.human:ForceDismount()
	horse:SetWorldPos(System.GetEntityByName('horseCutsceneTeleport'):GetWorldPos())
end
