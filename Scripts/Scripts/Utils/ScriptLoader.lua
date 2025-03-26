ScriptLoader = {ignoredPaths = {}}

-- =============================================================================
function ScriptLoader.IsLuaScript(path)
	return string.sub(path, -4) == ".lua"
end

-- =============================================================================
function ScriptLoader.ShouldIgnore(path)
	return ScriptLoader.ignoredPaths and table.ContainsIgnoreCase(ScriptLoader.ignoredPaths, path)
end

-- =============================================================================
function ScriptLoader.LoadScript(path)
	if not ScriptLoader.IsLuaScript(path) then
		Trace.Error('[ScriptLoader] ScriptLoader.LoadScript: "' .. path .. '" is not a lua script')
		return
	end

	Script.ReloadScript(path)
end

-- =============================================================================
function ScriptLoader.LoadFromInclude(path)
	ScriptLoader.LoadScript(path .. "/include.lua")
	for _, includeFile in ipairs(include) do
		ScriptLoader.LoadScript(path .. "/" .. includeFile)
	end
end

-- =============================================================================
function ScriptLoader.LoadFolder(path)
	if ScriptLoader.IsLuaScript(path) then
		Trace.Error('[ScriptLoader] ScriptLoader.LoadFolder: "' .. path .. '" is not a folder')
		return
	end

	local folders = System.ScanDirectory(path, SCANDIR_SUBDIRS)
	local files = System.ScanDirectory(path, SCANDIR_FILES)

	-- If has include.lua, then we should bypass automatic loading
	if table.ContainsIgnoreCase(files, "include.lua") then
		ScriptLoader.LoadFromInclude(path)
		return
	end

	-- Files loading
	for _, file in ipairs(files) do
		local filepath = path .. "/" .. file
		if ScriptLoader.IsLuaScript(filepath) and not ScriptLoader.ShouldIgnore(filepath) then
			ScriptLoader.LoadScript(filepath)
		end
	end

	-- Folders loading
	for _, folder in ipairs(folders) do
		local folderpath = path .. "/" .. folder
		if not ScriptLoader.ShouldIgnore(folderpath) then
			ScriptLoader.LoadFolder(folderpath)
		end
	end

end