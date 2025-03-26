-- =============================================================================
-- Interface template for entities that can control associated ghosts (GhostDummy entities)
-- Classes that use this interface must implement UpdateData function (see below)
-- =============================================================================

GhostsController =
{
}

-- =============================================================================
function GhostsController:OnSpawn()
	self.ghostsData = {}
	self:UpdateData()
	if System.IsEditor() then
		self:UpdateGhosts()
	end
end

-- =============================================================================
function GhostsController:OnEditorLayerLoaded()
	if System.IsEditor() then
		self:UpdateGhosts()
	end
end

-- =============================================================================
function GhostsController:OnPropertyChange()
	self:UpdateData()
	if System.IsEditor() then
		self:UpdateGhosts()
	end
end

-- =============================================================================
-- Function UpdateData must be implemented by the class using this interface. The function is expected to fill
-- in the ghostsData table accordingly. The table should contain models (string path to the model) for each
-- connected ghost with string key matching the link tag (and/or entity name).
-- =============================================================================
function GhostsController:UpdateGhosts()
	for ghostID, ghostModel in pairs(self.ghostsData) do
		local ghost = self:GetLinkTarget(ghostID)
		if ghost ~= nil then
			ghost:UpdateGhost(ghostModel)
		else
			local ghostName, count = string.gsub(self:GetName(), '^[^%[]+', ghostID)
			if count == 1 then
				ghost = System.GetEntityByName(ghostName)
				if ghost ~= nil then
					ghost:UpdateGhost(ghostModel)
				else
					if GhostsStorage == nil then
						GhostsStorage = {}
					end
					GhostsStorage[ghostName] = ghostModel
				end
			end
		end
	end
end
