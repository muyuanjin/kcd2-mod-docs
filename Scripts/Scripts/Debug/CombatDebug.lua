-- help functions for combat testing and  debugging
-- used mainly in combat_automaton* levels


-- #Script.ReloadScript("Scripts\\Debug\\CombatDebug.lua")

CombatDebug = {}

--WH_NOMASTER_START

CombatDebug.IDPlayer = 0
CombatDebug.IDEnemy = 0
CombatDebug.PlayerProfile = 0 -- for combat preset
CombatDebug.EnemyProfile = 0
CombatDebug.PlayerArmor = 0
CombatDebug.PlayerWeapon = 0
CombatDebug.EnemyArmor = 0
CombatDebug.EnemyWeapon = 0

-- =============================================================================


-- =============================================================================
-- syntax: CombatDebug.DebugSwitchWeapons(player, "longsword")
-- syntax: CombatDebug.DebugSwitchWeapons(player, "shortsword", "shield")
-- syntax: CombatDebug.DebugSwitchWeapons(player, "longsword", "bow")
-- syntax: CombatDebug.DebugSwitchWeapons(player, "bow")
-- OBSOLETE
function CombatDebug.DebugSwitchWeapons(who, w1, w2)

	-- OBSOLETE
	local weapons = {
		"5", -- longsword
		"9e085476-0be7-426a-be01-ed5e114bd348", -- shortsword
		"50bc472b-9f00-415f-bcab-2f1ad88f0079", -- shield
		"fb7c6380-d4e5-4ab6-afe1-843ad80c5fbc", -- axe
		"6e06e314-5cc0-41eb-a7b6-69896b121413", -- bow
		"ad6f0f01-aec4-44d1-982c-1210eb01b74a", -- arrows
		"405c1865-413d-43b8-8db9-c44a0eefd350", -- halberd
		"4cea28a0-0814-405a-bf24-4fd711f7eb63" -- torch
	}
	-- will not resolve other stuff

	-- new: use weapon preset

	local weaps = {}

	weaps.longsword = "417eafa6-cbbe-58d9-d1ef-f907612dbda4"
	weaps.bow = "49508979-7914-cbb5-e560-4a2d17994691" -- only bow
	weaps.halberd = "402e07c7-a8f1-6633-5ae7-7122ecfd50a0"
	weaps.unarmed = "10101010-c8cb-81dd-40f1-2f0554804f83"
	weaps.torch = "4e3c8dcf-77a1-ba32-1b51-610e5f2a9182"

	if w2 == "shield" then
		weaps.shortsword = "44c6abd2-9dc0-fe11-1454-c9863b1aa8bd"
		weaps.axe = "472c00b7-ce79-139d-2f26-0e1e392625a4"
		weaps.mace = "4c98959a-39f8-8433-cda7-1addc84f3cb6"
	else
		weaps.shortsword = "4840279e-cdb3-1490-d494-fd1474b39585"
		weaps.axe = "4932db0d-29c5-3c9e-4379-eb826ea3e59e"
		weaps.mace = "4af6ffc9-63bc-3568-5c59-fe3186bc19a0"
	end

	-- who.inventory:RemoveAllItems()
	-- who.actor:EquipClothingPreset(pres)

	if weaps[w1] ~= nil then
		who.actor:EquipWeaponPreset(weaps[w1])
	end

	-- bow added separately
	if w2 == "bow" then
		-- bow and arrows
		w1 = ItemManager.CreateItem("6e06e314-5cc0-41eb-a7b6-69896b121413", 1, 1)
		who.inventory:AddItem(w1)
		who.actor:EquipInventoryItem(w1)

		w1 = ItemManager.CreateItem("278d26d1-e9a7-4354-84f9-37d20cb72b45", 1, 30)
		who.inventory:AddItem(w1)
		who.actor:EquipInventoryItem(w1)
	end

	who.human:DrawWeapon()

end

-- =============================================================================
-- pressing the action key in combat automaton
-- OBSOLETE
function CombatDebug.DebugSkillKey(what)
	local who, a

	local en = "TargetDummy" .. (Variables.GetGlobal("GAutomatonMain") + 1)

	if Variables.GetGlobal("gFightPlayer") == 1 then
		who = player
	else
		who = System.GetEntityByName(en)
	end
	-- now what we do
	if what == "change" then -- change player
		local now
		if who == player then
			a = 0
			now = System.GetEntityByName(en)
		else
			a = 1
			now = player
		end
		Variables.SetGlobal("gFightPlayer", a)
		CombatDebug.RefreshGVars(now)

	elseif what == "weapon" then -- switch weapons for active character
		local wa, gvr
		if who == player then
			gvr = "gFightWeapP"
		else
			gvr = "gFightWeapO"
		end

		wa = Variables.GetGlobal(gvr)
		wa = wa + 1
		if wa > 7 then wa = 0 end

		Variables.SetGlobal(gvr, wa)

		CombatDebug.GetWeapons(who)
		CombatDebug.RefreshGVars(who)

		if wa == 0 then
			who.human:ToggleWeaponSet(0)
		end

	elseif what == "armor" then -- switch armor
		if who == player then
			CombatDebug.PlayerArmor = CombatDebug.PlayerArmor + 1
			if CombatDebug.PlayerArmor > 3 then CombatDebug.PlayerArmor = 0	end
			CombatDebug.SetArmorProfile(who, CombatDebug.PlayerArmor)
		else
			CombatDebug.EnemyArmor = CombatDebug.EnemyArmor + 1
			if CombatDebug.EnemyArmor > 3 then CombatDebug.EnemyArmor = 0 end
			CombatDebug.SetArmorProfile(who, CombatDebug.EnemyArmor)
		end

	-- deprecated
	elseif what == "cat" then -- change category
		a = Variables.GetGlobal("gFightSetting")
		a = a + 1
		if a > 2 then a = 0 end
		Variables.SetGlobal("gFightSetting", a)

	elseif what == "up" or what == "down" then -- increment / decrement
		local skill, gvar, dir, a
		if what == "up" then dir = 2 else dir = -2 end
		a = Variables.GetGlobal("gFightSetting")
		if a == 0 then -- defense
			skill = "defense"
			gvar = "gFighterDefense"
			Variables.SetGlobal(gvar, CombatDebug.AddSkill(who, skill, dir))
		elseif a == 1 then -- weapon
			-- get and set weapons
			local wa
			if who == player then
				wa = Variables.GetGlobal("gFightWeapP")
			else
				wa = Variables.GetGlobal("gFightWeapO")
			end

			if wa == 2 then
				skill = "heavy_weapons"
			else
				skill = "weapon_sword"
			end
			gvar = "gFighterWeapon"
			Variables.SetGlobal(gvar, CombatDebug.AddSkill(who, skill, dir))
		elseif a == 2 then -- agility
			skill = "agility"
			gvar = "gFighterAgi"
			Variables.SetGlobal(gvar, CombatDebug.AddStat(who, skill, dir))
		end
		CombatDebug.RefreshGVars(who)
	-- end of deprecated

	elseif what == "heal" then -- heal us!
		player.soul:AddBuff("f29ee947-a131-4597-8ed7-6f06aca0a4a2")
		System.GetEntityByName(en).soul:AddBuff("f29ee947-a131-4597-8ed7-6f06aca0a4a2")

	elseif what == "profile" then -- changing combat profile
		local prof
		if who == player then
			CombatDebug.PlayerProfile = CombatDebug.PlayerProfile + 1
			if CombatDebug.PlayerProfile > 5 then CombatDebug.PlayerProfile = 0 end
			prof = CombatDebug.PlayerProfile
		else
			CombatDebug.EnemyProfile = CombatDebug.EnemyProfile + 1
			if CombatDebug.EnemyProfile > 5 then CombatDebug.EnemyProfile = 0 end
			prof = CombatDebug.EnemyProfile
		end
		-- setting up a profile
		Variables.SetGlobal("gFighterProfile", prof)
		CombatDebug.SetSkillProfile(who, prof)
		CombatDebug.RefreshGVars(who)

	elseif what == "tough" then -- buff us!
		a = Variables.GetGlobal("gFightTough")
		if a == 0 then
			bfIDPlayer = player.soul:AddBuff("7ead0083-026d-4567-80b3-68ac82693b77")
			bfIDEnemy = System.GetEntityByName(en).soul:AddBuff("7ead0083-026d-4567-80b3-68ac82693b77")
			Variables.SetGlobal("gFightTough", 1)
		else
			player.soul:RemoveBuff(bfIDPlayer)
			System.GetEntityByName(en).soul:RemoveBuff(bfIDEnemy)
			Variables.SetGlobal("gFightTough", 0)
		end

	end

end

-- =============================================================================
-- Setting a profile with skills and perks -- used by SpawnEnemy -- even in KCD2 version
function CombatDebug.SetSkillProfile(who, prof)
	local strength, agility, vitality, wpn, def;

	-- sword, heavy, archery, large, unarmed
	local tbl = {} -- tabulka skillu
	local skills = {'sword', 'heavy', 'archery', 'large', 'unarmed'}

	if who ~= player then
		--CombatDebug.RemoveAllCombatPerks(who) -- not needed any more
	end

	if prof == 1 then -- noob
		strength, agility, vitality = 2, 2, 2
		wpn = 1
		def = 1
		-- tbl["archery"] = 8    -- specifically modified skill; if not, wpn value is used
	elseif prof == 2 then -- some skillz
		strength, agility, vitality = 8, 8, 8
		wpn = 8
		def = 8
		CombatDebug.AddCombatPerks(who, 'basic')
	elseif prof == 3 then -- semipro
		strength, agility, vitality = 15, 15, 15
		wpn = 15
		def = 15
		CombatDebug.AddCombatPerks(who, 'basic')
		CombatDebug.AddCombatPerks(who, 'advanced')
	elseif prof == 4 then -- very good
		strength, agility, vitality = 22, 22, 22
		wpn = 22
		def = 22
		CombatDebug.AddAllCombatPerks(who)
		CombatDebug.AddCombatPerks(who, 'specialripo')
	elseif prof == 5 then -- pro
		strength, agility, vitality = 30, 30, 30
		wpn = 30
		def = 30
		CombatDebug.AddCombatPerks(who, 'specialripo')
		CombatDebug.AddAllCombatPerks(who)
	elseif prof == 6 then -- defensive -- not available now
		strength = 10
		agility = 15
		vitality = 15
		wpn = 4
		def = 18
		--CombatDebug.AddCombatPerks(who, 'basic')
		--CombatDebug.AddCombatPerks(who, 'advanced')
		--CombatDebug.AddCombatPerks(who, 'specialripo')
	else -- aggro
		strength = 14
		agility = 8
		vitality = 12
		wpn = 18
		def = 4
		--CombatDebug.AddCombatPerks(who, 'basic')
		--CombatDebug.AddCombatPerks(who, 'advanced')
		--CombatDebug.AddCombatPerks(who, 'combo LS')
		--CombatDebug.AddCombatPerks(who, 'combo Shield')
		--CombatDebug.AddCombatPerks(who, 'combo Short')
	end

	-- if not explicitly said, all weapon skills come from weap variable
	for v in ipairs(skills) do
		if tbl[skills[v]] == nil then tbl[skills[v]] = wpn end
	end

	who.soul:SetStatLevelDebug("agility", agility)
	who.soul:SetStatLevelDebug("strength", strength)
	who.soul:SetStatLevelDebug("vitality", vitality)
	who.soul:SetSkillLevelDebug("weapon_sword", tbl["sword"])
	who.soul:SetSkillLevelDebug("heavy_weapons", tbl["heavy"])
	who.soul:SetSkillLevelDebug("marksmanship", tbl["archery"])
	who.soul:SetSkillLevelDebug("weapon_large", tbl["large"])
	who.soul:SetSkillLevelDebug("weapon_unarmed", tbl["unarmed"])
	who.soul:SetSkillLevelDebug("defense", def)

	-- new: need to set vision and hearing
	who.soul:SetStatLevelDebug("vision", 20)
	who.soul:SetStatLevelDebug("hearing", 20)

end

-- =============================================================================
-- SetArmorProfile: 0=default, 1-3=light, mid, heavy
-- OBSOLETE
function CombatDebug.SetArmorProfile(who, what)
	local figurina = nil
	local tx

	if what == 1 then -- lehke
		figurina = System.GetEntityByName("armorPresetLight")
	elseif what == 2 then -- stredni
		figurina = System.GetEntityByName("armorPresetMedium")
	elseif what == 3 then -- tezke
		figurina = System.GetEntityByName("armorPresetHeavy")
	end

	if figurina ~= nil then
		who.actor:EquipClothingPreset(figurina.actor:GetInitialClothingPreset())
	else
		-- initial!
		if who == player then
			who.actor:EquipClothingPreset(System.GetEntityByName("playerPresetDefault").actor:GetInitialClothingPreset())
		else
			local pres = who.actor:GetInitialClothingPreset()
			who.actor:EquipClothingPreset(pres)
		end
	end
end

-- =============================================================================
-- make all SpawnedEnemy / Friend tough or take the buff off
function CombatDebug.MakeSpawnedTough(tough)
	
	-- SpawnedEnemy_001 // SpawnedFriend_001
	local effect = ""
	if tough then
		effect = " hlh*0.01,edm*0.01" -- edm is for slower breaking weapon
	else
		effect = " hlh*1,edm*1"
	end

	for num = 1,100 do
		--local who = "SpawnedEnemy_" .. string.format("%03d", num)
		
		for _,who in ipairs{"SpawnedEnemy_" .. string.format("%03d", num), "SpawnedFriend_" .. string.format("%03d", num)} do
		
			if System.GetEntityByName(who) ~= nil then

				--Dump("found: "..num)
				System.ExecuteCommand("wh_rpg_AddBuffDebug " .. who .. effect)	

			end
		end
	end

	--System.ExecuteCommand("wh_rpg_AddBuffDebug " .. nm .. " hlh*0.01,edm*0.01")

end

-- =============================================================================
-- last argument set on true means removing perks
function CombatDebug.AddCombatPerks(who, what, removePerks)
	local combatperks = {}

	table.insert(combatperks, {'d2da2217-d46d-4cdb-accb-4ff860a3d83e', 'basic'}) -- PERFECT BLOCK
	table.insert(combatperks, {'ec4c5274-50e3-4bbf-9220-823b080647c4', 'basic'}) -- RIPOSTE
	table.insert(combatperks, {'7c804de3-ed00-4cd3-aa99-4220a66c7036', 'advanced'}) -- DODGE
	table.insert(combatperks, {'47709bf7-3bd8-493f-aca3-05b005f166d8', 'advanced'}) -- FEINT

	-- combos Long Sword -- updated for KCD2
	table.insert(combatperks, {'2482ca95-50f3-4a58-b52c-5ce11c86464a', 'combo LS'})
	table.insert(combatperks, {'459b4242-5225-484d-8245-40d84fa85c91', 'combo LS'})
	table.insert(combatperks, {'4675152d-a104-4a07-bdd5-1299339f44e5', 'combo LS'})
	table.insert(combatperks, {'909e2aa4-b6b4-4ccc-97b3-2b38fb5e5e74', 'combo LS'})
	table.insert(combatperks, {'a16d865f-507c-44c2-a870-6294495576bf', 'combo LS'})
	table.insert(combatperks, {'af57c258-c714-4d32-9883-2193c6af8184', 'combo LS'})
	table.insert(combatperks, {'dcd735c3-0e22-4fdd-b6a9-97499d2fb461', 'combo LS'})
	table.insert(combatperks, {'dfc3139d-f783-4465-9555-5311bb691d77', 'combo LS'})
	table.insert(combatperks, {'e966c6b5-db69-4680-bb9c-441d7ee761a3', 'combo LS'})
	table.insert(combatperks, {'f1391b7f-2d96-4415-9789-aae4669a7a8d', 'combo LS'})

	-- combos shorstsword
	table.insert(combatperks, {'05425c4c-16af-47d1-8fbf-a0d74a0b5c36', 'combo SHSW'})
	table.insert(combatperks, {'21a87571-93f8-44c5-b1ad-a8b9946e3904', 'combo SHSW'})
	table.insert(combatperks, {'25403625-7c0b-4476-ae71-410a3be88d60', 'combo SHSW'})
	table.insert(combatperks, {'316cd845-eb2a-4aa2-b746-a1d919200b43', 'combo SHSW'})
	table.insert(combatperks, {'547edd64-219e-4240-9257-cf406cdbe8b3', 'combo SHSW'})	
	table.insert(combatperks, {'5e645502-903b-44e3-bb8a-96290d4fac22', 'combo SHSW'})	
	table.insert(combatperks, {'a10204e3-5e34-4030-a2f3-a31ff3054471', 'combo SHSW'})	
	table.insert(combatperks, {'b578e5b0-ef24-41ee-98d4-3cdf847df04f', 'combo SHSW'})	
	table.insert(combatperks, {'decfdab9-3422-4d31-b54c-e4a51aa36af5', 'combo SHSW'})	
	
	-- combos short+shield
	table.insert(combatperks, {'04c2833f-a9e5-4b89-95a5-4ea32bcae12f', 'combo SSLD'})
	table.insert(combatperks, {'19b028c2-5750-4ab6-bf91-f16bb2ed6f3b', 'combo SSLD'})
	table.insert(combatperks, {'4a16d632-4ec7-4357-95ea-b0af663f2e17', 'combo SSLD'})
	table.insert(combatperks, {'602a92b9-c44b-4edf-980a-756cddbc78b9', 'combo SSLD'})
	table.insert(combatperks, {'da7adcc1-13b2-4aff-9da3-3ada0e585504', 'combo SSLD'})
	table.insert(combatperks, {'f5b46efe-8b68-41f1-94e4-9ecf9893223b', 'combo SSLD'})
	table.insert(combatperks, {'f809063a-d1e6-452e-8319-f5678a936568', 'combo SSLD'})

	-- combos heavy weapons (blunt)
	table.insert(combatperks, {'12c11e0d-dd87-41ee-9e02-43a96e13a71c', 'combo heavy'})	
	table.insert(combatperks, {'226d8009-a0da-4b2b-8a90-62ce709a1eae', 'combo heavy'})	
	table.insert(combatperks, {'4ce6ceda-03b8-4448-98a7-abdbd41e3ea3', 'combo heavy'})	
	table.insert(combatperks, {'c2507281-6300-4b5b-8528-6631968c4791', 'combo heavy'})	
	table.insert(combatperks, {'e7b38b92-a552-489b-ac28-f623278f638d', 'combo heavy'})	
	table.insert(combatperks, {'f5e64098-afda-45ec-8b7f-f8009773ad7a', 'combo heavy'})	

	-- combos heavy+shield (blunt+shield)
	table.insert(combatperks, {'16cc1b40-d9a6-4f6e-ab05-c4696853ed76', 'combo heavyshld'})
	table.insert(combatperks, {'17cf1cf8-278e-4b31-af19-a7804ea5f65e', 'combo heavyshld'})
	table.insert(combatperks, {'3386aba6-5325-4ee5-a7c5-87fcef473af6', 'combo heavyshld'})
	table.insert(combatperks, {'3ab6a961-022f-47bd-bb05-981ab2a7fa8e', 'combo heavyshld'})
	table.insert(combatperks, {'8964d9b0-bd61-4d5b-8453-f02e6eabbe3c', 'combo heavyshld'})
	table.insert(combatperks, {'8ff575a1-4534-49b7-99d1-4aec54bbdfdc', 'combo heavyshld'})
	table.insert(combatperks, {'c6c2e508-5d38-46de-ad21-1fc794fd86c2', 'combo heavyshld'})
	
	-- combos halberd (large weapons)
	table.insert(combatperks, {'9780ac36-f75e-448f-8165-0e882f6ce0ad', 'combo hlbrd'})
	table.insert(combatperks, {'a39a4d76-ea8c-4c5a-bcf2-1a45216d0072', 'combo hlbrd'})
	table.insert(combatperks, {'e300e732-8fdc-4810-aad0-7ffc68b297e9', 'combo hlbrd'})
	table.insert(combatperks, {'f3764568-1c4c-446f-b1a9-2c9348b1077e', 'combo hlbrd'})

	-- combos unarmed
	table.insert(combatperks, {'03d70183-216b-428f-9f8c-e9b76882acdd', 'combo unrmd'})
	table.insert(combatperks, {'065e82a4-2339-40bc-82ca-3ad76a6ae762', 'combo unrmd'})
	table.insert(combatperks, {'08193537-25c5-41dc-b819-a61d1662c401', 'combo unrmd'})
	table.insert(combatperks, {'29904729-cd69-498a-bdfc-0fb1c69aed44', 'combo unrmd'})
	table.insert(combatperks, {'866c5520-1eeb-4f15-b611-d21ef7792d90', 'combo unrmd'})
	table.insert(combatperks, {'8a9d7b1b-a500-448c-a4f0-0b294b1d1e49', 'combo unrmd'})
	table.insert(combatperks, {'f0f8f7cc-0b18-415c-a143-22d433360ccf', 'combo unrmd'})
	
	-- masterstrike
	table.insert(combatperks, {'2993585c-40c9-42e3-ac45-b837f3bc50f7', 'specialripo'})

	for ind, perk in ipairs(combatperks) do
		local perkType = perk[2]
		local perkGuid = perk[1]

		if perkType == what then

			if removePerks ~= nil then
				who.soul:RemovePerk(perkGuid)
			else
				who.soul:AddPerk(perkGuid)
			end

		end

	end

end

-- =============================================================================
function CombatDebug.dbgSetV6(howmuch)
	return howmuch, howmuch, howmuch, howmuch, howmuch, howmuch
end

-- =============================================================================
-- used by SpawnFighters
-- used by KCD2 haste (rpg -- hardcore etc. henry)

function CombatDebug.AddAllCombatPerks(who)
	CombatDebug.AddCombatPerks(who, 'basic')
	CombatDebug.AddCombatPerks(who, 'advanced')
	CombatDebug.AddCombatPerks(who, 'combo LS')
	CombatDebug.AddCombatPerks(who, 'combo SHSW')
	CombatDebug.AddCombatPerks(who, 'combo SSLD')
	CombatDebug.AddCombatPerks(who, 'combo heavy')
	CombatDebug.AddCombatPerks(who, 'combo heavyshld')
	CombatDebug.AddCombatPerks(who, 'combo hlbrd')
	CombatDebug.AddCombatPerks(who, 'combo unrmd')
	CombatDebug.AddCombatPerks(who, 'specialripo')
end

-- =============================================================================
function CombatDebug.RemoveAllCombatPerks(who)
	CombatDebug.AddCombatPerks(who, 'basic', true)
	CombatDebug.AddCombatPerks(who, 'advanced', true)
	CombatDebug.AddCombatPerks(who, 'combo LS', true)
	CombatDebug.AddCombatPerks(who, 'combo SHSW', true)
	CombatDebug.AddCombatPerks(who, 'combo SSLD', true)
	CombatDebug.AddCombatPerks(who, 'combo heavy', true)
	CombatDebug.AddCombatPerks(who, 'combo heavyshld', true)
	CombatDebug.AddCombatPerks(who, 'combo hlbrd', true)
	CombatDebug.AddCombatPerks(who, 'combo unrmd', true)
	CombatDebug.AddCombatPerks(who, 'specialripo', true)
end

-- =============================================================================
function CombatDebug.SetHardcoreCVars()
	System.SetCVar("wh_cs_timewarpduration", 0.0012)
	System.SetCVar("wh_cs_TimeWarpFadeIn", 0.014)
	System.SetCVar("wh_cs_TimeWarpFadeOut", 0.09)
	System.SetCVar("wh_cs_TimeWarpPBFadeSpeedForPlayer", 0.9)
	System.SetCVar("wh_cs_TimeWarpPBFadeSpeedForOpp", 0.9)
	System.SetCVar("wh_cs_TimeWarpDodgeFadeSpeedForPlayer", 0.75)
	System.SetCVar("wh_cs_TimeWarpDodgeFadeSpeedForOpp", 0.84)
end

-- =============================================================================
-- add skill, returns current value
-- call: #CombatDebug.AddSkill(player, "fencing", 5) -- adds 5 to fencing
function CombatDebug.AddSkill(who, skillName, num)
	local current = who.soul:GetSkillLevel(skillName)
	if (num + current) < 0 then
		current = 0
	else
		current = current + num
	end
	who.soul:SetSkillLevelDebug(skillName, current)
	return current
end

-- =============================================================================
-- add stat, returns current value
-- call: #CombatDebug.AddStat(player, "agility", 5) -- adds 5 to agility
function CombatDebug.AddStat(who, statName, num)
	local current = who.soul:GetStatLevel(statName)
	if (num + current) < 0 then
		current = 0
	else
		current = current + num
	end
	who.soul:SetStatLevelDebug(statName, current)
	return current
end

-- =============================================================================
-- enemy spawner for debug / testing purposes
function CombatDebug.SpawnFighters(enemy, tbl) -- num, enemyType, enemyLevel, weapon, range, direction)

	--Dump(tbl)

	local spawnedBandits =
	{ -- KCD2-265909
		"d2a3c045-2d43-491c-80a4-96137fcb99de",
		"b3037b98-cae4-47c8-9583-c21a92883f09",
		"584f681c-2f90-4ef2-b1de-470282a7993d"
		--"450fb1d9-a72e-51df-61af-d2a0772253ae",	-- test ZZ 22/01/2021
		--"4abf612d-3218-770f-5f9b-379e79e728b3",
		--"450fb1d9-a72e-51df-61af-d2a0772253ae",
		--"450fb1d9-a72e-51df-61af-d2a0772253ae"
	}

	local spawnedCumans =
	{ -- KCD2-265909
		"20eb21a4-21ba-4530-bcac-3af448cb1810"
		--"4bf7849c-001b-9cfd-bb0e-db63fe5d07be", -- test ZZ 22/01/2021
		--"47f6fcf7-bdf1-1197-9598-d93d749deea2",
		--"42377010-bb52-b08a-dde0-b4e3dc5044a5"
	}

	-- soldiers from Rattay
	local spawnedFriends =
	{ -- KCD2-265909
		"61cbb0a5-922d-4eb0-b0d9-6cfdf00807ee",
		"5977088c-fca3-4a3a-9eb8-be8006d17381",
		"c60c97b7-f46b-4fc4-b304-ed26bbdb6127"
	
		-- old version KCD2-67415
		--"4dafd3ca-13ad-d7c0-cbdf-6ec9ca14258a",
		--"4409fc91-8348-ef5c-163c-c5499b867cae",
		--"483a0228-599a-305b-2661-1d72b76f44b2"
	}

	local armorsBandits =
	{ -- armors taken July 21, 2023
		["light"] =
		{
			-- TODO used from DB, would be better to create special presets?
			-- soldier_generic
			"928e783a-32e3-4512-84f4-128bf42251bd",
			"74d5bd43-a63b-426d-a1b5-3663d3355eea",
			"3d21d8d3-6d74-4f73-93ec-c181a620d450",
			"fca2a301-45e5-4cd9-af18-09469bbd8102" -- cuman 2 04
			
			--"f708cb4a-1d9b-4a5a-9dcc-24ce7eb3f9ae",
			--"92fbdd03-50ea-4c72-a460-2a537bc689da"
			--"97915c8a-d022-4d1f-8674-fe2e3c55d649", -- test ZZ 22/01/2021
			--"46036946-052a-255b-6d2f-22cec99bd39c",
			--"4911149b-495d-0f9f-8c30-85c4526a439b"
		},
		["medium"] =
		{
			-- soldier generic 3
			"1deb1422-9138-44de-9828-ffa3ac96341a",
			"6a515886-bb99-4235-bdee-db57abe0e654",
			"f4160fef-c3fe-4e6d-a8f5-17a177716337", -- nebak 3 2
			"66b6fc88-d09a-4152-a74f-28d4263cdfdf" -- semin 3 2
			
		},
		["heavy"] =
		{
			-- generic 5
			"65c20d96-1fce-48c5-9d2f-654634222106",
			"0f5e458e-1a8b-4477-8a02-8e11d96fe371",
			"53ae8a20-ee5b-4a3e-b351-541e1d17cc6a",
			"b2c6416e-8688-4d71-be97-80614d29e4be"
		}
	}

	local armorsCumans = armorsBandits
	-- {
		-- -- TODO: clothing presets not ready yet
		-- ["light"] =
		-- {
		-- "4e4613e5-9390-dd24-07db-4f9af72c949f",
		-- "44a78c3b-d535-bc8d-fd38-508ff0cfb3a0",
		-- "4c149913-4be1-b7ee-fda0-7d681fab45a3"
		-- },
		-- ["medium"] =
		-- {
		-- "4a9919f0-b277-aa0d-db22-9edf42cdeaa9",
		-- "4e0ddb85-a021-5ee1-7b97-6b42cd66e982",
		-- "4f7b9bc0-cd7e-7126-5247-4b66e44ee0b8"
		-- },
		-- ["heavy"] =
		-- {
		-- "4cfb32d6-54d4-b168-5d12-5a675af1dfb9",
		-- "41a16ff9-0b42-297e-436c-b751d5737f89",
		-- "459a8305-1035-7288-cc67-71d32dbc81b4"
		-- }
	-- }

	local armorsFriends =
	{
		["light"] =
		{ -- soldier_liepa_2
		  "279bf58e-8394-4306-b80b-c99145b147aa",
		  "e09441c6-e9b9-463e-be4e-4c80acf233c7",
		  "70aab62e-b4e3-4ab4-a982-cb8efb214337", -- soldier_generic_1_08
		  "1616eeaa-06fd-465a-b433-4e987a9d9efc" -- khTournament_light_03
		  
		  --"2b7a5194-9bec-4059-8fc7-f8d148e697c6",
		  --"b6135af2-0b95-4b08-af3a-c7a51600d915"
		},
		["medium"] =
		{
		  "fd1f3c9e-ca9a-4775-b149-6b624b8d9256", -- taboryUCesty_archery_cumplech
		  "65eae61d-b819-4104-9dd5-cb9fbf3215f8", -- soldier_liepa_3
		  "e824bdf5-43d8-4e16-b0e4-9bf9b51c8d1d",
		  "e4a42bb4-81c0-4f17-9120-f9cb248b17c6"
		  
		  --"3ac4b51f-5aa4-4076-b476-26a43da75a7b",
		  --"63a559da-b3a6-4f24-9ffc-2788e05295ca"
		  --"4e1f60eb-7c8f-0ea4-8879-e71f0fca97b9"
		},
		["heavy"] =
		{ 
		  --"fdb7279e-f270-4983-a056-d202e5ebf210", -- soldier_generic_5
		  -- soldier bergov 5
		  "5a9c81da-e69f-42c3-8dc5-437ccbf237fa",
		  "fe31e28a-d4c9-4b8c-9e87-82dc40123042",
		  "5a22022a-f8b9-4be1-a64f-241d953982a8" -- soldier generic 6 03
		  --"4ab6aa3e-7292-d1e5-0f2e-3328cb16249b",
		}
	}

	-- weapon presets: sword=longsword; shield=one-hand and shield
	local weaponsBandits =
	{
		longsword = "9b042396-e438-4a79-ab9d-138c12cda0a6",
		shortsword = "b966514a-966a-4b1c-b870-755abd25bd32",
		short = "b966514a-966a-4b1c-b870-755abd25bd32",
		swordshield = "75f24a17-4bcc-4517-bd34-b0a0c6693817",
		shield = "75f24a17-4bcc-4517-bd34-b0a0c6693817",	-- same as swordshield
		mace = "5abe261f-125d-4f33-9a85-717b61d43f59",
		maceshield = "1adef57d-c9e8-4475-a81f-e8c662faf607",
		halberd = "21ab003f-c98b-4482-aac1-eb2d0be88d65",
		bow = "540bab62-09ea-41a9-bc44-e30a8cf98d56",
		unarmed = "10101010-c8cb-81dd-40f1-2f0554804f83",
		crossbow = "1a5e4d64-f240-4596-b0c6-49e11c047468",
		gun = "31e8543a-4a09-47fd-a2c9-534fb6730b36"
	}

	-- TODO for now, same weapons for cumans
	local weaponsCumans = weaponsBandits
	-- {
		-- longsword = "8f57080e-0525-4d81-be37-1db1f50b587e",
		-- shortsword = "8d9729b8-127e-48c3-917b-bd32f221fe77",
		-- short = "8d9729b8-127e-48c3-917b-bd32f221fe77",
		-- swordshield = "30f0febc-b9bc-4d63-aece-5e6a07f56516",
		-- shield = "30f0febc-b9bc-4d63-aece-5e6a07f56516",	-- same as swordshield
		-- mace = "f044e85c-39f2-4557-af00-d2b5ea575d16",
		-- maceshield = "7eba7a4c-4c62-4a18-88c6-ecdbb94e4518",
		-- halberd = "f0c8d066-416d-4f09-bddf-259367b78584",	-- do not use for now
		-- bow = "a2d19d16-317d-4780-8ac5-29783d45783b",
		-- unarmed = "10101010-c8cb-81dd-40f1-2f0554804f83"
	-- }

	local weaponsFriends = weaponsBandits
	-- {
		-- longsword = "8f57080e-0525-4d81-be37-1db1f50b587e",
		-- shortsword = "8d9729b8-127e-48c3-917b-bd32f221fe77",
		-- short = "8d9729b8-127e-48c3-917b-bd32f221fe77",
		-- swordshield = "30f0febc-b9bc-4d63-aece-5e6a07f56516",
		-- shield = "30f0febc-b9bc-4d63-aece-5e6a07f56516",	-- same as swordshield
		-- mace = "f044e85c-39f2-4557-af00-d2b5ea575d16",
		-- maceshield = "7eba7a4c-4c62-4a18-88c6-ecdbb94e4518",
		-- halberd = "4c120c8f-d862-09b7-8009-57fdb2ffddb8",	-- do not use for now
		-- bow = "a2d19d16-317d-4780-8ac5-29783d45783b",
		-- unarmed = "10101010-c8cb-81dd-40f1-2f0554804f83"
	-- }

	-- LOGIC

	-- local howMany = num or 1
	local howMany = 1
	local armorOverwrite = 0 -- 1=light, 2=medium, 3=heavy
	local dir = 0
	-- local enemyLevel = 2
	local range, weapon
	local enemyLevel
	local enemyType = ""
	
	local isTough = false -- if param is "tough", spawned NPC gets temporal debuff (after spawn)

	local isBrave = false -- buff for dogs and courage for men
	
	local hasHalberd = false -- for now, only when specifically defined as "halberd"; TODO: detect the halberd is in the weapon preset
	
	local isRandom = false -- random weapon
	
	local isArmed = false -- weapon in hand automatically
	
	local weaponSkillOverride = -1
	local defenseSkillOverride = -1
	local doShoot = fasle -- switch to long range on start weapon if equipped

	local entityClass = "NPC"

	local tblArmorOverwrite = {
		light = 1,
		medium = 2,
		heavy = 3
	}

	local tblSoulGUIDOverwrite = {}
	local tblWeaponGUIDOverwrite = {}
	local tblArmorGUIDOverwrite = {}

	-- rest of the params
	for i, param in ipairs(tbl) do

		-- first param (if number) is always how many of them; except it's -1 for direction
		if i == 1 and type(param) == "number" then

			if param == -1 then

				dir = -1

			else

				howMany = param

			end

		-- string: type or weapon or something else
		elseif type(param) == "string" then
		
			param = string.lower(param) -- ignoring upper/lower case
			
			if string.find(param, "=") then
			
				-- weapon=level or defense=level for overwrite of skills
				local p = string.find(param, "=")
				local level = tonumber(string.sub(param, p+1))
				
				if string.find(param, "weapon") then
				
					weaponSkillOverride = level
				
				elseif string.find(param, "defense") then
				
					defenseSkillOverride = level
				
				end
				
			elseif param == "help" then
			
				-- will not spawn regardless other params!
				Dump("SpawnEnemy([number][params]) / SpawnFriend(...)")
				Dump("number: how many to spawn, must be the fist param")
				Dump("params: level 1-5, range 6-N, various strings (see docs on wiki)")
				Dump("ex.: SpawnEnemy(3, 4, \"light\", \"random\") -- three fighters level 4/5 in light armor with random weapons")
				return

			elseif param == "cuman" then

				enemyType = "cuman"

			elseif param == "brave" then

				isBrave = true

			elseif param == "dog" then

				enemyType = "dog"
				entityClass = "Dog"
				
			elseif param == "tough" then
				
				isTough = true
				
			elseif param == "random" then
			
				isRandom = true
				
			elseif param == "armed" then
			
				isArmed = true
				
			elseif param == "shoot" then
			
				doShoot = true

			-- is it GUID? aXXXX armor, sXXXX soul, wXXXX weapon
			elseif string.len(param) == 37 then

				local c = string.sub(param, 1, 1)
				local guid = string.sub(param, 2)

				if c == "s" then -- soul

					table.insert(tblSoulGUIDOverwrite, guid)

				elseif c == "a" then -- armor preset

					table.insert(tblArmorGUIDOverwrite, guid)

				elseif c == "w" then -- weapon preset

					table.insert(tblWeaponGUIDOverwrite, guid)

				end

			-- is the string weapon? i.e. does this index exists?
			elseif weaponsBandits[param] ~= nil then

				weapon = param
				if param == "halberd" then hasHalberd = true end

			-- "light", "medium", "heavy" can overwrite the armor
			elseif tblArmorOverwrite[param] ~= nil then

				armorOverwrite = tblArmorOverwrite[param]

			end

		elseif type(param) == "number" then

			if param == -1 then
				dir = -1
			elseif param <= 5 then
				enemyLevel = param
			else
				range = param
			end

		end

	end

	-- Zbrane default, jinak VSEM jeden longsword / savli a stit (banditum sekeru) / halapartnu / luk

	local pPos = player:GetPos()
	local pDir = player:GetWorldDir()

	local tblWho, tblWeap, tblArmor
	tblWeap = {}

	if enemy then

		if enemyType == "dog" then

			-- enemy dog
			tblWho = {"5e7f0b0e-b3ca-4283-bfbd-b71e57a54dbe"} -- KCD2 lovVlku_forthPack_dog_5

		elseif enemyType == "cuman" then
			tblWho = spawnedCumans
			tblWeap = weaponsCumans
			tblArmor = armorsCumans
		else
			tblWho = spawnedBandits
			tblWeap = weaponsBandits
			tblArmor = armorsBandits
		end
	else -- friends
		if enemyType == "dog" then

			-- players dog
			tblWho = {"44a28861-719d-9fed-e3dd-b20c479e8781"} -- KCD2 vorech

		else
			tblWho = spawnedFriends
			tblWeap = weaponsFriends
			tblArmor = armorsFriends
		end
	end

	-- Overwrite tables
	if #tblSoulGUIDOverwrite > 0 then
		tblWho = tblSoulGUIDOverwrite

		-- if number is not specified, the number is defined by number of GUIDs
		if howMany < #tblSoulGUIDOverwrite then howMany = #tblSoulGUIDOverwrite end

	end

	if #tblArmorGUIDOverwrite > 0 then
		tblArmor = tblArmorGUIDOverwrite
	end

	if #tblWeaponGUIDOverwrite > 0 then
		tblWeap = tblWeaponGUIDOverwrite
	end

	-- #CombatDebug.SpawnFriend("s4737000b-d6f5-b118-ce6e-7f01704dafb3") -- ptacek

	-- #CombatDebug.SpawnFriend("a42307d23-4f2f-39fd-789a-53662441edb3") -- bernard

	-- #CombatDebug.SpawnFriend("s4737000b-d6f5-b118-ce6e-7f01704dafb3", "a42307d23-4f2f-39fd-789a-53662441edb3")

	local soulID = 1 -- pos in souls tab
	local weaponID = 1 -- pos in weapon table
	local armorID = 1 -- pos in armor table

	-- pos and rot
	local e_range = range or 5

	-- spawn point ahead of player e_range meters away
	local startX = pPos.x + e_range * pDir.x
	local startY = pPos.y + e_range * pDir.y
	local dist = 1 -- const, how far from each other they are
	local playerRotAng = player:GetAngles().z
	local rotX = math.cos(playerRotAng)
	local rotY = math.sin(playerRotAng)

	local spnmr = 1	-- number at name (new: unique)

	-- spawn them
	for i = 1, howMany do
    
		local sl = tblWho[soulID]
		local nm = "" -- name

		local spawnedEntityId -- id of spawned entity
		local spawnedEntity -- spawned entity itself
		
  
		if enemy then
			nm = "SpawnedEnemy_"
		else
			nm = "SpawnedFriend_"
		end

		-- finding unused name
		while System.GetEntityByName(nm .. string.format("%03d", spnmr)) ~= nil do
			spnmr = spnmr + 1
		end

		nm = nm .. string.format("%03d", spnmr)
		spnmr = spnmr + 1


		if enemyType == "dog" then

			local model = ""

			if enemy then
				nm = "SpawnedDogEnemy_" .. string.format("%03d", i)
				model = "Objects/Characters/animals/Dog/dog.cdf" -- KCD2 dog
			else
				nm = "SpawnedDog_" .. string.format("%03d", i)
				model = "Objects/Characters/animals/Dog/dog.cdf"
			end


		end

		--spNPC = System.SpawnEntity({class = entityClass, position = {startX + (i - 1) * rotX, startY + (i - 1) * dist * rotY, pPos.z}, name = nm, properties = {sharedSoulGuid = sl}})
  
		spawnedEntityId = XGenAIModule.SpawnEntity{Name = nm, ClassName = entityClass, SharedSoulGuid = sl, Pos = {startX + (i - 1) * rotX, startY + (i - 1) * dist * rotY, pPos.z}}
		spawnedEntity = System.GetEntity(spawnedEntityId)
      

		--[[
		local dogVorech = System.GetEntityByName('player_dogCompanion_vorech')
		if dogVorech then
			local dogChangeRequestMessage = table.MakeFromType('dog:changeRequest',{newMaster=true,master=player.this.id,newMode=true,mode=enum_dogCompanionMode.free})
			XGenAIModule.SendMessageToEntityData(System.GetEntityByName('player_dogCompanion_vorech').this.id,"dog:changeRequest",dogChangeRequestMessage)
			player:SetPos(System.GetEntityByName('player_dogCompanion_vorech'):GetPos())
		end
		--]]

		-- spNPC:SetDirectionVector({pDir.x, pDir.y, pDir.z})
		local locdir = 3.14
		if dir == -1 then locdir = 0 end -- his back is turned to player
		spawnedEntity:SetAngles({0, 0, locdir + playerRotAng})

		-- clothing preset / buff / etc
		-- level: 1-5
		local level = enemyLevel or 3
		local maxArmor = 1 -- max index in armor table: will be overwritten when appropriate table is chosen
		
		if isBrave then -- add "never run" buff -- suitable for dogs

			spawnedEntity.soul:AddBuff('61bf5b0d-aa94-45cc-9cdd-dd76d3903189')

		end

		-- humans only
		if enemyType ~= "dog" then

			-- armor overwritten
			if #tblArmorGUIDOverwrite > 0 then

				spawnedEntity.actor:EquipClothingPreset(tblArmor[armorID])
				maxArmor = #tblArmor

			else -- no overwrite for an armor

				-- 1: "light" or low level and not soul defined
				if armorOverwrite == 1 or (level < 3 and armorOverwrite == 0 and #tblSoulGUIDOverwrite == 0) then
					spawnedEntity.actor:EquipClothingPreset(tblArmor.light[armorID])
					maxArmor = #tblArmor.light

					-- 2: "medium"
				elseif armorOverwrite == 2 or (level == 3 and armorOverwrite == 0 and #tblSoulGUIDOverwrite == 0) then
					spawnedEntity.actor:EquipClothingPreset(tblArmor.medium[armorID])
					maxArmor = #tblArmor.medium

					-- 3: "heavy" or high level and not soul defined
				elseif armorOverwrite == 3 or (level > 3 and armorOverwrite == 0 and #tblSoulGUIDOverwrite == 0) then
					spawnedEntity.actor:EquipClothingPreset(tblArmor.heavy[armorID])
					maxArmor = #tblArmor.heavy
				end

			end

			-- setting up level only when not soul defined or defined explicitly
			if #tblSoulGUIDOverwrite == 0 or enemyLevel ~= nil then
				--Dump(enemyLevel)
				CombatDebug.SetSkillProfile(spawnedEntity, level)
			end

			-- weapons -- for soldiers default sword, bandits have their own default weapon preset

			if #tblWeaponGUIDOverwrite > 0 then

				local wpnindex = weaponID
				if isRandom then wpnindex = math.random(1,table.getn(tblWeap)) end
				
				spawnedEntity.actor:EquipWeaponPreset(tblWeap[wpnindex])

			else -- no overwrite

				
				if isRandom then
				
					-- lua seems cannot access dictionaries by random indexes, so we make help table -- good thing we can use exceptions there
					local tempWeaponTbl = {}
					
					for w,gd in pairs(tblWeap) do
						
						if w ~= "unarmed" then
							table.insert(tempWeaponTbl, gd)
						end
					
					end
					
					--Dump(table.getn(tempWeaponTbl))
					--Dump(tempWeaponTbl)
					
					local wpnindex = math.random(table.getn(tempWeaponTbl))
					spawnedEntity.actor:EquipWeaponPreset(tempWeaponTbl[wpnindex])
				
				else

					if weapon == nil then weapon = "longsword" end	-- no weapon defined: use longsword
					
					local wpn = tblWeap[weapon]
					if wpn ~= nil then
						spawnedEntity.actor:EquipWeaponPreset(wpn)
					end
					
				end

			end
			
			if isTough then System.ExecuteCommand("wh_rpg_AddBuffDebug " .. nm .. " hlh*0.01,edm*0.01") end -- adding tough buff
			if isBrave then spawnedEntity.soul:SetStatLevelDebug("courage", 30) end

			if weaponSkillOverride > -1 then
			
				spawnedEntity.soul:SetSkillLevelDebug("weapon_sword", weaponSkillOverride)
				spawnedEntity.soul:SetSkillLevelDebug("heavy_weapons", weaponSkillOverride)
				spawnedEntity.soul:SetSkillLevelDebug("marksmanship", weaponSkillOverride)
				spawnedEntity.soul:SetSkillLevelDebug("weapon_large", weaponSkillOverride)
				spawnedEntity.soul:SetSkillLevelDebug("weapon_unarmed", weaponSkillOverride)
				
			end
			
			if defenseSkillOverride > -1 then

				spawnedEntity.soul:SetSkillLevelDebug("defense", defenseSkillOverride)

			end
			
			--if hasHalberd then spawnedEntity.human:ToggleWeaponSet(2) end	-- TODO not very nice hack here...
			
			-- even worse hack: if he has halberd, he swithes; if not, this fails and he is fine
			spawnedEntity.human:ToggleWeaponSet(2)
			
			if doShoot then -- slight hack to pull a range weapon on start
			
				spawnedEntity.human:ToggleWeaponSet(1)
				isArmed = true -- to make sure he pulls out the weapon
			
			end
			
			-- to get weapon in hand automatically
			if isArmed then
			
				spawnedEntity.human:DrawWeapon()
			
			end

		end

		soulID = soulID + 1
		armorID = armorID + 1
		weaponID = weaponID + 1

		if soulID > #tblWho then soulID = 1 end
		if armorID > maxArmor then armorID = 1 end
		if weaponID > #tblWeap then weaponID = 1 end

	end

end

-- =============================================================================
-- CORRECT FORM:
-- SpawnEnemy([number [,params]])
-- SpawnFriend([number [,params]])
-- number: number of NPCs
-- params in any order ("number of spawns" must be defined if params are to use):
-- -- int 1-5: combat level (1-novice, 5-expert) - also gives appropriate armor
-- -- int 6+: how far from player they spawn
-- -- const -1: will spawn with a back to the player (face otherwise)
-- -- "light", "medium", "heavy" - armor override
-- -- "sword", "shield", "bow" - weapon override
-- -- "aGUID", "wGUID", "sGUID" - use specific armor preset / weapon preset / spawn a specific soul

-- CombatDebug.SpawnEnemy([num [, "bandit" | "cuman" [, level [, "shield" | "sword" | "halberd" | "bow" ]]]])
-- CombatDebug.SpawnEnemy(2, "bandit", 3, "shield")
-- CombatDebug.SpawnEnemy()	-- one bandit
-- CombatDebug.SpawnEnemy(2) -- two bandits
-- bandit, cuman  //  shield, sword, halberd, full
-- range: how many meters ahead of player; dir: 1 (back to player) or -1 (face player)

-- function CombatDebug.SpawnEnemy(num, enemyType, enemyLevel, weapon, range, dir)
-- new version: args not necessary in correct order now

-- RULES: if the first argument is a number, it's number of enemies
-- EXAMPLES: CombatDebug.SpawnEnemy("bow"); CombatDebug.SpawnEnemy(5); CombatDebug.SpawnEnemy("cuman", "shield", 4) -- one enemy level 4
function CombatDebug.SpawnEnemy(...)
	-- CombatDebug.SpawnFighters(true, num, enemyType, enemyLevel, weapon, range, dir)
	-- CombatDebug.SpawnFighters(true, {...})	-- "arg" is obsolete for Lua 5.2+ !! But it seems CryEngine is still using the old one
	CombatDebug.SpawnFighters(true, arg)
end
SpawnEnemy = CombatDebug.SpawnEnemy

-- =============================================================================
-- function CombatDebug.SpawnFriend(num, enemyType, enemyLevel, weapon, range, dir)
function CombatDebug.SpawnFriend(...)
	-- CombatDebug.SpawnFighters(false, num, enemyType, enemyLevel, weapon, range, dir)
	CombatDebug.SpawnFighters(false, arg)
end
SpawnFriend = CombatDebug.SpawnFriend

-- =============================================================================
-- CombatDebug.SpawnBattle(howmany_enemy, howmany_friends)
function CombatDebug.SpawnBattle(friends, enemies)

	local enemyRange = 10
	local friendRange = 18
	
	if(friends == "help" or friends == 0) then
		
		Dump("SpawnBattle() -- 1 vs. 1 medium level fighters")
		Dump("SpawnBattle({params_for_friends},{params_for_enemies})")
		Dump("ex.: SpawnBattle({3, 4, \"light\", \"random\"}, {5, 1, \"heavy\"}")
		Dump("adds range and rotation automatically, do not use -1 and range.")
		Dump("- for more info type SpawnEnemy(\"help\")")
		Dump("presets: SpawnBattle(preset)")
		Dump("- 1: 3v3 middle random")
		Dump("- 2: 3v5 light skilled vs. heavy weak")
		Dump("- 3: 5v5 tough armored brave")
		
	
	elseif type(friends) == "number" then
	
		-- preset
		if friends == 1 then
		-- 3v3 middle random
		
			SpawnEnemy(3,-1,enemyRange, "random")
			SpawnFriend(3,friendRange,"armed", "random")
		
		elseif friends == 2 then
		-- 3 lightstrong vs. 5 heavy weak
			
			SpawnEnemy(5, 2, -1,enemyRange, "random", "heavy")
			SpawnFriend(3, 4, "light", friendRange,"armed", "random")
		
		elseif friends == 3 then
		-- 5 vs 5 tough brave
		
			SpawnEnemy(5, 4, -1,enemyRange, "random", "tough", "brave")
			SpawnFriend(5, 4, friendRange,"armed", "random", "tough", "brave")
		
		end
	
	else
		
		if(friends == nil) then -- empty params
			
			SpawnEnemy(-1,enemyRange)
			SpawnFriend(1,friendRange,"armed")
		
		else
			-- just send params
			
			table.insert(friends, friendRange)
			table.insert(friends, "armed")
			
			table.insert(enemies, enemyRange)
			table.insert(enemies, -1)
			
			SpawnEnemy(unpack(enemies))
			SpawnFriend(unpack(friends))
			
			--Dump(friends)
		
		end
	
	end

end


function CombatDebug.SpawnBattleOld(friends, enemies, skillfriend, skillenemy, ...)

	if(friends == "help") then
		
		Dump("SpawnBattle(number_of_friends, number_of_enemies, skill_friends, skill_enemies, params)")
	
	else 
		
		local numEnemies = enemies or 1
		local numFriends = friends or 1

		local skillEnemies = skillenemy or 3
		local skillFriends = skillfriend or 3
		
		local frn = {numFriends, skillFriends, 20}
		local enm = {numEnemies, skillEnemies, 10, -1}
		
		for _,v in ipairs(arg) do table.insert(frn, v); table.insert(enm, v) end
		
		--Dump(frn)
		--Dump(enm)
	
		CombatDebug.SpawnFighters(false, frn)
		CombatDebug.SpawnFighters(true, enm)
		--SpawnEnemy(enm)
		--SpawnFriend(frn)
		
		--CombatDebug.SpawnFighters(true, {numEnemies, skillEnemies, -1, arg}) -- enemies
		--CombatDebug.SpawnFighters(false, {numFriends, skillFriends, 10, arg}) -- friends
		
	end
	
end

SpawnBattle = CombatDebug.SpawnBattle

-- =============================================================================
function CombatDebug.StartLog()
	System.SetCVar("wh_rpg_LogTarget", 2) -- log to file
	System.SetCVar("wh_rpg_LogLevel", 1) -- log combat
	System.SetCVar("wh_rpg_LogType", 1) -- log names of entities
	System.SetCVar("wh_rpg_LogReasons", 1) -- log reasons
	System.SetCVar("wh_rpg_LogInterval", 100000) -- very long logs; will be logged at game mode exiting or at stop command
	System.SetCVar("wh_rpg_LogSize", 100000000) -- really big logs supported...
	System.SetCVar("wh_rpg_TelemetryLimitedToPlayline", 0) -- disable limitation to playline

	System.ExecuteCommand("wh_rpg_ResetLogging")
	DebugUtils.Log("Loging to file started!")
end

-- =============================================================================
function CombatDebug.StopLog()
	System.SetCVar("wh_rpg_LogTarget", 0)
	System.SetCVar("wh_rpg_LogReasons", 0)
	System.ExecuteCommand("wh_rpg_ResetLogging") -- write actual log if it started and save new values
end

function CombatDebug.TestCombat()
	System.SetCVar("wh_rpg_LockOnAllTargets", 1)
	System.SetCVar("wh_rpg_UnlockAll", 1)
end

function CombatDebug.TestLock(what)
	
	local cvars = {} -- cvar, modded, default
	
	table.insert (cvars, {'wh_cs_playermaxopponentdistancetolock', {8, 6}})
	table.insert (cvars, {'wh_cs_playermaxopponentdistancetounlock', {8, 7}})
	table.insert (cvars, {'wh_cs_playerunlocktimeout', {0, 3}})
	table.insert (cvars, {'wh_cs_playerverticalunlockdelay', {0, 1}})
	table.insert (cvars, {'wh_cs_playerhorizontalunlockdelay', {0, 0.5}})
	table.insert (cvars, {'wh_cs_playerlockopponentanglebias', {2, 6}})
	table.insert (cvars, {'wh_cs_playermaxopponentangletolock', {0.8, 0.7854}})
	table.insert (cvars, {'wh_cs_playermaxopponentangletounlock', {0.8, 0.8727}})
	table.insert (cvars, {'wh_cs_playerinputcombatunlockdelay', {0, 0.4}})
	table.insert (cvars, {'wh_cs_playerinputcursorunlockdistance', {0.05, 0.2}})
	table.insert (cvars, {'wh_cs_playerinputlockingtolerance', {20, 60}})
	table.insert (cvars, {'wh_cs_playerinputlockareawidth', {0.6, 0.25}})
	table.insert (cvars, {'wh_cs_playerinputmouseunlockxthreshold', {60, 45}})
	table.insert (cvars, {'wh_cs_playerinputmouseunlockmintime', {0, 0.15}})
	table.insert (cvars, {'wh_cs_playerinputmouseunlockreturntime', {1.5, 0.2}})
	table.insert (cvars, {'wh_cs_playerinputmouseunlockminoppangle', {20, 35}})
	
	if what == "help" or what == nil or what > #cvars[1][2] then
		Dump("CombatDebug.TestLock(N) -- 0=show all, 1=modded, 2=default")
		return
	end
	
	for ind, cv in ipairs(cvars) do
		--print(cv[1], ": ", cv[2][1])
		if what == 0 then
			Dump(cv[1] .. ": " .. tostring(System.GetCVar(cv[1])))
		else -- what == 1 modded or 2 default or ....
			System.SetCVar(cv[1], cv[2][what])
		end
		
	end
	
	
	-- MOD vs. defaault
	--wh_cs_playermaxopponentdistancetolock = 8; def 6
	--wh_cs_playermaxopponentdistancetounlock = 8; def 7
	--wh_cs_playerunlocktimeout = 0; 3
	--wh_cs_playerverticalunlockdelay = 0; 1
	--wh_cs_playerhorizontalunlockdelay = 0; 0.5
	--wh_cs_playerlockopponentanglebias = 2; 6
	--wh_cs_playermaxopponentangletolock = 0.8; 0.7854
	--wh_cs_playermaxopponentangletounlock = 0.8; 0.8727
	--wh_cs_playerinputcombatunlockdelay = 0; 0.4
	--wh_cs_playerinputcursorunlockdistance = 0.05; 0.2
	--wh_cs_playerinputlockingtolerance = 20; 60
	--wh_cs_playerinputlockareawidth = 0.6; 0.25
	--wh_cs_playerinputmouseunlockxthreshold = 60; 45
	--wh_cs_playerinputmouseunlockmintime = 0; 0.15
	--wh_cs_playerinputmouseunlockreturntime = 1.5; 0.2
	--wh_cs_playerinputmouseunlockminoppangle = 20; 35
	
end

-- functions for better combat testing
function CombatDebug.SetEnv()

	System.SetCVar("r_DisplayInfo", 0) -- cut off ugly info
	System.SetCVar("wh_ui_ShowTutorialMessage", 0) -- no tutors
	System.SetCVar("wh_ai_crime_levelsDebugDraw", 0) -- crime icons
	System.SetCVar("e_TimeOfDaySpeed", 0) -- stop time -- not working?
	
	System.SetCVar("wh_cs_TimeWarpDurationPlayer", 0.1)
	System.SetCVar("wh_cs_TimeWarpDurationOpp", 0.1)
	
	--combat
	System.SetCVar("wh_cs_AutomationAction_ZoneChangeToAttackMinDelay", 5)

	System.ExecuteCommand("wh_rpg_AddBuffDebug Dude wud*0.01,edm*0.01,wat*0.5")
	
end

-- spawn presets for fun
function CombatDebug.Spawn(who)

	if who == "sw" then
	
		SpawnEnemy(1,3,"aca2dea14-4849-4e65-9288-111decfb2c47","shortsword")
		
	elseif who == "2" then
	
		SpawnEnemy(1,3,"a89999546-ddfa-4e1a-98eb-0d3af45421de", "shield")
		SpawnEnemy(1,3,6, "s20eb21a4-21ba-4530-bcac-3af448cb1810", "abe7176a5-dc9a-480b-9b93-7ccfc0733191", "wd6324106-5119-427b-bded-d17a4d05e928")
	
	elseif who == "unarmed" then
	
		SpawnEnemy(1,4,"a7f26bcc3-e7a0-4331-8536-49d42062cc8d", "s584f681c-2f90-4ef2-b1de-470282a7993d", "unarmed")
	
	elseif who == "bitka" then
	
		SpawnEnemy(3,2,"random")
		SpawnFriend(2,3,"random")
	
	elseif who == "long" then -- drsnak highlevel low clothing
	
		SpawnEnemy(1, 4, "sb3037b98-cae4-47c8-9583-c21a92883f09", "a6f1fd67f-3518-4118-b335-c18dcc6d715f","longsword")
	
	elseif who == "halberd" then -- obrnenec
	
		SpawnEnemy(1,4, "halberd")
	
	end

end


-- placeholder function for setting up better RPG / AI params
-- now for testing new defense automaton
function CombatDebug.SetDef()

	System.SetCVar("wh_cs_TimeWarpDurationOpp", 0.05) -- tiny slowmo for enemies
	
	-- defense auto
	RPG.CombatMasterStrikeProb1 = 3;
	RPG.CombatPerfectBlockPowTo = 1.5;
	RPG.CombatPerfectBlockNPCvsNPCCoef = 1.5;
	RPG.CombatPerfectBlockZoneDistanceCoef = 0.45;
	RPG.CombatPerfectBlockOnRiposteCoef = 1.5;
	RPG.CombatNoBlockProb0 = 0.3;
	RPG.CombatNormalBlockProb1 = 0.2;
	
end

function CombatDebug.SetDefBack()

	System.SetCVar("wh_cs_TimeWarpDurationOpp", 1) -- tiny slowmo for enemies no more
	
	-- defense auto
	RPG.CombatMasterStrikeProb1 = 2.2;
	RPG.CombatPerfectBlockPowTo = 2;
	RPG.CombatPerfectBlockNPCvsNPCCoef = 2;
	RPG.CombatPerfectBlockZoneDistanceCoef = 0.4;
	RPG.CombatPerfectBlockOnRiposteCoef = 1.2;
	RPG.CombatNoBlockProb0 = 0.4;
	RPG.CombatNormalBlockProb1 = 0.3;
	
end

-- functions for better combat testing
function CombatDebug.SetEnv()

	System.SetCVar("r_DisplayInfo", 0) -- cut off ugly info
	System.SetCVar("wh_ui_ShowTutorialMessage", 0) -- no tutors
	System.SetCVar("wh_ai_crime_levelsDebugDraw", 0) -- crime icons
	System.SetCVar("e_TimeOfDaySpeed", 0) -- stop time -- not working?
	
	System.SetCVar("wh_cs_TimeWarpDurationPlayer", 0.1)
	System.SetCVar("wh_cs_TimeWarpDurationOpp", 0.1)
	
	--combat
	System.SetCVar("wh_cs_AutomationAction_ZoneChangeToAttackMinDelay", 5)

	System.ExecuteCommand("wh_rpg_AddBuffDebug Dude wud*0.01,edm*0.01,wat*0.5")
	
end

-- spawn presets for fun
function CombatDebug.Spawn(who)

	if who == "sw" then
	
		SpawnEnemy(1,3,"aca2dea14-4849-4e65-9288-111decfb2c47","shortsword")
		
	elseif who == "2" then
	
		SpawnEnemy(1,3,"a89999546-ddfa-4e1a-98eb-0d3af45421de", "shield")
		SpawnEnemy(1,3,6, "s20eb21a4-21ba-4530-bcac-3af448cb1810", "abe7176a5-dc9a-480b-9b93-7ccfc0733191", "wd6324106-5119-427b-bded-d17a4d05e928")
	
	elseif who == "unarmed" then
	
		SpawnEnemy(1,4,"a7f26bcc3-e7a0-4331-8536-49d42062cc8d", "s584f681c-2f90-4ef2-b1de-470282a7993d", "unarmed")
	
	elseif who == "bitka" then
	
		SpawnEnemy(3,2,"random")
		SpawnFriend(2,3,"random")
	
	elseif who == "long" then -- drsnak highlevel low clothing
	
		SpawnEnemy(1, 4, "sb3037b98-cae4-47c8-9583-c21a92883f09", "a6f1fd67f-3518-4118-b335-c18dcc6d715f","longsword")
	
	elseif who == "halberd" then -- obrnenec
	
		SpawnEnemy(1,4, "halberd")
	
	end

end

--WH_NOMASTER_END