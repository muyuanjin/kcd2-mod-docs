Rats =
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
			AttractDistMin = 0.1,
			AttractDistMax = 10,
		},
		Movement =
		{
			HeightMin = 0,
			HeightMax = 0,
			SpeedMin = 1.5,
			SpeedMax = 1.8,
			SpeedScared = 2.7,
			FactorOrigin = 100000000,
			FactorHeight = 10,
			FactorAvoidLand = 50000,
			MaxAnimSpeed = 1,
			RandomMovement = 1,
			MaxDistFromOrigin = 10,
			IgnoreTerrainElevation = true,
			IgnoreWallsBehindPlayer = true,
			WalkAnimationSpeed = 2.0,
			RunAnimationSpeed = 2.5,
			RunThreshold = 2.2,
		},
		Boid =
		{
			nCount = 3, --[0,1000,1,"Specifies how many individual objects will be spawned."]
			object_Model = "Objects/characters/animals/rat/rat.cdf",
			--SizeRandom = 0.25,
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
			VisibilityDist = 20,
			bActivate = true,
			Radius = 2,
		},
	},

	Sounds =

	{
		"b_rat_idle",   	-- idle
		"b_rat_scared",     -- scared
		"",    				-- die
		--"",   -- pickup
		--"",   -- throw
	},
	Animations =
	{
		"rat_run",   -- walking
		"rat_idle",      -- idle1
		"rat_idle_var01",      -- idle2/scared
		"rat_idle_var02",      -- idle3
		"pickup",      -- pickup
		"throw",      -- throw
		"",
		"rat_run_jump"
	},
	Editor = {
		Icon = "Bird.bmp"
	},
	params={x=0,y=0,z=0},
}

-- =============================================================================
function Rats:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
  self:SetFlagsExtended(ENTITY_FLAG_EXTENDED_NEEDS_MOVEINSIDE, 0);
end

-- =============================================================================
function Rats:OnInit()

	--self:NetPresent(0);
	--self:EnableSave(1);

	self.flock = 0;
	self.currpos = {x=0,y=0,z=0};
	if (self.Properties.Options.bActivate == true) then
		self:CreateFlock();
	end
end

-- =============================================================================
function Rats:GetFlockType()
	return Boids.FLOCK_RATS;
end

-- =============================================================================
function Rats:CreateFlock()

	local Flocking = self.Properties.Flocking;
	local Movement = self.Properties.Movement;
	local Boid = self.Properties.Boid;
	local Options = self.Properties.Options;

	local params = self.params;

	params.count = math.max(0, Boid.nCount);
	params.model = Boid.object_Model;
	params.model1 = Boid.object_Model1;
	params.model2 = Boid.object_Model2;
	params.model3 = Boid.object_Model3;
	params.model4 = Boid.object_Model4;

	params.boid_size = 1;
	params.boid_size_random = 0.25;
	params.min_height = Movement.HeightMin;
	params.max_height = Movement.HeightMax;
	params.min_attract_distance = Flocking.AttractDistMin;
	params.max_attract_distance = Flocking.AttractDistMax;
	params.min_speed = Movement.SpeedMin;
	params.max_speed = Movement.SpeedMax;
	params.scared_speed = Movement.SpeedScared
	params.walk_animation_speed = Movement.WalkAnimationSpeed
	params.run_animation_speed = Movement.RunAnimationSpeed
	params.run_threshold = Movement.RunThreshold

	if (Flocking.bEnableFlocking == true) then
		params.factor_align = Flocking.FactorAlign;
	else
		params.factor_align = 0;
	end
	--params.factor_cohesion = Flocking.FactorCohesion;
	--params.factor_separation = Flocking.FactorSeparation;
	--params.factor_origin = Movement.FactorOrigin;
	params.factor_keep_height = Movement.FactorHeight;
	params.factor_avoid_land = Movement.FactorAvoidLand;

	params.spawn_radius = Options.Radius;
	params.gravity_at_death = Boid.gravity_at_death;
	params.boid_mass = Boid.Mass;
	params.invulnerable = Boid.bInvulnerable;
	params.ondeath_item = Boid.guidItemSpawnedOnKill;

	params.fov_angle = Flocking.FieldOfViewAngle;

	params.max_anim_speed = Movement.MaxAnimSpeed;
	params.max_dist_from_origin = Movement.MaxDistFromOrigin
	params.ignore_terrain_elevation = Movement.IgnoreTerrainElevation
	params.ignore_walls_behind_player = Movement.IgnoreWallsBehindPlayer
	params.follow_player = Options.bFollowPlayer;
	params.pickable_alive = Options.bPickableWhenAlive;
	params.pickable_dead = Options.bPickableWhenDead;
	params.pickable_message = Options.PickableMessage;
	params.avoid_water = Options.bAvoidWater;
	params.no_landing = Options.bNoLanding;
	params.avoid_obstacles = Options.bObstacleAvoidance;
	params.max_view_distance = Options.VisibilityDist;

	params.Sounds = self.Sounds;
	params.Animations = self.Animations;

	if (self.flock == 0) then
		self.flock = 1;
		Boids.CreateFlock( self, self:GetFlockType(), params );
	end
	if (self.flock ~= 0) then
		Boids.SetFlockParams( self, params );
	end
end

-- =============================================================================
function Rats:OnPropertyChange()
	if (self.Properties.Options.bActivate == true) then
		self:CreateFlock();
		self:Event_Activate();
	else
		self:Event_Deactivate();
	end
end

-- =============================================================================
function Rats:Event_Activate()

	if (self.Properties.Options.bActivate == false) then
		if (self.flock==0) then
			self:CreateFlock();
		end
	end

	if (self.flock ~= 0) then
		Boids.EnableFlock( self,1 );
		self:RegisterForAreaEvents(1);
	end
end

-- =============================================================================
function Rats:Event_Deactivate()
	if (self.flock ~= 0) then
		Boids.EnableFlock( self,0 );
		self:RegisterForAreaEvents(0);
	end
end

-- =============================================================================
function Rats:OnProceedFadeArea( player,areaId,fadeCoeff )
	if (self.flock ~= 0) then
		Boids.SetFlockPercentEnabled( self,fadeCoeff*100 );
	end
end
