--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2013.

Ladder =
{
	Properties =
	{
		bSaved_by_game = false,
		fileModel = "objects/manmade/common_fixtures/ladders/ladder.cgf",

		bUseOnlyFromFront = true,
		bUsable	= true,
		bTopBlocked	= false,
		bTopOnPalisade = false,
		bDrawWeaponOntop = false,
		height = 3.7,

		esLadderType = "Ladder",

		sWH_AI_EntityCategory = "Ladder",
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		soclasses_SmartObjectClass = "",
		esNavCompoment = "Ladder",
		bInteractiveCollisionClass = true,

		ViewLimits =
		{
			horizontalViewLimit 		= 30,	-- horizontal view limit while climbing ladders
			verticalUpViewLimit 		= 45,	-- vertical view limit for looking up while climbing ladders
			verticalDownViewLimit 		= -45,	-- vertical view limit for looking down while climbing ladders
		},
		Offsets =
		{
			bShowHelpers = false,
			verticalDistanceBetweenRungs		= 0.25,	-- Vertical distance in meters between the rungs of a ladder
			getOnDistanceAwayTop 				= 0.85,	-- Player starts this far away from ladder climb position when getting on at top
			getOnDistanceAwayBottom				= 0,	-- Player starts this far away from ladder climb position when getting on at bottom
		},
		Movement =
		{
			movementAcceleration 		= 5, 	-- How much speed the player can gain in a second
			movementSpeedUpwards 		= 2.5, 	-- Speed (rungs/second) at which the player moves up ladders
			movementSpeedDownwards 		= 2.25, -- Speed (rungs/second) at which the player moves down ladders
			movementSettleSpeed 		= 0.8, 	-- Speed at which player settles on a rung when stopping part-way up/down a ladder
			movementInertiaDecayRate 	= 5.5, 	-- Speed at which player input inertia returns to 0 when player releases the up/down input
		},
  },

	Editor=
	{
		Icon = "ladder.bmp",
		IconOnTop=1,
	},

	Server = {},
}

-- =============================================================================
function Ladder:OnSpawn()
	self:LoadObject( 0,self.Properties.fileModel )
	self:Physicalize(0,PE_STATIC,{mass = 0, density = 0})
	self:SetInteractiveCollisionType()

	if (System.IsEditor()) then
		self:Activate(1)
	end

    self.Runtime = { isUsable = self.Properties.bUsable == true }

end

-- =============================================================================
function Ladder:SetInteractiveCollisionType()
	local filtering = {}

	if(self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
function Ladder:OnPropertyChange()
	self:LoadObject( 0,self.Properties.fileModel )
	self:Physicalize(0,PE_STATIC,{mass = 0, density = 0})
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function Ladder:GetActions(user,firstFast)
    output = {}

    if(not self.Runtime.isUsable) then
		return output
	end

	if(user.human:CanUseLadder(self.id,self.Properties.height,self.Properties.bUseOnlyFromFront) == 1) then
        AddInteractorAction( output, firstFast, Action():hint("@use_ladder"):action("use"):func(Ladder.OnUsed):interaction(inr_ladder ) )
    end

    return output
end

-- =============================================================================
function Ladder:OnUsed(user)
    user.human:GrabOnLadder(self.id)
end

-- =============================================================================
function Ladder:IsUsable(user)
    if(not self.Runtime.isUsable) then
        return 0
    end
    return user.human:CanUseLadder(self.id,self.Properties.height,self.Properties.bUseOnlyFromFront)
end

-- =============================================================================
function Ladder.Server:OnUpdate(frameTime)
	if(System.IsEditing() and self.Properties.Offsets.bShowHelpers==true) then
		local pos = self:GetWorldPos()
		local frontDirection = self:GetDirectionVector(1)
		local upDirection = self:GetDirectionVector(2)
		local playerStart = pos.y

		local ladderGetOn  = pos
		local ladderGetOff = VectorUtils.Sum(ladderGetOn,VectorUtils.Scale(upDirection,self.Properties.height - self.Properties.Offsets.getOnDistanceAwayTop))
		Game.DebugDrawCylinder(ladderGetOn.x, ladderGetOn.y, ladderGetOn.z, 0.3, 0.001, 60, 60, 255, 100)
		Game.DebugDrawCylinder(ladderGetOff.x, ladderGetOff.y, ladderGetOff.z, 0.3, 0.001, 60, 60, 255, 100)

		local height = VectorUtils.Sum(pos,VectorUtils.Scale(upDirection,self.Properties.height))
		Game.DebugDrawCylinder(height.x,height.y,height.z,0.3, 0.001, 60, 255, 60, 100)
	end
end

-- =============================================================================
function Ladder:SetUsable( usable )
    self.Runtime.isUsable = usable
end

-- =============================================================================
function Ladder:OnLoad(table)
    self.Runtime = table.Runtime
end

-- =============================================================================
function Ladder:OnSave(table)
    table.Runtime = self.Runtime
end