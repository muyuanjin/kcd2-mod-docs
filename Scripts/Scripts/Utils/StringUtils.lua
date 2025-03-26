function string.Explode(s, delim)
	local tokens = {}
	for token in s:gmatch(StrFormat('[^%s]+', delim)) do
		table.insert(tokens, token)
	end

	return tokens
end

-- =============================================================================
function string.Trim(s)
	s = s:gsub('^%s+', ''):gsub('%s+$', '')
	return s
end

-- =============================================================================
function string.CapitaliseFirst(s)
	s = s:sub(1, 1):upper() .. s:sub(2)
	return s
end

-- =============================================================================
function string.StartsWith(s, start)
	return s:sub(1, #start) == start
end

-- =============================================================================
function string.Split(str, delimiter, omitEmpty)
	local delim = delimiter or '\r\n'
	local result = {}
	local foundEnd = 0
	local oldFoundEnd = 0
	local found = nil

	repeat
		found, foundEnd = string.find(str, delim, foundEnd + 1)
		local subResult = ""
		subResult = string.sub(str, oldFoundEnd + 1, (found or 0) - 1)
		if not (omitEmpty and (subResult == "" or subResult == nil)) then
			result[#result + 1] = subResult
		end
		oldFoundEnd = foundEnd
	until found == nil

	return result
end

-- =============================================================================
-- Check if a string is set and it's length > 0
function string.IsEmpty(str)
	if (str and string.len(str) > 0) then
		return false
	end
	return true
end

-- =============================================================================
-- Shortcuts
-- =============================================================================
ToStr = tostring
StrFormat = string.format
