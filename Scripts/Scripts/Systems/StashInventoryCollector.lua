StashInventoryCollector = {}

-- =========================================================

function StashInventoryCollector.GetStashWuid(stash)
    local wuid = XGenAIModule.GetMyWUID(stash)
    
    return Framework.IsValidWUID(wuid) and wuid or nil
end

-- =========================================================

function StashInventoryCollector.GetStashOwner(context)
    if context.wuid == nil then
        return nil
    end

    local owner = XGenAIModule.GetOwner(context.wuid)
    return Framework.IsValidWUID(owner) and owner or nil
end

-- =========================================================

function StashInventoryCollector.GetStashHome(context)
    if context.wuid == nil or context.owner == nil then
        return nil
    end
    
    return XGenAIModule.FindLinks(context.owner, "home")[1] -- nil if no home
end

-- =========================================================

function StashInventoryCollector.HasClothingLink(context)
    if context.wuid == nil then
        return false
    end

    return XGenAIModule.HasClothingLink(context.wuid)
end

-- =========================================================

function StashInventoryCollector.GetNPCInformation(npcWuid)
    if Framework.IsValidWUID(npcWuid) then
        local npcEntity = XGenAIModule.GetEntityByWUID(npcWuid)

        if npcEntity ~= nil and npcEntity.this ~= nil and npcEntity.soul ~= nil then
            return 
            {
                name = npcEntity.this.name,
                socialClass = npcEntity.soul:GetSocialClass().Name,
                factionID = npcEntity.soul:GetFactionID(),
            }
        end
    end

    return nil
end

-- =========================================================

function StashInventoryCollector.GetHomeInhabitantsData(context)
    if context.home == nil then
        return {}
    end

    local data = {}
    local inhabitants = XGenAIModule.FindLinks(context.home, "home_inhabitant")

    for index, targetWuid in pairs(inhabitants) do
        table.insert(data, StashInventoryCollector.GetNPCInformation(targetWuid))
    end

    return data
end

-- =========================================================

function StashInventoryCollector.GetOwnersData(context)
    if context.owner == nil then
        return nil
    end

    local data = {}

    if context.home ~= nil then
        data = StashInventoryCollector.GetHomeInhabitantsData(context)
    else
        table.insert(data, StashInventoryCollector.GetNPCInformation(context.owner))
    end

    return data
end

-- =========================================================

function StashInventoryCollector.GetOwnerPrefix(context)
    if context.owner == nil then
        return ""
    end

    ownerEntity = XGenAIModule.GetEntityByWUID(context.owner)
    return string.Explode(ownerEntity.this.name, "_")[1]
end

-- =========================================================

function StashInventoryCollector.IsShopStash(context)
    if context.wuid == nil then
        return false
    end

    local links = XGenAIModule.FindLinks(context.wuid, 'shopStash_reverse')
    return #links > 0
end

-- =========================================================

function StashInventoryCollector.IsMasterStash(context)
    if context.wuid == nil then
        return false
    end

    local masterLinks = XGenAIModule.FindLinks(context.wuid, 'masterStash')
    local slaveLinks = XGenAIModule.FindLinks(context.wuid, 'slaveStash')

    return #masterLinks > 0 or #slaveLinks > 0
end

-- =========================================================
-- #StashInventoryGenerator.GetInventoryFromData(StashInventoryCollector.GetStashInformation(q.en("Stash2")))

function StashInventoryCollector.GetStashInformation(stash)
    local stashContext = {}
    stashContext.wuid = StashInventoryCollector.GetStashWuid(stash)
    stashContext.owner = StashInventoryCollector.GetStashOwner(stashContext)
    stashContext.home = StashInventoryCollector.GetStashHome(stashContext)

    local data = {}
    -- =========== Interior
    data.isInterior = XGenAIModule.IsPointInAreaWithLabel(stash:GetPos(), "interior")

    -- =========== Clothing stash
    data.isClothingStash = StashInventoryCollector.HasClothingLink(stashContext)

    -- =========== Model
    data.model = 
    {
        value = stash.Properties.object_Model,
        matches = function(val) 
            return string.match(stash.Properties.object_Model, val) ~= nil
        end
    }

    -- =========== Prefix
    local prefix = StashInventoryCollector.GetOwnerPrefix(stashContext)
    data.prefix = 
    {
        value = prefix,
        matches = function(val)
            return string.match(string.lower(prefix), string.lower(val)) ~= nil
        end
    }
    -- =========== Context label
    -- ShootableStashe doesn't have chestContext
    local contextLabel = (stash.Properties.esChestContextLabel and string.lower(stash.Properties.esChestContextLabel) or "None")
    data.contextLabel = 
    {
        value = contextLabel,
        matches = function(val)
            return string.match(string.lower(contextLabel), string.lower(val)) ~= nil
        end
    }

    -- =========== Owners
    local owners = StashInventoryCollector.GetOwnersData(stashContext)
    data.owners = 
    {
        value = owners,
        hasOwner = function()
            return owners ~= nil
        end,
        containSocialClass = function(val)
            if owners == nil then
                return false
            end

            for key, entry in pairs(owners) do
                if string.match(entry.socialClass, val) ~= nil then
                    return true
                end
            end
            return false
        end,
        containFactionID = function(val)
            if owners == nil then   
                return false
            end

            for key, entry in pairs(owners) do
                if string.match(entry.factionID, val) ~= nil then
                    return true
                end
            end
            return false   
        end
    }

    -- =========== Shop stash
    data.isShopStash = StashInventoryCollector.IsShopStash(stashContext)

    -- =========== Master stash
    data.isMasterStash = StashInventoryCollector.IsMasterStash(stashContext)
    
    --Dump(data)
    return data
end

-- =========================================================