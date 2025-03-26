-- Created by Marco C. May 2013

RuntimePrefab = {
	type = "RuntimePrefab",

	Properties = {
		guidPrefabTemplate = "0",
		nMaxSpawn = 0,
	},

	-- editor information
	Editor = {
		Icon = "RuntimePrefab.bmp",
		ShowBounds = 1,
	},
}

-- =============================================================================
function RuntimePrefab:OnInit()
	--System.Log( "RuntimePrefab:OnInit" )
	local isLoading = Game.IsLoadingEngineSaveGame()
	if isLoading then
		self:CreateOnLoad()
	else
		self:Reset()
	end
end

-- =============================================================================
function RuntimePrefab:OnPropertyChange()
	--System.Log( "RuntimePrefab:OnPropertyChange" )
	self:Reset()
end

-- =============================================================================
function RuntimePrefab:OnDestroy( sender )
	--System.Log( "RuntimePrefab:OnDestroy" )
	Game.DeletePrefab(self.id)
end

-- =============================================================================
function RuntimePrefab:OnMove()
	--System.Log( "RuntimePrefab:OnMove" )
	Game.MovePrefab(self.id)
end

-- =============================================================================
function RuntimePrefab:OnSpawn()

	if (CryAction.IsClient()) then
		--System.Log( "CLIENT" )
		self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
	end

	if (CryAction.IsServer()) then
		--System.Log( "SERVER" )
		self:SetFlags(ENTITY_FLAG_SERVER_ONLY,0)
	end
end

-- =============================================================================
function RuntimePrefab:Spawn()
	--System.Log( "RuntimePrefab:Spawn" )

	local props=self.Properties
	if(not string.IsEmpty(props.guidPrefabTemplate)) then
		--System.Log( "PrefabName="..props.guidPrefabTemplate )
		Game.SpawnPrefab(self.id,props.guidPrefabTemplate,props.nMaxSpawn)
	end
end

-- =============================================================================
function RuntimePrefab:CreateOnLoad()

	local props=self.Properties
	if(not string.IsEmpty(props.ObjectVariation.sPrefabVariation)) then
		-- only create the prefab without spawning its contents, they will get loaded
		Game.CreatePrefab(self.id,props.guidPrefabTemplate,props.nMaxSpawn)
	end
end

-- =============================================================================
function RuntimePrefab:Reset()
	--System.Log( "RuntimePrefab:Reset" )

	Game.DeletePrefab(self.id)
	self:Spawn()
end

-- =============================================================================
function RuntimePrefab:OnHidden()
	Game.HidePrefab(self.id,true)
end

-- =============================================================================
function RuntimePrefab:OnUnHidden()
	Game.HidePrefab(self.id,false)
end

-- =============================================================================
function RuntimePrefab:OnReset( sender )
	--System.Log( "RuntimePrefab:OnReset" )
	if (System.IsEditor()) then
		-- change prefabs only if we are editing (and the user pressed reload script),
		-- do not change every time we go in and out of game mode...
		-- unless we are in game mode generation
		local clientgamemode=0; --System.GetCVar("g_GameModeGenerate")

		--if (System.IsEditing() or clientgamemode==1) then
		--	self:Reset()

		--end

		-- Backup solution - reload runtime prefabs when game->editor
		self:Reset()
	end
	--System.Log( "OnReset done" )
end
