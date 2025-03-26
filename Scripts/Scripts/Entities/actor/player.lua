Player =
{
	ActionController = "Animations/Mannequin/ADB/kcd_male_controllerdefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/kcd_male_database.adb",
	OpponentMnTag = "relatedMale",
	CombatOpponentMnTag = "oppMale",
	--AnimDatabase1P = "",
	--SoundDatabase = "",

	type = "Player",
	defaultSoulClass = "player",

	foreignCollisionDamageMult = 0.1,
	vehicleCollisionDamageMult = 7.5,

	UseMannequinAGState = true,

	Properties =
	{
		-- AI-related properties
		esNavigationType = "MediumSizedCharacters",
		commrange = 40; -- Luciano - added to use SIGNALFILTER_GROUPONLY
		bCanHoldInformation = false,

		aicharacter_character = "Player",
		SoundPack = "ai_player_default",
		esCommConfig = "player_default",
		esVoice = "player_default",

		fileModel = "Objects/Characters/humans/male/skeleton/male.cdf",
		fileHitDeathReactionsParamsDataFile = "Libs/HitDeathReactionsData/HitDeathReactions_SkeletonMale.xml",
		clientFileModel = "Objects/Characters/humans/male/skeleton/male.cdf", -- pouzite pro multiplayer, pokud je player client ukaze to tenhle model
		esClothingConfig = "male2",
		fpItemHandsModel = "", -- model pro first person pohled pri neseni nejakeho predmetu

		CharacterSounds =
		{
			footstepEffect = "footsteps_player",		-- Footstep mfx library to use
			foleyEffect = "foleys_player",			-- Foley signal effect name
		},

		LipSync =
		{
			TransitionQueueSettings =
			{
			playbackWeight = 1.0,
			}
		},
	},

	PropertiesInstance =
	{
		aibehavior_behaviour = "PlayerIdle",
	},

	gameParams =
	{
		lookAtSimpleHeadBone = "LookIK", -- kost na ktere se otaci hlava pri LookAt
		canUseComplexLookIK = false, -- nenasel sem, co to pouziva

		slopeSlowdown = 3.0,

		lookFOV = 720, -- this is multiplied by 0.5 in-game, need to be reworked for NPCs and players

		stance =
		{
			normal = {
					size = {x=0.35,y=0.0,z=0.4},
				},
		},

	},

		-- the AI movement ability
	AIMovementAbility =
	{
		collisionAvoidanceObstacleRadius = 0.7,
	},

	Server = {},
	Client = {},
	SignalData = {},

	AI = {},
}

-- =============================================================================
-- Called from code
-- =============================================================================
function Player.Server:OnInit(bIsReload)
	if AI then
		--AI related: create ai representation for the player
		CryAction.RegisterWithAI(self.id, AIOBJECT_PLAYER, self.Properties,self.PropertiesInstance,self.AIMovementAbility); -- Registers the entity to AI System, creating an AI object associated to it

		--AI related: player is leader of squad-mates always
		--AI.SetLeader(self.id)
	end

	self:OnInit()
end

-- =============================================================================
function Player.Client:OnInit()
	self:OnInit()
end

-- =============================================================================
function Player:OnAction(action, activation, value) -- called by engine when some action happen // for now got just ui_back, ui_start_pause
	-- gamerules needs to get all player actions all times
	if (g_gameRules and g_gameRules.Client.OnActorAction) then -- we are using singleplayer.lua
		if (not g_gameRules.Client.OnActorAction(g_gameRules, self, action, activation, value)) then
			return
		end
	end

	if ( ( action == "custom_quest_call_horse_action" ) and ( activation == "press" ) ) then
		local content = { action= action }
		XGenAIModule.SendMessageToEntityData(player.this.id,'player:actionMapReaction', content )
	end

	--Dump(action)

--PR INF
--[[
	if ( action == "telep" and telepAct == 1) then
		self:PRTelep( player )
--WH_NOMASTER_START
	elseif ( action == "teleport_switch" ) then
		self:PRTelep_func( player, 0 )
--WH_NOMASTER_END
	elseif ( action == "teleport_time" ) then
		self:PRTelep_func( player, 9 )
	elseif ( action == "telock1" and telepAct == 0) then
		self:PRTelep_unlock( player, 1 )
	elseif ( action == "telock2" and telepAct == 0) then
		self:PRTelep_unlock( player, 2 )
	elseif ( action == "telock3" and telepAct == 0) then
		self:PRTelep_unlock( player, 3 )
	elseif ( action == "telock4" and telepAct == 0) then
		self:PRTelep_unlock( player, 4 )
	elseif ( action == "telock5" and telepAct == 0) then
		self:PRTelep_unlock( player, 5 )
	elseif ( action == "telock6" and telepAct == 0) then
		self:PRTelep_unlock( player, 6 )
	elseif ( action == "teleport1" ) then
		self:PRTelep_func( player, 1 )
	elseif ( action == "teleport2" ) then
		self:PRTelep_func( player, 2 )
	elseif ( action == "teleport3" ) then
		self:PRTelep_func( player, 3 )
	elseif ( action == "teleport4" ) then
		self:PRTelep_func( player, 4 )
	elseif ( action == "teleport5" ) then
		self:PRTelep_func( player, 5 )
	elseif ( action == "teleport6" ) then
		self:PRTelep_func( player, 6 )
	elseif ( action == "teleport_f1" ) then
		self:PRTelep_func_2( player, 1 )
	elseif ( action == "teleport_f2" ) then
		self:PRTelep_func_2( player, 2 )
	elseif ( action == "teleport_f3" ) then
		self:PRTelep_func_2( player, 3 )
	elseif ( action == "teleport_f4" ) then
		self:PRTelep_func_2( player, 4 )
	elseif ( action == "teleport_f5" ) then
		self:PRTelep_func_2( player, 5 )
	end
]]

--[[
	if ( action == "movetime" ) then
		self:CheatMoveTime( player )
	end
--]]

--[[
--WH_NOMASTER_START

	if Player:IsCheatEngineAvailable() then

		-- cheats and debug
		if ( ( action == "cheat_sword" ) and ( activation == "release" ) ) then
			self:CheatGiveSword( player )

		-- cheat engine
		elseif ( ( action == "cheat_engine_start" ) and ( activation == "release" ) ) then
			self:CheatEngine( nil )
		elseif ( ( action == "cheat_bow" ) and ( activation == "release" ) ) then
			self:CheatGiveBow( player )
		elseif ( ( action == "cheat_money" ) and ( activation == "release" ) ) then
			self:CheatEngine_money( player )
		elseif ( ( action == "cheat_addstat" ) and ( activation == "release" ) ) then
			cheat_engine_sub = "stats"
			cheat_engine_mainmenu = 0
			ActionMapManager.EnableActionMap("cheat_engine", false)
			ActionMapManager.SetActionListener("cheat_engine_stat", g_localActor.id)
			ActionMapManager.EnableActionMap("cheat_engine_stat", true)

		elseif ( ( action == "cheat_addskill" ) and ( activation == "release" ) ) then
			cheat_engine_sub = "skills"
			cheat_engine_mainmenu = 0
			ActionMapManager.EnableActionMap("cheat_engine", false)
			ActionMapManager.SetActionListener("cheat_engine_skill", g_localActor.id)
			ActionMapManager.EnableActionMap("cheat_engine_skill", true)

		elseif ( ( action == "cheat_animal" ) and ( activation == "release" ) ) then
			cheat_engine_sub = "animals"
			cheat_engine_mainmenu = 0
			ActionMapManager.EnableActionMap("cheat_engine", false)
			ActionMapManager.SetActionListener("cheat_engine_animal", g_localActor.id)
			ActionMapManager.EnableActionMap("cheat_engine_animal", true)

		elseif ( ( action == "cheat_animal_close" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 0 )
		elseif ( ( action == "cheat_animal_separationUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 1 )
		elseif ( ( action == "cheat_animal_separationDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -1 )
		elseif ( ( action == "cheat_animal_alignUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 2 )
		elseif ( ( action == "cheat_animal_alignDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -2 )
		elseif ( ( action == "cheat_animal_cohesionUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 3 )
		elseif ( ( action == "cheat_animal_cohesionDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -3 )
		elseif ( ( action == "cheat_animal_threatUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 4 )
		elseif ( ( action == "cheat_animal_threatDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -4 )
		elseif ( ( action == "cheat_animal_herdUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 5 )
		elseif ( ( action == "cheat_animal_herdDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -5 )
		elseif ( ( action == "cheat_animal_targetUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 6 )
		elseif ( ( action == "cheat_animal_targetDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -6 )
		elseif ( ( action == "cheat_animal_maxUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 7 )
		elseif ( ( action == "cheat_animal_maxDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -7 )
		elseif ( ( action == "cheat_animal_safeUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 8 )
		elseif ( ( action == "cheat_animal_safeDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -8 )
		elseif ( ( action == "cheat_animal_activationUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 9 )
		elseif ( ( action == "cheat_animal_activationDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -9 )
		elseif ( ( action == "cheat_animal_deactivationUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 10 )
		elseif ( ( action == "cheat_animal_deactivationDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -10 )
		elseif ( ( action == "cheat_animal_thresholdUp" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 11 )
		elseif ( ( action == "cheat_animal_thresholdDown" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( -11 )
		elseif ( ( action == "cheat_animal_print" ) and ( activation == "release" ) ) then
			self:CheatEngine_animal( 99 )
		elseif ( ( action == "cheat_stat_str" ) and ( activation == "release" ) ) then
			self:CheatEngine_stat( "str" )
		elseif ( ( action == "cheat_stat_agi" ) and ( activation == "release" ) ) then
			self:CheatEngine_stat( "agi" )
		elseif ( ( action == "cheat_stat_spc" ) and ( activation == "release" ) ) then
			self:CheatEngine_stat( "spc" )
		elseif ( ( action == "cheat_stat_vit" ) and ( activation == "release" ) ) then
			self:CheatEngine_stat( "vit" )
		elseif ( ( action == "cheat_stat_close" ) and ( activation == "press" ) ) then
			self:CheatEngine_stat( 0 )
		elseif ( ( action == "cheat_skill_archery" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "marksmanship" )
		elseif ( ( action == "cheat_skill_alchemy" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "alchemy" )
		elseif ( ( action == "cheat_skill_lockpick" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "thievery" )
		elseif ( ( action == "cheat_skill_defense" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "defense" )
		elseif ( ( action == "cheat_skill_longsword" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "weapon_sword" )
		elseif ( ( action == "cheat_skill_reading" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "scholarship" )
		elseif ( ( action == "cheat_skill_horse" ) and ( activation == "release" ) ) then
			self:CheatEngine_skill( "horse_riding" )
		elseif ( ( action == "cheat_skill_close" ) and ( activation == "press" ) ) then
			self:CheatEngine_skill( 0 )
		elseif ( ( action == "cheat_fastertime" ) and ( activation == "release" ) ) then
			self:CheatEngine_time( player )

		-- gear
		elseif ( ( action == "cheat_gear" ) and ( activation == "release" ) ) then
			cheat_engine_sub = "gear"
			cheat_engine_mainmenu = 0
			ActionMapManager.EnableActionMap("cheat_engine", false)
			ActionMapManager.SetActionListener("cheat_engine_gear", g_localActor.id)
			ActionMapManager.EnableActionMap("cheat_engine_gear", true)
		elseif ( ((action == "cheat_gear_longsword") or (action == "cheat_gear_shortsword") or (action == "cheat_gear_axe") or (action == "cheat_gear_mace") or (action == "cheat_gear_shortsword_shield") or (action == "cheat_gear_axe_shield") or (action == "cheat_gear_mace_shield")) and ( activation == "release" ) ) then
			self:CheatEngine_equipweapon( player, action )
		elseif ( ( action == "cheat_gear_shield_only" ) and ( activation == "release" ) ) then
			player.inventory:AddItem(ItemManager.CreateItem("5b7ed53e-3554-47c7-817b-b971a2d99713", 1, 1));	-- shield_01_talmberk2
			self:CheatEngine("cheat_engine_gear")
		elseif ( ( action == "cheat_gear_armor_light" ) and ( activation == "release" ) ) then
			player.actor:EquipClothingPreset("48691669-b94a-0e6a-d9db-0a70a0ca1fad")
			self:CheatEngine("cheat_engine_gear")
		elseif ( ( action == "cheat_gear_armor_medium" ) and ( activation == "release" ) ) then
			player.actor:EquipClothingPreset("4fd62c5f-ff3a-8d50-3857-a66724c99d91")
			self:CheatEngine("cheat_engine_gear")
		elseif ( ( action == "cheat_gear_armor_heavy" ) and ( activation == "release" ) ) then
			player.actor:EquipClothingPreset("4036a7d4-06fd-4f1f-c75e-c62ace5aa2a8")
			self:CheatEngine("cheat_engine_gear")
		elseif ( ( action == "cheat_gear_clothes" ) and ( activation == "release" ) ) then
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '4d29d49a-e6d1-d0a0-47b7-3fac105c23b5'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '407f6f52-d70e-7e3b-056d-cda8069aab86'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '43f19e40-1107-38aa-a226-5d6179e9b4a3'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '4e8bfdae-a38a-fae5-1177-b513733f1c90'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '4249522f-a1db-7d3e-020f-237390c80ba2'))
			cheat_engine_sub = 0
			ActionMapManager.EnableActionMap("cheat_engine_gear", false)
			self:CheatEngine("cheat_engine_gear")
		elseif ( ( action == "cheat_gear_close" ) and ( activation == "release" ) ) then
			self:CheatEngine("cheat_engine_gear")

		-- log etc
		elseif	( ( action == "cheat_logCombat" ) and ( activation == "release" ) ) then
		  if dbgCheatLogCombat == nil then
				CombatDebug.StartLog()
				dbgCheatLogCombat = 1
			else
				CombatDebug.StopLog()
				dbgCheatLogCombat = nil
			end
			self:CheatEngine(nil)
		elseif ( ( action == "cheat_heal" ) and ( activation == "release" ) ) then
			player.soul:AddBuff("f29ee947-a131-4597-8ed7-6f06aca0a4a2")
			self:CheatEngine(nil)
		elseif ( ( action == "cheat_survive" ) and ( activation == "release" ) ) then
			-- add some bandages and food
			player.inventory:AddItem(ItemManager.CreateItem("2264f217-590e-4c0f-a4c6-f50c6532b9f6", 1, 1))
			player.inventory:AddItem(ItemManager.CreateItem("2264f217-590e-4c0f-a4c6-f50c6532b9f6", 1, 1))
			player.inventory:AddItem(ItemManager.CreateItem("2264f217-590e-4c0f-a4c6-f50c6532b9f6", 1, 1))
			player.inventory:AddItem(ItemManager.CreateItem("2264f217-590e-4c0f-a4c6-f50c6532b9f6", 1, 1))
			player.inventory:AddItem(ItemManager.CreateItem("2264f217-590e-4c0f-a4c6-f50c6532b9f6", 1, 1))
			player.inventory:AddItem(ItemManager.CreateItem("9fa3000e-3807-48a8-bed8-81427f0bda55", 1, 10))
			self:CheatEngine(nil)
		end

	end

	------------------------------------------------

	if ( ( action == "toggle_weapon_debug" ) and ( activation == "release" ) ) then
		self.human:ToggleWeapon()
	end

	if ( ( action == "cycle_weapon_debug" ) and ( activation == "release" ) ) then
		self.human:CycleWeapon()
	end

--WH_NOMASTER_END
--]]
end

--[[
--WH_NOMASTER_START

-- =============================================================================
-- Maps wh_sys_specVersion values
-- to which cheat modules are available
local cheatsAvailable =
{
	[''] =
	{
		cheatEngine = true
	},

	['expo'] =
	{
		cheatEngine = false
	},

	['expo_press'] =
	{
		cheatEngine = false
	},

	['master_master'] =
	{
		cheatEngine = false
	},

	['focus'] =
	{
		cheatEngine = false
	}
}

-- =============================================================================
function Player:IsCheatEngineAvailable()

	local version = System.GetCVar('wh_sys_specVersion')
	return cheatsAvailable[version] == nil or cheatsAvailable[version].cheatEngine

end
--WH_NOMASTER_END
--]]

-- =============================================================================
-- CheatEngine
-- =============================================================================
function Player:CheatEngine(entity)		-- parametr: akcni mapa k vypnuti
--[[
--WH_NOMASTER_START
	if(cheat_engine_runs) then
		-- byl-li zrychleny cas
		if(cheat_engine_mainmenu == 2) then
			Calendar.SetWorldTimeRatio(g_globalTimeSpeed)
		end

		if(entity ~= nil) then
			ActionMapManager.EnableActionMap(entity, false)
		end

		ActionMapManager.EnableActionMap("cheat_engine", false)
		cheat_engine_runs = false
		ActionMapManager.SetActionListener("default", g_localActor.id)
		--ActionMapManager.EnableActionMap("default", true)

		System.Log("CHEAT: Cheat engine closed..")

	else
		System.Log("CHEAT: Calling cheat engine!")
		g_globalTimeSpeed = Calendar.GetWorldTimeRatio()

		cheat_engine_runs = true
		cheat_engine_mainmenu = 1
		cheat_engine_sub = ""

		--ActionMapManager.EnableActionMap("default", false)
		ActionMapManager.SetActionListener("cheat_engine", g_localActor.id)
		ActionMapManager.EnableActionMap("cheat_engine", true)
	end
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:PRTelep_unlock(entity, num)
	telepPos = telepPos + 1
	if telepMen[telepPos] == num then
		if telepPos == #telepMen then
			telepAct = 1
		end
	else
		telepPos = 0
	end
end

-- =============================================================================
function Player:PRTelep(entity)
--WH_NOMASTER_START
	--System.Log(". . teleport attempt (have a nice journey)..")
	local e = System.GetEntityByName("fgTeleport")
	if(e ~= nil) then
		ActionMapManager.EnableActionMap("PR_cheat_teleport_more", false);	-- just to be sure
		-- open or close "menu"
		if(global_PRCheat == 1) then
			global_PRCheat = nil
			Game.HideCurrentTutorial()
			--ActionMapManager.SetActionListener("PR_cheat_teleport", g_localActor.id)
			ActionMapManager.EnableActionMap("PR_cheat_teleport", false)
			ActionMapManager.SetActionListener("default", g_localActor.id)
			--ActionMapManager.EnableActionMap("default", true)
		else
			global_PRCheat = 1
			--e:ActivateOutput("Activate", true)
			--ActionMapManager.EnableActionMap("default", false)
			--ActionMapManager.EnableActionMap("default", false)
			ActionMapManager.EnableActionMap("PR_cheat_teleport", true)
			ActionMapManager.SetActionListener("PR_cheat_teleport", g_localActor.id)
			self:PRTelepShowMessage()
		end
	else
		System.Log("ERROR: no PR flowgraph found :( Don't use this cheat key.")
	end
	return true
end

-- =============================================================================
function Player:PRTelepShowMessage()
	if(global_PRTeleport == 2) then
		--telOnly = "ON"
		local fntgrey = "<font color='#909090'>"
		local fntblack = "<font color='#000000'>"
		local fntend = "</font>"

		local fnt = fntblack

		local msg = "The Quest!\n\n\
".. fnt .. "1 - Woodcutters camp" .. fntend .. "\
2 - Reeky's hideout\
3 - Mill with more info\
4 - Looking for Timmy\n"

	if Variables.GetGlobal('q_pribBattle_started')==1 then
		msg = msg .. "<font color='#990000'>5 - END THE BATTLE!</font>\n\n"
	elseif Variables.GetGlobal('q_pribBattle_started')==0 then
		msg = msg .."5 - Bandit's camp\n\n"
	else
		msg = msg .. "\n\n"
	end

	msg = msg .. "7 - (close this)\
8 - (switch page: <font color='#990000'>"..(global_PRTeleport+1).."</font>)\
9 - (move time 2 hours)"

	Game.ShowTutorial(msg)


	elseif(global_PRTeleport == 1) then
		--telOnly = "ON"
		Game.ShowTutorial("Move around some more...\n\n\
1 - Combat Arena\
2 - Alchemy Minigame\
3 - Samopesh village\
4 - Kolben's estate\
5 - Merhojed village\
6 - Starting position\n\
7 - (close this)\
8 - (switch page: <font color='#990000'>"..(global_PRTeleport+1).."</font>)\
9 - (move time 2 hours)", 0)
	else	-- default: nil or 0
		--telOnly = "OFF"
		global_PRTeleport = 0
		Game.ShowTutorial("Move around!\n\n\
1 - Talmberg (start)\
2 - Woodcutters\
3 - The cave\
4 - The mill\
5 - The quarry\
6 - The bandits\n\
7 - (close this)\
8 - (switch page: <font color='#990000'>"..(global_PRTeleport+1).."</font>)\
9 - (move time 2 hours)", 0)
	end
--WH_NOMASTER_END
end

--[[
--WH_NOMASTER_START

-- =============================================================================
-- default PR cheat function
function Player:PRTelep_func(entity, what)
-- remove for real release!
	--System.Log("setting: " .. Variables.GetGlobal('gTeleport_PR') .. " / " .. what)
	local e = System.GetEntityByName("fgTeleport")
	if(what == 0) then
		-- change pages in the "menu"
		if(global_PRTeleport == 0) then global_PRTeleport = 1	-- nil = problem in master
		--elseif(global_PRTeleport == 1) then global_PRTeleport = 2
		else global_PRTeleport = 0
		end
		self:PRTelepShowMessage()
	elseif(what == 9) then
		-- move time -----------------------------------------------------------------------
		self:CheatMoveTime(entity, 2)
	----------------------------------------------------------------------------------------
	elseif(what == 1) then
		-- Talbmerg / Combat arena / Q: Woodcutters -----------------------------------------------------------------------
		if(global_PRTeleport == 0) then
			setTel(6)
		elseif(global_PRTeleport == 1) then
			setTel(1)
		else
			setTel(7)
		end

		e:ActivateOutput("Activate", true)	-- fadout and teleport
		self:PRTelep(entity)
		if(global_PRTeleport == 1) then
			Game.ShowTutorial("Welcome to the combat arena!\n\nTalk to the trainer at the training range to initiate combat or fencing tutorial.\nYou can also try the archery nearby.", 10)
		end

		if(global_PRTeleport == 2) then
				BETAJumpLumberjacks()
		end
	elseif(what == 2) then
		-- Woodcutters / alchemy / Reekys
		if(global_PRTeleport == 0) then
			setTel(7)
		elseif(global_PRTeleport == 1) then
			setTel(2)
		else
			setTel(3)
		end

		e:ActivateOutput("Activate", true)	-- fadout and teleport
		self:PRTelep(entity)
		local add = ""
		if(global_PRTeleport == 2) then
			BETAJumpCave()
		end

	elseif(what == 3) then
		-- cave / sick bastard / mill Quest -----------------------------------------------------------------------
		if(global_PRTeleport == 0) then
			setTel(3)
		elseif(global_PRTeleport == 1) then
			setTel(10)
		else
			setTel(8)
		end

		e:ActivateOutput("Activate", true)	-- fadout and teleport
		self:PRTelep(entity)

		if(global_PRTeleport == 2) then
			BETAJumpMill()
		end

	elseif(what == 4) then
		-- mill / kolben / kolbenPeta -----------------------------------------------------------------------
		if(global_PRTeleport == 0) then
			setTel(8)
		else
			setTel(13)
		end

		e:ActivateOutput("Activate", true)	-- fadout and teleport
		self:PRTelep(entity)

		if(global_PRTeleport == 2) then
				BETAJumpFarmVisitPeta()
		end

	elseif(what == 5) then
		-- quarry / merhojed / bandits OR battle! -----------------------------------------------------------------------
		-- TODO: various approaches
		if(global_PRTeleport == 0) then
			setTel(12)
			e:ActivateOutput("Activate", true)	-- fadout and teleport
			self:PRTelep(entity)
		elseif(global_PRTeleport == 1) then
			setTel(9)
			e:ActivateOutput("Activate", true)	-- fadout and teleport
			self:PRTelep(entity)
		else
			self:PRTelep(entity)
			ActionMapManager.EnableActionMap("PR_cheat_teleport", false)
			ActionMapManager.SetActionListener("PR_cheat_teleport_more", g_localActor.id)
			ActionMapManager.EnableActionMap("PR_cheat_teleport_more", true)

			if Variables.GetGlobal('q_pribBattle_started')==1 then
				Game.ShowTutorial("How do you want it?\n\n1 - WIN THE BATTLE!\n2 - Lose the batle\n3 - Not sure...", 0)
			elseif Variables.GetGlobal('q_pribBattle_started')==0 then
				setTel(4)
				e:ActivateOutput("Activate", true)	-- fadout and teleport
				Game.ShowTutorial("You are right in the middle of the enemy territory. Now what?\n\n1 - Infiltrate\n2 - Meet with bandit\n3 - Battle - full scale!\n4 - Battle - middle\n5 - Battle - small", 0)
			else -- je po bitve! a to by se to tu vubec nemelo poustet... leda by bitva skoncila, zatimco to mel otevrene...
				ActionMapManager.EnableActionMap("PR_cheat_teleport_more", false)
				ActionMapManager.SetActionListener("default", g_localActor.id)
			end
		end

	elseif(what == 6) then
		-- Bandits / Start / ... -----------------------------------------------------------------------
		if(global_PRTeleport == 0) then
			setTel(4)
			e:ActivateOutput("Activate", true)	-- fadout and teleport
		elseif(global_PRTeleport == 1) then
			setTel(6)
			e:ActivateOutput("Activate", true)	-- fadout and teleport
			-- else do nothing
		end
		self:PRTelep(entity)
	end
end

-- =============================================================================
function setTel(num)
	Variables.SetGlobal("gTeleport_PR", num)
	-- 1 military camp
	-- 2 alchemy
	-- 3 cave\
	-- 4 battle
	-- 5 battle !
	-- 6 START POS
	-- 7 Woodcutters
	-- 8 Mill
	-- 9 Merhoyed
	-- 10 Sick Bastard
	-- 11 Samopesh
	-- 12 Quarry
	-- 13 Kolben
end

-- =============================================================================
function Player:PRTelep_func_2(entity, what)
	Game.HideCurrentTutorial()
	ActionMapManager.EnableActionMap("PR_cheat_teleport_more", false)
	ActionMapManager.SetActionListener("default", g_localActor.id)

	if Variables.GetGlobal('q_pribBattle_started')==1 then	-- battle in progress
		if(what == 1) then
			winPribBattle()
		elseif(what == 1) then
			losePribBattle()
		end
	-- not battle running now what?
	elseif Variables.GetGlobal('q_pribBattle_started')==0 then
		if(what == 1) then
			-- infiltrate only
			-- get cumans equip
			ItemUtils.CreateInvItem(player, 'fd6cceee-06d0-4a0b-a0f6-c52d0afd5481')
			ItemUtils.CreateInvItem(player, 'fd6cceee-06d0-4a0b-a0f6-c52d0afd5481')
			ItemUtils.CreateInvItem(player, 'fd6cceee-06d0-4a0b-a0f6-c52d0afd5481')
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '4d29d49a-e6d1-d0a0-47b7-3fac105c23b5'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '407f6f52-d70e-7e3b-056d-cda8069aab86'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '43f19e40-1107-38aa-a226-5d6179e9b4a3'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '4e8bfdae-a38a-fae5-1177-b513733f1c90'))
			player.actor:EquipInventoryItem(ItemUtils.CreateInvItem(player, '4249522f-a1db-7d3e-020f-237390c80ba2'))
			BETAJumpCampNoMach()
		elseif(what == 2) then
			BETAJumpCampMach()
		elseif(what == 3) then
			startPribBattle(0, {sabotages_arrows = 0, sabotages_poison = 0, banditKills = 0, reinforcementLevel = 7})
		elseif(what == 4) then
			startPribBattle(0, {sabotages_arrows = 3, sabotages_poison = 3, banditKills = 24, reinforcementLevel = 6})
		elseif(what == 5) then
			startPribBattle(0, {sabotages_arrows = 4, sabotages_poison = 4, banditKills = 30, reinforcementLevel = 1})
		end
	end
end

-- =============================================================================
function Player:CheatMoveTime(entity, howmuch)
	local t = howmuch or 1
	System.Log(". . skipping ".. t .." hour(s)..")
	Calendar.SetWorldTime(Calendar.GetWorldTime()+t*3600)
	return true
end

-- =============================================================================
function Player:CheatGiveSword(entity)
	local swordGuid = "2f2095b6-ad4b-4002-9af3-96612f3e143c"
	local id = entity.inventory:FindItem(swordGuid)
	if (id == nil) then
		entity.inventory:CreateItem(swordGuid,1,1)
		id = entity.inventory:FindItem(swordGuid)
	end
	entity.actor:EquipInventoryItem(id)

	entity.human:DrawWeapon()
	return true
end
--WH_NOMASTER_END
--]]

-- =============================================================================
function Player:CheatEngine_money(entity)
--[[
--WH_NOMASTER_START
	entity.inventory:CreateItem("5ef63059-322e-4e1b-abe8-926e100c770e", 1, 1000)
	self:CheatEngine(nil)
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:CheatEngine_time(entity)
--[[
--WH_NOMASTER_START
	if(cheat_engine_mainmenu == 1) then
		cheat_engine_mainmenu = 2
		g_globalTimeSpeed = Calendar.GetWorldTimeRatio()
		Calendar.SetWorldTimeRatio(600)
	else
		cheat_engine_mainmenu = 1
		Calendar.SetWorldTimeRatio(g_globalTimeSpeed)
	end
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:CheatEngine_equipweapon(entity, what)
--[[
--WH_NOMASTER_START
	System.Log("CHEAT: equiping: "..what)
	local weapon1 = ""
	local weapon2 = ""
	local item

	if(what == "cheat_gear_longsword") then
		weapon1 = "5"
	elseif(what == "cheat_gear_shortsword_shield") then
		weapon1 = "6c8a6e64-350c-4f47-9a3f-18e3450987ef"
		weapon2 = "5b7ed53e-3554-47c7-817b-b971a2d99713"
	elseif(what == "cheat_gear_axe_shield") then
		weapon1 = "547dbb33-e2a7-414c-a2ea-379c96b776ee"
		weapon2 = "5b7ed53e-3554-47c7-817b-b971a2d99713"
		entity.inventory:AddItem(ItemManager.CreateItem("196be21b-6d21-4dd6-84e4-c95ecd2092a7", 1, 1));	-- adding mace to inv
	end

	item = ItemManager.CreateItem(weapon1, 1, 1)
	entity.inventory:AddItem(item)
	entity.actor:EquipInventoryItem(item)

	if(weapon2 ~= "") then
		item = ItemManager.CreateItem(weapon2, 1, 1)
		entity.inventory:AddItem(item)
		entity.actor:EquipInventoryItem(item)
	end
	entity.human:DrawWeapon()

	cheat_engine_sub = 0
	self:CheatEngine("cheat_engine_gear")
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:CheatEngine_animal(what)
--[[
--WH_NOMASTER_START
   local whatAbs = math.abs(what)
   local value = 0.05
   if what < 0 then
      value = -0.05
   end

   if(whatAbs == 0) then --close
		cheat_engine_sub = 0
		ActionMapManager.EnableActionMap("cheat_engine_animal", false)
		self:CheatEngine(nil)
		return true
	elseif (whatAbs == 99) then --print
	Dump("Animal setting parameters")
	for i=1,11,1 do
		Dump(Variables.GetGlobal("cheat_animal_test"..i))
	end
	else
		local global = "cheat_animal_test"..whatAbs
		local newValue = Variables.GetGlobal(global)+value
		Variables.SetGlobal(global,newValue)
		Game.LogGameEvent("New value: "..newValue)
	end
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:CheatEngine_stat(stat)
--[[
--WH_NOMASTER_START
	if(stat == 0) then	-- close
		cheat_engine_sub = ""
		self:CheatEngine("cheat_engine_stat")
		return true
	end

	g_localActor.soul:AdvanceToStatLevel(stat, g_localActor.soul:GetStatLevel(stat)+2)
	Game.LogGameEvent(stat..': now '..g_localActor.soul:GetStatLevel(stat))
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:CheatEngine_skill(what)
--[[
--WH_NOMASTER_START
	if(what == 0) then
		cheat_engine_sub = 0
		self:CheatEngine("cheat_engine_skill")
		return true
	end

	g_localActor.soul:AdvanceToSkillLevel(what, g_localActor.soul:GetSkillLevel(what)+2)
	Game.LogGameEvent(what..': now '..g_localActor.soul:GetSkillLevel(what))
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:CheatGiveBow(entity)
--[[
--WH_NOMASTER_START
	local id = entity.inventory:FindItem("6e06e314-5cc0-41eb-a7b6-69896b121413")
	if (id == nil) then
		id = ItemManager.CreateItem("6e06e314-5cc0-41eb-a7b6-69896b121413",1,1)
		id = entity.inventory:AddItem(id)
	end
	entity.actor:EquipInventoryItem(id)

	local id = entity.inventory:FindItem("ad6f0f01-aec4-44d1-982c-1210eb01b74a")
	if (id == nil) then
		id = ItemManager.CreateItem("ad6f0f01-aec4-44d1-982c-1210eb01b74a",1,50)
		id = entity.inventory:AddItem(id)
	end
	entity.actor:EquipInventoryItem(id)

	if g_localActor.soul:GetSkillLevel("marksmanship") < 15 then
		g_localActor.soul:AdvanceToSkillLevel("marksmanship", 15)
	end

	entity.human:DrawWeapon()
	self:CheatEngine(nil)
	return true
--WH_NOMASTER_END
--]]
end

-- =============================================================================
function Player:OnLoadAI(saved)
	self.AI = {}
	if(saved.AI) then
		self.AI = saved.AI
	end
end

-- =============================================================================
function Player:OnSaveAI(save)
	if(self.AI) then
		save.AI = self.AI
	end
end

-- =============================================================================
function Player:SetModel(model, arms, frozen, fp3p)
	if (model) then
		if (fp3p) then
			self.Properties.clientFileModel = fp3p
		end
		self.Properties.fileModel = model

		if (arms) then
			self.Properties.fpItemHandsModel = arms
		end
	end
end

-- =============================================================================
function Player:OnInit()

--	AI.RegisterWithAI(self.id, AIOBJECT_PLAYER, self.Properties)
	self:SetAIName(self:GetName()); -- scriptbind_entity
	----------------------------------------
	telepMen = {1, 6, 2, 3, 4, 5, 6}
	telepPos = 0
	telepAct = 0

	self:OnReset(true)
end

-- =============================================================================
function Player:OnReset(bFromInit, bIsReload)
	BasicActor.Reset(self, bFromInit, bIsReload)

	table.Merge(Player.SignalData, g_SignalData)

	-- Reset all properties to editor set values.
	if AI then AI.ResetParameters(self.id, bIsReload, self.Properties, self.PropertiesInstance, nil,self.melee) end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(Player, BasicActor)
