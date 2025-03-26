--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2005.

BasicAITable = {
	PropertiesInstance = {
		soclasses_SmartObjectClass = "",
		aibehavior_behaviour = "",
		bAutoDisable = false,
		nVariation = 0,
		esVoice = "",
	},

	Properties =
	{
		sWH_AI_EntityCategory = "",
		guidSharedSoulId = "",
		sharedSoulInstanceId = 0,

		commrange = 30.0,

		esVoice = "npc_default",
		esCommConfig = "npc_default",
		fFmodCharacterTypeParam = 0,
		esBehaviorSelectionTree = "",
		esModularBehaviorTree = "IdleSeq",
		esNavigationType = "",

		aicharacter_character = "",
		fileModel = "",
		nModelVariations=0,

		bInvulnerable = false,

		eiColliderMode = 0, -- zero as default, meaning 'script does not care and does not override graph, etc'.
	},

	-- the AI movement ability
	AIMovementAbility =
	{
		b3DMove = 0,
		pathLookAhead = 2,
		pathRadius = 0.3,
		walkSpeed = 2.0, -- set up for humans
		runSpeed = 4.0,
		sprintSpeed = 6.4,
		maxAccel = 1000000.0,
		maxDecel = 1000000.0,
		maneuverSpeed = 1.5,
		minTurnRadius = 0,	-- meters
		maxTurnRadius = 3,	-- meters
		maneuverTrh = 2.0,  -- when cross(dir, desiredDir) > this use manouvering
		resolveStickingInTrace = 1,
		pathRegenIntervalDuringTrace = -1,
		avoidanceRadius = 1.5,

		-- If this is turned off, then the AI will not avoid collisions, and will not
		-- be avoided by other AI either.
		collisionAvoidanceParticipation = true,

		-- When moving, this increment value will be progressively added
		-- to the agents avoidance radius (the rate is defined with the
		-- CollisionAvoidanceRadiusIncrementIncreaseRate/DecreaseRate
		-- console variables).
		-- This is meant to make the agent keep a bit more distance between
		-- him and other agents/obstacles. /Mario
		collisionAvoidanceRadiusIncrement = 0.0,
	},

	AI = {},
}