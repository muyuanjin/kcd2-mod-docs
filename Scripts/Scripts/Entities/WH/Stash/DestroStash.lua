Script.ReloadScript( "Scripts/Entities/WH/Stash/ShootableStashBase.lua" )

DestroStash =
{
	Server = {},
	Client = {},

	Properties =
	{
		
		object_Model = "objects/natural/animal/bird_nest.cgf",
		object_ShardModel = "objects/natural/stones/stone_basalt_b.cgf",
		
		Database =
		{
			bReadOnly = true,
		},

		Sounds =
		{
			snd_Hit = "",
		},

    },
	Editor=
	{
		Icon		="DestroStash.bmp",
		ShowBounds 	= 1,
		IconOnTop 	= 1,
	},
}

-- =============================================================================
function DestroStash:GetSoundTriggerID()
	if snd_Hit == "" then
		return nil
	end
	return AudioUtils.LookupTriggerID(self.Properties.Sounds.snd_Hit)
end

-- =============================================================================
function DestroStash:OnLoad(table)
	self:DoStopSound()
	if(table.shot ~= nil) then
		self.shot = table.shot
	else
		self.shot = 0
	end

	self:Hide(self.shot)
end

-- =============================================================================
function DestroStash:AfterReset()
	self:Hide(0)
end

-- =============================================================================
-- OVERRIDE
function DestroStash:IsUsable(user)
	return not self.shot
end

-- =============================================================================
function DestroStash:GetActions(user, firstFast)
	if (user == nil) then
		return {}
	end

	if (self.shot == 1) then
		return {}
	end

	output = {}
	AddInteractorAction( output, firstFast, Action():hint( "@ui_open_stash" ):action( "use" ):func( DestroStash.OnUsed ):interaction( inr_stashOpen ) )
	return output
end


-- =============================================================================
function DestroStash:CanBeUsed()
	if (self.shot == 1) then
		return 0
	end

	return 1
end

-- =============================================================================
function DestroStash:AfterShot(hit)
	self.stash:DumpItemsToWorld()
	self:DoPlaySound()
	
	self:SpawnShard()
	self:SpawnShard()

	self:Hide(1)
end

-- =============================================================================
function DestroStash:SpawnShard()

	local params = {
		class = "Debris",
		position = self:GetPos(),

			properties = {
				object_Model= self.Properties.object_ShardModel,
				Physics = {
					Mass = 2,
					bResting = 0
				}

			},
	}

	params.name = "shard"
	shard = System.SpawnEntity(params)
end
-- =============================================================================

EntityCommon.DeriveOverride(DestroStash,ShootableStashBase );