Script.ReloadScript( "Scripts/Entities/Physics/BasicEntity.lua" )

SEQUENCE_NOT_STARTED = 0
SEQUENCE_PLAYING = 1
SEQUENCE_STOPPED = 2

AnimObject =
{
	Properties =
	{
		Animation =
		{
			Animation = "Default",
			Speed = 1,
			bLoop = true,
			bPlaying = true,
			bAlwaysUpdate = false,
			playerAnimationState = "",
			bPhysicalizeAfterAnimation = false,
			bResetOnUnslaved = false,
			BlendTime = 0,
		},
		Physics =
		{
			bArticulated = false,
			bRigidBody = false,
			bPushableByPlayers = false,
			bBulletCollisionEnabled = true,
		},
		Rendering =
		{
			bWrinkleMap = false,
		},
		Cinematic =
		{
			bOnDemandModelLoad = false,
			bRenderAlways = false,
		},
		ActivatePhysicsThreshold = 0,
		ActivatePhysicsDist = 50,
		bNoFriendlyFire = false,
		object_Model = "objects/props/maritime/windsock/windsock.cga",
		MultiplayerOptions =
		{
			bNetworked = false,
		},
		bInteractiveCollisionClass = false,
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		sWH_AI_EntityCategory = "",
		bUpdateOnlyByScript = false, -- JFilek, option to register to update only when required
		Script =
		{
			bDefaultOpen = false,
		},
	},


	PHYSICALIZEAFTER_TIMER = 1,
	POSTQL_TIMER = 2,

	Client = {},
	Server = {},

	Editor =
	{
		Icon = "animobject.bmp",
		IconOnTop = 0,
	}
}

Net.Expose
{
	Class = AnimObject,
	ClientMethods =
	{
		ClEvent_StartAnimation = { RELIABLE_ORDERED, NO_ATTACH, FLOAT, },
		ClEvent_ResetAnimation = { RELIABLE_ORDERED, NO_ATTACH, },
		ClSync = { RELIABLE_ORDERED, NO_ATTACH, FLOAT, FLOAT, FLOAT, },
	},
	ServerMethods =
	{
		SVSync = { RELIABLE_ORDERED, NO_ATTACH, },
	},
	ServerProperties = {},
}

EntityCommon.DeriveOverride( AnimObject,BasicEntity )
-- __super does not work well with more than single level of inheritance,
-- so it does not work for PlayerWeapon (BasicEntity->AnimObject->PlayerWeapon)
AnimObjectBase = BasicEntity


-- =============================================================================
function AnimObject:LoadModelOnDemand()
	return self.Properties.Cinematic.bOnDemandModelLoad
end

-- =============================================================================
function AnimObject:SetFromProperties()
	self.controllingAnimHere = true
	self.isModelLoaded = false
	self.isRagdollized = false
	AnimObjectBase.SetFromProperties(self); -- Call parent function.
	self.touchedByFlownode = false

	self.animstarted = 0
	self.sequenceStatus = SEQUENCE_NOT_STARTED

	local Properties = self.Properties

--	if (Properties.Animation.bPlaying ~= self.bAnimPlaying or Properties.Animation.bLoop ~= self.bAnimLoop or
--			Properties.Animation.Animation ~= self.animName or Properties.Animation.Speed ~= self.animationSpeed) then

		self.bAnimPlaying = Properties.Animation.bPlaying
		self.bAnimLoop = Properties.Animation.bLoop
		self.animName = Properties.Animation.Animation
		if (Properties.Animation.bPlaying == true) then
			self:DoStartAnimation(false)

		else
			self:ResetAnimation(0, -1)
		end
--	end

	self:SetAnimationSpeed( 0, 0, Properties.Animation.Speed )
	self.animationSpeed = Properties.Animation.Speed
	self.curAnimTime = 0
	if (self.Properties.ActivatePhysicsThreshold>0) then
		local apd = { threshold = self.Properties.ActivatePhysicsThreshold, detach_distance = self.Properties.ActivatePhysicsDist }
		self:SetPhysicParams(PHYSICPARAM_AUTO_DETACHMENT, apd)
	end

	self:CheckShaderParamCallbacks()
	self:SetUpdatePolicyInternal()
end

-- =============================================================================
function AnimObject:SetupModel()
	if (self:LoadModelOnDemand() == false or System.IsEditor()) then
		self:LoadAndPhysicalizeModel()
	else
		Game.CacheResource("AnimObject.lua", self.Properties.object_Model, eGameCacheResourceType_StaticObject, 0)
	end
end

-- =============================================================================
function AnimObject:LoadAndPhysicalizeModel()
	if (not self.isModelLoaded) then
		self:LoadObject(0,self.Properties.object_Model)
		self:RenderAlways(self.Properties.Cinematic.bRenderAlways and 1 or 0)

		if (self.Properties.Physics.bPhysicalize == true) then
			self:PhysicalizeThis()
		end
		self.isModelLoaded = true
		return 1
	end
	return 0
end

-- =============================================================================
function AnimObject:UnloadModel()
	if (self.isModelLoaded) then
		self:DestroyPhysics()
		self:FreeSlot(0)
		self.isModelLoaded = false
	end
end

-- =============================================================================
function AnimObject:OnSpawn()
	if (self.Properties.MultiplayerOptions.bNetworked == false) then
		self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
	end

	self.isRagdollized = false
	AnimObjectBase.OnSpawn(self); -- Call parent

	self:SetUpdatePolicyInternal()
	-- JFilek set proper update policy for on demand updates
	if (self.Properties.bUpdateOnlyByScript == true) then
		self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
	end
end

-- =============================================================================
function AnimObject:OnReset()
	AnimObjectBase.OnReset(self); -- Call parent
	self.bAnimPlaying = 0
	self:SetFromProperties()
	self.sequenceStatus = SEQUENCE_NOT_STARTED
	-- JFilek set proper update policy for on demand updates
	if (self.Properties.bUpdateOnlyByScript == true) then
		self:SetUpdatePolicy(ENTITY_UPDATE_SCRIPT)
	end
end

-- =============================================================================
function AnimObject:Event_ResetAnimation()
	self.controllingAnimHere = true
	self:ResetAnimation(0, -1)
	self.animstarted=0
	--
	local PhysProps = self.Properties.Physics
	if( PhysProps.Mass>0 ) then
		self:OnReset()
	else
		self.animName = self.Properties.Animation.Animation
		self:StartAnimation( 0,self.Properties.Animation.Animation,0,0,0,false )
	end
	-- net
	if( CryAction.IsServer() and self.allClients ) then
		self.allClients:ClEvent_ResetAnimation()
	end

end

-- =============================================================================
function AnimObject:Event_StartAnimation(sender)
	self.controllingAnimHere = true
	self:StartEntityAnimation()
	self.animstarted=1

	if( CryAction.IsServer() and self.allClients) then
		self.allClients:ClEvent_StartAnimation(CryAction.GetServerTime())
		--DebugUtils.Log("Server:ClEvent_StartAnimation call"..self:GetName())
	end

end

-- =============================================================================
function AnimObject:Event_StopAnimation(sender)
	self.controllingAnimHere = true
	if (self.animstarted == 1 and self:IsAnimationRunning(0,0)) then
		self.curAnimTime = self:GetAnimationTime(0,0)
	else
		self.curAnimTime = 0
	end
	self:StopAnimation(0, -1);	-- all layers
	self.animstarted = 0
end

-- =============================================================================
function AnimObject:Event_RagdollizeDerived()
	self.isRagdollized = true
end

-- =============================================================================
function AnimObject:Event_ModelLoad()
	local justLoaded = self:LoadAndPhysicalizeModel()
	if(justLoaded ~= 0) then
		self:RelinkAllEntities()
	end
end

-- =============================================================================
function AnimObject:Event_ModelUnload()
	if (not System.IsEditor()) then
		self:UnloadModel()
	end
end

-- =============================================================================
function AnimObject:Event_RenderAlwaysEnable()
	self:RenderAlways(1)
end

-- =============================================================================
function AnimObject:Event_RenderAlwaysDisable()
	self:RenderAlways(0)
end

-- =============================================================================
function AnimObject:DoStartAnimation(useBlendTime)
	self.animName = self.Properties.Animation.Animation
	local blendTime = useBlendTime and self.Properties.Animation.BlendTime or 0
	self:StartAnimation( 0,self.Properties.Animation.Animation,0, blendTime, self.Properties.Animation.Speed,self.Properties.Animation.bLoop,1 )
	self:ForceCharacterUpdate(0, true)
	self.animstarted = 1
	-- save curAnimTime for QS/QL
	if (self.Properties.Animation.Speed < 0) then
		self.curAnimTime = 0
	else
		self.curAnimTime = self:GetAnimationLength(0, self.Properties.Animation.Animation)
	end

--	local currTime = System.GetCurrTime()
	self.startTime = CryAction.GetServerTime();--System.GetCurrAsyncTime()
	if( self.timeDiff ) then
		self.startTime=self.startTime-self.timeDiff
	end

end

-- =============================================================================
function AnimObject:StartEntityAnimation()
	self:StopAnimation(0, -1)
	self:DoStartAnimation(false)
	self.bStopAnimAfterQL = false
	self:KillTimer(self.POSTQL_TIMER)

	if (self.Properties.Animation.bPhysicalizeAfterAnimation == true) then
		local animLen = self:GetAnimationLength(0,self.Properties.Animation.Animation) * 1000.0 / self.Properties.Animation.Speed
		self:SetTimer(self.PHYSICALIZEAFTER_TIMER,animLen)
		--DebugUtils.Log("timer set to:"..animLen.."ms")
	end

end

-- =============================================================================
function AnimObject.Client:OnTimer(timerId,mSec)
	if (timerId == self.PHYSICALIZEAFTER_TIMER) then
		local PhysProps = self.Properties.Physics

		PhysProps.bRigidBodyActive = true
		PhysProps.bPhysicalize=true
		PhysProps.bRigidBody=true
		PhysProps.bResting = 0

		if (self.bRigidBodyActive ~= PhysProps.bRigidBodyActive) then
			self.bRigidBodyActive = PhysProps.bRigidBodyActive
			self:PhysicalizeThis()
		end
		if (PhysProps.bRigidBody == true) then
			self:AwakePhysics(1-PhysProps.bResting)
			self.bRigidBodyActive = PhysProps.bRigidBodyActive
		end
	end
	if (timerId == self.POSTQL_TIMER and self.sequenceStatus == SEQUENCE_NOT_STARTED) then
		self:StopAnimation(0, -1)
	end
end

-- =============================================================================
function AnimObject:CorrectTiming(frameTime)

--	local skip = 0
--	if( skip==0 ) then
	if( self.animstarted==1 and self:IsAnimationRunning(0,0) and self.Properties.Animation.Speed>0 ) then
		local curTime = CryAction.GetServerTime();--System.GetCurrAsyncTime()
		local diffRealTime = (curTime-self.startTime)*self.Properties.Animation.Speed
		local curAnimTime = self:GetAnimationTime(0,0)
		if( curAnimTime<=self.curAnimTime ) then
			local diff = diffRealTime-curAnimTime
			if( diff<-0.02 ) then
					-- correct speed
					local frameTimeAnim = self.Properties.Animation.Speed*frameTime
					local reqTime = frameTimeAnim-diff
					local ratio = (frameTimeAnim)/reqTime
					if( ratio<0.5 ) then
						-- clamp
						ratio=0.5
					end
					--
					newSpeed = ratio*self.Properties.Animation.Speed
					self:SetAnimationSpeed( 0, 0, newSpeed )

					--System.LogToConsole(self:GetName().." RealLess="..diff.." Speed="..newSpeed)
			else
				if( diff>0.02 ) then
					-- correct speed
					local frameTimeAnim = self.Properties.Animation.Speed*frameTime
					local reqTime = frameTimeAnim+diff
					local ratio = reqTime/(frameTimeAnim)
					if( ratio>1.1 ) then
						-- clamp
						ratio=1.1
					end

					newSpeed = ratio*self.Properties.Animation.Speed
					self:SetAnimationSpeed( 0, 0, newSpeed )

					--System.LogToConsole(self:GetName().." RealMore="..diff.." Speed="..newSpeed)
				else
					-- restore speed
					if( self.Properties.Animation.Speed>0 ) then
						self:SetAnimationSpeed( 0, 0, self.Properties.Animation.Speed )
					end
				end
			end
		end
	end
--	end
end

-- =============================================================================
function AnimObject:OnLoad(table)

	self:OnReset()

	local Properties = self.Properties

	--AnimObjectBase.OnLoad( self,table ); -- Call parent
	if(table.bAnimPlaying ~= nil) then
		self.bAnimPlaying = table.bAnimPlaying
	else
		self.bAnimPlaying = Properties.Animation.bPlaying
	end

	if(table.bAnimLoop ~= nil) then
		self.bAnimLoop = table.bAnimLoop
	else
		self.bAnimLoop = Properties.Animation.bAnimLoop
	end

	if(table.animName ~= nil) then
		self.animName = table.animName
	else
		self.animName = Properties.Animation.Animation
	end

	if(table.animstarted ~= nil) then
		self.animstarted = table.animstarted
	else
		self.animstarted = 0
	end

	if(table.bControllingAnimHere ~= nil) then
		self.controllingAnimHere = table.bControllingAnimHere
	else
		self.controllingAnimHere = true
	end
	-- self.movedByFlowgraph = table.movedByFlowgraph

	local animTime = 0
	if(table.animTime ~= nil) then
		animTime = table.animTime
	end
	
	local sequenceStatus = SEQUENCE_NOT_STARTED
	if(table.sequenceStatus ~= nil) then
		sequenceStatus = table.sequenceStatus
	end

	if (self.controllingAnimHere) then
		if (self.animstarted == 1) then -- restart animation
			self:StartEntityAnimation()
			self:SetAnimationTime(0, 0, animTime)
		else
			--we have to stop the animation
			-- either at the point stored in the file
			if (animTime > 0) then
				if (self.animName~=self.Properties.Animation.Animation) then
					self:StartAnimation( 0, self.animName, 0, 0, self.Properties.Animation.Speed,self.Properties.Animation.bLoop,1 )
					self:SetAnimationTime(0, 0, animTime)
				else
					self:StartEntityAnimation()
				end
				self:SetAnimationSpeed( 0, 0, 0.0 )
				self:SetAnimationTime(0, 0, animTime)
				self.bStopAnimAfterQL = true
				self:Activate(1)
				self.curAnimTime = animTime
			end

			if (animTime==0) then
				local bTouchedByTrackview = (sequenceStatus == SEQUENCE_NOT_STARTED and self.sequenceStatus ~= SEQUENCE_NOT_STARTED)
				-- this check makes no sense imo. But im not removing it at this time (c3 last weeks) to avoid any risk
				if (bTouchedByTrackview or self.touchedByFlownode) then
					-- or just at the beginning
					self:ResetAnimation(0, -1)
					self:StartEntityAnimation()
					self:SetAnimationSpeed(0, 0, 0.0)
					self:SetAnimationTime(0, 0, 0.0)
					self.bStopAnimAfterQL = true
					self:Activate(1)
					self.curAnimTime = 0
				end
			end
		end
	else
		self.externalAnim_anim = table.externalAnim_anim
		self.externalAnim_layer = table.externalAnim_layer
		self.externalAnim_loop = table.externalAnim_loop
		self:StartAnimation( 0, self.externalAnim_anim, self.externalAnim_layer, 0, 1, self.externalAnim_loop )
		self:SetAnimationTime(0, self.externalAnim_layer, table.animTime)
	end
	self.touchedByFlownode = false

	-- physicalized ones that are neither articulated neither rigidbody become static. Static physical entities are not serialized at all. So we just rephysicallize in that case.
	if (self.Properties.Physics.bArticulated==false and self.Properties.Physics.bRigidBody==false and self.Properties.Physics.bPhysicalize==true) then
		self:PhysicalizeThis()
	end

	self.sequenceStatus = sequenceStatus
end

-- =============================================================================
function AnimObject:NeedSerialize()
	local Properties = self.Properties

	if(self.bAnimPlaying ~= Properties.Animation.bPlaying) then
		return true
	end
	if(self.bAnimLoop ~= Properties.Animation.bAnimLoop) then
		return true
	end
	if(self.animName ~= Properties.Animation.Animation) then
		return true
	end
	if(self.sequenceStatus ~= SEQUENCE_NOT_STARTED) then
		return true
	end	
	if(self.controllingAnimHere ~= true) then
		return true
	end

	if (self.controllingAnimHere) then
		if (self.animstarted == 1 and self:IsAnimationRunning(0,0)) then
			return true
		else
			if (self.curAnimTime > 0) then
			  table.animTime = self.curAnimTime
			  return true
			end
		end
	else
		return true
	end

	return false
end

-- =============================================================================
function AnimObject:OnSave(table)
	local Properties = self.Properties
	
	if(self.bAnimPlaying ~= Properties.Animation.bPlaying) then
		table.bAnimPlaying = self.bAnimPlaying
	end
	if(self.bAnimLoop ~= Properties.Animation.bAnimLoop) then
		table.bAnimLoop = self.bAnimLoop
	end
	if(self.animName ~= Properties.Animation.Animation) then
		table.animName = self.animName
	end
	if(self.sequenceStatus ~= SEQUENCE_NOT_STARTED) then
		table.sequenceStatus = self.sequenceStatus
	end	
	if(self.controllingAnimHere ~= true) then
		table.bControllingAnimHere = self.controllingAnimHere
	end

	if (self.controllingAnimHere) then
		if (self.animstarted == 1 and self:IsAnimationRunning(0,0)) then
			local animTime = self:GetAnimationTime(0,0)
			if(animTime > 0) then
				table.animTime = animTime
			end
			table.animstarted = 1
		else
			if (self.curAnimTime > 0) then
			  table.animTime = self.curAnimTime
			end
		end
	else
		table.externalAnim_anim = self.externalAnim_anim
		table.externalAnim_layer = self.externalAnim_layer
		table.externalAnim_loop = self.externalAnim_loop
		table.animTime = self:GetAnimationTime(0,self.externalAnim_layer)
	end
end

-- =============================================================================
-- Additional Flow events.
-- =============================================================================
AnimObject.FlowEvents.Inputs.ResetAnimation = { AnimObject.Event_ResetAnimation, "bool" }
AnimObject.FlowEvents.Inputs.StartAnimation = { AnimObject.Event_StartAnimation, "bool" }
AnimObject.FlowEvents.Inputs.StopAnimation = { AnimObject.Event_StopAnimation, "bool" }

AnimObject.FlowEvents.Inputs.ModelLoad = { AnimObject.Event_ModelLoad, "bool" }
AnimObject.FlowEvents.Inputs.ModelUnload = { AnimObject.Event_ModelUnload, "bool" }

-- =============================================================================
-- client functions
-- =============================================================================
function AnimObject.Client:ClEvent_StartAnimation(servertime)

	--DebugUtils.Log("ClEvent_StartAnimation recieved"..self:GetName())

	self.timeDiff = CryAction.GetServerTime()-servertime
--	local localDiff = System.GetCurrTime()-servertime
--	if( self.timeDiff>0.1 ) then
--			System.LogToConsole(self:GetName().." Diff="..self.timeDiff.." localDiff="..localDiff)
--	else
--		if( self.timeDiff<-0.1 ) then
--				System.LogToConsole(self:GetName().." Diff="..self.timeDiff)
--		end
--	end

	if( not CryAction.IsServer() ) then
		self:Event_StartAnimation()
	end
end

-- =============================================================================
function AnimObject.Client:ClEvent_ResetAnimation()
	if( not CryAction.IsServer() ) then
		self:Event_ResetAnimation()
	end
end

-- =============================================================================
function AnimObject:SavePhysicalState()
	self.initPos = self:GetPos()
	self.initRot = self:GetWorldAngles()
	self.initScale = self:GetScale()
end

-- =============================================================================
function AnimObject:RestorePhysicalState()
	self:SetPos(self.initPos)
	self:SetWorldAngles(self.initRot)
	self:SetScale(self.initScale)

	-- restore
	self:ResetAnimation(0, -1)
	self.animstarted=0
	local PhysProps = self.Properties.Physics
	if( PhysProps.Mass>0 ) then
		self:OnReset()
	else
		self.animName = self.Properties.Animation.Animation
		self:StartAnimation( 0,self.Properties.Animation.Animation,0,0,0,false )
	end
end

-- =============================================================================
function AnimObject:PhysicalizeThis()

	BasicEntity.PhysicalizeThis(self)

	-- Remove bullet collision if desired
	local Physics = self.Properties.Physics
	if (Physics.bBulletCollisionEnabled == false) then
		local flagstab = { flags_mask= geom_colltype_ray + geom_colltype_foliage_proxy, flags=geom_colltype_player*(Physics.bPushableByPlayers and 1 or 0) }
		self:SetPhysicParams(PHYSICPARAM_PART_FLAGS, flagstab)
	end
end

-- =============================================================================
function AnimObject:SendSyncToClient( channelId )
	if( self.animstarted==1 ) then
		animTime = self:GetAnimationTime(0,0)
		self.onClient:ClSync( channelId, animTime, self.startTime, CryAction.GetServerTime() )
	end
end

-- =============================================================================
function AnimObject.Server:OnPostInitClient( channelId )
	self:SendSyncToClient(channelId)
end

-- =============================================================================
function AnimObject.Server:SVSync(channelId)
	self:SendSyncToClient(channelId)
end

-- =============================================================================
function AnimObject.Client:ClSync( animTimeValue, startTimeValue, serverTimeValue )
--	if( self.animstarted==0 ) then
		--self:Event_ResetAnimation()
		--self.timeDiff = CryAction.GetServerTime()-serverTimeValue
		self:StartEntityAnimation()
		self.startTime = startTimeValue
		self:SetAnimationTime(0,0,animTimeValue)
		--DebugUtils.Log("CLSync recieved"..self:GetName()..animTimeValue)
--	end
end

-- =============================================================================
-- notifications from PlaySequence FG node (entire sequence starts/stops)
function AnimObject:OnSequenceStart()
	self.sequenceStatus = SEQUENCE_PLAYING
end

-- =============================================================================
function AnimObject:OnSequenceStop()
	self.sequenceStatus = SEQUENCE_STOPPED
end

-- =============================================================================
-- Notifications from trackview (animation in sequence starts/stops)
function AnimObject:OnSequenceAnimationStart( animName )
	self.sequenceStatus = SEQUENCE_PLAYING
	self.animName = animName
end

-- =============================================================================
function AnimObject:OnSequenceAnimationStop()
	self.sequenceStatus = SEQUENCE_STOPPED
end

-- =============================================================================
function AnimObject:OnFlowGraphAnimationStart( animName, layer, loop )
	self.animName = animName
	self.externalAnim_anim = animName
	self.controllingAnimHere = false
	self.externalAnim_layer = layer
	self.externalAnim_loop = loop
	self.touchedByFlownode = true
end

-- =============================================================================
function AnimObject:OnFlowGraphAnimationStop()
	if (self.externalAnim_layer) then
		self.curAnimTime = self:GetAnimationTime(0, self.externalAnim_layer)
	end
	self.controllingAnimHere = true
end

-- =============================================================================
function AnimObject:OnFlowGraphAnimationEnd()
	self.curAnimTime = 1;  -- is a normalized time, so 1 == end
	self.controllingAnimHere = true
end

-- =============================================================================
-- interactive collision class
-- =============================================================================
function AnimObject.Client:OnLevelLoaded()
	self:SetInteractiveCollisionType()
   -- AnimObjectBase.OnPropertyChange(self); -- Call parent function. But there is no parent with OnLevelLoad?
end

-- =============================================================================
function AnimObject:OnEnablePhysics()
	-- When loading streamable layer, OnLevelLoaded has been sent way before.
	-- Nevertheless, interactive collision class must be set for the entity
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function AnimObject:OnPropertyChange()
	self:SetInteractiveCollisionType()
	AnimObjectBase.OnPropertyChange(self); -- Call parent function. Maybe?
end

-- =============================================================================
function AnimObject:SetInteractiveCollisionType()
	local filtering = {}

	if(self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
function AnimObject:SetUpdatePolicyInternal()
	if (self.Properties.Animation.bAlwaysUpdate == true) then
		self:SetUpdatePolicy(ENTITY_UPDATE_IN_RANGE)
	else
		self:SetUpdatePolicy(ENTITY_UPDATE_VISIBLE)
	end
end


-- =============================================================================
function AnimObject:OnObjectUnslaved()
	if(self.Properties.Animation.bResetOnUnslaved == true) then
		self:DoStartAnimation(true)
	end
end