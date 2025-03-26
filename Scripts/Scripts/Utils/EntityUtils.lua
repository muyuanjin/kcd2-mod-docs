EntityUtils = {}

-- =============================================================================
-- Loads an entity property declared in the 'Script' group –
-- either explicitely, or within the Misc property
function EntityUtils.GetScriptProperty(entity, propertyName)
	if entity == nil then
		TError("EntityUtils.GetScriptProperty error: The provided entity is not valid.")
		return nil
	end

	local properties = entity.Properties.Script
	if properties == nil then
		TError("EntityUtils.GetScriptProperty error: The provided entity doesn't have 'Script' properties declared.")
		return nil
	end

	local misc = {}
	local miscStr = properties['Misc']
	if miscStr then
		for k, v in miscStr:gmatch('|?([^:]+):([^|]+)') do misc[k] = v end
	end

	local result = properties[propertyName] or misc[propertyName]

	-- Convert to bool, when possible
	if result == 'true' then return true end
	if result == 'false' then return false end

	-- Convert to number, when possible
	return tonumber(result) or result
end

-- =============================================================================

function EntityUtils.GetEntityCategory(entity)
	return entity.Properties.sWH_AI_EntityCategory;
end

-- =============================================================================
function EntityUtils.GetMiscProperty(entityId, propertyName)
	local miscStr = EntityModule.GetEntityScriptMisc(entityId)

	property = nil
	if miscStr then
		for k, v in miscStr:gmatch('|?([^:]+):([^|]+)') do
			if k == propertyName then
				property = v
			end
		end
	end

	if property == 'true' then
		return true
	elseif property == 'false' then
		return false
	elseif property == '0' then
		return 0
	else
		return tonumber(property) or property
	end
end

-- =============================================================================
function EntityUtils.IsFemale(entity)
	local soul = assert(entity.soul, "Cannot check gender of an entity without a soul.")
	return soul:GetGender() == enum_humanGender.female
end
IsFemale = EntityUtils.IsFemale

-- =============================================================================
function EntityUtils.IsAnimal(entity)
	return entity.human == nil
end
IsAnimal = EntityUtils.IsAnimal

-- =============================================================================
-- easy way to log entity id
-- accepts both entity table or entityid
function EntityUtils.GetName(entity)
	if (type(entity) == "userdata") then
		local e = System.GetEntity(entity)
		if (e) then
			return e:GetName()
		end
	elseif (type(entity) == "table") then
		return entity:GetName()
	end
	return ""
end

-- =============================================================================
-- easy way to get entity by name
-- usefull for "console debugging"!
function EntityUtils.EntityNamed(name)
	return System.GetEntityByName(name)
end
EntityNamed = EntityUtils.EntityNamed

-- =============================================================================
function EntityUtils.GetScriptSoulData(entity)
	local result = table.MakeFromType('soul')

	-- Social class
	local socialClass = entity.soul:GetSocialClass()
	result.socialClass = socialClass.Name

	-- Other personal data
	result.entityClass = entity.class
	result.gender = entity.soul:GetGender()
	result.factionId = entity.soul:GetFactionID()
	result.race = enum_race.human

	-- Done
	return result
end

-- =============================================================================
function EntityUtils.DumpEntities()
	local ents = System.GetEntities()
	System.Log("Entities dump")
	for idx, e in pairs(ents) do
		local pos = e:GetPos()
		local ang = e:GetAngles()
		System.Log("[" .. tostring(e.id) .. "]..name=" .. e:GetName() .. " clsid=" .. e.class .. format(" pos=%.03f,%.03f,%.03f", pos.x, pos.y, pos.z) ..
					   format(" ang=%.03f,%.03f,%.03f", ang.x, ang.y, ang.z))
	end
end

function EntityUtils.Teleport(entityName, targetName)
	local entity = System.GetEntityByName(entityName)
	local target = System.GetEntityByName(targetName)
	entity:SetWorldPos(target:GetWorldPos())
end