NPC = {
	ActionController = "Animations/Mannequin/ADB/kcd_male_controllerdefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/kcd_male_database.adb",
	OpponentMnTag = "relatedMale",
	CombatOpponentMnTag = "oppMale",
	--AnimDatabase1P = "",
	--SoundDatabase = "",

	UseMannequinAGState = true,

	Properties = {
		esNavigationType = "MediumSizedCharacters",
		sWH_AI_EntityCategory = "",
		bWH_PerceptorObject = true,
		bWH_PerceptibleObject = true,
		bWH_ListenerObject = true,
		bWH_CreateSituationSubsystem = true,
		bWH_RequiresHome = true,
		fileModel = "Objects/Characters/humans/male/skeleton/male.cdf",
		fileHitDeathReactionsParamsDataFile = "Libs/HitDeathReactionsData/HitDeathReactions_SkeletonMale.xml",
		esClothingConfig = "male2",
		voiceType = "enemy",
		perInstanceStreamingPriority = 0,
		eiSoundObstructionType = 2, -- See EAudioObjectObstructionCalcType
		CharacterSounds =
		{
			footstepEffect = "footsteps_npc",			-- Footstep mfx library to use
			foleyEffect = "foleys_npc",					-- Foley signal effect name
		},
	},

	gameParams =
	{
		inertia = 0.0, --the more, the faster the speed change: 1 is very slow, 10 is very fast already
		inertiaAccel = 0.0,
		lookFOV = 180, -- FOV of AI sight registration
		minimumAngleForTurnWithoutDelay = 20,
	},

	ProceduralContextLook =
	{
		polarCoordinatesSmoothEnable = true,
		polarCoordinatesSmoothTimeSeconds = 0.08,
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
		allowEntityClampingByAnimation = 1,
		usePredictiveFollowing = 1,
		pathLookAhead = 1,
		walkSpeed = 2.0, -- set up for humans
		runSpeed = 4.0,
		sprintSpeed = 6.4,
		maneuverSpeed = 1.5,
		b3DMove = 0,
		minTurnRadius = 0,	-- meters
		maxTurnRadius = 3,	-- meters
		pathSpeedLookAheadPerSpeed = -1.5,
		cornerSlowDown = 0.75,
		pathType = AIPATH_HUMAN,
		pathRadius = 0.25,
		passRadius = 0.25,

		distanceToCover = 0.5, -- needs to be at least 20cm more than max(passRadius, pathRadius)
		inCoverRadius = 0.075,
		effectiveCoverHeight = 0.55,
		effectiveHighCoverHeight = 1.75,

		pathFindPrediction = 0.5,		-- predict the start of the path finding in the future to prevent turning back when tracing the path.
		maxAccel = 2.0,
		maxDecel = 4.0,
		velDecay = 0.5,
		maneuverTrh = 2.0,  -- when cross(dir, desiredDir) > this use manouvering
		resolveStickingInTrace = 1,
		pathRegenIntervalDuringTrace = 1, -- MB: to avoid big look up into physic grid when evaluation whole path
		lightAffectsSpeed = 1,

		avoidanceAbilities = AVOIDANCE_ALL,
		pushableObstacleWeakAvoidance = true,
		pushableObstacleAvoidanceRadius = 0.4,

		-- These are actually aiparams (as they may be changed during game and need to get serialized),
		-- but defined here so that designers do not try to change them.
		lookIdleTurnSpeed = 30,
		lookCombatTurnSpeed = 50,
		aimTurnSpeed = -1, --120,
		fireTurnSpeed = -1, --120,

		-- Adjust the movement speed based on the angle between body dir and move dir.
		directionalScaleRefSpeedMin = 1.0,
		directionalScaleRefSpeedMax = 8.0,

		AIMovementSpeeds =
		{
			--            { default, min, max }
			Relaxed =
			{
				Slow =      { 0.6,     0.6, 0.6 },
				Walk =      { 1.1,     1.1, 1.1 },
				Run =       { 3.5,     3.5, 3.5 },
				Sprint =    { 5.0,     5.0, 5.0 },
			},
			Alerted =
			{
				Slow =      { 0.8,     0.8, 0.8 },
				Walk =      { 1.4,     1.4, 1.4 },
				Run =       { 3.5,     3.5, 3.5 },
				Sprint =    { 5.0,     5.0, 5.0 },
			},
			Combat =
			{
				Slow =      { 0.8,     0.8, 0.8 },
				Walk =      { 1.7,     1.7, 1.7 },
				Run =       { 4.5,     4.5, 4.5 }, -- Min should ideally be: Max - (<Idle2Move duration> * maxAccel)
				Sprint =    { 6.0,     6.0, 6.0 },
			},
			Crouch =
			{
				Slow =      { 0.8,     0.8, 0.8 },
				Walk =      { 1.3,     1.3, 1.3 },
				Run =       { 2.0,     2.0, 2.0 },
				Sprint =    { 2.0,     2.0, 2.0 },
			},
			LowCover =
			{
				Slow =      { 0.9,     0.9, 0.9 },
				Walk =      { 0.9,     0.9, 0.9 },
				Run =       { 1.8,     1.8, 1.8 },
				Sprint =    { 1.8,     1.8, 1.8 },
			},
			HighCover =
			{
				Slow =      { 1.3,     1.3, 1.3 },
				Walk =      { 1.3,     1.3, 1.3 },
				Run =       { 1.8,     1.8, 1.8 },
				Sprint =    { 1.8,     1.8, 1.8 },
			},
			Swim =
			{
				Slow =      { 1.0,     1.0, 1.0 },
				Walk =      { 1.0,     1.0, 1.0 },
				Run =       { 3.5,     3.5, 3.5 },
				Sprint =    { 5.0,     5.0, 5.0 },
			},
		},
	},

	-- collision damage
	collisionDamageThreshold = 2,
	lastCanTalkHintFlag = true,

	IsChatUsable = 1,
}

-- =============================================================================
function NPC:IsUsableMsgChanged()
	local newHintType = BasicAIActions.GetCanTalkHintType(self)
	if (newHintType ~= lastCanTalkHintFlag) then
		lastCanTalkHintFlag = newHintType
		return true
	end

	return false
end

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(
	NPC,
	BasicAIActions,
    BasicActor,
    BasicAI
)

EntityCommon.MakeSpawnable(NPC)