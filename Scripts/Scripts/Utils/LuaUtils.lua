LuaUtils = {}

-- =============================================================================
function LuaUtils.IsNumber(val)
	return type(val) == 'number'
end
IsNumber = LuaUtils.IsNumber

-- =============================================================================
function LuaUtils.IsInt(val)
	return LuaUtils.IsNumber(val) and (val % 1 == 0)
end
IsInt = LuaUtils.IsInt

-- =============================================================================
function LuaUtils.IsStr(val)
	return type(val) == 'string'
end
IsStr = LuaUtils.IsStr

-- =============================================================================
function LuaUtils.IsTable(val)
	return type(val) == 'table'
end
IsTable = LuaUtils.IsTable

-- =============================================================================
function LuaUtils.NativeToStr(s)
	if LuaUtils.IsStr(s) then
		return s
	end

	if LuaUtils.IsNumber(s) then
		return ToStr(s)
	end

	if s == nil then
		return '[nil]'
	end

	if s == true then
		return '[true]'
	end

	if s == false then
		return '[false]'
	end

	error(StrFormat("Cannot convert provided value '%s'", ToStr(s)))
end

-- =============================================================================
function LuaUtils.StrToNative(s)
	assert(LuaUtils.IsStr(s))

	if s == '[nil]' then
		return nil
	end

	if s == '[true]' then
		return true
	end

	if s == '[false]' then
		return false
	end

	return tonumber(s) or s
end

-- =============================================================================
-- Check if a number value is true or false
-- Useful for entity parameters
function LuaUtils.NumberToBool(n)
	if (n and (tonumber(n) ~= 0)) then
		return true
	else
		return false
	end
end

-- =============================================================================
function LuaUtils.Pick(condition, a, b)
	if condition then
		return a
	end
	return b
end
Pick = LuaUtils.Pick
