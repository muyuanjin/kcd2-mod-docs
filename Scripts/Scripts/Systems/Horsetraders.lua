Horsetraders = {}

-- =========================================================
function Horsetraders.SetupHaggle(stableMaster,playerHorseValue, newHorseValue)
    -- add metarole to stablemaster, don't forget to remove it after haggle is done
    stableMaster.soul:AddMetaRoleByName('SMLOUVANI')

    -- values need to be in decigroschen, but dialogue sends groschen
    newHorseValue = newHorseValue * 10;
    playerHorseValue = playerHorseValue * 10;
    -- fill in variables for haggle included dialogue
    Variables.SetGlobal('haggle_playerBuysValue', newHorseValue)
    Variables.SetGlobal('haggle_playerSellsValue', playerHorseValue)
    Variables.SetGlobal('haggle_suspiciousness', 0)
    Variables.SetGlobal('haggle_suspiciousness_reaction', 0)

    -- MoneySlider is implicitly set to use stablemaster's inventory money
    local params = 
    {
        limitByNpcEntity = stableMaster
    }
    DialogUtils.SetupMoneySlider(params)
end

function Horsetraders.RemoveHaggleMetarole(stableMaster)
    stableMaster.soul:RemoveMetaRoleByName('SMLOUVANI')
end