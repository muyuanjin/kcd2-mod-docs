-- This script is loaded very early at startup
-- =============================================================================
-- Load utils
-- =============================================================================
Script.ReloadScript("Scripts/Utils/LuaUtils.lua")
Script.ReloadScript("Scripts/Utils/StringUtils.lua")
Script.ReloadScript("Scripts/Utils/TableUtils.lua")
Script.ReloadScript("Scripts/Utils/MathUtils.lua")
Script.ReloadScript("Scripts/Utils/VectorUtils.lua")
Script.ReloadScript("Scripts/Debug/DebugUtils.lua")
Script.ReloadScript("Scripts/Utils/ScriptLoader.lua")
-- Script.ReloadScript("Scripts/Utils/Containers.lua")

-- =============================================================================
-- Common globals and definitions.
-- =============================================================================
-- data structure passed to the Signals, use this global to avoid temporary lua mem allocation
g_SignalData_point = {x = 0, y = 0, z = 0}
g_SignalData_point2 = {x = 0, y = 0, z = 0}

-- REMEMBER! ALWAYS write
-- g_SignalData.point = g_SignalData_point
-- before doing direct value assignment (i.e. not referenced) like
-- g_SignalData.point.x = ...
g_SignalData = {
	point = g_SignalData_point, -- since g_SignalData.point is always used as a handler
	point2 = g_SignalData_point2,
	ObjectName = "",
	id = NULL_ENTITY,
	fValue = 0,
	iValue = 0,
	iValue2 = 0
}
g_StringTemp1 = "                                            "
g_HitTable = {{}, {}, {}, {}, {}, {}, {}, {}, {}, {}}