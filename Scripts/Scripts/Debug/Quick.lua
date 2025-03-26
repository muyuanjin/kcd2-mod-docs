
q =
{
	utils = {}
}

-- ======================================================================================
function q.en (name)

	return System.GetEntityByName(name)

end

-- ======================================================================================
function q.nen (name)

	return System.GetNearestEntityByName(name)

end

-- ======================================================================================
function q.sm (entityOrEntityName, type, data)

	local entity = q.utils.parseEntityParam(entityOrEntityName)
	XGenAIModule.SendMessageToEntityData(entity.this.id, type, data)

end

-- ======================================================================================
function q.dd (entityOrEntityName, hitToHealth, hitToStamina)

	local entity = q.utils.parseEntityParam(entityOrEntityName)
	entity.soul:DealDamage(hitToHealth, hitToStamina, __null, true)

end

-- ======================================================================================
function q.ci (itemGuid)

	ItemUtils.CreateInvItem(player, itemGuid)

end

-- ======================================================================================
function q.utils.parseEntityParam (entityOrEntityName)

	if type(entityOrEntityName) == 'string' then

		local entity = System.GetEntityByName(entityOrEntityName)
		if entity ~= nil then

			return entity

		else

			error(StrFormat("Entity with name '%s' doesn't exist.", entityOrEntityName))

		end

	end

	if type(entityOrEntityName) == 'table' then

		return entityOrEntityName

	end

	error("Cannot parse provided argument as either entity or an entity name.")

end
