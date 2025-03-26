--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2006.

ShootingTargetOld =
{
	Client = {},
	Server = {},
	Properties=
	{
		fileModel 					= "objects/manmade/task_specific_props/combat/archery/target.cgf",
		bTurningMode = false,
		fIntervallMin = 3,
		fIntervallMax = 5,
		fLightUpTime = 2,
		fTurnSpeed = 0.5,
		fScoreScale = 10,
	},
	Editor=
	{
		Icon="Item.bmp",
		ShowBounds = 1,
	},
	States = {"Activated","Deactivated","Turning","Init"},
}
ACTIVATION_TIMER=0
TURN_TIMER=1

-- =============================================================================
function ShootingTargetOld:OnReset()
 	local props=self.Properties
 	if(not string.IsEmpty(props.fileModel))then
 		self:LoadObject(0,props.fileModel)
 	end
 	EntityCommon.PhysicalizeRigid(self,0,self.physics,false)
 	self.side=0
 	self.ended=0
	self:GetAngles(self.initialrot)
	VectorUtils.Copy(self.turnrot,self.initialrot)
	if(self.Properties.bTurningMode==true)then
		self.turnrot.z=self.turnrot.z+(math.pi/2)
	end
 	self:Activate(1)
 	self:GotoState("Deactivated")
end

-- =============================================================================
function ShootingTargetOld:OnSave(tbl)
	tbl.side=self.side
	tbl.ended=self.ended
end

-- =============================================================================
function ShootingTargetOld:OnLoad(tbl)
	self.side=tbl.side
	self.ended=tbl.ended
end

-- =============================================================================
function ShootingTargetOld:OnPropertyChange()
	self:OnReset()
end

-- =============================================================================
function ShootingTargetOld.Server:OnInit()
	self.physics = {
		bRigidBody=true,
		bRigidBodyActive = true,
		Density = -1,
		Mass = -1,
	}
	self.tmp={x=0,y=0,z=0}
	self.turnrot={x=0,y=0,z=0}
	self.initialrot={x=0,y=0,z=0}
	self.inc=0
	self.init=1
	self:OnReset()
end

-- =============================================================================
function ShootingTargetOld.Client:OnHit(hit)

end

-- =============================================================================
function ShootingTargetOld.Server:OnHit(hit)

	if(self:GetState()~="Activated")then return;end
	local vTmp=g_Vectors.temp
	vTmp = VectorUtils.Subtract(self:GetPos(), hit.pos)
	local dist=VectorUtils.Length(vTmp)
	dist=((1-(dist*2))+0.08)*10
	if(dist>9.4)then
		dist=10
	else
		dec=string.find(dist,".",1,1)
		dist=tonumber(string.sub(dist,1,dec-1))
	end

	if(self.Properties.bTurningMode==true)then
		local shooter=0
		if(hit.shooter and hit.shooter==g_localActor)then
			shooter=1
		else
			shooter=2
		end
		if(self.side==1)then
			self:GotoState("Init")
			self:ActivateOutput("Hit",dist)
		else
			self:ActivateOutput("Hit",-1)
		end
	else
		--Normal mode just outputs hit
	end
end

-- =============================================================================
function ShootingTargetOld:Event_Activated()
	self:GotoState("Init")
	EntityCommon.BroadcastEvent(self, "Activated")
end

-- =============================================================================
function ShootingTargetOld:Event_Deactivated()
	self.ended=1
	self:GotoState("Deactivated")
	EntityCommon.BroadcastEvent(self, "Deactivated")
end

-- =============================================================================
ShootingTargetOld.Server.Deactivated=
{
	OnBeginState = function(self)
		if(self.init==0)then
			local props=self.Properties
			self:KillTimer(ACTIVATION_TIMER)
			self:KillTimer(TURN_TIMER)
			if(props.fIntervallMin>props.fIntervallMax)then props.fIntervallMin=props.fIntervallMax;end
			self:SetTimer(ACTIVATION_TIMER,20)
		else
			self.init=0
		end
	end,
	OnTimer = function(self,timerId,msec)
		if(timerId==ACTIVATION_TIMER)then
			self:GetAngles(self.tmp)
			self.inc=self.inc+self.Properties.fTurnSpeed
			self.tmp.z=self.tmp.z+self.Properties.fTurnSpeed
			self:SetAngles(self.tmp)
			if(self.inc<math.pi)then
				self:SetTimer(ACTIVATION_TIMER,20)
			else
				self:SetAngles(self.initialrot)
			end
		end
	end,
}

-- =============================================================================
ShootingTargetOld.Server.Activated=
{
	OnBeginState = function(self)
		self.ended=0
		if(self.Properties.bTurningMode==true)then
			local props=self.Properties
			if(props.fIntervallMin>props.fIntervallMax)then props.fIntervallMin=props.fIntervallMax;end
			self:SetTimer(ACTIVATION_TIMER,1000*random(props.fIntervallMin,props.fIntervallMax))
		end
	end,
	OnTimer = function(self,timerId,msec)
		if(self.ended==1)then
			self:GotoState("Deactivated")
			return
		end
		if(timerId==ACTIVATION_TIMER)then
			self:GetAngles(self.tmp)
			self.inc=self.inc+self.Properties.fTurnSpeed
			self.tmp.z=self.tmp.z-self.Properties.fTurnSpeed
			self:SetAngles(self.tmp)
			if(self.inc<math.pi)then
				self:SetTimer(ACTIVATION_TIMER,20)
			else
				self:SetAngles(self.initialrot)
				self.side=1
				self:SetTimer(TURN_TIMER,1000*self.Properties.fLightUpTime)
			end
		elseif(timerId==TURN_TIMER)then
			self:GotoState("Init")
		end
	end,
}

-- =============================================================================
ShootingTargetOld.Server.Init=
{
	OnBeginState = function(self)
		self:KillTimer(ACTIVATION_TIMER)
		self:KillTimer(TURN_TIMER)
		self.inc=0
		self.side=0
		self:SetTimer(ACTIVATION_TIMER,25)
	end,
	OnTimer = function(self,timerId,msec)
		if(timerId==ACTIVATION_TIMER)then
			self:GetAngles(self.tmp)
			self.inc=self.inc+self.Properties.fTurnSpeed
			self.tmp.z=self.tmp.z+self.Properties.fTurnSpeed
			self:SetAngles(self.tmp)
			if(self.inc<math.pi/2)then
				self:SetTimer(ACTIVATION_TIMER,25)
			else
				self:SetAngles(self.turnrot)
				self:GotoState("Activated")
			end
		end
	end,
}

-- =============================================================================
--[[ShootingTargetOld.FlowEvents =
{
	Inputs =
	{
		Deactivated = { ShootingTargetOld.Event_Deactivated, "bool" },
		Activated = { ShootingTargetOld.Event_Activated, "bool" },
	},
	Outputs =
	{
		Deactivated = "bool",
		Activated = "bool",
		Hit = "int",
		PlayerOne = "int",
		PlayerTwo = "int",
	},
}
]]