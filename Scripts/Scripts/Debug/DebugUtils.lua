DebugUtils = {}

-- =============================================================================
function DebugUtils.DistanceToPlayer(entity_name)
	local entity_pos = System.GetEntityByName(entity_name):GetPos()
	return math.sqrt(VectorUtils.DistanceSquared2D(player:GetPos(), entity_pos))
end

-- =============================================================================
function DebugUtils.RainOn()
	System.ExecuteCommand('wh_env_raindebug 1')
	System.ExecuteCommand('wh_env_rainthreshold 0')
	EnvironmentModule.RebuildClouds()
end

-- =============================================================================
function DebugUtils.RainOff()
	System.ExecuteCommand('wh_env_raindebug 0')
	System.ExecuteCommand('wh_env_rainthreshold 1')
	EnvironmentModule.RebuildClouds()
end

-- =============================================================================
function DebugUtils.NavmeshCleaner()
	System.ExecuteCommand('wh_ai_RecastDebugDrawMode 1')
	System.ExecuteCommand('wh_ai_RecastFloodFill')
	System.ExecuteCommand('wh_ai_RecastPrune')
end

-- =============================================================================
function DebugUtils.FakeLoadedGameVersion(version)
	System.SetCVar('wh_sys_FakeLoadedGameVersion', version)
end

-- =============================================================================
-- Provided with an expression, outputs the current values of all the variables
-- used within and how the variables compare to their right-hand-side constants.
function DebugUtils.CheckExp(exp)
	local ops = {}
	ops['<']  = function(a, b) return a <  b end
	ops['<='] = function(a, b) return a <= b end
	ops['>']  = function(a, b) return a >  b end
	ops['>='] = function(a, b) return a >= b end
	ops['=='] = function(a, b) return a == b end
	ops['!='] = function(a, b) return a ~= b end

	local pattern = "gvar%('([%w_%.]*)'%)([!<>=]*)([0-9]*)"
	for var, op, val in exp:gsub(' ', ''):gmatch(pattern) do
		local v = Variables.GetGlobal(var)
		opFunction = assert(ops[op], string.format("Unrecognised operator: %s", op))

		v = tonumber(v)
		val = tonumber(val)

		local result
		if opFunction(v, val) then
			result = "Condition holds"
		else
			result = "Condition does not hold"
		end

		local output = string.format("Condition %s %s %d: value = %d -- %s.", var, op, val, v, result)
		DebugUtils.Log(output)
	end
end

-- =============================================================================
-- Call this from any function that you want to mark as deprecated. Whenever such
-- a function will be called, this will print out a warning along with the current call stack.
function DebugUtils.WarnDeprecated()
	local di = debug.getinfo(2, "nS")

	local functionName = di.name
	local sourceFileName = di.source:sub(2)
	local line = di.linedefined

	local stack = debug.traceback():gsub('stack traceback:\n', ''):gsub('\n', ' |'):gsub('\t', ' ')
	Trace.Warning(string.format("Function '%s' declared at %s:%d is deprecated | call stack: %s", functionName, sourceFileName, line, stack))
end

-- =============================================================================
function DebugUtils.LogError(fmt, ...)
	if Trace then
		Trace.Error(string.format(fmt, ...))
	else
		System.Log("$4" .. string.format(fmt, ...))
	end
end

-- =============================================================================
function DebugUtils.LogWarning(fmt, ...)
	if Trace then
		Trace.Warning(string.format(fmt, ...))
	else
		System.Log("$6" .. string.format(fmt, ...))
	end
end

-- =============================================================================
function DebugUtils.Log(fmt, ...)
	if Trace then
		Trace.Info(string.format(fmt, ...))
	else
		System.Log(string.format(fmt, ...))
	end
end

-- =============================================================================
function DebugUtils.FlyMode()
	local flyMode = player.player:GetFlyMode()
	if flyMode == FlyMode_Off then
		player.player:SetFlyMode(FlyMode_On)
	elseif flyMode == FlyMode_On then
		player.player:SetFlyMode(FlyMode_OnNoCollisions)
	else
		player.player:SetFlyMode(FlyMode_Off)
	end
end

-- =============================================================================
function DebugUtils.UnlockAllCodexEntries()
	player.soul:AddAllCodexPerks()	
end