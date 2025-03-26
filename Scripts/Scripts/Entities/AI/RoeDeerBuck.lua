RoeDeerBuck = {
    ActionController = "Animations/Mannequin/ADB/kcd_roebuck_controllerdefs.xml",
    AnimDatabase3P = "Animations/Mannequin/ADB/kcd_roebuck_database.adb",

	UseMannequinAGState = true,

	defaultSoulArchetype = "RoeDeerBuck",
	defaultSoulClass = "roe_deer_buck",
	CombatOpponentMnTag = "oppRoebuck",

	Properties = {
		bCanHoldInformation = true, -- Wild animals use information for startling
		esNavigationType = "MediumSizedCharacters",
		sWH_AI_EntityCategory = "",
		bWH_PerceptorObject = true,
		bWH_PerceptibleObject = true,
		bWH_ListenerObject = true,
		bWH_RequiresHome = false,
		NPC = {
			eiNPCCategory = 1,
			aianchorHome = "",
		},
		fileModel = "Objects/Characters/animals/roebuck/roebuck.cdf",
		esClothingConfig = "roe_deer_buck",
		bNotPlayerMountable = false,
		
		CharacterSounds =
		{
			footstepEffect = "footsteps_deer",			-- Footstep mfx library to use
			remoteFootstepEffect = "footsteps_deer",		-- Footstep mfx library to use for remote players
			bFootstepGearEffect = true,				-- This plays a sound from materialfx
			footstepIndGearAudioSignal_Walk = "",   -- This directly plays the specified audiosignal on every footstep
			footstepIndGearAudioSignal_Run = "",	-- This directly plays the specified audiosignal on every footstep
			foleyEffect = "foley_deer",					-- Foley signal effect name
		},
	},

	collisionCapsule =
	{
		radius = 0.15,
		height = 0.6,
		axis   = {x=0,y=1,z=0},
		pos    = {x=0,y=0,z=0.65},
		posCarcass = {x=-0.05,y=-0.15,z=0.15},
	},

	physicsParams =
	{
		mass = 30,

		Living =
		{
			mass = 30,
		},
	},

	gameParams =
	{
		stance =
		{
			normal = {
				stanceId = E_ACTORSTANCE_NORMAL,
				heightCollider = 0.4,
				heightPivot = 0.0,
				size = {x=0.1,y=0.0,z=0.01},
				viewOffset = {x=0,y=0.10,z=0.5},
				name = "normal",
				useCapsule = 0,
			},
		},

		inertia = 0.0, --the more, the faster the speed change: 1 is very slow, 10 is very fast already
		inertiaAccel = 0.0,
	},
	
    ProceduralContextLook =
    {
        polarCoordinatesSmoothEnable = true,
        polarCoordinatesSmoothTimeSeconds = 0.2,
        polarCoordinatesMaxYawDegreesPerSecond = 360,
        polarCoordinatesMaxPitchDegreesPerSecond = 360,
        -- default values that are overriden from PC Looking
        fadeInSeconds = 0.8,
        fadeOutSeconds = 0.8,
        fadeOutMinDistance = 0.0,
    },
	-- the AI movement ability
	AIMovementAbility =
	{
		usePredictiveFollowing = 1,
		pathLookAhead = 1,
		walkSpeed = 1.5,
		runSpeed = 2.5,
		sprintSpeed = 7.0,

		b3DMove = 0,
		minTurnRadius = 0,	-- meters
		maxTurnRadius = 3,	-- meters
		pathSpeedLookAheadPerSpeed = -1.5,
		cornerSlowDown = 0.75,
		pathType = "AIPATH_HUMAN",
		pathRadius = 0.4,
		maneuverSpeed = 1.5,
		pathFindPrediction = 0.5,		-- predict the start of the path finding in the future to prevent turning back when tracing the path.
		maxAccel = 2.0,
		maxDecel = 4.0,
		velDecay = 0.5,
		maneuverTrh = 2.0,  -- when cross(dir, desiredDir) > this use manouvering
		resolveStickingInTrace = 1,
		pathRegenIntervalDuringTrace = 4,
		
		collisionAvoidanceParticipation = true,
		passRadius = 1.25,

		AIMovementSpeeds =
		{
			--         { default, min, max }
			Relaxed =
			{
				Slow   = { 0.9,     0.8, 1.3 },
				Walk   = { 1.5,     1.3, 2.0 },
				Run    = { 2.5,     2.0, 3.0 },
				Sprint = { 7.0,    5.0, 8.0 },
			},
		},
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(
	RoeDeerBuck,
	BasicAnimal,
    BasicAI
)

EntityCommon.MakeSpawnable(RoeDeerBuck)