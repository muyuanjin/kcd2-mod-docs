-- =============================================================================
function LoadAllScripts()
	ScriptLoader.ignoredPaths = {
		"Scripts/Utils/ScriptLoader.lua",
	}

	ScriptLoader.LoadFolder("Scripts/Utils")
	ScriptLoader.LoadFolder("Scripts/Systems")
	ScriptLoader.LoadFolder("Scripts/Quests")
	ScriptLoader.LoadFolder("Scripts/Debug")
end

-- =============================================================================
function OnInit()
	LoadAllScripts()

	-- GameCodeCoverage
	local _dummyFn = function() return end
	if GameCodeCoverage then
		CCCP = GameCodeCoverage.SCCPOINT or _dummyFn
	else
		CCCP = _dummyFn
	end
end

-- =============================================================================
function OnShutdown()
end
