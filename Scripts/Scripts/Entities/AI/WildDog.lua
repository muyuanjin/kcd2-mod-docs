WildDog = {
    ActionController = "Animations/Mannequin/ADB/kcd_dog_controllerdefs.xml",
    AnimDatabase3P = "Animations/Mannequin/ADB/kcd_dog_database.adb",

    UseMannequinAGState = true,

    defaultSoulArchetype = "WildDog",
    defaultSoulClass = "wilddog",
    OpponentMnTag = "relatedDog",
    CombatOpponentMnTag = "oppDog",

    Properties = {
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
        fileModel = "Objects/Characters/animals/Dog/dog.cdf",
        esClothingConfig = "wild_dog",
        bNotPlayerMountable = false,
        bCanHoldInformation = true,
        
        CharacterSounds =
        {
            footstepEffect = "footsteps_Dog",			-- Footstep mfx library to use
            foleyEffect = "foley_Dog",					-- Foley signal effect name
        },
    },

    physicsParams =
    {
        mass = 25,

        Living =
        {
            mass = 25,
            gravity = 30,
        },
    },

    collisionCapsule =
    {
        radius = 0.13,
        height = 0.55,
        axis   = {x=0,y=1,z=0},
        pos    = {x=0,y=0.05,z=0.52},
        posCarcass = {x=0.1,y=0.16,z=0.08},
    },

    gameParams =
    {
        stance =
        {
            combat = {
                stanceId = E_ACTORSTANCE_COMBAT,
                heightCollider = 0.4,
                heightPivot = 0.0,
                size = {x=0.1,y=0.0,z=0.01},
                viewOffset = {x=0,y=0.10,z=0.5},
                name = "combat",
                useCapsule = 0,
            },
            normal = {
                stanceId = E_ACTORSTANCE_NORMAL,
                heightCollider = 0.4,
                heightPivot = 0.0,
                size = {x=0.1,y=0.0,z=0.01},
                viewOffset = {x=0,y=0.10,z=0.5},
                name = "normal",
                useCapsule = 0,
            },
            crouch = {
                stanceId = E_ACTORSTANCE_CROUCH,
                heightCollider = 0.4,
                heightPivot = 0.0,
                size = {x=0.1,y=0.0,z=0.01},
                viewOffset = {x=0,y=0.10,z=0.5},
                name = "crouch",
                useCapsule = 0,
            },
            carryCorpse = {
                stanceId = E_ACTORSTANCE_CARRYCORPSE,
                heightCollider = 0.4,
                heightPivot = 0.0,
                size = {x=0.1,y=0.0,z=0.01},
                viewOffset = {x=0,y=0.10,z=0.5},
                name = "carryCorpse",
                useCapsule = 1,
            },
        },

        inertia = 0.0, --the more, the faster the speed change: 1 is very slow, 10 is very fast already
        inertiaAccel = 0.0,

        jumpHeight = 1.0,

        lookFOV = 180, -- FOV of AI sight registration

        animatedCharacterTurnSpeedSmoothingTime = 0.2,
    },

	ProceduralContextLook =
	{
		polarCoordinatesSmoothEnable = true,
		polarCoordinatesSmoothTimeSeconds = 0.2,
		polarCoordinatesMaxYawDegreesPerSecond = 360,
		polarCoordinatesMaxPitchDegreesPerSecond = 360,
		-- default values that are overriden from PC Looking
		fadeInSeconds = 1,
		fadeOutSeconds = 1,
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

        dashPossibleCheckDistance = 12.0,
        dashPossibleCheckRequiredSpeedParam = 0.75,

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

    IsChatUsable = 1,
}

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(
    WildDog,
    BasicAnimal,
    BasicAI
)

EntityCommon.MakeSpawnable(WildDog)