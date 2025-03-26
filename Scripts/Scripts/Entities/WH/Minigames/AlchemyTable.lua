Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

AlchemyTable =
{
	Server = {},
	Client = {},

	Properties =
	{
		sWH_AI_EntityCategory = "",
		object_Model = "Objects/props/alchemy/alchemist_table.cgf",
		HourGlassAlembic = "Objects/props/alchemy/sandglass/sandglass_sand.cax",
		PotionPouring = "Objects/props/alchemy/flask/potion_pouring.cax",
		PotInsertBase = "Objects/props/alchemy/alchemy_pot/alchemy_pot_start.cax",
		FlaskRise = "Objects/props/alchemy/flask/potion_rise.cax",
		PotFinish = "Objects/props/alchemy/alchemy_pot/alchemy_pot_finish.cax",
		BellowsIdleTimeout = 0.5,
		MortarUseCount = 1,
		FireSound = "Sounds/environment:special/alchemy:fireplace",
		WaterSound = "Sounds/environment:special/alchemy:boiling_water",

		HerbsMortar 		= "Objects/props/alchemy/mortar/mortar_herbs.cgf",
		HerbsMortarMilled 	= "Objects/props/alchemy/mortar/mortar_herbs_crushed.cgf",
		HerbsBow 			= "Objects/props/alchemy/bowl/bowl_herbs.cgf",
		HerbsBowMilled 		= "Objects/props/alchemy/bowl/bowl_herbs_crushed.cgf",
		
		MortarFinishingModel		= "Objects/manmade/task_specific_props/alchemy/mortar/mortar_gunpowder.cgf",
		MortarFinishingMilledModel	= "Objects/manmade/task_specific_props/alchemy/mortar/mortar_gunpowder_crushed.cgf",

		StrongBoilFireIntensity = 2.0,

		StepsTolerance = 2,

		HourGlassUnitTime = 10, -- seconds for one hourglass turn
		WeakBoilTimeout = 5,
		StrongBoilTimeout = 10,

		WaitDuration = 5,

		guidSmartObjectType = "", -- added by Bazilisk (needed for Smart object properties)
		soclass_SmartObjectHelpers = "",

		bOnlyNPC = true,  -- added by Bazilisk (needed to block player use when NPC is using)
		bInteractiveCollisionClass = false, -- added by Bazilisk (collision with NPC)

		fUseAngle = 0.9,
		fUseDistance = 3.25,
		
		BellowsUseCountToDistill = 2,
		
		CameraLimitAngleLeft = -75.0,
		CameraLimitAngleRight = 95.0,
		CameraLimitAngleDown = -60.0,
		CameraLimitAngleUp = 20.0
	},

	-- Subbrain switches this based on the messages
	State =
	{
		isUsedByPlayer = false,
		enteredBook = false
	},

	Editor =
	{
		Icon = "animobject.bmp",
	},
}

-- =============================================================================
-- OnReset called only by the editor.
function AlchemyTable:OnReset()
	Alchemy.ResetTable(self.id)
	self:Reset()
	self.State.isUsedByPlayer = false
	self.State.enteredBook = false
	
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AlchemyTable:IsUsable(user)
	if (not user) then
		return 0; -- cannot be used by AI
	end
	
	-- Disabled from code / concept node
	if (not self.alchemyTable:IsEnabled()) then
		return 0;
	end
	
	-- Women can't use alchemy tables
	if(IsFemale(user)) then
		return 0
	end

	if (self.nUserId ~= 0) then
		return 0
	end

	if (self.Properties.bOnlyNPC == true) then
      return 0
	end

	local useAngle = self.Properties.fUseAngle
	if (useAngle < -1 and useAngle > 1) then
		return 0
	end

	local myDirection = g_Vectors.temp_v1
	local vecToPlayer = g_Vectors.temp_v2
	local myPos = g_Vectors.temp_v3

	myDirection = self:GetDirectionVector(0)

	user:GetWorldPos(vecToPlayer)
	self:GetWorldPos(myPos)

	vecToPlayer = VectorUtils.Subtract(myPos,vecToPlayer)

	if(math.abs(vecToPlayer.z) > 0.6) then
		return 0
	end
	vecToPlayer = VectorUtils.Normalize(vecToPlayer)
	vecToPlayer = VectorUtils.Rotate90AroundZ(vecToPlayer)


	local dp = VectorUtils.DotProduct2D(myDirection,vecToPlayer)

	if (dp < useAngle) then
		return 0
	end

	local useDistance = self.Properties.fUseDistance
	if (useDistance <= 0.0) then
		return 0
	end

	local delta = g_Vectors.temp_v1
	local mypos,bbmax = self:GetWorldBBox()

	mypos = VectorUtils.Sum(mypos, bbmax)
	mypos = VectorUtils.Scale(mypos, 0.5)
	user:GetWorldPos(delta)

	delta = VectorUtils.Subtract(delta,mypos)
	local dist = VectorUtils.LengthSquared(delta)

	if (dist<useDistance*useDistance) then
		return 1
	else
		return 0
	end
end

-- =============================================================================
-- when firstFast is true method returns only first action
function AlchemyTable:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	output = {}

	self.bUseableMsgChanged = 0

	if (firstFast) then
		if (self:IsUsable(user) == 0) then
		  return output
		end
	end

	if user.soul:HaveSkill('alchemy') and not user.soul:HasScriptContext("minigame_disabledAlchemy") then

		local canUseMinigame = Minigame.CanUseMinigame(user.id);
		AddInteractorAction( output, firstFast, Action():hint( "@ui_hud_start_alchemy" ):action( "use" ):func( AlchemyTable.OnUsed ):enabled( canUseMinigame ):interaction( inr_alchemy ) )
	end

	return output
end

-- =============================================================================
function AlchemyTable.Client:OnLevelLoaded()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AlchemyTable:OnPropertyChange()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AlchemyTable:OnEnablePhysics()
	-- When loading streamable layer, OnLevelLoaded has been sent way before.
	-- Nevertheless, interactive collision class must be set for the entity
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AlchemyTable:SetInteractiveCollisionType()
	local filtering = {}

	if(self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
function AlchemyTable:OnUsed(user)
	if (user) then
		if (self.nUserId == 0) then
			Alchemy.StartAlchemy(user.id, self.id)
			self:ActivateOutput( "OnUse", true )
			XGenAIModule.SendMessageToEntityData(player.this.id, 'tutorial:onAlchemyUse', true)
		end
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(AlchemyTable, UsableItem);