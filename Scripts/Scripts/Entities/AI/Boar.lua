Boar = {
    ActionController = "Animations/Mannequin/ADB/kcd_pig_controllerdefs.xml",
    AnimDatabase3P = "Animations/Mannequin/ADB/kcd_pig_database.adb",

    UseMannequinAGState = true,

    defaultSoulArchetype = "Boar",
    defaultSoulClass = "pig",
    CombatOpponentMnTag = "oppPig",

    collisionClass = gcc_npc_reported_type,

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
        fileModel = "objects/characters/animals/boar/boar.cdf",
		esClothingConfig = "boar",
        bNotPlayerMountable = false,

        CharacterSounds =
        {
            footstepEffect = "footsteps_boar",			-- Footstep mfx library to use
            foleyEffect = "foley_boar",					-- Foley signal effect name
        },
    },

    collisionCapsule =
    {
        radius = 0.25,
        height = 0.8,
        pos    = {x=0,y=0.15,z=0.6},
        axis   = {x=0,y=1,z=0},
        posCarcass = {x=0.25,y=0.1,z=0.25},
    },

    physicsParams =
    {
        mass = 100,

        Living =
        {
            mass = 100,
        },
    },

    gameParams =
    {
        stance =
        {
            relaxed = {
                stanceId = E_ACTORSTANCE_NORMAL,
                heightCollider = 0.4,
                heightPivot = 0.0,
                size = {x=0.1,y=0.0,z=0.1},
                viewOffset = {x=0,y=0.10,z=0.5},
                name = "relaxed",
                useCapsule = 0,
            },
        },

        inertia = 0.0, --the more, the faster the speed change: 1 is very slow, 10 is very fast already
        inertiaAccel = 0.0,

        backwardMultiplier = 0.5,--speed is multiplied by this ammount when going backward

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
    Boar,
    BasicAnimal,
    BasicAI
)

EntityCommon.MakeSpawnable(Boar)