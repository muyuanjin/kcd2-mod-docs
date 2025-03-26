Script.ReloadScript( "Scripts/Entities/WH/Stash/ShootableStashBase.lua" )
Nest =
{
	Server = {},
	Client = {},

	Properties =
	{
		Database =
		{
			sInventoryPreset = "inventory_birdNest",
		},
		Sounds =
		{
			snd_Birds = "a_l_poi_birdnest",
		},
		isShootingTarget = true,	-- True if entity hit with missile weapon should by process by RPG event
    },
}

-- =============================================================================
function Nest:GetSoundTriggerID()
	return AudioUtils.LookupTriggerID(self.Properties.Sounds.snd_Birds)
end

-- =============================================================================
function Nest:OnLoad(table)
	self:DoStopSound()
	if(table.shot ~= nil) then
		self.shot = table.shot
	else
		self.shot = 0
	end
end

-- =============================================================================
function Nest:AfterReset()
	self:DoStopSound()
	self:DoPlaySound()
end

-- =============================================================================
function Nest:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	output = {}

	AddInteractorAction( output, firstFast, Action():hint( "@ui_open_nest" ):action( "use" ):func( Nest.OnUsed ):interaction( inr_stashOpen ) )
	return output
end

-- =============================================================================
function Nest:CanBeUsed()
	return 1
end

-- =============================================================================
function Nest:AfterShot(hit)
  local PhysicsAfterShot = {
    bPhysicalize 	     = true,
    bRigidBody 			   = true,
    bPushableByPlayers = self.Properties.Physics.bPushableByPlayers,
    Density 			     = self.Properties.Physics.Density,
    Mass 				       = self.Properties.Physics.Mass
  }
	EntityCommon.PhysicalizeRigid( self, 0, PhysicsAfterShot, true )
	self:DoStopSound()
end

EntityCommon.DeriveOverride( Nest,ShootableStashBase );