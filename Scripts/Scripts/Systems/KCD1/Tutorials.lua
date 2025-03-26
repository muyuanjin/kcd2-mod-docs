
Tutorials = {}

-- =============================================================================
function Tutorials.InitData()

	local result = {}

	local function addTutorial (name, values)

		-- for overlay tutorials --
		values.isOverlay = values.isOverlay or false
		values.overlayName = values.overlayName or ''
		values.isDLCOverlay = values.isDLCOverlay or false
		values.isGotyOverlay = values.isGotyOverlay or false

		-- for normal tutorials shown in corner --

		values.isAlwaysShownAsHenry = values.isAlwaysShownAsHenry or false -- tutorial is always shown, independent on the setup in game menu
		values.contentStringName = values.contentStringName or '<invalid>'
		values.perk = values.perk or ''
		values.showDuration = values.showDuration or 15
		values.syncWithDialog = values.syncWithDialog or false
		values.forceTutorial = values.forceTutorial or false -- show immediately

		-- dlc4 tutorials
		values.disableInTheresasLevel = values.disableInTheresasLevel or false

		-- hardcore mode tutorials setup
		values.isActiveInHarcoreMode = values.isActiveInHarcoreMode or false
		values.hardcoreModeContentStringNameOverride = values.hardcoreModeContentStringNameOverride or ''
		values.hardcoreModePerkOverride = values.hardcoreModePerkOverride or ''

		-- for tutorials which are placed in q_tutorials like objectives and need to complete them without any more informations (ex. pickpocket training objective after complete quest first time) --
		values.isEmpty = values.isEmpty or false

		-- for all tutorials together --
		values.repetitions = values.repetitions or 1
		values.cooldown = values.cooldown or '3m'
		values.nextShow = values.nextShow or 0

		result[name] = values

	end

	addTutorial('pickpocket',
	{
		contentStringName = 'chap14_sch29_yLmT_e45_XI8w',
		perk = '43711486-e6cb-46ff-874a-caaf5e643031',
		disableInTheresasLevel = true
	})

	addTutorial('bleeding',
	{
		contentStringName = 'chap14_sch29_yLmT_e27_WYdp',
	})

	addTutorial('callHorse',
	{
		contentStringName = 'chap14_sch29_yLmT_e53_Yey8',
		perk = '3e69e852-2bb6-44c4-8e6a-be659a4ff496',
		disableInTheresasLevel = true
	})

	addTutorial('lockpicking',
	{
		isEmpty = true
	})

	addTutorial('haggle',
	{
		contentStringName = 'chap14_sch29_yLmT_e17_keCW',
		perk = '72016e5b-6ed8-4256-b3da-22f4f60ba4e1',
		syncWithDialog = true,
		showDuration = -1,
		disableInTheresasLevel = true
	})

	addTutorial('mountHorse',
	{
		isOverlay = true,
		overlayName = 'horse',
		disableInTheresasLevel = true
		-- predelano na overlay contentStringName = 'chap14_sch29_yLmT_e55_1cag',
		-- predelano na overlay perk = '3e69e852-2bb6-44c4-8e6a-be659a4ff496'
	})

	addTutorial('move',
	{
		contentStringName = 'chap14_sch29_yLmT_e9_HlrL',
		perk = '9c2ca1b3-100b-4fdc-96f8-7f4e82461488',
		disableInTheresasLevel = true
	})

	addTutorial('objectives',
	{
		contentStringName = 'chap14_sch29_yLmT_e13_YuQX',
		perk = '0c89082e-41fa-4f7e-bb17-8166bbad8d9c',
		disableInTheresasLevel = true
	})

	addTutorial('quests',
	{
		contentStringName = 'chap14_sch29_yLmT_e11_bw0R',
		perk = '0c89082e-41fa-4f7e-bb17-8166bbad8d9c',
		disableInTheresasLevel = true,
		forceTutorial = true
	})

	addTutorial('reputation',
	{
		contentStringName = 'chap14_sch29_yLmT_e23_HnbD',
	})

	addTutorial('save',
	{
		contentStringName = 'chap14_sch29_yLmT_e20_duQ2',
		perk = '9c2ca1b3-100b-4fdc-96f8-7f4e82461488'
	})

	addTutorial('shop',
	{
		contentStringName = 'chap14_sch29_yLmT_e15_8M2H',
		perk = '72016e5b-6ed8-4256-b3da-22f4f60ba4e1',
		disableInTheresasLevel = true
	})

	addTutorial('stats',
	{
		contentStringName = 'chap14_sch29_yLmT_e7_eEDZ',
		perk = '3b6eebc0-0ed9-4569-bb62-679d59e0d152',
		syncWithDialog = true,
		showDuration = -1,
		disableInTheresasLevel = true
	})

	addTutorial('stealing',
	{
		contentStringName = 'chap14_sch29_yLmT_e39_ubvz',
	})

	addTutorial('stealth',
	{
		contentStringName = 'chap14_sch29_yLmT_e41_CnNI',
		perk = 'e729d4d6-0c54-4537-8667-a53defa20f43'
	})

	addTutorial('talking',
	{
		contentStringName = 'chap14_sch29_yLmT_e9_qHkj',
		perk = '5f6fb230-830f-427e-8e03-0a7782bd6deb',
		disableInTheresasLevel = true
	})

	addTutorial('tresspassing',
	{
		contentStringName = 'chap14_sch29_yLmT_e43_4we3',
	})

	addTutorial('injury',
	{
		contentStringName = 'chap14_sch29_yLmT_e25_ous7',
		perk = '2ddc47b1-338a-4602-8b24-5fba6a1c862b',
	})

	addTutorial('escapeToTalmberk',
	{
		contentStringName = 'chap14_sch29_yLmT_e9_Gl12',
		perk = '',
		forceTutorial = true,
		disableInTheresasLevel = true
	})

	addTutorial('experience',
	{
		contentStringName = 'chap14_sch29_yLmT_e19_zic4',
		perk = '3b6eebc0-0ed9-4569-bb62-679d59e0d152',
		disableInTheresasLevel = true
	})

	addTutorial('perks',
	{
		contentStringName = 'chap14_sch29_yLmT_e21_q48i',
		perk = '3b6eebc0-0ed9-4569-bb62-679d59e0d152',
		disableInTheresasLevel = true
	})

	addTutorial('inventory',
	{
		contentStringName = 'chap14_sch29_yLmT_e21_6oDO',
		perk = 'e93776b8-2dab-4d07-949b-dd75be0ab1bc',
		disableInTheresasLevel = true
	})

	addTutorial('codex',
	{
		contentStringName = 'chap14_sch29_yLmT_e25_WP9S',
		perk = '9c2ca1b3-100b-4fdc-96f8-7f4e82461488'
	})

	addTutorial('bleedWithPerk',
	{
		contentStringName = 'chap14_sch29_yLmT_e29_6tRz',
		perk = '2ddc47b1-338a-4602-8b24-5fba6a1c862b',
		disableInTheresasLevel = true
	})

	addTutorial('bleedWithoutPerk',
	{
		contentStringName = 'chap14_sch29_yLmT_e31_tcE9',
		disableInTheresasLevel = true
	})

	addTutorial('mercy',
	{
		contentStringName = 'chap14_sch29_yLmT_e33_bXmS',
		perk = '63170514-b5a3-42fa-ada0-38c1815a756b'
	})

	addTutorial('giveUp',
	{
		contentStringName = 'chap14_sch29_yLmT_e62_ICjc',
		perk = '63170514-b5a3-42fa-ada0-38c1815a756b',
		forceTutorial = true
	})

	addTutorial('giveUpCapture',
	{
		contentStringName = 'chap14_sch29_yLmT_e67_RJnl',
	})

	addTutorial('stealth',
	{
		contentStringName = 'chap14_sch29_yLmT_e35_9h2b',
		perk = 'e729d4d6-0c54-4537-8667-a53defa20f43'
	})

	addTutorial('disguise',
	{
		contentStringName = 'chap14_sch29_yLmT_e37_92Lt',
		perk = 'e729d4d6-0c54-4537-8667-a53defa20f43'
	})

	addTutorial('punishment',
	{
		contentStringName = 'chap14_sch29_yLmT_e41_CnNI',
		perk = 'a50139d3-dde2-496b-a5e3-de629fb0b366'
	})

	addTutorial('hunger',
	{
		contentStringName = 'chap14_sch29_yLmT_e47_cKvv',
		perk = '8b52626b-f736-4e82-b323-c6f46daace3a',
		disableInTheresasLevel = true
	})

	addTutorial('alcohol',
	{
		contentStringName = 'chap14_sch29_yLmT_e59_V5Wz',
		perk = '8ddbe313-e988-4442-a552-d1761a4b28f2'
	})

	addTutorial('fatigue',
	{
		contentStringName = 'chap14_sch29_yLmT_e49_u4S2',
		perk = 'a42e411d-d4d2-40bb-8464-2fe03f69fe54',
		disableInTheresasLevel = true
	})

	addTutorial('overload',
	{
		contentStringName = 'chap14_sch29_yLmT_e98_JtR3',
		perk = '8b52626b-f736-4e82-b323-c6f46daace3a',
		disableInTheresasLevel = true
	})

	addTutorial('overeating',
	{
		contentStringName = 'chap14_sch29_yLmT_e101_3j95',
		perk = '8b52626b-f736-4e82-b323-c6f46daace3a'
	})

	addTutorial('skipTime',
	{
		contentStringName = 'chap14_sch29_yLmT_e51_DoMK',
		perk = 'a42e411d-d4d2-40bb-8464-2fe03f69fe54',
		disableInTheresasLevel = true
	})

	addTutorial('horseStats',
	{
		contentStringName = 'chap14_sch29_yLmT_e61_BpYE',
		perk = '3e69e852-2bb6-44c4-8e6a-be659a4ff496',
		disableInTheresasLevel = true
	})

	addTutorial('fastTravel',
	{
		contentStringName = 'chap14_sch29_yLmT_e57_zuui',
		disableInTheresasLevel = true
	})

	addTutorial('alchemy',
	{
		isEmpty = true,
		disableInTheresasLevel = true
	})

	addTutorial('dices',
	{
		isEmpty = true
	})

	addTutorial('repairing',
	{
		contentStringName = 'chap14_sch29_yLmT_e63_srI0',
		perk = 'c41ba2b8-fac5-4e11-af66-01e2c949226e'
	})

	addTutorial('sharpening',
	{
		contentStringName = 'chap14_sch29_yLmT_e79_hs14',
		perk = 'c41ba2b8-fac5-4e11-af66-01e2c949226e'
	})

	addTutorial('reading',
	{
		contentStringName = 'chap14_sch29_yLmT_e65_MZDM',
		perk = '29f2b7da-eed5-421d-b763-91c461075f76',
		disableInTheresasLevel = true
	})

	addTutorial('poisoning',
	{
		contentStringName = 'chap14_sch29_yLmT_e202_Mi8E',
	})

	addTutorial('weaponStats1',
	{
		contentStringName = 'chap14_sch29_yLmT_e205_35L6',
	})

	addTutorial('weaponStats2',
	{
		contentStringName = 'chap14_sch29_yLmT_e208_7heA',
	})

	addTutorial('trophies',
	{
		contentStringName = 'chap14_sch29_yLmT_e211_eTep',
	})

	addTutorial('trophiesHuntWithPtacek',
	{
		contentStringName = 'chap14_sch29_yLmT_e211_eTep',
		disableInTheresasLevel = true
	})

	addTutorial('holdWeapon',
	{
		contentStringName = 'chap14_sch29_yLmT_e224_Yril',
	})

	addTutorial('walkNightWatch',
	{
		contentStringName = 'chap14_sch29_yLmT_e229_7Yjz',
		disableInTheresasLevel = true
	})

	addTutorial('walkMillerDate',
	{
		contentStringName = 'chap14_sch29_yLmT_e229_7Yjz',
		disableInTheresasLevel = true
	})

	addTutorial('walkMonastery',
	{
		contentStringName = 'chap14_sch29_yLmT_e229_7Yjz',
		disableInTheresasLevel = true
	})

	addTutorial('surrender',
	{
		contentStringName = 'chap14_sch29_yLmT_e92_H8h7',
		perk = '63170514-b5a3-42fa-ada0-38c1815a756b'
	})

	addTutorial('sellingStolen',
	{
		contentStringName = 'chap14_sch29_yLmT_e39_ubvz',
	})

	addTutorial('yourHome',
	{
		contentStringName = 'chap14_sch29_yLmT_e235_2CZV',
		forceTutorial = true,
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		disableInTheresasLevel = true
	})

	-- rozdil mezi verzi 1 a 2 je v uprave pravidel. Mezi verzemi 1.6 a 1.7 se kostky trochu zmenily. Tato zmena je primo v tutorialu ''dice'' zanesena. Tzn. ve verzi 1.6 vypadala pravidla jinak a v 1.7 zase jinak, ale
	-- s temito zmenami se nevytvarel zbytecne novy tutorial - http://youtrack/issue/DLC-2173
	addTutorial('overlayDice',
	{
		isOverlay = true,
		overlayName = 'dice'
	})

	addTutorial('overlayDiceVer2',
	{
		isOverlay = true,
		overlayName = 'dice'
	})

	addTutorial('overlayDiceDiff1_2',
	{
		isOverlay = true,
		overlayName = 'dice_addition'
	})

	addTutorial('overlayHaggle',
	{
		isOverlay = true,
		overlayName = 'haggle',
		disableInTheresasLevel = true
	})

	addTutorial('overlayLockpick',
	{
		isOverlay = true,
		overlayName = 'lockpick'
	})

	addTutorial('overlaySharpening',
	{
		isOverlay = true,
		overlayName = 'sharpening',
		disableInTheresasLevel = true
	})

	addTutorial('overlayPickpocket',
	{
		isOverlay = true,
		overlayName = 'pickpocket',
		disableInTheresasLevel = true
	})

	addTutorial('overlayAlchemy',
	{
		isOverlay = true,
		overlayName = 'alchemy',
		disableInTheresasLevel = true
	})

	addTutorial('overlayEXPOCombat',
	{
		isOverlay = true,
		overlayName = 'expoCombat',
		disableInTheresasLevel = true
	})

	addTutorial('trainingPickpocket',
	{
		isEmpty = true,
		disableInTheresasLevel = true
	})

	addTutorial('overlayCombat',
	{
		isOverlay = true,
		overlayName = 'combat',
		disableInTheresasLevel = true
	})

	addTutorial('overlayCombatUnarmed',
	{
		isOverlay = true,
		overlayName = 'combat_unarmed',
		disableInTheresasLevel = true
	})

		addTutorial('overlayCombatWeapon',
	{
		isOverlay = true,
		overlayName = 'combat',
		disableInTheresasLevel = true
	})

	addTutorial('jail',
	{
		isEmpty = true,
		disableInTheresasLevel = true
	})

	addTutorial('lowReputation',
	{
		contentStringName = 'chap14_sch29_yLmT_e238_m8jr'
	})

	addTutorial('enemyReputation',
	{
		contentStringName = 'chap14_sch29_yLmT_e241_WQjG',
		-- opakovani nastaveno z KCD-65771
		repetitions = 1000,
		cooldown = '10m',
	})

	addTutorial('huntAttack',
	{
		contentStringName = 'chap14_sch29_yLmT_e251_gB1z',
		forceTutorial = true
	})

	addTutorial('anotherHome',
	{
		contentStringName = 'chap14_sch29_yLmT_e238_olV0',
		forceTutorial = true,
		repetitions = 30,
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		disableInTheresasLevel = true
	})

	addTutorial('pirkstejnHome',
	{
		contentStringName = 'chap14_sch29_yLmT_e260_4a2Q',
		forceTutorial = true,
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		disableInTheresasLevel = true
	})

	-- KCD-79706 - na zaklade bugu obj. overlayDLC1 otevira dlc_1_2 a naopak DLC2 otevira dlc_1
	addTutorial('overlayDLC1',
	{
		isOverlay = true,
		overlayName = 'dlc_1_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	-- KCD-79706 - na zaklade bugu obj. overlayDLC1 otevira dlc_1_2 a naopak DLC2 otevira dlc_1
	addTutorial('overlayDLC1_2',
	{
		isOverlay = true,
		overlayName = 'dlc_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC4_1',
	{
		isOverlay = true,
		overlayName = 'dlc_4_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC4_2',
	{
		isOverlay = true,
		overlayName = 'dlc_4_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('useSavePotion',
	{
		contentStringName = 'chap14_sch29_yLmT_e266_QIMA',
		disableInTheresasLevel = true
	})

	addTutorial('torch',
	{
		contentStringName = 'chap14_sch29_yLmT_e263_opx4',
		disableInTheresasLevel = true
	})

	addTutorial('overlayEpilog',
	{
		isOverlay = true,
		overlayName = 'epilog',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	addTutorial('playersHorse',
	{
		contentStringName = 'chap14_sch29_yLmT_e174_dsC8',
		disableInTheresasLevel = true
	})

	addTutorial('gravedigger',
	{
		contentStringName = 'chap14_sch29_yLmT_e277_qFQt',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	-- special kind of tutorial - has condition in behavior - this tutorial is only for Hardcore mode (in normal mode is prohibited)
	addTutorial('overlayHardcoreMode',
	{
		isOverlay = true,
		overlayName = 'hardcore_mode',
		isActiveInHarcoreMode = true,
	})

	addTutorial('smokedFood',
	{
		contentStringName = 'chap14_sch29_yLmT_e282_CPJc',
	})

	addTutorial('brewery',
	{
		contentStringName = 'chap14_sch29_yLmT_e1_xERA',
	})


	addTutorial('tournament',
	{
		contentStringName = 'chap14_sch29_yLmT_e396_QePo',
		perk = '57ec597f-2d70-4419-844f-0e50dd69577b'
	})

	addTutorial('overlayTournament_1',
	{
		isOverlay = true,
		overlayName = 'tournament_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayTournament_2',
	{
		isOverlay = true,
		overlayName = 'tournament_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	addTutorial('overlayTournament_3',
	{
		isOverlay = true,
		overlayName = 'tournament_3',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	-- DLC8 - Ptackova romanticka dobrodruzstvi
	addTutorial('overlayDLC8_1',
	{
		isOverlay = true,
		overlayName = 'dlc_8_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC8_2',
	{
		isOverlay = true,
		overlayName = 'dlc_8_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC8_3',
	{
		isOverlay = true,
		overlayName = 'dlc_8_3',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	-- DLC 9 - bands of bastards
	-- overlay pro DLC3 - pred pribyslavicema
	addTutorial('overlayDLC9_1',
	{
		isOverlay = true,
		overlayName = 'dlc_9_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	-- overlay pro DLC3 - po pribyslavicich
	addTutorial('overlayDLC9_2',
	{
		isOverlay = true,
		overlayName = 'dlc_9_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('barking',
	{
		contentStringName = 'chap14_sch29_yLmT_e289_eota',
		isActiveInHarcoreMode = true,
		isAlwaysShownAsHenry = true,
	})

	-- DLC 10 - Theresa
	addTutorial('overlayDLC10_theresaEnd',
	{
		isOverlay = true,
		overlayName = 'theresaEnd',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	-- DLC - DOG
	addTutorial('overlayDLC_dog_1',
	{
		isOverlay = true,
		overlayName = 'dlc_dog_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	-- DLC - DOG
	addTutorial('overlayDLC_dog_2',
	{
		isOverlay = true,
		overlayName = 'dlc_dog_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	-- DLC - DOG
	addTutorial('overlayDog',
	{
		isOverlay = true,
		overlayName = 'dog',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
	})

	addTutorial('inventoryFood',
	{
		contentStringName = 'chap14_sch29_yLmT_e313_U7oH'
	})

	addTutorial('compas',
	{
		contentStringName = 'chap14_sch29_yLmT_e311_okJT'
	})

	addTutorial('staminaHorse',
	{
		contentStringName = 'chap14_sch29_yLmT_e309_ViqT'
	})

	addTutorial('surrenderFailed',
	{
		contentStringName = 'chap14_sch29_yLmT_e307_bOlm'
	})

	addTutorial('theresasStealthKill',
	{
		contentStringName = 'chap_dlc4_sch18_FJ22_e81_iK55',
		isAlwaysShownAsHenry = true
	})

	addTutorial('combatSwordsUI1',
	{
		contentStringName = 'chap14_sch29_yLmT_e317_7cvf'
	})

	addTutorial('combatSwordsUI2',
	{
		contentStringName = 'chap14_sch29_yLmT_e332_Tho9'
	})

	addTutorial('dogHasRanAway',
	{
		contentStringName = 'chap14_sch29_yLmT_e291_XTpQ'
	})

	addTutorial('dogAlarmPerk',
	{
		contentStringName = 'chap14_sch29_yLmT_e295_LOiH'
	})

	addTutorial('dogSearchPerk',
	{
		contentStringName = 'chap14_sch29_yLmT_e297_vuVL'
	})

	addTutorial('dogHuntPerk',
	{
		contentStringName = 'chap14_sch29_yLmT_e299_6eqi'
	})

	addTutorial('dogAggressiveMode',
	{
		contentStringName = 'chap14_sch29_yLmT_e301_mEWh'
	})

	addTutorial('dogFollowMode',
	{
		contentStringName = 'chap14_sch29_yLmT_e303_RSMi'
	})

	addTutorial('dogFreeMode',
	{
		contentStringName = 'chap14_sch29_yLmT_e305_VIJp'
	})

	addTutorial('dogWaitMode',
	{
		contentStringName = 'chap14_sch29_yLmT_e307_18ZE'
	})

	addTutorial('dogLowMorale',
	{
		contentStringName = 'chap14_sch29_yLmT_e383_W7OM'
	})

	--used in q_master_main to start DLC_tutorials_evaluation
	addTutorial('DLC_overlay_starter',
	{
		isEmpty = true
	})

	addTutorial('firstAidTheresa',
	{
		contentStringName = 'chap_dlc4_sch17_NeWe_e146_Y9bJ',
		isAlwaysShownAsHenry = true
	})

	addTutorial('overlayDLC_10_1',
	{
		isOverlay = true,
		overlayName = 'dlc_10_1',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC_10_2',
	{
		isOverlay = true,
		overlayName = 'dlc_10_2',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC_10_3',
	{
		isOverlay = true,
		overlayName = 'dlc_10_3',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isDLCOverlay = true,
	})

	addTutorial('overlayDLC_all',
	{
		isOverlay = true,
		overlayName = 'dlc_all',
		isAlwaysShownAsHenry = true,
		isActiveInHarcoreMode = true,
		isGotyOverlay = true,
	})

	addTutorial('allDLCOwned',
	{
		isEmpty = true
	})

	return result

end
