Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )

CrimeDebugger = 
{
    bPerceptionDebugEnabled     = false,
    fHighestPerceptionThreshold = 0,
    Properties = 
    {
        bExported_to_game = true,
        guidSmartObjectType = "43c857b4-032b-844f-3d1b-3cc90d5a2382",
    }
}

function CrimeDebugger:SetDebugEnabled(val)
    self.bPerceptionDebugEnabled = val
end

function CrimeDebugger:SetHighestPerceptionThreshold(val)
    self.fHighestPerceptionThreshold = val
end

function CrimeDebugger:_getPerceptionIconString()
    local equals = ''
    local spaces = ''
    local recognition = self.fHighestPerceptionThreshold * 10

    equals = string.rep("=", recognition)
    spaces = string.rep("_", 10-recognition)

    return '[' .. equals .. spaces .. ']'
end

function CrimeDebugger:_getPerceptionIconPosition()
    local position = { x=0, y=0 }
    local viewport = System.GetViewport()

    -- no clue how big the rendered text will be, so let's just use magic numbers
    position.x = viewport.width/2 - 90
    position.y = viewport.height/2 + 50

    return position
end

-- Editor callbacks
function CrimeDebugger:OnPropertyChange()
     -- pass
end

function CrimeDebugger:OnReset()
    self.bPerceptionDebugEnabled = false
end

function CrimeDebugger:OnInit()
    self:Activate(1)
end

function CrimeDebugger:OnUpdate(dt)
    if self.bPerceptionDebugEnabled then
        System.DrawText(100, 100, "Crime debug active")

        if self.fHighestPerceptionThreshold > 0 then
            local position = self:_getPerceptionIconPosition()
            System.DrawText(position.x, position.y, self:_getPerceptionIconString(), 3)
        end
    end
end

-- /Editor callbacks

-- =============================================================================
-- Compose entity
-- =============================================================================
EntityCommon.DeriveOverride( CrimeDebugger, SmartObjectHolder )