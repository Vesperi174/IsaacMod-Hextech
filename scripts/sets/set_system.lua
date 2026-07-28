local mod = HextechMod

mod.SETS = {
    DragonFlame = {
        name = "Dragon Flame",
        items = {
            mod.ITEMS.MAGICMISSILE,
            mod.ITEMS.FANTHEHAMMER,
            mod.ITEMS.TYPHOON,
            mod.ITEMS.DOUBLETAP,
        },
    },
}

local activatedSets = {}
local setProgress = {}

local DRAGON_FLAME_CHANCES = {
    [2] = 0.4,
    [3] = 0.7,
    [4] = 1.0,
}

local function getSetCount(setItems)
    local player = Isaac.GetPlayer(0)
    if not player then return 0 end
    local count = 0
    for _, itemId in ipairs(setItems) do
        if player:GetCollectibleNum(itemId, true) > 0 then
            count = count + 1
        end
    end
    return count
end

local function checkSetEffects(player)
    for setName, setData in pairs(mod.SETS) do
        local count = getSetCount(setData.items)
        setProgress[setName] = count

        if count >= 2 and not activatedSets[setName] then
            activatedSets[setName] = true
        end
    end
end

function mod:GetSetProgress(setName)
    return setProgress[setName] or 0
end

function mod:GetSetChance(setName)
    local count = setProgress[setName] or 0
    if setName == "DragonFlame" then
        return DRAGON_FLAME_CHANCES[count] or 0
    end
    return 0
end

function mod:FireChainMissile(tear, target)
    local player = tear.SpawnerEntity
    if not player or not target then return end

    mod.Missile.Fire(player, target, 1.0, nil)
end

function mod:onMissileTakeDamage(entity, amount, flags, source, cooldownFrames)
    if not entity:IsVulnerableEnemy() then return end
    if not source or not source.Entity then return end

    local srcEntity = source.Entity
    local data = srcEntity:GetData()
    if not data or not data.isMissile then return end

    local chance = mod:GetSetChance("DragonFlame")
    if chance > 0 and math.random() < chance then
        mod:FireChainMissile(srcEntity, entity)
    end
end

function mod:GetSetBoost(itemId)
    local player = Isaac.GetPlayer(0)
    if not player then return 1.0 end

    for _, setData in pairs(mod.SETS) do
        for _, setId in ipairs(setData.items) do
            if setId == itemId then
                local collected = 0
                for _, sId in ipairs(setData.items) do
                    if player:GetCollectibleNum(sId, true) > 0 then
                        collected = collected + 1
                    end
                end

                if collected == 1 then
                    return 1.5
                elseif collected == 2 then
                    return 1.25
                else
                    return 1.0
                end
            end
        end
    end
    return 1.0
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    local player = Isaac.GetPlayer(0)
    if player then
        checkSetEffects(player)
    end
end)

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onMissileTakeDamage)
