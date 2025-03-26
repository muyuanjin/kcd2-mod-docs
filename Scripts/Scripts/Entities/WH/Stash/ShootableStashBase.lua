ShootableStashBase =
{
	Server = {},
	Client = {},

	Properties =
	{
		object_Model = "Objects/natural/animal/bird_nest.cgf",
		ParticleEffect = "",

		Lock =
		{
			bLocked = false, -- default state
			bCanLockPick = false,
			bCanUnlockWithDynamicKey = false, -- master key to all locks in home or shop generated in code while looting / pickpocketing. Disable to enable only legacy guid keys
			fLockDifficulty = 1,
			bLockDifficultyOverride = false,
			esLockFanciness = "Common",
			bSendMessage = false,	-- send signals to AI
			guidItemClassId = "", --["item used as a key"]
		},
		
		Physics = {
			bPhysicalize 		= true, 	-- True if object should be physicalized at all.
			bRigidBody 			= true, 	-- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density 			= -1,
			Mass 				= 1,
		},

		Database = {
			guidInventoryDBId	= "0",
			sInventoryPreset 	= "",
			nRestockPeriodDays 	= 0, -- in how many days does the item restock after being taken, 0 to disable restock
			bReadOnly 			= false,
		},
    },


	Editor=
	{
		Icon		="Stash.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},

	inventoryId		= 0,
	hSoundTriggerID = nil,
	shot		= 0,
	bLocked 		= false, -- current state
}

-- =============================================================================
function ShootableStashBase:NeedSerialize()
	if (self.shot ~= 0) then
		return true
	end

	return false
end

-- =============================================================================
function ShootableStashBase:OnSave(table)
	if (self.shot ~= 0) then
		table.shot = self.shot
	end
end

-- =============================================================================
-- OnPropertyChange called only by the editor.
function ShootableStashBase:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
-- OnReset called only by the editor.
function ShootableStashBase:OnReset()
	self:Reset()
end

-- =============================================================================
-- OnSpawn called Editor/Game.
function ShootableStashBase:OnSpawn()
	self:Reset()
end

-- =============================================================================
function ShootableStashBase:Reset()

	if (self.Properties.object_Model ~= "") then
		self:LoadObject(0, self.Properties.object_Model)
	end

	self.hSoundTriggerID = self:GetSoundTriggerID()

	self:PhysicalizeThis()
	self.shot = 0
	self:AfterReset()
end

-- =============================================================================
function ShootableStashBase:PhysicalizeThis()
	local Physics = self.Properties.Physics
	EntityCommon.PhysicalizeRigid( self, 0, Physics, false )
end

-- =============================================================================
function ShootableStashBase:IsUsable(user)
	return 1
end

-- =============================================================================
function ShootableStashBase:Open(user)
	user.actor:OpenItemTransferStore(self.id, self.inventoryId)

	self:Event_Open()
end

-- =============================================================================
function ShootableStashBase:Close()
	self:Event_Close()
end

-- =============================================================================
function ShootableStashBase:OnInventoryClosed()
	self:Close()
end

-- =============================================================================
function ShootableStashBase:OnUsed(user, slot)
	if (user.soul:IsInCombatDanger()) then
		return
	end

	if self:CanBeUsed() == 0 then
		return
	end

	if (user.player) then
		self:Open(user)
	end
end

-- =============================================================================
-- override this function in child
function ShootableStashBase:GetSoundTriggerID()
	return nil 
end

-- =============================================================================
function ShootableStashBase:DoPlaySound()
	self:DoStopSound()

	if (self.hSoundTriggerID ~= nil) then
		self:ExecuteAudioTrigger(self.hSoundTriggerID, self:GetDefaultAuxAudioProxyID())
	end
end

-- =============================================================================
function ShootableStashBase:DoStopSound()
	if (self.hSoundTriggerID ~= nil) then
		self:StopAudioTrigger(self.hSoundTriggerID, self:GetDefaultAuxAudioProxyID())
	end
end

-- =============================================================================
function ShootableStashBase:StartParticleEffect(hit)
	Particle.SpawnEffect(self.Properties.ParticleEffect, hit.pos, hit.dir)
end

-- =============================================================================
function ShootableStashBase.Client:OnHit(hit)
	if (self.shot == 0) then
		self:StartParticleEffect(hit)
		self:AfterShot()
		self.shot = 1
	end
end

-- =============================================================================
-- Events
-- =============================================================================
function ShootableStashBase:Event_Open()
	--System.Log("ShootableStashBase: Open Event")
end

-- =============================================================================
function ShootableStashBase:Event_Close()
	--System.Log("ShootableStashBase: Close Event")
end

-- =============================================================================
function ShootableStashBase:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
end

-- =============================================================================
function ShootableStashBase:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
end

-- =============================================================================
function ShootableStashBase:AssignInventory()
	local stashInformation = StashInventoryCollector.GetStashInformation(self)
	local generatedInventory = StashInventoryGenerator.GetInventoryFromData(stashInformation)

	--Dump("Assigning inventory '" .. generatedInventory)
	EditorUtil.AssignInventoryToStash(self.id, generatedInventory)
end

-- =============================================================================
ShootableStashBase.FlowEvents =
{
	Inputs =
	{
		Close = { ShootableStashBase.Event_Close, "bool" },
		Open = { ShootableStashBase.Event_Open, "bool" },
		Hide = { ShootableStashBase.Event_Hide, "bool" },
		UnHide = { ShootableStashBase.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Close = "bool",
		Open = "bool",
		Hide = "bool",
		UnHide = "bool",
	},
}