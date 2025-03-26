Script.ReloadScript( "Scripts/Entities/WH/UsableItem.lua")

Hole =
{
	Properties =
	{
		sWH_AI_EntityCategory = "",
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		object_Model = "objects/characters/assets/grave_pit/grave_pit.cgf",
		bPreview = false,			-- previews hole in terrain in editor
		bCover = true,				-- vegetation cover of the hole
		nDiggingTime = 6.5,			-- how long is hole digged in seconds
		bSendMessage = false,			-- send signals to AI
		bCanBeUsed = true,
		fUsabilityDistance = 5,

		Physics = {
			bPhysicalize = true, -- True if object should be physicalized at all.
			bRigidBody = false, -- True if rigid body, False if static.
			bPushableByPlayers = false,
			Density = -1,
			Mass = -1,
		},

		Script = {
			bLegalToDig = false
		}
	},

	Editor={
		Icon = "DeadBody.bmp",
		IconOnTop = 1,
	},

	nDepth = 0,		-- 0 - hole full, 1 - hole is empty
}

-- =============================================================================
-- OnReset called only by the editor.
function Hole:OnReset()
	self:Reset()
end

-- =============================================================================
function Hole:Reset()
	UsableItem.Reset(self)
	self.nDepth = 0
	self.canBeUsed = self.Properties.bCanBeUsed
end

-- =============================================================================
function Hole:OnPropertyChange()
    self:Reset()
end

-- =============================================================================
function Hole:OnSpawn()
	self:Reset()
end

-- =============================================================================
function Hole:OnLoad(t)
	self:Reset()
	self.canBeUsed = t.canBeUsed
	self.nDepth = t.nDepth
end

-- =============================================================================
function Hole:OnSave(t)
	t.canBeUsed = self.canBeUsed
	t.nDepth = self.nDepth
end

-- =============================================================================
function Hole:CreateHole()		-- for scripters instead of save/load
	self.nDepth = 1
end

-- =============================================================================
function Hole:ChangeModel()		-- for scripters
	self.nDepth = 1
	self:LoadObject(0, self.Properties.object_ModelNew)
	self:PhysicalizeThis()
end

-- =============================================================================
function Hole:GetActions(user, firstFast)
	output = {}

	if self.canBeUsed == false then
			return output
	end

	if (not user) then
		return output; -- cannot be used by AI
	end

	if (self.nUserId ~= 0) then
		return output
	end

	if (self.nDepth == 1) then
		return output
	end

	if (user.soul:GetGender() ~= 1) then
		return output; -- can only be used by males
	end

	dist = self:GetDistance(user.id)
	if (dist > self.Properties.fUsabilityDistance) then
		return output
	end

	local canUseMinigame = Minigame.CanUseMinigame(user.id);
	local ui_hint = "@ui_hud_start_digging"
	if self.Properties.Script.bLegalToDig == false then
		ui_hint = "@ui_hud_start_digging_illegal"
	end
	AddInteractorAction( output, firstFast, Action():hint( ui_hint ):action( "use" ):func( Hole.OnUsed ):interaction( inr_holeDigging ):enabled(canUseMinigame) )
	return output
end

-- =============================================================================
function Hole:OnUsed(user)
	if (user) then
		if (self.nUserId == 0 and self.nDepth < 1) then

			Minigame.StartHoleDigging(self.id)

			-- Crime: Move this to C++ when possible
			if self.Properties.Script.bLegalToDig == false then

				local shovelGuid = '85409fc6-36ff-4de7-b337-e2889e435f1b'
				if player.inventory:FindItem(shovelGuid) then

					local pos = self:GetPos()

					local crimeVolume = XGenAIModule.SpawnPerceptibleVolume(pos, 1, 1.5, 1, 1, 'crime_graveRobbing', '10s', true, true)
					XGenAIModule.AddLink(crimeVolume, self.this.id, 'crime_graveRobbing')

					local values = { posX = pos.x, posY = pos.y, posZ = pos.z }
					XGenAIModule.SendMessageToEntityData(player.this.id, 'minigame:holedigging', values)
				end
			end

		end
	end
end

-- =============================================================================
function Hole:SetInteractive (value)
	self.canBeUsed = value
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride(Hole, UsableItem)
