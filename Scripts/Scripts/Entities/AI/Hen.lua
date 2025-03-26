Hen = {
    ActionController = "Animations/Mannequin/ADB/kcd_hen_controllerdefs.xml",
    AnimDatabase3P = "Animations/Mannequin/ADB/kcd_hen_database.adb",

	UseMannequinAGState = true,

	defaultSoulArchetype = "Hen",

	Properties = {
		esNavigationType = "MediumSizedCharacters",
		sWH_AI_EntityCategory = "",
		bWH_PerceptorObject = false,
		bWH_PerceptibleObject = false,
		bWH_ListenerObject = false,
		bWH_RequiresHome = true,
		NPC = {
			eiNPCCategory = 1,
			aianchorHome = "",
		},
		fileModel = "Objects/Characters/animals/hen/hen_brown_light.cdf",

		CharacterSounds =
		{
			footstepEffect = "footsteps_Hare",			-- Footstep mfx library to use
			foleyEffect = "foley_Hare",					-- Foley signal effect name
		},
	},

	collisionCapsule =
	{
		radius = 0.15,
		height = 0.07,
		pos    = {x=0,y=0,z=0.25},
		axis   = {x=0,y=1,z=0},
	},

	physicsParams =
	{
		mass = 0.7,

		Living =
		{
			mass = 0.7,
		},
	},

	gameParams =
	{
		stance =
		{
			normal = {
				stanceId = E_ACTORSTANCE_NORMAL,
				heightCollider = 0.5,
				heightPivot = 0.0,
				size = {x=0.1,y=0.0,z=0.01},
				viewOffset = {x=0,y=0.10,z=1.625},
				name = "normal",
				useCapsule = 0,
			},
		},

		inertia = 0.0, --the more, the faster the speed change: 1 is very slow, 10 is very fast already
		inertiaAccel = 0.0,

		jumpHeight = 1.0,
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
	Hen,
	BasicAnimal,
    BasicAI
)

EntityCommon.MakeSpawnable(Hen)