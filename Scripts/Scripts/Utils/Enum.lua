Enum = {}

-- =============================================================================
function Enum.new (values)

	setmetatable(values, Enum)

	for _, v in pairs(values) do
		setmetatable(v, EnumValue)
	end

	return values

end

-- =============================================================================
function Enum.__index (enum, k)

	-- Look in the 'Enum' table.
	-- This allows to dispatch methods.
	return (assert(Enum[k], StrFormat("Enumeration doesn't contain a value named '%s'.", k)))

end

-- =============================================================================
function Enum:ListValues()

	local values = List.new()
	for _, v in pairs(self) do

		values:Add(v)

	end

	return values

end

-- =============================================================================
function Enum:FromIndex (index)

	local value = table.SelectOne(self, function (value) return value.index == index end)
	return (assert(value, StrFormat("Cannot parse %d into an enumeration value.", index)))

end

-- =============================================================================
function Enum:FromStr (str)

	local value = table.SelectOne(self, function (value) return value.str == str end)
	return (assert(value, StrFormat("Cannot parse '%s' into an enumeration value.", str)))

end

-- =============================================================================
EnumValue = {}
EnumValue.__index = EnumValue

-- =============================================================================
function EnumValue.__lt (val1, val2)

	assert(val1.index, "Cannot compare enumeration values that do not have their 'index' value declared.")
	assert(val2.index, "Cannot compare enumeration values that do not have their 'index' value declared.")
	return val1.index < val2.index

end

-- =============================================================================
function EnumValue.__le (val1, val2)

	return val1 < val2 or val1 == val2

end

-- =============================================================================
function EnumValue:ToIndex()

	return (assert(self.index, "Cannot call ToIndex() on an enum value without its 'index' value declared."))

end

-- =============================================================================
function EnumValue:ToStr()

	return (assert(self.str, "Cannot call ToStr() on an enum value without its 'str' value declared."))

end
