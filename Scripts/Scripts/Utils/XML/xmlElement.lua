
--WH_NOMASTER_START
--[[

XmlElement = {}
XmlElement.__index = XmlElement

-- =======================================================================

function XmlElement.new()

	local new = {}
	setmetatable(new, XmlElement)

	new.attributes = {}
	new.elements = {}

	return new

end

-- =======================================================================

function XmlElement.newFromParserData (parserData)

	local new = XmlElement.new()
	
	new.name = parserData.label
	for name, value in pairs(parserData.attrs) do

		new.attributes[name] = new:DecodeEscapedStr(value)

	end

	for index, elementParserData in ipairs(parserData) do

		if IsTable(elementParserData) then

			local element = XmlElement.newFromParserData(elementParserData)
			table.insert(new.elements, element)

		else

			new.content = new:DecodeEscapedStr(elementParserData)

		end
	
	end

	return new

end

-- =======================================================================

function XmlElement.newWithName (name)

	local new = XmlElement.new()

	new.name = name

	return new

end

-- ... ===================================================================
-- =======================================================================

function XmlElement:DecodeEscapedStr (s)
	
	return s:gsub('&lt;', '<'):gsub('&gt;', '>'):gsub('&quot;', '"'):gsub('&apos;', '\''):gsub('&amp;', '&')

end

-- READ ACCESS ===========================================================
-- =======================================================================

function XmlElement:GetName()

	return self.name

end

-- =======================================================================

-- Returns a table indexed with attribute names 
-- that holds the respective attributes' values.
function XmlElement:GetAttributes()

	return self.attributes

end

-- =======================================================================

-- Returns the provided attribute's value.
-- For attributes that can be parsed as numbers, the value is converted to a number.
-- For attributes that contain either '[true]' or '[false]', the returned value is 
-- the respective boolean value.
function XmlElement:GetAttribute (name, suppressCoercion)

	local value = self.attributes[name]
	if suppressCoercion then
		return value
	end
	
	if tonumber(value) then
		return tonumber(value)
	end
	
	if value == '[true]' then
		return true
	end
	
	if value == '[false]' then
		return false
	end
	
	if value == '[nil]' then
		return nil
	end
	
	return value

end

-- =======================================================================

-- Returns the provided attribute's value in an identical manner as GetAttribute(),
-- but checks whether the attribute is declared and throws an error in case that it is not.
function XmlElement:GetRequiredAttribute (name, suppressCoercion)

	local value = self:GetAttribute(name, suppressCoercion)
	return assert(value, StrFormat("XML element <%s> declared without the required '%s' attribute.", self:GetName(), name))

end

-- =======================================================================

-- Returns an iterator that iterates over all the children elements.
-- A 'name' parameter can be provided, in which case the method returns 
-- an iterator over all the children nodes with the provided name.
-- 
-- The iterator returns a pair: index, XmlElement
function XmlElement:EachElement (name)

	if name == nil then
		return ipairs(self.elements)
	end

	local elements = table.SelectValues(self.elements, function (element) return element:GetName() == name end)
	return ipairs(elements)
	
end

-- =======================================================================

-- Returns a sequence table with all the elements.
function XmlElement:GetElements()

	return self.elements

end

-- =======================================================================

-- Returns a child element with the requested name.
function XmlElement:GetElement (name)

	return table.SelectOne(self.elements, function (element) return element:GetName() == name end)

end

-- =======================================================================

-- Returns a child element with the requested name and throws an error in case there is no such element.
function XmlElement:GetRequiredElement (name)
	
	local element = self:GetElement(name)
	return assert(element, StrFormat("XML element <%s> declared without the required <%s> child element.", self:GetName(), name))

end

-- =======================================================================

-- Returns whether there is a child element with the requested name.
function XmlElement:HasElement (name)
	
	return self:GetElement(name) ~= nil

end

-- =======================================================================

-- Returns the element's content.
function XmlElement:GetContent()

	return self.content or ''

end

-- =======================================================================

-- Returns the element's content without tabs and newlines.
function XmlElement:GetCleanContent()
	
	return self:GetContent():gsub('\t', ''):gsub('\n', ''):Trim()

end

-- WRITE ACCESS ==========================================================
-- =======================================================================

function XmlElement:SetContent (content)

	self.content = content

end

-- =======================================================================

-- Set the attribute to <nil> to clear it.
function XmlElement:SetAttribute (name, value)

	self.attributes[name] = value

end

-- =======================================================================

function XmlElement:AddElement (element)

	table.insert(self.elements, element)

end

-- WRITE TO FILE =========================================================
-- =======================================================================

-- Writes the element into the provided output file.
function XmlElement:WriteToFile (outputFile, indent)

	local indentStr = ('\t'):rep(indent)
	outputFile:Write(indentStr .. '<' .. self.name)

	-- Sort the attribute names
	local sortedAttributeNames = {}
	for name, _ in pairs(self.attributes) do

		table.insert(sortedAttributeNames, name)

	end

	-- Output the attributes
	table.sort(sortedAttributeNames)
	for _, name in ipairs(sortedAttributeNames) do

		local value = self.attributes[name]
		local t = type(value)

		if t == 'boolean' then
			
			value = '[' .. tostring(value) .. ']'

		elseif t == 'number' then

			value = tostring(value)

		elseif t == 'string' then

			-- Escape XML special characters
			value = value:gsub('&', '&amp;'):gsub('"', '&quot;'):gsub("'", '&apos;'):gsub('<', '&lt;'):gsub('>', '&gt;')

		else
		
			value = '<Invalid value>'

		end

		outputFile:Write(string.format(' %s="%s"', name, value))

	end

	-- Close one-line elements
	if self.content == nil and #self.elements == 0 then

		outputFile:WriteLine(' />')
		return

	end

	-- Close
	outputFile:WriteLine('>')

	-- Children
	for _, element in ipairs(self.elements) do

		element:WriteToFile(outputFile, indent + 1)

	end

	-- Content
	if self.content ~= nil and #self.content > 0 then

		outputFile:WriteLine(self.content)
		
	end

	-- Close
	outputFile:WriteLine(indentStr .. '</' .. self.name .. '>')

end

]]--
--WH_NOMASTER_END
