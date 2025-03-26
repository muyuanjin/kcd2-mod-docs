
Dump = {}

-- =============================================================================
setmetatable(Dump, {

	__call = function(t, val, options)

		options = options or {}
		t:Dump(val, { depth = 0, maxDepth = options.depth or 3, visited = {} })

	end

})

-- =============================================================================
function Dump:Dump (val, context)

	local str
	local suppressDescent
	local t = type(val)

	if t == 'table' then

		--
		local visited = table.Lookup(context.visited, val)

		--
		if visited then

			str = string.format("<table #%d -- see above>", visited)
			suppressDescent = true

		else

			if context.maxDepth == 'all' or context.depth < context.maxDepth then

				table.insert(context.visited, val)
				str = string.format("<table #%d:>", #context.visited)

			else

				str = "<table -- descent too deep>"
				suppressDescent = true

			end

		end

	else

		str = self:FormatTerminal(val)

	end

	local indent = ('        '):rep(context.depth)
	if context.index ~= nil then

		local index = self:FormatTerminal(context.index)
		local comma = context.comma and ', ' or ''

		self:Print(string.format('%s%s = %s%s', indent, index, str, comma))

	else

		self:Print(indent .. str)

	end

	if t == 'table' and (not suppressDescent) then

		local keys = self:ListKeys(val)
		for n, k in ipairs(keys) do

			local subcontext = table.ShallowCopy(context)

			subcontext.depth = subcontext.depth + 1
			subcontext.comma = (n < #keys)
			subcontext.index = k

			self:Dump(val[k], subcontext)

		end

	end

end

-- =============================================================================
function Dump:FormatTerminal (val)

	local t = type(val)
	if t == 'boolean' then

		return val and '<true>' or '<false>'

	elseif t == 'string' then

		return  '"' .. val .. '"'

	elseif t == 'number' then

		return tostring(val)

	elseif t == 'nil' then

		return '<nil>'

	end

	return '<' .. tostring(val):gsub('00000000', '') .. '>'

end

-- =============================================================================
-- Lists all the keys in the table in order in which we want to dump them:
-- First lists all the numbers in order, then all strings alphabetically, and then the rest.
function Dump:ListKeys (t)

	local numbers = {}
	local strings = {}
	local others = {}

	for k, _ in pairs(t) do

		local t = type(k)
		if t == 'number' then

			table.insert(numbers, k)

		elseif t == 'string' then

			table.insert(strings, k)

		else

			table.insert(others, k)

		end

	end

	table.sort(numbers)
	table.sort(strings)

	local result = {}
	for _, v in ipairs(numbers) do

		table.insert(result, v)

	end

	for _, v in ipairs(strings) do

		table.insert(result, v)

	end

	for _, v in ipairs(others) do

		table.insert(result, v)

	end

	return result

end

-- =============================================================================
function Dump:Print (str)
	if TError then
		TError(str)
	else
		print(str)
	end
end
