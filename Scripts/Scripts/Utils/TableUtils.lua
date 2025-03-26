-- =============================================================================
-- Returns an index on which the provided value is stored in the provided table.
function table.Lookup(t, val)
	for k, v in pairs(t) do
		if v == val then
			return k
		end
	end
end

-- =============================================================================
-- Returns a boolean value based on whether
-- the provided table contains the provided value.
function table.Contains(t, val)
	return table.Lookup(t, val) ~= nil
end

-- =============================================================================
function table.ContainsIgnoreCase(t, val)
    for _, v in pairs(t) do
		if string.lower(v) == string.lower(val) then
			return true
		end
    end
    return false
end

-- =============================================================================
function table.ShallowCopy(obj)
	assert(LuaUtils.IsTable(obj), "Invalid argument type: should be table, got " .. type(obj))

	local copy = {}
	for key, value in pairs(obj) do
		copy[key] = value
	end

	return copy
end

-- =============================================================================
-- Creates a deep copy of a table. Handles recursive tables.
function table.DeepCopy(obj)
	-- assert(LuaUtils.IsTable(obj), "Invalid argument type: should be table, got " .. type(obj))

	-- Use internal function to hide a copies argument, which is used only for passing information during recursion
	function DeepCopyInternal(obj, copies)
		-- Return obj if trying to copy a primitive type
		if not LuaUtils.IsTable(obj) then
			return obj
		end

		-- Now we know that obj is a table, so check if it wasn't copied before
		if copies and copies[obj] then
			return copies[obj]
		end

		-- It's not, then create a new table, where original table will be copied
		local copy = {}
		-- Add its reference to copies buffer, to avoid endless recursion when working with recursive tables
		copies = copies or {}
		copies[obj] = copy

		-- Recursively copy original values to a new table
		for key, value in pairs(obj) do
			copy[DeepCopyInternal(key, copies)] = DeepCopyInternal(value, copies)
		end

		return copy
	end

	return DeepCopyInternal(obj)
end

-- =============================================================================
-- Merges tables from varargs (starting from the second) to the first table without overwriting fields.
-- Example: table.Merge(A, B, C) = table.Merge(table.Merge(A, B), C)
-- Handles recursive tables
function table.Merge(...)
	-- Use internal function to hide a copies argument, which is used only for passing information during recursion
	function MergeInternal(target, source, copies)
		if copies and copies[source] then
			return copies[source]
		end

		copies = copies or {}
		copies[source] = source

		for key, _ in pairs(source) do
			if IsTable(source[key]) and target[key] == nil then
				target[key] = {}
			end

			if IsTable(source[key]) and IsTable(target[key]) then
				target[key] = MergeInternal(target[key], source[key], copies)
			elseif target[key] == nil then
				target[key] = source[key] -- target has priority, we don't overwrite
			end
		end

		return target
	end

	local tableList = {...}
	local result = table.PopFirst(tableList)
	for _, tbl in ipairs(tableList) do
		result = MergeInternal(result, tbl)
	end
	return result
end

-- =============================================================================
-- Returns a table which contains exactly those key-value pairs present
-- in the provided table where the value meets the provided predicate.
function table.Select(t, pred)
	local result = {}
	for k, v in pairs(t) do
		if pred(v) then
			result[k] = v
		end
	end

	return result
end

-- =============================================================================
-- Returns a sequence which contains all the values
-- in the provided sequence that meet the provided predicate.
function table.SelectValues(t, pred)
	local result = {}
	for _, v in ipairs(t) do
		if pred(v) then
			table.insert(result, v)
		end
	end

	return result
end

-- =============================================================================
-- Returns a value in the provided
-- table that meets the provided predicate.
function table.SelectOne(t, pred)
	for _, v in pairs(t) do
		if pred(v) then
			return v
		end
	end
end

-- =============================================================================
function table.Count(_tbl)
	local count = 0
	if (_tbl) then
		for i, v in pairs(_tbl) do
			count = count + 1
		end
	end
	return count
end

-- =============================================================================
-- Returns how many values in the
-- provided table meet the provided predicate.
function table.CountWithPredicate(t, pred)
	local count = 0
	for _, v in pairs(t) do
		if pred(v) then
			count = count + 1
		end
	end

	return count
end

-- =============================================================================
-- Removes all the values in the table that meet the provided predicate.
function table.RemoveWithPredicate(t, pred)
	local k, v
	while true do
		k, v = next(t, k)
		if k == nil then
			break
		end
		if pred(v) then
			t[k] = nil
		end
	end
end

-- =============================================================================
-- Find a value in a table. Returns its index if found and nil if not.
function table.Find(t, val)
	for k, v in pairs(t) do
		if v == val then
			return k
		end
	end

	return nil
end

-- =============================================================================
-- Removes a value contained in the table.
function table.RemoveValue(t, val)
	for k, v in pairs(t) do
		if v == val then
			table.remove(t, k)
			return
		end
	end
end

-- =============================================================================
-- Returns the first element in a sequence, and removes it from the sequence.
function table.PopFirst(t)
	local v = t[1]
	table.remove(t, 1)

	return v
end

-- =============================================================================
-- Returns the last element in a sequence, and removes it from the sequence.
function table.PopLast(t)
	local v = t[#t]
	table.remove(t, #t)

	return v
end

-- =============================================================================
function table.IsEmpty(t)
	return next(t) == nil
end

-- =============================================================================
function table.Append(t1, t2)
	for _, v in ipairs(t2) do
		table.insert(t1, v)
	end
end

-- =============================================================================
function table.ArrayShiftZero(t1, t2)
	if t2 == nil then
		t2 = t1
	end

	for i = 0, (#t1 - 1) do
		t2[i] = t1[i + 1]
	end
	t2[#t1] = nil -- delete last (IF t1==t2), does nothing on new table t2
end

-- =============================================================================
function table.ArrayShiftOne(t1, t2)
	if t2 == nil then
		t2 = t1
	end

	for i = #t1 + 1, 1, -1 do
		t2[i] = t1[i - 1]
	end
	t2[0] = nil -- delete first element, for the case t1==t2
end

-- =============================================================================
function table.SafeGet(table, name)
	if table then
		return table[name]
	else
		return nil
	end
end

-- =============================================================================
-- Sorts simple indexed array of objects (tables with string keys)
-- based on the provided keys (additional function arguments as strings)
-- in descending order of importance (i.e. the first additional argument is
-- the most important sorting key which can decide the comparison of two elements first)
function table.SortArrayOfObjects(array, ...)
	local sortingFunction = function(o1, o2)
		for _, key in ipairs(arg) do
			local v1 = o1[key]
			local v2 = o2[key]
			-- If the key isn't present in either of the objects, continue with the next key
			if v1 ~= nil or v2 ~= nil then
				-- If only one of the objects has the key at all, it comes first
				if v1 ~= nil and v2 == nil then
					return true
				elseif v1 == nil and v2 ~= nil then
					return false
					-- If only one of the objects has non-empty string as value of the key, it comes first
				elseif v1 ~= "" and v2 == "" then
					return true
				elseif v1 == "" and v2 ~= "" then
					return false
					-- If value of the key of one object is strictly less than the other object's, it comes first
				elseif v1 < v2 then
					return true
				elseif v1 > v2 then
					return false
					-- This key was unable to decide between the objects, continue with the next key
				end
			end
		end

		-- The objects appear to be equal considering the given sorting keys
		return false
	end

	table.sort(array, sortingFunction)
end

-- =============================================================================
-- Given a simple indexed array of objects (tables with string keys) the function creates an indexing table;
-- returns table which contains keys for every value of indexKey among the original objects,
-- the value of these keys is a simple indexed array of all objects, that have according indexKey value
-- (e.g. for input array { {ik="A", val="a1"}, {ik="B", val="b1"}, {ik="B", val="b2"} }
-- and indexKey parameter "ik" returns { A = { {ik="A", val="a1"} }, B = { {ik="B", val="b1"}, {ik="B", val="b2"} } })
function table.IndexArrayOfObjects(array, indexKey)
	local result = {}

	for i, obj in ipairs(array) do
		local index = obj[indexKey]
		if result[index] == nil then
			result[index] = {}
		end
		table.insert(result[index], obj)
	end

	return result
end

-- =============================================================================
function table.Shuffle(list)
	for i = 1, #list do
		local j = math.random(i, #list)
		list[j], list[i] = list[i], list[j]
	end
end

-- =============================================================================
-- Reindex first level Lua Table (indexed from 1) to Modular Behavior Tree array (indexed from 0)
-- No need to make this recursice since MBT does not support 2d arrays
function table.ReindexTableToMBT(array)
	local mbtArray = {}

	for i = 1, #array do

		if IsTable(array[i]) then
			mbtArray[i - 1] = table.DeepCopy(array[i])
		else
			mbtArray[i - 1] = array[i]
		end

	end

	return mbtArray
end

-- =============================================================================
function table.MakeFromType(typeName, override)
	local tab = XGenAIModule.MakeTableFromType(typeName)
	assert(tab, StrFormat("table.MakeFromType requires name of a existing MBT type, got '%s.'", typeName))

	if override ~= nil then
		for k, v in pairs(override) do
			assert(tab[k] ~= nil, StrFormat("override table does not match the type '%s.', got member '%s.'", typeName, k))
			tab[k] = v
		end
	end

	return tab
end

-- =============================================================================
function table.ReservoirSample(k, list)
	local sample = {}
	for i = 1, k do
		sample[i] = list[i]
	end

	for i = k + 1, #list do
		j = math.random(1, i)
		if j <= k then
			sample[j] = list[i]
		end
	end

	return sample
end

-- =============================================================================
-- Picks random element from list, considering only valid elements.
-- Valid are those elements, for which valid(element,callbackParams) is not false
function table.RollingSample(list, callback, callbackParams)
	local numValid = 1 -- number of valid elements
	local chosenElement = 1 -- ID of the chosen element

	-- pick first valid
	while list[chosenElement] ~= nil and callback(list[chosenElement], callbackParams) == false do
		chosenElement = chosenElement + 1
	end

	if list[chosenElement] == nil then
		return nil
	end

	for i = chosenElement + 1, #list do -- go through all remaining configurations
		if callback(list[i], callbackParams) then -- valid alignment
			numValid = numValid + 1
			if math.random(1, numValid) == 1 then -- reservoir sampling
				chosenElement = i
			end
		end
	end

	return list[chosenElement]
end

-- =============================================================================
-- Picks random element from list. weightCallback returns weights for each element.
function table.WeightedSample(list, weights)
	local total = 0
	for i = 1, #weights do
		total = total + weights[i]
	end

	local roll = math.random() * total

	for i = 1, #list do
		if roll < weights[i] then
			return list[i]
		else
			roll = roll - weights[i]
		end
	end
end

-- =============================================================================
-- Picks K items from list, items probability is given by it's weight
-- A-Chao algorithm
function table.WeightedReservoirSample(k, list, weights)
	local sumW = 0
	local sample = {}
	for i = 1, k do
		sample[i] = list[i]
		sumW = sumW + weights[i] / k
	end

	for i = k + 1, #list do
		sumW = sumW + weights[i] / k
		if math.random() < (weights[i] / sumW) then
			sample[math.random(1, k)] = list[i]
		end
	end

	return sample
end
