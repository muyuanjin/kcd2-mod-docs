
--WH_NOMASTER_START
--[[

XmlDocument = {}
XmlDocument.__index = XmlDocument

-- =======================================================================

function XmlDocument.new()

	local new = {}
	setmetatable(new, XmlDocument)

	return new

end

-- =======================================================================

function XmlDocument.newFromFile (sourceFilePath)

	local new = XmlDocument.new()
	new:LoadFromFile(sourceFilePath)

	return new

end

-- =======================================================================

function XmlDocument.newWithRootName (rootElementName)

	local new = XmlDocument.new()
	
	new.root = XmlElement.newWithName(rootElementName)

	return new

end

-- READ FROM FILE ========================================================
-- =======================================================================

function XmlDocument:LoadFromFile (sourceFilePath)

	local content = System.LoadTextFile(sourceFilePath)
	
	-- XML declaration
	content = content:match('<?[.]*?>(.*)') or content
	content = content:match('<!DOCTYPE [^>]*>(.*)') or content
	
	-- Strip comments
	content = content:gsub('<!%-%-.-%-%->', '')

	local parserData = xmlReader.collect(content)
	self.root = XmlElement.newFromParserData(parserData[1])

end

-- WRITE TO FILE =========================================================
-- =======================================================================

function XmlDocument:SaveToFile (destFilePath)

	local outputFile = OutputFile.new(destFilePath)
	outputFile:WriteLine('<?xml version="1.0"?>')

	self.root:WriteToFile(outputFile, 0)

	outputFile:Close()

end

-- EXPOSE ================================================================
-- =======================================================================

function XmlDocument:GetRoot()

	return self.root

end

]]--
--WH_NOMASTER_END
