--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2004.

SinglePlayer = {
	tempVec = {x = 0, y = 0, z = 0},

	Client = {},
	Server = {},

	Properties = {
		bSaved_by_game = 0
	},

	-- this table is used to track the available entities where we can spawn the
	-- player
	spawns = {}
}

usableEntityList = {}

-- =============================================================================
function SinglePlayer:OnShoot(shooter)
	if (shooter and shooter.OnShoot) then
		if (not shooter:OnShoot()) then
			return false
		end
	end

	return true
end

-- =============================================================================
function SinglePlayer:IsUsable(obj)

	-- some entities want to be always usable e.g. to show action hint title
	if (obj.ForceUsable and obj:ForceUsable(g_localActor)) then
		return 1
	end

	-- some action is provided by target
	if (obj.GetActions) then
		local actions = obj:GetActions(g_localActor, true)
		if #actions > 0 then
			return 1
		end

		return 0
	end

	-- alternative way
	if (obj.IsUsable) then
		return obj:IsUsable(g_localActor)
	end

	return 0
end

-- =============================================================================
function SinglePlayer:IsUsableByDog(obj)
	-- some action is provided by target
	if (obj.GetDogActions) then
		local actions = obj:GetDogActions(g_localActor, true)
		if #actions > 0 then
			return 1
		end

		return 0
	end

	return 0
end

-- =============================================================================
function SinglePlayer:IsUsableForChat(obj)
	if (obj.GetChatActions) then
		local actions = obj:GetChatActions(g_localActor)
		if #actions > 0 then
			return 1
		end
	end

	return 0
end

-- =============================================================================
function SinglePlayer:AreUsable(source, entities)

	if (entities) then
		for i, entity in ipairs(entities) do
			usableEntityList[i] = entity:IsUsable(source)
		end
	end

	return usableEntityList
end

-- =============================================================================
function SinglePlayer:IsUsableMsgChanged(objId)
	local obj = System.GetEntity(objId)
	if (obj.IsUsableMsgChanged) then
		return obj:IsUsableMsgChanged()
	end

	return 0
end

-- =============================================================================
function SinglePlayer:OnDogUsableMessage(obj)
	if obj.GetDogActions then
		g_localActor.player:AddLuaActions(obj:GetDogActions(g_localActor))
	end

end

-- =============================================================================
function SinglePlayer:OnChatUsableMessage(obj)
	if obj.GetChatActions then
		g_localActor.player:AddLuaActions(obj:GetChatActions(g_localActor))
	end
end

-- =============================================================================
function SinglePlayer:OnUsableMessage(obj)

	if obj.GetActions then
		g_localActor.player:AddLuaActions(obj:GetActions(g_localActor, false))
		return
	end

	-- For backward compatibility but using new interface to C++
	-- Supports only use and hold use
	local msg = ""
	if obj.GetUsableMessage then
		msg = obj:GetUsableMessage(0)
	else
		local state = obj:GetState()
		if state ~= "" then
			state = obj[state]
			if state.GetUsableMessage then
				msg = state.GetUsableMessage(obj, 0)
			end
		end
	end

	-- send normal hint
	local hintEvent = "use"
	if obj.GetUsableEvent then
		hintEvent = obj:GetUsableEvent(0)
	end

	if ((msg ~= "") and obj.IsUsable and obj:IsUsable(g_localActor) > 0) then
		local actions = {}
		AddAction(actions, false, msg, hintEvent, AHT_RELEASE, true, obj.OnUsed)
		g_localActor.player:AddLuaActions(actions)
	end

	-- send hold hint
	local hintEventHold = "use"
	if obj.GetUsableEventHold then
		hintEventHold = obj:GetUsableEventHold(0)
	end

	if (obj.IsUsableHold and obj.GetUsableHoldMessage and obj:IsUsableHold(g_localActor) > 0) then
		msg = obj:GetUsableHoldMessage()

		local actions = {}
		AddAction(actions, false, msg, hintEventHold, AHT_HOLD, true, nil)
		g_localActor.player:AddLuaActions(actions)
	end
end

-- =============================================================================
function SinglePlayer:EndLevel(params)
	if (not System.IsEditor()) then
		if (not params.nextlevel) then
			Game.PauseGame(true)
			Game.ShowMainMenu()
		end
		g_GameTokenPreviousLevel = GameToken.GetToken("Game.Global.Previous_Level")
	end
end

-- =============================================================================
function SinglePlayer:CreateHit(targetId, shooterId, weaponId, dmg, radius, material, partId, type, pos, dir, normal)
	if (not radius) then
		radius = 0
	end

	local materialId = 0

	if (material) then
		materialId = self.game:GetHitMaterialId(material)
	end

	if (not partId) then
		partId = -1
	end

	local typeId = 0
	if (type) then
		typeId = self.game:GetHitTypeId(type)
	else
		typeId = self.game:GetHitTypeId("normal")
	end

	self.game:ServerHit(targetId, shooterId, weaponId, dmg, radius, materialId, partId, typeId, pos, dir, normal)
end

-- =============================================================================
function SinglePlayer:ClientViewShake(pos, distance, radiusMin, radiusMax, amount, duration, frequency, source, rnd)
	if (g_localActor and g_localActor.actor) then
		if (distance) then
			self:ViewShake(g_localActor, distance, radiusMin, radiusMax, amount, duration, frequency, source, rnd)
			return
		end
		if (pos) then
			local delta = self.tempVec
			VectorUtils.Copy(delta, pos)
			delta = VectorUtils.Subtract(delta, g_localActor:GetWorldPos())
			local dist = VectorUtils.Length(delta)
			self:ViewShake(g_localActor, dist, radiusMin, radiusMax, amount, duration, frequency, source, rnd)
			return
		end
	end
end

-- =============================================================================
function SinglePlayer:ViewShake(player, distance, radiusMin, radiusMax, amount, duration, frequency, source, rnd)
	local deltaDist = radiusMax - distance
	rnd = rnd or 0.0
	if (deltaDist > 0.0) then
		local r = math.min(1, deltaDist / (radiusMax - radiusMin))
		local amt = amount * r
		local halfDur = duration * 0.5
		player.actor:SetViewShake({x = 2 * g_Deg2Rad * amt, y = 2 * g_Deg2Rad * amt, z = 2 * g_Deg2Rad * amt}, {x = 0.02 * amt, y = 0.02 * amt, z = 0.02 * amt}, halfDur + halfDur * r, 1 / 20, rnd)
	end
end

-- =============================================================================
function SinglePlayer.Server:OnClientConnect(channelId, className)
	local params = {
		name = "Dude",
		class = "Player",
		position = {x = 0, y = 0, z = 0},
		rotation = {x = 0, y = 0, z = 0},
		scale = {x = 1, y = 1, z = 1}
	}

	-- use override class name if given
	if (className ~= nil and className ~= '') then
		params.class = className
	end

	player = Actor.CreateActor(channelId, params)

	if (not player) then
		DebugUtils.Log("OnClientConnect: Failed to spawn the player!")
		return
	end

	local spawnId = self.game:GetFirstSpawnLocation(0)
	if (spawnId) then
		local spawn = System.GetEntity(spawnId)
		if (spawn) then
			-- set pos
			player:SetWorldPos(spawn:GetWorldPos(g_Vectors.temp_v1))
			-- set angles
			spawn:GetAngles(g_Vectors.temp_v1)
			g_Vectors.temp_v1.x = 0
			g_Vectors.temp_v1.y = 0
			player.actor:PlayerSetViewAngles(g_Vectors.temp_v1)
			spawn:Spawned(player)

			return
		end
	end

	System.Log("$1warning: No spawn points; using default spawn location!")
end

-- =============================================================================
function SinglePlayer.Server:OnStartLevel()
	CryAction.SendGameplayEvent(NULL_ENTITY, eGE_GameStarted)
	if (g_GameTokenPreviousLevel) then
		GameToken.SetToken("Game.Global.Previous_Level", g_GameTokenPreviousLevel)
		g_GameTokenPreviousLevel = nil
	end
end

-- =============================================================================
function SinglePlayer.Client:OnHit(hit)
	local trg = hit.target

	-- send hit to target
	if (trg and trg.Client and trg.Client.OnHit) then
		trg.Client.OnHit(trg, hit)
	end
end
