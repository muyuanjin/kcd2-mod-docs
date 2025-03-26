Chickens =
{
	type = "Boids",
	MapVisMask = 0,
	ENTITY_DETAIL_ID = 1,

	Properties = {
		Flocking =
		{
			bEnableFlocking = true,
			FieldOfViewAngle = 250,
			FactorAlign = 1,
			FactorCohesion = 1,
			FactorSeparation = 1,
			AttractDistMin = 5,
			AttractDistMax = 20,
		},
		Movement =
		{
			HeightMin = 0,
			HeightMax = 1,
			SpeedMin = 0.4,
			SpeedMax = 0.4,
			SpeedScared = 2.0,
			FactorOrigin = 0.3,
			FactorHeight = 1,
			FactorAvoidLand = 15,
			MaxAnimSpeed = 1,
			MaxDistFromOrigin = 30,
			WalkAnimationSpeed = 0.4,
			RunAnimationSpeed = 2.0,
			RunThreshold = 1.1,
		},
		Boid =
		{
			nCount = 10, --[0,1000,1,"Specifies how many individual objects will be spawned."]
			object_Model = "objects/characters/animals/hen_v2/hen_v2.cdf", 
			object_Model1 = "objects/characters/animals/hen_v2/hen_v2_brown.cdf", 
            object_Model2 = "objects/characters/animals/hen_v2/hen_v2_black.cdf",
            object_Model3 = "objects/characters/animals/hen_v2/hen_v2_speckled.cdf", 
            object_Model4 = "objects/characters/animals/hen_v2/hen_v2_white.cdf",
			SpecialModel = "Data/objects/characters/animals/rooster/rooster.cdf",
			--SizeRandom = 0,
			gravity_at_death = -9.81,
			Mass = 10,
			bInvulnerable = false,

			guidItemSpawnedOnKill = "18ff9093-2cc4-4ab3-9f34-7cb0dd7cd30a",	-- item GUID of item which will be spawned upon death
		},
		Options =
		{
			bPickableWhenAlive = true,
			bPickableWhenDead = true,
			PickableMessage = "",
			bFollowPlayer = false,
			bAvoidWater = true,
			bNoLanding = false,
			bObstacleAvoidance = true,
			VisibilityDist = 40,
			bActivate = true,
			Radius = 6,
			bDisableOnRain = true,
			ActiveHoursBegin = 4,
			ActiveHoursEnd = 21,
		},

		guidSmartObjectType = "def0005e-0000-0000-0000-def00000005e",
		bOwnedByHome = true, -- Automatically create an ownership link from home if placed in one
		bRequiresOwner = true,
	},

	

	Sounds =
	{
		"b_hen_idle",   	-- idle
		"b_hen_scared",     -- scared
		"b_hen_death",    	-- die
		--"",   -- pickup
		--"",   -- throw
	},
	Animations =
	{
		"hen_walk_fwd",   -- walking
		"hen_idle_01_look_around",      -- idle1
		"hen_idle_02_look_around",      -- idle2/scared
		"hen_idle_03_eating",      -- idle3
		"pickup",      -- pickup
		"throw",      -- throw
		"rooster_crowing",      -- Rooster
		"hen_run_fwd",      -- Running
	},
	Editor = {
		Icon = "Bird.bmp"
	},
	params={x=0,y=0,z=0},
}

-- =============================================================================
function Chickens:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0)
  self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_NEEDS_MOVEINSIDE, 0)
end

-- =============================================================================
function Chickens:OnInit()

	--self:NetPresent(0)
	--self:EnableSave(1)

	self.flock = 0
	self.currpos = {x=0,y=0,z=0}
	if (self.Properties.Options.bActivate == true) then
		self:CreateFlock()
	end
end

-- =============================================================================
function Chickens:GetFlockType()
	return Boids.FLOCK_CHICKENS
end

-- =============================================================================
function Chickens:CreateFlock()

	local Flocking = self.Properties.Flocking
	local Movement = self.Properties.Movement
	local Boid = self.Properties.Boid
	local Options = self.Properties.Options

	local params = self.params

	params.count = math.max(0, Boid.nCount)
	params.model = Boid.object_Model
	params.model1 = Boid.object_Model1
	params.model2 = Boid.object_Model2
	params.model3 = Boid.object_Model3
	params.model4 = Boid.object_Model4

	params.boid_size = 1
	params.boid_size_random = 0
	params.min_height = Movement.HeightMin
	params.max_height = Movement.HeightMax
	params.min_attract_distance = Flocking.AttractDistMin
	params.max_attract_distance = Flocking.AttractDistMax
	params.min_speed = Movement.SpeedMin
	params.max_speed = Movement.SpeedMax
	params.scared_speed = Movement.SpeedScared
	params.walk_animation_speed = Movement.WalkAnimationSpeed
	params.run_animation_speed = Movement.RunAnimationSpeed
	params.run_threshold = Movement.RunThreshold

	if (Flocking.bEnableFlocking == true) then
		params.factor_align = Flocking.FactorAlign
	else
		params.factor_align = 0
	end
	params.factor_cohesion = Flocking.FactorCohesion
	params.factor_separation = Flocking.FactorSeparation
	params.factor_origin = Movement.FactorOrigin
	params.factor_keep_height = Movement.FactorHeight
	params.factor_avoid_land = Movement.FactorAvoidLand

	params.spawn_radius = Options.Radius
	params.gravity_at_death = Boid.gravity_at_death
	params.boid_mass = Boid.Mass
	params.invulnerable = Boid.bInvulnerable
	params.ondeath_item = Boid.guidItemSpawnedOnKill

	params.fov_angle = Flocking.FieldOfViewAngle

	params.max_anim_speed = Movement.MaxAnimSpeed
	params.max_dist_from_origin = Movement.MaxDistFromOrigin
	params.follow_player = Options.bFollowPlayer
	params.pickable_alive = Options.bPickableWhenAlive
	params.pickable_dead = Options.bPickableWhenDead
	params.pickable_message = Options.PickableMessage
	params.avoid_water = Options.bAvoidWater
	params.no_landing = Options.bNoLanding
	params.avoid_obstacles = Options.bObstacleAvoidance
	params.max_view_distance = Options.VisibilityDist
	params.disable_on_rain = Options.bDisableOnRain
	params.active_hours_begin = Options.ActiveHoursBegin
	params.active_hours_end = Options.ActiveHoursEnd

	params.Sounds = self.Sounds
	params.Animations = self.Animations
	params.special_model = Boid.SpecialModel

	if (self.flock == 0) then
		self.flock = 1
		Boids.CreateFlock( self, self:GetFlockType(), params )
	end
	if (self.flock ~= 0) then
		Boids.SetFlockParams( self, params )
	end
end

-- =============================================================================
function Chickens:OnPropertyChange()
	if (self.Properties.Options.bActivate == true) then
		self:CreateFlock()
		self:Event_Activate()
	else
		self:Event_Deactivate()
	end
end

-- =============================================================================
function Chickens:Event_Activate()

	if (self.Properties.Options.bActivate == false) then
		if (self.flock==0) then
			self:CreateFlock()
		end
	end

	if (self.flock ~= 0) then
		Boids.EnableFlock( self,1 )
		self:RegisterForAreaEvents(1)
	end
end

-- =============================================================================
function Chickens:Event_Deactivate()
	if (self.flock ~= 0) then
		Boids.EnableFlock( self,0 )
		self:RegisterForAreaEvents(0)
	end
end

-- =============================================================================
function Chickens:OnProceedFadeArea( player,areaId,fadeCoeff )
	if (self.flock ~= 0) then
		Boids.SetFlockPercentEnabled( self,fadeCoeff*100 )
	end
end
