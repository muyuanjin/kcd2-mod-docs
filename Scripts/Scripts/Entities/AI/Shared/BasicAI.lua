Script.ReloadScript("Scripts/Entities/AI/Shared/BasicAITable.lua")

BasicAI = {
	ai = 1,

	IsAIControlled = function()
		return true
	end,

	Server = {},
	Client = {},

	Editor = {
		Icon = "User.bmp",
		IconOnTop = 1,
	},
}

-- =============================================================================
function BasicAI:OnPropertyChange()
	--do not rephysicalize at each property change

	local forceResetAI = System.IsEditor()
	self:RegisterAI(forceResetAI)
	self:OnReset(false)

end

-- =============================================================================
function BasicAI:OnLoadAI(saved)

	self.AI = {}
	if(saved.AI) then
		self.AI = saved.AI
	end

	if(saved.spawnedEntity) then
		self.spawnedEntity = saved.spawnedEntity
	else
		self.spawnedEntity = nil
	end

	if(saved.lastSpawnedEntity) then
		self.lastSpawnedEntity = saved.lastSpawnedEntity
	else
		self.lastSpawnedEntity = nil
	end

	if(saved.InitialPosition) then
		self.InitialPosition = saved.InitialPosition
	else
		self.InitialPosition = nil
	end
end

-- =============================================================================
function BasicAI:OnSaveAI(save)
	if(self.AI) then
		save.AI = self.AI
	end

	if(self.spawnedEntity) then
		save.spawnedEntity = self.spawnedEntity
	end
	if(self.lastSpawnedEntity) then
		save.lastSpawnedEntity = self.lastSpawnedEntity
	end
	if(self.InitialPosition) then
	  save.InitialPosition = self.InitialPosition
	end
end

-- =============================================================================
function BasicAI:RegisterAI(bForce)

	-- (KEVIN) Don't re-register if already has an AI and not forced
	-- This is so an entity container reused doesn't create a new AI object
	if (not bForce or bForce == false) then
		if (CryAction.HasAI(self.id)) then
			return
		end
	end

	if (self ~= g_localActor) then
		CryAction.RegisterWithAI(self.id, AIOBJECT_ACTOR, self.Properties, self.PropertiesInstance, self.AIMovementAbility,self.melee)
	end
end

-- =============================================================================
function BasicAI:ResetAIParameters(bFromInit, bIsReload)
	--DebugUtils.Log("%s:ResetAIParameters(%s, %s)", self:GetName(), tostring(bFromInit), tostring(bIsReload))
	if ((not bFromInit) or bIsReload) then
		AI.ResetParameters(self.id, bIsReload, self.Properties, self.PropertiesInstance, self.AIMovementAbility, self.melee)
	end
end

-- =============================================================================-
function BasicAI:OnReset(bFromInit, bIsReload)
	if AI then
		-- Reset all properties to editor set values.
		self:ResetAIParameters(bFromInit, bIsReload)

		AI.SetStance(self.id, E_ACTORSTANCE_NORMAL)
	end

	BasicActor.Reset(self, bFromInit, bIsReload)

	if (self.Properties.eiColliderMode) then --WH[TJ]: player spawned as dialogue twin uses Properties table from player.lua, which does not have collider mode; should be default anyway
		self:SetColliderMode(self.Properties.eiColliderMode)
	end

	-- To support spawn at the initial (rather than current) position
	self.InitialPosition = self:GetPos()

	self:CheckShaderParamCallbacks()
end

-- =============================================================================
function BasicAI:OnSpawn(bIsReload)
	-- System.Log("BasicAI.Server:OnSpawn()"..self:GetName())

	-- Register with AI
	self:RegisterAI(not bIsReload)
end

-- =============================================================================
function BasicAI:GetReturnToPoolWeight(isUrgent)

	-- Don't consider me if I'm not dead unless its urgent
	local isDead = self:IsDead()
	if (not isDead and not isUrgent) then
		return 0
	end

	local weight = 0.0

	-- Add large bonus if dead
	if (isDead) then
		weight = weight + 1000.0
	end

	-- Add distance from player
	if (g_localActor) then
		local distance = self:GetDistance(g_localActor.id)
		weight = weight + distance
	end

	return weight

end

-- =============================================================================
function BasicAI.Server:OnInit(bIsReload)
	--DebugUtils.Log("%s.Server:OnInit(%s)", self:GetName(), tostring(bIsReload))

	self:OnReset(true, bIsReload)
	
	BasicActor.ReviveInEditor(self) -- spawned NPCs do not call OnSpawn on BasicActor but on BasicAI -> missing revive in editor
end

-- =============================================================================
function BasicAI:Expose()
	Net.Expose{
		Class = self,
		ClientMethods = {
			ClAIEnable={ RELIABLE_ORDERED, PRE_ATTACH },
			ClAIDisable={ RELIABLE_ORDERED, PRE_ATTACH },
		},
		ServerMethods = {
		},
		ServerProperties = {
		}
	}
end

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(BasicAI, BasicAITable)