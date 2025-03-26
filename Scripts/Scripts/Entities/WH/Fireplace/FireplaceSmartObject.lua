FireplaceSmartObject =
{
	Properties =
	{
		Fireplace = {
			esFireplaceCauldronType = 'goulash',
			bFullOnInit = true,
		},
	},
	
	cauldronType = 'goulash',
}


-- =============================================================================
function FireplaceSmartObject:OnPropertyChange()
	self:Reset()
end

-- =============================================================================
function FireplaceSmartObject:OnSpawn()
	self:Reset()
end

-- =============================================================================
function FireplaceSmartObject:Reset()
	if self.Properties.Fireplace.esFireplaceCauldronType == 'goulash' then
		self.cauldronType = 'goulash'
	elseif self.Properties.Fireplace.esFireplaceCauldronType == 'lentil' then
		self.cauldronType = 'lentil'
	elseif self.Properties.Fireplace.esFireplaceCauldronType == 'soup' then
		self.cauldronType = 'soup'
	end
end

-- =============================================================================
function FireplaceSmartObject:GetEatItemClassId()
	if self.Properties.Fireplace.esFireplaceCauldronType == 'goulash' then
		return '0dc9d98b-c59c-495d-b8e4-316448719026'
	elseif self.Properties.Fireplace.esFireplaceCauldronType == 'lentil' then
		return 'ffa8c4dd-5d4b-4fbc-ac40-38b50536b454'
	else
		return 'ba16dff8-4c13-417e-bbeb-d5ab435be20d'
	end
end

-- =============================================================================
-- Compose entity
-- =============================================================================
Script.ReloadScript( "Scripts/Entities/WH/Others/SmartObjectHolder.lua" )
EntityCommon.DeriveOverride( FireplaceSmartObject, SmartObjectHolder )