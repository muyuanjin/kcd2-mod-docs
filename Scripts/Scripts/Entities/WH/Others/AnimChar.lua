Script.ReloadScript( "Scripts/Entities/Physics/BasicEntity.lua" )

AnimChar =
{
	Properties =
	{
		bSaved_by_game = false,
		object_Model = "Objects/Characters/humans/male/skeleton/male.cdf",

		Physics = {
			bPhysicalize = false, -- True if object should be physicalized at all.
			bRigidBody = true, -- True if rigid body, False if static.
			bPushableByPlayers = true,

			Density = -1,
			Mass = -1,
		},

		Rendering =
		{
			bWrinkleMap = true,
		},

		Body =
		{
			guidBodyPresetId = "0",
			guidClothingPresetId = "0",
			guidWeaponPresetId = "0",
			fDirtOverride = -1.0, --[-1.0,1.0,0.1,"Same dirt value on body and equip. Negative to turn off."]
			fBloodOverride = -1.0, --[-1.0,1.0,0.1,"Same blood value on body and equip. Negative to turn off."]
			fScratchesOverride = -1.0, --[-1.0,1.0,0.1,"Same scratches on equip. Negative to turn off."]
			bIsMortal = false, -- If false, the original body preset will be used in cutscenes even if the soul is dead
			guidSubstituteBodyPresetId = "0", -- What body preset should be used when the original is dead
			bVisorClosed = false,
		},
		esClothingConfig = "male2",
		bClothingRemoveHelmet = true,
		characterDetail = 0,
		guidBeardHairOverrideId = "0",
	},

}

-- =============================================================================
function AnimChar:OnSpawn()
	self.__super.OnSpawn(self); -- Call parent

end

-- =============================================================================
function AnimChar:OnReset()
	self.__super.OnReset(self); -- Call parent
	self:SetFromProperties()
end

-- =============================================================================
function AnimChar:SetFromProperties()
	self.__super.SetFromProperties(self); -- Call parent function.
end

-- =============================================================================
function AnimChar:Event_BodyBlood(sender, msg)
	zone, value = msg:match("([^,]+):([^,]+)")
	value01 = tonumber(value)
	EntityModule.AnimCharSetBodyBlood(self.id, zone, value01)
end

-- =============================================================================
AnimChar.FlowEvents =
{
	Inputs =
	{
		BodyBlood = { AnimChar.Event_BodyBlood, "string" },
	},
	Outputs =
	{
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( AnimChar, BasicEntity )