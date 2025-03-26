PathfindDebugUtils = {}
PathfindDebugUtils.Data = 
{
	Origin = {},
	Destination = {},
	Speed = "walk", -- walk, run, sprint supported (needs to be casted from string -> enum in subbrain)
}
PathfindDebugUtils.Presets = 
{
	SoulName = "test_pathfollower_dummy",
	SoulSharedGUID = "88bee0ec-f164-4282-ae1e-6576a76b9bac",
}

-- =============================================================================
function PathfindDebugUtils.SaveOriginPos()
	PathfindDebugUtils.Data.Origin.Pos = player:GetPos()
	PathfindDebugUtils.Data.Origin.Rot = player:GetAngles()
	
	PathfindDebugUtils.SpawnOrMoveTagPointToPlayerPos("PathStart")
end

-- =============================================================================
function PathfindDebugUtils.SaveDestinationPos()
	PathfindDebugUtils.Data.Destination.Pos = player:GetPos()
	PathfindDebugUtils.Data.Destination.Rot = player:GetAngles()
	
	PathfindDebugUtils.SpawnOrMoveTagPointToPlayerPos("PathEnd")
end

-- =============================================================================
function PathfindDebugUtils.GenerateSpawnParams()	
	local spawnParams = {}
	spawnParams.ClassName = "NPC"
	spawnParams.Name = PathfindDebugUtils.Presets.SoulName    
	spawnParams.SharedSoulGuid  = PathfindDebugUtils.Presets.SoulSharedGUID
    spawnParams.Properties = {}	
    spawnParams.PercepDestinationrObjectAI = false
    spawnParams.PerceptibleObjectAI = false
	
	return spawnParams
end

-- =============================================================================
function PathfindDebugUtils.SpawnNPC(reversed)	

	-- the NPC uses onUpdate subbrain from haste/test_pathfollower_dummy.xml as their default behaviour

	local spawnParams = PathfindDebugUtils.GenerateSpawnParams()

	local tbl = reversed and PathfindDebugUtils.Data.Destination or PathfindDebugUtils.Data.Origin

	spawnParams.Pos = tbl.Pos
	spawnParams.Rot = tbl.Rot
	
    local entity = XGenAIModule.SpawnEntity(spawnParams)
	
	tbl.entity = entity
	
end

-- =============================================================================
function PathfindDebugUtils.FindDataTable(entityId)	
	
	-- primary npc
	if(entityId == PathfindDebugUtils.Data.Origin.entity) then
		return PathfindDebugUtils.Data.Destination
	end
	
	-- reversed npc
	if(entityId == PathfindDebugUtils.Data.Destination.entity) then
		return PathfindDebugUtils.Data.Origin
	end
	
	-- fallback
	return {
		Pos = player:GetPos(),
		Rot = player:GetAngles()
	};
	
end

-- =============================================================================
function PathfindDebugUtils.SpawnOrMoveTagPointToPlayerPos(tagPointName)
	
	if System.GetEntityByName(tagPointName) == nil then
		System.SpawnEntity({class='TagPointWithScript', name=tagPointName, position='x=0, y=0, z=0'}); 
	end
	
	System.GetEntityByName(tagPointName):SetPos(player:GetPos());
	
end

-- =============================================================================
function PathfindDebugUtils.SetNPCSpeed(speed)
	PathfindDebugUtils.Data.Speed = speed
end

-- =============================================================================
function PathfindDebugUtils.GetNPCSpeed()
	return PathfindDebugUtils.Data.Speed
end