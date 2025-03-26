-- This code is essential to correct synchronisation of the MBT variables into the Lua nodes.

_dataMetaTable = {}

-- =============================================================================
_dataMetaTable.__index = function (t, k)

	local v = XGenAIModule._GetDataVariable(k)

	if v ~= nil then
		rawset(t, k, v)
	end

	return v

end

-- =============================================================================
_dataMetaTable.__newindex = function (t, k, v)

	XGenAIModule._SetDataVariable(k)
	rawset(t, k, v)

end