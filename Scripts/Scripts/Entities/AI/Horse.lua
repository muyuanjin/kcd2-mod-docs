Horse = {
	ActionController = "Animations/Mannequin/ADB/kcd_horse_controllerdefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/kcd_horse_database.adb",

	UseMannequinAGState = true,

	defaultSoulArchetype = "Horse",
	defaultSoulClass = "horse",

	Properties = {
		esNavigationType = "MediumSizedCharacters",
		sWH_AI_EntityCategory = "",
		bWH_PerceptorObject = true,
		bWH_PerceptibleObject = true,
		bWH_ListenerObject = true,
		bWH_RequiresHome = true,
		NPC = {
			eiNPCCategory = 1,
			aianchorHome = "",
		},
		fileModel = "Objects/Characters/animals/horse/horse.cdf",
		esClothingConfig = "horse2",
		bNotPlayerMountable = false,
		bNotPlayerInspectable = false,
		bMountIsLegal = false,

		CharacterSounds =
		{
			footstepEffect = "footsteps_horse_mat",			-- Footstep mfx library to use
			foleyEffect = "foley_horse",					-- Foley signal effect name
		},
	},

	simplifiedRootRotation = false,

	collisionCapsule =
	{
		radius = 0.32,
		height = 1,
		axis   = {x=0,y=1,z=0},
		pos    = {x=0,y=0,z=1.15},
		posCarcass = {x=0.18,y=0,z=0.22},
	},

	actorCombatDimension =
	{
		size   = {x=0.5,y=1.3,z=0}
	},

	physicsParams =
	{
		mass = 480.0,
		neckMass = 1.0,

		Living =
		{
			gravity = 30,

			mass = 480.0,

			min_slide_angle = 90.0,
			max_climb_angle = 50.0,
			min_fall_angle = 90.0,
			max_jump_angle = 40.0,

			inertia = 11.0,--7.0,--the more, the faster the speed change: 1 is very slow, 10 is very fast already
			inertiaAccel = 11.0,--same as inertia, but used when the player accel
		},
	},

	gameParams =
	{
		stance =
		{
			normal = {
				stanceId = E_ACTORSTANCE_NORMAL,
				heightCollider = 1.3,
				heightPivot = 0.0,
				size = {x=0.4,y=0.4,z=0.2},
				name = "normal",
				useCapsule = 1,
			},
		},
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
		passRadius = 0.5,

		collisionAvoidanceAgentRadius = 1.25,
		collisionAvoidanceAgentMinRadius = 0.8,
		collisionAvoidanceObstacleOffest = {x = 0, y = 0.3, z = 0},
		collisionAvoidanceObstacleRadius = 0.5,
		collisionAvoidanceObstacleTravel = 0.8,

		AIMovementSpeeds =
		{
			--         { default, min, max }
			Relaxed =
			{
				Slow   = { 1.2,     0.9, 1.3 },
				Walk   = { 1.7,     1.3, 2.0 },
				Run    = { 2.3,     2.0, 2.6 },
				Sprint = { 6.8,    6.5, 7.1 },
			},
		},
	},

	mountableByPlayer = true,
	inspectableByPlayer = true,
	mountIsLegal,
	maxMountDistance = 1.75,
	mountableByPlayerDisabledFromAI = false, -- controlled from AI switch_animal_horseBrain by a context, doesn't save
	mountIsLegalFromAI 				= false, -- controlled from aI switch_animal_horseBrain by a context, doesn't save
}

-- =============================================================================
function Horse:OnReset(bFromInit, bIsReload)
	BasicAnimal.Reset(self, bFromInit, bIsReload)
	self.mountableByPlayer = self.Properties.bNotPlayerMountable == false
	self.inspectableByPlayer = self.Properties.bNotPlayerInspectable == false
	self.mountIsLegal = self.Properties.bMountIsLegal == true
	self.mountableByPlayerDisabledFromAI = false
	self.mountIsLegalFromAI		 = false
end

-- =============================================================================
function Horse:IsUsable(user)
	-- Women can't use horses
	if(IsFemale(user)) then
		return 0
	end
	local myDirection = g_Vectors.temp_v1
	local vecToPlayer = g_Vectors.temp_v2
	local myPos = g_Vectors.temp_v3

	myDirection = self:GetDirectionVector(0)

	user:GetWorldPos(vecToPlayer)
	self:GetWorldPos(myPos)

	vecToPlayer = VectorUtils.Subtract(myPos, vecToPlayer)
	local len = VectorUtils.Length(vecToPlayer)

	if(len > self.maxMountDistance) then
		return 0
	end

	vecToPlayer = VectorUtils.Normalize(vecToPlayer)

	local dp = VectorUtils.DotProduct2D(myDirection,vecToPlayer)

	-- System.Log("Horse: "..dp)

	if(math.abs(dp) > 0.20) then
		return 1
	end

	return 0
end

-- =============================================================================
function Horse:ForceUsable(user)
	if (not user) then
		return false; -- canot be used by AI
	end

	local vecToPlayer = g_Vectors.temp_v2
	local myPos = g_Vectors.temp_v3

	user:GetWorldPos(vecToPlayer)
	self:GetWorldPos(myPos)

	vecToPlayer = VectorUtils.Subtract(myPos,vecToPlayer)
	local len = VectorUtils.Length(vecToPlayer)

	if(len > self.maxMountDistance) then
		return false
	end

	if self.horse:HasRider() then
		return false
	end

	return true
end

-- =============================================================================
function Horse:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	output = {}


	if self:IsUsable(user) > 0 then

		-- Dead:
		if self.actor:GetHealth() <= 0 then

			return self:AddAnimalLootAction(user, firstFast)

		end

		-- Alive:
		if not self.horse:HasRider() and self.horse:IsMountable() then

			-- Mount:
			if self.mountableByPlayer and not self.mountableByPlayerDisabledFromAI then

				local playerCanMount = user.player:CanMountHorse(self.id)
				local disableReason = ""
				if(playerCanMount == CanMount_DisableEncumbered) then
					disableReason = "@dlg_horse_cannotMount"
				end

				--local playerCanBond = user.player:CanBondHorse(self.id)

				local isPlayerHorse = user.player:GetHorseId() == self.id
				local isFreeToTake  = isPlayerHorse or self:IsMountLegal() -- IsMountLegal includes entity OR fromAI

				local mountStr = Pick(isFreeToTake, "@ui_hud_mount", "@ui_hud_mount_and_steal")
				local mountActionType = Pick(isFreeToTake, AHT_RELEASE, AHT_HOLD)
				AddInteractorAction( output, firstFast, Action():hint( mountStr ):action( "mount_horse" ):hintType( mountActionType ):func( Horse.OnMount ):interaction( inr_horseMount ):uiOrder( 0 ):enabled( playerCanMount == CanMount_Enable ):reason(disableReason))
				--AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_bond" ):action( "companion_bond" ):func( Horse.OnBonding ):interaction( inr_horseBond ):uiOrder( 0 ):enabled( playerCanBond ))

			end

			-- Inspect:
			if self.inspectableByPlayer then

				AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_horse_inspect" ):action( "use_horse" ):func( Horse.OnInspect ):interaction( inr_horseInspect ):uiOrder( 1 ) )

			end

		end
	end

	return output
end

-- =============================================================================
function Horse:OnMount(user, slot)
	user.human:Mount(self.id)
end

-- =============================================================================
function Horse:OnBonding(user, slot)
	user.human:DoBonding(self.id)
end

-- =============================================================================
function Horse:OnLoot(user, slot)
	self.actor:RequestItemExchange(user.id)
end

-- =============================================================================
function Horse:OnStartle(user, slot)
	local horseStartleMessage = table.MakeFromType('animal:startle', { origin = player.this.id })
	XGenAIModule.SendMessageToEntityData(self.this.id, "animal:startle", horseStartleMessage)
end

-- =============================================================================
function Horse:OnInspect(user, slot)
	user.player:HorseInspect(self.id)
end

-- =============================================================================
function Horse:OnLoad(table)
	self.Properties.sharedSoulGuid = table.sharedSoulGuid
	self.mountableByPlayer = table.mountableByPlayer
	self.inspectableByPlayer = table.inspectableByPlayer
	self.mountIsLegal = table.mountIsLegal
end

-- =============================================================================
function Horse:OnSave(table)
	table.sharedSoulGuid = self.Properties.sharedSoulGuid
	table.mountableByPlayer	= self.mountableByPlayer
	table.inspectableByPlayer = self.inspectableByPlayer
	table.mountIsLegal = self.mountIsLegal
end

-- =============================================================================
function Horse:SetMountableByPlayer (mountable)
	self.mountableByPlayer = mountable
end

-- =============================================================================
function Horse:SetMountableByPlayerDisabledFromAI(mountable)
	self.mountableByPlayerDisabledFromAI = mountable
end

-- =============================================================================
function Horse:SetMountIsLegalFromAI(mountIsLegal)
	self.mountIsLegalFromAI = mountIsLegal
end
-- =============================================================================
function Horse:SetInspectableByPlayer( inspectable )
	self.inspectableByPlayer = inspectable
end

-- =============================================================================
function Horse:GetMountableByPlayer()
	return (self.mountableByPlayer and not self.mountableByPlayerDisabledFromAI)
end

-- =============================================================================
function Horse:GetInspectableByPlayer()
	return self.inspectableByPlayer
end

-- =============================================================================
function Horse:SetMountIsLegal( isLegal )
	self.mountIsLegal = isLegal
end

-- =============================================================================
function Horse:IsMountLegal()
	return (self.mountIsLegal or self.mountIsLegalFromAI)
end

-- =============================================================================
-- Compose entity
-- =============================================================================
table.Merge(
	Horse,
	BasicAnimal,
    BasicAI
)

EntityCommon.MakeSpawnable(Horse)