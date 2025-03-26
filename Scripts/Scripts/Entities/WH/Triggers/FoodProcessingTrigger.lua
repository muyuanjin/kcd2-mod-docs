-- =============================================================================
FoodProcessingTrigger = {}

-- =============================================================================
function FoodProcessingTrigger:OnAction(user,action)
    
	TriggerBase.OnAction(self, user, action)
	
    if( action.InventoryFilter ~= "" or action.InventoryMultiFilter~="") then
        self:ShowFoodProcessingTutorials()
	end
	
end

-- =============================================================================
function FoodProcessingTrigger:ShowFoodProcessingTutorials()
	local foodType = EntityUtils.GetMiscProperty(self.id, 'foodProcessingType');

	if foodType == 'cooking' then
		Game.ShowTutorial('OB_T01_CookingFood');
	elseif foodType == 'smoking' then
		Game.ShowTutorial('OB_T02_SmokingFood');
	elseif foodType == 'drying' then
		Game.ShowTutorial('OB_T03_DryingFood');
	end
end


-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "SCRIPTS/Entities/WH/Triggers/TriggerBase.lua")
table.Merge(FoodProcessingTrigger, TriggerBase)