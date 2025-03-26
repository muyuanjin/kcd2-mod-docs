-- =============================================================================
-- Entity useful for creating ghosts (visual guides), derived from BasicEntity
-- The ghost can (it doesn't have to) be dynamically controlled by entity implementing GhostsController interface
-- =============================================================================

GhostDummy =
{
	Properties =
	{
		object_Model = '',

		bExported_to_game = false,
		bExported_to_test = false,

		Physics =
		{
			CollisionFiltering =
			{
				collisionType =
				{
					bT_gcc_interactive = "1",
				},
			},
		},
	},
}

-- =============================================================================
function GhostDummy:UpdateMaterial(gameMode)
	-- Set either nodraw or transparent material
	local cvarValue = System.GetCVar("wh_ent_ShowHelperObjects")
	local showInEditMode = cvarValue > 0
	local showInGameAndGameMode = cvarValue > 1
	if ((System.IsEditor() and showInEditMode and not gameMode) or showInGameAndGameMode) then
		self:SetMaterial("objects/intermediates/poses/poses_nomultimaterial")
	else
		self:SetMaterial("materials/special/nodraw")
	end
end

-- =============================================================================
function GhostDummy:UpdateGhost(ghostModel)
	local defaultModel = self.Properties.object_Model
	-- Update stored ghost model
	if ghostModel ~= nil and ghostModel ~= '' then
		if GhostsStorage == nil then
			GhostsStorage = {}
		end
		GhostsStorage[self.id] = ghostModel
	end
	-- Reload current ghost model from storage or use default model
	if GhostsStorage ~= nil and GhostsStorage[self.id] ~= nil then
		self:LoadObject(0, GhostsStorage[self.id])
	elseif GhostsStorage ~= nil and GhostsStorage[self:GetName()] ~= nil then
		self:LoadObject(0, GhostsStorage[self:GetName()])
	elseif defaultModel ~= '' then
		self:LoadObject(0, defaultModel)
	end
	self:UpdateMaterial(false)
end

-- =============================================================================
function GhostDummy:OnEditorSetGameMode(gameMode)
	self:UpdateMaterial(gameMode)
end

-- =============================================================================
function GhostDummy:OnReset()
	self:UpdateGhost(nil)
end

-- =============================================================================
function GhostDummy:OnSpawn()
	self:OnReset()
end

-- =============================================================================
function GhostDummy:OnPropertyChange()
	self:OnReset()
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript("Scripts/Entities/Physics/BasicEntity.lua")
EntityCommon.DeriveOverride(GhostDummy, BasicEntity)
