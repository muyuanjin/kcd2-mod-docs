Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )

BirdsTakeoff =
{
    iLastSpawnGameTime = -1,                                       -- when was the last time we spawned birds
    hSoundTrigger_idle = nil,
    hSoundTrigger_scared = nil,
    bSoundIdleIsPlaying = false,
    Properties = 
    {
        bDebugEnabled     = false,
        bExported_to_game = true,
        guidSmartObjectType = "861d5258-0d30-4638-be5e-2c6f02b3d187",
        Settings =
        {
            -- BirdsTakeoff specific editor properties
            esBirdsTakeoffPreset = "None",                           -- settings override

            Audio =
            {
                snd_idle = "",
                snd_scared = "",
            },

            ManualValues =
            {
                esBirdsTakeoffType = "AwayFromPlayer",               -- spawn direction
                ParticleEffect = "",                                 -- what particle should be spawned
                iCooldownSeconds = 240,                              -- spawn cooldown
                fMaxRandomSpread = 1,                                -- randomly adds rotation to directionalVector around Z axis (<-value, value>)
                bSpawnAwayFromPlayer = true,                         -- should particles be spawned away or towards the player
                fSpeedScale      = 1,                                -- speed scale that gets sent into LoadParticleEffect
                bIgnoreDaytimeCheck = false                          -- by design birds take off only during day, this boolean ignores that
            }

        },

    },

    _ParticleTable = {},
    _ParticleSlot = 1,
}

-- Presets

--[[ 
    - add new enum value into `Data/Libs/UI/GlobalEnums.xml` under `BirsdTakeoffPreset` (needed for editor input box)
    - use same name in the array below
    - values under given preset will override `BirdsTakeoff.Properties` values upon level load
    - if you want to add a new preset - contact patrik.papso
]]

PresetSettings = 
{
    None = {
        Properties = {},                                                   -- use editor values
    },                                                      
    Crows_takeoff_only =
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "a_o_kavka_idle",
                        snd_scared = "a_o_kavka_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.crows",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 180,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },
    Crows_no_sound = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "",
                        snd_scared = ""
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.crows",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 180,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },
    Crows = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "a_o_kavka_idle",
                        snd_scared = "a_o_kavka_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.crows_tree",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 90,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },
    Crows_static_angle = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "",
                        snd_scared = ""
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "StaticAngle",
                        ParticleEffect = "WH_Particels.other.birds_small_tree",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 0,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },
    Starlings = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "a_o_spacek_idle",
                        snd_scared = "a_o_spacek_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.birds_small_tree",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 45,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },
    Nuthatchs = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "a_o_brhlik_idle",
                        snd_scared = "a_o_brhlik_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.birds_small_tree",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 45,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },
    Nightjar = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "a_o_lelek_idle",
                        snd_scared = "a_o_lelek_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.birds_small_tree",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 45,
                        fSpeedScale = 2.5
                    }
                }   
            }
        },   
    Buzzard_takeoff_only = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "", -- should be ignored
                        snd_scared = "a_o_kane_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "AwayFromPlayer",
                        ParticleEffect = "WH_Particels.other.bird_big_single",
                        iCooldownSeconds = 300,
                        fMaxRandomSpread = 180,
                        fSpeedScale = 3
                    }
                }   
            }
        },       
    Bats  = 
        {
            Properties = 
            {
                Settings = {
                    Audio = 
                    {
                        snd_idle = "a_o_netopyr_idle",
                        snd_scared = "a_o_netopyr_scared"
                    },
                    ManualValues = 
                    {
                        esBirdsTakeoffType = "TowardsPlayer",
                        ParticleEffect = "WH_Particels.other.bats",
                        iCooldownSeconds = 600,
                        fMaxRandomSpread = 45,
                        fSpeedScale = 1.5,
                        bIgnoreDaytimeCheck = true
                    }
                }   
            }
        },            
}
-- /Presets

function BirdsTakeoff:ApplyPreset(preset)
    if (PresetSettings[preset] ~= nil) then
        presetCopy = table.DeepCopy(PresetSettings[preset])      
        table.Merge(presetCopy.Properties, self.Properties)
        self.Properties = presetCopy.Properties
    end
end

-- Editor callbacks
function BirdsTakeoff:OnPropertyChange()
end

function BirdsTakeoff:OnReset()
    self.iLastSpawnGameTime =  -1                                  -- reset cooldown when entering/leaving editor game mode
    self:FreeSlot(self._ParticleSlot)
    --self:SetAngles({x=0, y=0, z=0})
    -- enable on OnUpdate debug draw
    if self:IsDebugEnabled() then
        self:Activate(1)
    else
        self:Activate(0)
    end
end

function BirdsTakeoff:OnInit()
    self:CacheResources()
end

-- =============================================================================
function BirdsTakeoff:CacheResources()
	self:PreLoadParticleEffect( self.Properties.Settings.ManualValues.ParticleEffect )
end

function BirdsTakeoff:OnSave(table)
    table.iLastSpawnGameTime = self.iLastSpawnGameTime
    table.Properties.Settings.esBirdsTakeoffPreset = self.Properties.Settings.esBirdsTakeoffPreset
end

function BirdsTakeoff:OnLoad(table)
    self.iLastSpawnGameTime = table.iLastSpawnGameTime
    self.Properties.Settings.esBirdsTakeoffPreset = table.Properties.Settings.esBirdsTakeoffPreset
end

function BirdsTakeoff:OnLevelLoaded()
    self:ApplyPreset(self.Properties.Settings.esBirdsTakeoffPreset)
end
-- /Editor callbacks

function BirdsTakeoff:IsDebugEnabled()
    return self.Properties.bDebugEnabled
end

function BirdsTakeoff:IsOffCooldown()
    -- @KCD2-74602 disable takeoff based on time of the day and rain intensity
    -- variability ~10minutes
    local worldHourOfDay = Calendar.GetWorldHourOfDay() - math.random(0, 0.30)
    --Dump("Time: " .. worldHourOfDay)
    if (worldHourOfDay > 21 or worldHourOfDay < 5) and not self.Properties.Settings.ManualValues.bIgnoreDaytimeCheck then
        return false
    end

    local rainIntensity = EnvironmentModule.GetRainIntensity()
    if (rainIntensity > 0) then -- is raining
        return false
    end

    -- actual cooldown
    local currentTime = Calendar.GetGameTime()
    return (self.iLastSpawnGameTime == -1 or self.iLastSpawnGameTime < (currentTime - self.Properties.Settings.ManualValues.iCooldownSeconds))
end

function BirdsTakeoff:_playSound(soundString)
    if soundString == "" then
        return
    end

    local soundTrigger = AudioUtils.LookupTriggerID(soundString)
    if (soundTrigger ~= nil) then
        self:ExecuteAudioTrigger(soundTrigger, self:GetDefaultAuxAudioProxyID())
    end

    if soundTrigger == self.hSoundTrigger_idle then
        self.bSoundIdleIsPlaying = true
    end
end

function BirdsTakeoff:_stopSound(soundString)
    if soundString == "" then
        return
    end

    local soundTrigger = AudioUtils.LookupTriggerID(soundString)
    if (soundTrigger ~= nil) then
        self:StopAudioTrigger(soundTrigger, self:GetDefaultAuxAudioProxyID())
    end

    if soundTrigger == self.hSoundTrigger_idle then
        self.bSoundIdleIsPlaying = false
    end
end

function BirdsTakeoff:EnteredSoundArea()
    if self:IsOffCooldown() then
        self:_playSound(self.Properties.Settings.Audio.snd_idle)
    end
end

function BirdsTakeoff:LeftSoundArea()
    -- we might have already stopped it when we scared birds, so let's not stop stopped sound
    if self.bSoundIdleIsPlaying then
        self:_stopSound(self.Properties.Settings.Audio.snd_idle)
    end
end

function BirdsTakeoff:_SpawnParticle(direction)
    local particleEffect = self.Properties.Settings.ManualValues.ParticleEffect
    -- Spawn Particle effect.
    if (particleEffect ~= "") then
        if self.Properties.Settings.ManualValues.esBirdsTakeoffType ~= "StaticAngle" then
            -- #KCD2-323299 [patrik.papso]
            -- StaticAngle uses [0,1,0] as a relative direction complementing entity's rotation
            -- All the other types are treated as an AbsoluteDirection, so the entity's rotation
            -- should be ignored. So let's transform the absolute world direction into entity's local space
            direction = self:VectorToLocal(-1, direction);
        end
        
        self._ParticleTable.SpeedScale = self.Properties.Settings.ManualValues.fSpeedScale
        self:FreeSlot(self._ParticleSlot)
        self:LoadParticleEffect(self._ParticleSlot, particleEffect, self._ParticleTable )
        self:SetSlotPosAndDir(self._ParticleSlot, {x=0,y=0,z=0}, direction)
    end 
end

--WH_NOMASTER_START
--[[

function BirdsTakeoff:OnUpdate(dt)
    if self:IsDebugEnabled() then
        
        -- entity forward
        System.DrawLine(self:GetPos(), VectorUtils.Sum(self:GetPos(), VectorUtils.Scale(self:GetWorldDir(),5)), 1, 0, 0, 1)

        -- slot forward
        local slotForward = self:GetSlotWorldDir(self._ParticleSlot);
        System.DrawLine(self:GetPos(), VectorUtils.Sum(self:GetPos(), VectorUtils.Scale(slotForward, 5)), 0, 1, 0, 1)
    end
end

]]--
--WH_NOMASTER_END

-- Return true/false if we spawned birds
function BirdsTakeoff:SpawnBirds(startleSource)
    if self:IsOffCooldown() or self:IsDebugEnabled() then
        local shouldAddRandomSpread = true
        -- calculate spawnDirection based on takeoff type
        local spawnDirection = { x = 0, y = 0, z = 0}
        local startleSourcePosition = VectorUtils.Sum(startleSource:GetPos(), {x = 0, y = 0, z = 1.8}) -- with added player's height
        local perfectDir = VectorUtils.GetDirection(self:GetPos(), startleSourcePosition)

        if self.Properties.Settings.ManualValues.esBirdsTakeoffType == "Upwards" then
            spawnDirection = {x = 0, y = 0.02, z = 1}
            shouldAddRandomSpread = false
        elseif self.Properties.Settings.ManualValues.esBirdsTakeoffType == "TowardsPlayer" then
            spawnDirection = perfectDir
            shouldAddRandomSpread = false
        elseif self.Properties.Settings.ManualValues.esBirdsTakeoffType == "AwayFromPlayer" then
            spawnDirection = VectorUtils.Negate(perfectDir)
            shouldAddRandomSpread = true
        elseif self.Properties.Settings.ManualValues.esBirdsTakeoffType == "StaticAngle" then
            spawnDirection = {x=0,y=1,z=0}  -- relative direction
            shouldAddRandomSpread = false
        end

        -- stop idle sound
        self:_stopSound(self.Properties.Settings.Audio.snd_idle)

        -- play scared sound
        self:_playSound(self.Properties.Settings.Audio.snd_scared)
        
        -- add random spread to spawnDirection
        if shouldAddRandomSpread then
            -- calculate random angle
            local angleToY = VectorUtils.GetAngleBetween(spawnDirection, { x = 0, y = 1, z = 0})
            local randomAngleY = math.random( -self.Properties.Settings.ManualValues.fMaxRandomSpread, self.Properties.Settings.ManualValues.fMaxRandomSpread )
            spawnDirection = VectorUtils.RotateAround(spawnDirection, { x = 0, y = 1, z = 0}, math.rad(randomAngleY))
            spawnDirection.z = 0.8 -- @KCD2-117390, make the angle static to solve this issue
        end

        spawnDirection = VectorUtils.Normalize(spawnDirection)
        
        -- spawn particle and update cooldown
        self:_SpawnParticle(spawnDirection)
        local currentTime = Calendar.GetGameTime()
        self.iLastSpawnGameTime = currentTime

        return true
    end
    return false
end

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( BirdsTakeoff, SmartObjectHolder )