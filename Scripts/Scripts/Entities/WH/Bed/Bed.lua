Script.ReloadScript( "Scripts/Entities/Physics/BasicEntity.lua" )

Bed =
{
	Properties =
	{
		bSaved_by_game = false,
		guidSmartObjectType = "",
		soclass_SmartObjectHelpers = "",
		bInteractiveCollisionClass = false,
		sWH_AI_EntityCategory = "",
		sSittingTagGlobal = "sittingNoTable",
		fUsabilityDistance = 1.75,

		object_Model="Objects/props/furniture/beds/bed_cottage_01.cgf",


		Script = {
			Misc = '',
			esBedTypes = 'bench',
		},

		Body =
		{
			guidBodyPrestId = "0",
			guidClothingPresetId = "0",
		},

		Bed =
		{
			esSleepQuality = "low",
			esReadingQuality = "none",
		},

		esFaction = "",

	},

	 Editor={
		 Icon="physicsobject.bmp",
		 IconOnTop=1,
	},

	Client = {},
	Server = {},
}

-- =============================================================================
function Bed:GetSleepQuality()
    -- this mapping is in db table 'sleeping_spot_type'

    local str = self.Properties.Bed.esSleepQuality

    if str=="low" then
        return 2
    elseif str=="medium" then
        return 3
    elseif str=="high" then
        return 1
    elseif str=="exceptional" then
        return 0
    else
        return 2
    end
end

-- =============================================================================
function Bed:GetReadingQuality()
    -- db table 'reading_spot_type'

    local str = self.Properties.Bed.esReadingQuality

    if str=="none" then
        return 0
    elseif str=="bed_ground" then
        return 1
    elseif str=="bed" then
        return 3
    elseif str=="bed_exceptional" then
        return 4
    elseif str=="bench_table" then
        return 5
    elseif str=="bench_notable" then
        return 6
    else
        return 0
    end
end

-- =============================================================================
-- function Stash:GetUsableMessage(idx)
-- 	return "@ui_hud_sleep"
-- end

-- =============================================================================
function Bed.Client:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
end

-- =============================================================================
function Bed.Server:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0)
end

-- =============================================================================
function Bed.Client:OnPhysicsBreak( vPos,nPartId,nOtherPartId )
	self:ActivateOutput("Break",nPartId+1 )
end

-- =============================================================================
function Bed:Event_Remove()
	self:DrawSlot(0,0)
	self:DestroyPhysics()
	self:ActivateOutput( "Remove", true )
end

-- =============================================================================
function Bed:Event_Hide()
	self:Hide(1)
	self:ActivateOutput( "Hide", true )
end

-- =============================================================================
function Bed:Event_UnHide()
	self:Hide(0)
	self:ActivateOutput( "UnHide", true )
end

-- =============================================================================
function Bed:OnLoad(table)
	self.health = table.health
	self.dead = table.dead
	if(table.bAnimateOffScreenShadow) then
		self.bAnimateOffScreenShadow = table.bAnimateOffScreenShadow
	else
		self.bAnimateOffScreenShadow = false
	end
    self.usedByNPC = nil
end

-- =============================================================================
function Bed:OnSave(table)
	table.health = self.health
	table.dead = self.dead
	if(self.bAnimateOffScreenShadow) then
		table.bAnimateOffScreenShadow = self.bAnimateOffScreenShadow
	else
		table.bAnimateOffScreenShadow = false
	end
end

-- =============================================================================
function Bed.Client:OnLevelLoaded()
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function Bed:OnEnablePhysics()
	-- When loading streamable layer, OnLevelLoaded has been sent way before.
	-- Nevertheless, interactive collision class must be set for the entity
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function Bed:OnPropertyChange()
	BasicEntity.OnPropertyChange( self )
	self:SetInteractiveCollisionType()
end

-- =============================================================================
function Bed:MarkUsedByNPC( used )
    self.usedByNPC = used
end

-- =============================================================================
function Bed:IsUsableByPlayer(user)

    local myDirection = g_Vectors.temp_v1
    local vecToPlayer = g_Vectors.temp_v2
    local myPos = g_Vectors.temp_v3

    myDirection = self:GetDirectionVector(0)

    user:GetWorldPos(vecToPlayer)
    self:GetWorldPos(myPos)

    vecToPlayer = VectorUtils.Subtract(myPos, vecToPlayer)
    local len = VectorUtils.Length(vecToPlayer)

    if(len <= self.Properties.fUsabilityDistance) then
        return true
    end
    return false
end

-- =============================================================================
function Bed:GetActions(user,firstFast)
    output = {}
    local sleepPrompt = EntityModule.WillSleepingOnThisBedSave( self.id ) and "@ui_hud_sleep_and_save" or "@ui_hud_sleep"
    if( self:IsUsableByPlayer(user) ) then
        if ( self.Properties.Script.esBedTypes == 'normal' or self.Properties.Script.esBedTypes == 'bench' ) then
            AddInteractorAction( output, firstFast, Action():hint("@ui_hud_sit"):action("use_bed_sit"):func(Bed.OnUsed):interaction(inr_bedSit):enabled(not self.usedByNPC) )
            if Variables.GetGlobal('bed_disable_direct_sleep') == 0 then
                AddInteractorAction( output, firstFast, Action():hint( sleepPrompt ):action("use_bed_sleep"):hintType( AHT_HOLD ):func(Bed.OnUsedHold):interaction(inr_bedSit):enabled(not self.usedByNPC) )
            end
        else
            AddInteractorAction( output, firstFast, Action():hint( sleepPrompt ):action("use_bed_sleep"):func(Bed.OnUsed):interaction(inr_bedSleep ):enabled(not self.usedByNPC) )
        end
    end
    return output
end

-- =============================================================================
function Bed:OnUsed(user)
    if( self.Properties.Script.esBedTypes == 'normal' or self.Properties.Script.esBedTypes == 'bench' or ( user.player and user.player.CanSleepAndReportProblem() ) ) then
        XGenAIModule.SendMessageToEntity( player.this.id, "player:request", "target("..Framework.WUIDToMsg( XGenAIModule.GetMyWUID(self) ).."), mode ('use')" )
    end
end

-- =============================================================================
function Bed:OnUsedHold(user)
    if( user.player and user.player.CanSleepAndReportProblem() ) then
        XGenAIModule.SendMessageToEntity( player.this.id, "player:request", "target("..Framework.WUIDToMsg( XGenAIModule.GetMyWUID(self) ).."), mode ('use'), behavior('player_use_sleep')" )
    end
end

-- =============================================================================
function Bed:SetInteractiveCollisionType()
	local filtering = {}

	if(self.Properties.bInteractiveCollisionClass == true) then
		filtering.collisionClass = 262144; -- gcc_interactive from GamePhysicsCollisionClasses.h
	else
		filtering.collisionClassUNSET = 262144
	end

	self:SetPhysicParams(PHYSICPARAM_COLLISION_CLASS, filtering )
end

-- =============================================================================
Bed.FlowEvents =
{
	Inputs =
	{
		Hide = { Bed.Event_Hide, "bool" },
		UnHide = { Bed.Event_UnHide, "bool" },
		Remove = { Bed.Event_Remove, "bool" },
	},
	Outputs =
	{
		Hide = "bool",
		UnHide = "bool",
		Remove = "bool",
		Break = "int",
	},
}

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( Bed, BasicEntity )
