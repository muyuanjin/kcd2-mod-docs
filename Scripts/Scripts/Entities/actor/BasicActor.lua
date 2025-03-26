--  Crytek Source File.
--  Copyright (C), Crytek Studios, 2001-2004.

-- =============================================================================
BasicActor =
{
	Properties =
	{
		fileHitDeathReactionsParamsDataFile = "Libs/HitDeathReactionsData/HitDeathReactions_Default.xml",
		bIsDummy = false, -- turns on entity flag NO_XAI: intended for inventory dummies etc.
		physicMassMult = 1.0,
		ControlProfile = 0, -- AI=0, TrackView=1

		LipSync =
		{
			esLipSyncType = "LipSync_TransitionQueue",	-- can be either "LipSync_TransitionQueue" or "LipSync_FacialInstance" (the legacy one) at the moment
			bEnabled = true,

			-- these settings will be used by "LipSync_TransitionQueue"
			TransitionQueueSettings =
			{
				nCharacterSlot = 0,
				nAnimLayer = 12,
				sDefaultAnimName = "facial_chewing_01",
				playbackWeight = 0.75,
			}
		},

		Rendering =
		{
			bWrinkleMap = true,
		},

		CharacterSounds =
		{
			footstepEffect = "footsteps",			-- Footstep mfx library to use
			foleyEffect = "foleys",						-- Foley signal effect name
		},

		Script =
		{
			Misc = '',
			bIdleUntilFirstPatch = false,
		}
	},

	Server = {},
	Client = {},

	InteractorPriority = 2,
	IsDogUsable = 1,
	IsChatUsable = 0
}

-- =============================================================================
BasicActorParams =
{
	physicsParams =
	{
		flags = 0,
		mass = 80,
		stiffness_scale = 73,

		Living =
		{
			gravity = 13,
			mass = 80,
			air_resistance = 0.5, --used in zeroG

			inertia = 11.0,--7.0,--the more, the faster the speed change: 1 is very slow, 10 is very fast already
			inertiaAccel = 11.0,--same as inertia, but used when the player accel

			k_air_control = 0.1,

			max_vel_ground = 16,

			min_slide_angle = 49.0,
			max_climb_angle = 50.0,
			min_fall_angle = 90.0,
			max_jump_angle = 40.0,


			timeImpulseRecover = 1.0,

			colliderMat = "mat_player_collider",
		},
	},

	gameParams =
	{
		stance =
		{
			combat = {
					stanceId = E_ACTORSTANCE_COMBAT,
					heightCollider = 1.05,
					heightPivot = 0.0,
					size = {x=0.3,y=0.0,z=0.4},
					viewOffset = {x=0,y=0.10,z=1.6},
					name = "combat",
					useCapsule = 1,
				},
			crouch = {
					stanceId = E_ACTORSTANCE_CROUCH,
					heightCollider = 0.8,
					heightPivot = 0.0,
					size = {x=0.35,y=0.0,z=0.1},
					viewOffset = {x=0,y=0.0,z=1.1},
					name = "crouch",
					useCapsule = 1,
				},
			normal = {
					stanceId = E_ACTORSTANCE_NORMAL,
					heightCollider = 1.05,
					heightPivot = 0.0,
					size = {x=0.3,y=0.0,z=0.4},
					viewOffset = {x=0,y=0.10,z=1.6},
					name = "normal",
					useCapsule = 1,
				},
			carryCorpse = {
					stanceId = E_ACTORSTANCE_CARRYCORPSE,
					heightCollider = 0.90,
					heightPivot = 0.0,
					size = {x=0.4,y=0.4,z=0.15},
					viewOffset = {x=0,y=0.10,z=1.6},
					name = "carryCorpse",
					useCapsule = 1,
				},
			stoneThrowing = {
					stanceId = E_ACTORSTANCE_STONETHROWING,
					heightCollider = 1.05,
					heightPivot = 0.0,
					size = {x=0.3,y=0.0,z=0.4},
					viewOffset = {x=0,y=0.10,z=1.6},
					name = "stoneThrowing",
					useCapsule = 1,
				},
			injured = {
					stanceId = E_ACTORSTANCE_INJURED,
					heightCollider = 1.05,
					heightPivot = 0.0,
					size = {x=0.3,y=0.0,z=0.4},
					viewOffset = {x=0,y=0.10,z=1.6},
					name = "injured",
					useCapsule = 1,
				},
		},
	},
}

-- =============================================================================
function BasicActor:ResetCommon(bFromInit, bIsReload)
	self.AI = {}
end

-- =============================================================================
-- Call some initial code for actor spawn and respawn
function BasicActor:InitialSetup(bIsReload)
	BasicActor.Reset(self, true, bIsReload)
	self:ReviveInEditor()
end

-- =============================================================================
function BasicActor:ReviveInEditor()
	if (self.actor) then
		if (System.IsEditor()) then
			self.actor:Revive(true)
		end
	end
end

-- =============================================================================
function BasicActor:Reset(bFromInit, bIsReload)
	BasicActor.ResetCommon(self, bFromInit, bIsReload)
end

-- =============================================================================
function BasicActor:SetActorModel(isClient)
	local PropInstance = self.PropertiesInstance
	local model = self.Properties.fileModel

	-- take care of fp3p
	if (self.Properties.clientFileModel and isClient) then
		model = self.Properties.clientFileModel
	end

	local nModelVariations = self.Properties.nModelVariations
	if (nModelVariations and nModelVariations > 0 and PropInstance and PropInstance.nVariation) then
		local nModelIndex = PropInstance.nVariation
		if (nModelIndex < 1) then
			nModelIndex = 1
		end
		if (nModelIndex > nModelVariations) then
			nModelIndex = nModelVariations
		end
		local sVariation = string.format('%.2d',nModelIndex)
		model = string.gsub(model, "_%d%d", "_"..sVariation)
		-- System.Log( "ActorModel = "..model )
	end

	if (self.currModel ~= model) then
		self.currModel = model

		self:LoadCharacter(0, model)

		self:ForceCharacterUpdate(0, false)

		if(self.CreateAttachments) then
			self:CreateAttachments()
		end
	end
--[[
	if (self.currItemModel ~= self.Properties.fpItemHandsModel) then
		self:LoadCharacter(3, self.Properties.fpItemHandsModel)
		self:DrawSlot(3, 0)
		self:LoadCharacter(4, self.Properties.fpItemHandsModel); -- second instance for dual wielding
		self:DrawSlot(4, 0)

		self.currItemModel = self.Properties.fpItemHandsModel
	end
	]]
end

-- =============================================================================
function BasicActor:OnSpawn(bIsReload)
	-- If AI tables were included, propagate call down the chain
	-- Note on InitialSetup:
	-- InitialSetup calls Reset(), which will happen right after for AI, during the OnInit callback
	-- this way we make sure Reset() is only called once during initialization of the entity (reloaded or not)
	-- If not we will end up with two calls, which can re-create the inventory twice and what not (expensive!)
	-- For Players needs to figure out if it is required to call InitialSetup (and Reset) at this point
	if (self.ai) then
		BasicAI.OnSpawn(self,bIsReload)
	else
		self:InitialSetup(bIsReload)
	end
end

-- =============================================================================
function BasicActor:AddLootAction(output, user, firstFast)
	if user.actor:CanLoot(self.id) then
		local hType
		local hint
		if self.soul:IsLegalToLoot() then
			hType = AHT_RELEASE
			hint = "@ui_hud_loot"
		else
			hType = AHT_HOLD
			hint = "@ui_hud_rob_body"
		end

		if AddInteractorAction( output, firstFast, Action():hint(hint):action("use"):hintType(hType):func(BasicAIActions.OnLoot):interaction(inr_loot)) then
			return true
		end
	end

	return false
end

-- =============================================================================
-- Dog
-- =============================================================================
function BasicActor:GetDogActions(user)
	if (not user.player) or (self.soul:HasScriptContext("disableDogActions")) then
		return {}
	end

	output = {}

	AddInteractorAction( output, firstFast, Action():hint( "@ui_dog_request" ):action( "request_dog" ):hintType( AHT_HOLD ):hintClass( AHC_DOG ):func( Hare.OnDogRequest ):interaction( inr_dogInteract ):actionMap("dog"))

	return output
end

-- =============================================================================
function BasicActor:OnDogRequest(user, slot)
	user.player:RequestDogObjective(self.id)
end

-- =============================================================================
-- Create a shortcut for merged tables
-- =============================================================================
local ActorAndParams = {}
table.Merge(ActorAndParams, BasicActorParams, BasicActor) -- BasicActorParams table should have a priority when merging
BasicActor = ActorAndParams -- Store merged tables in BasicActor for cleaner entity composition.