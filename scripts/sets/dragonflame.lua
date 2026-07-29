local mod = HextechMod

local DRAGON_FLAME_CHANCES = {
    [2] = 0.4,
    [3] = 0.7,
    [4] = 1.0,
}

local activatedSets = {}
local playerSetProgress = {}

local function getSetCount(setItems, player)
    if not player then return 0 end
    local count = 0
    for _, itemId in ipairs(setItems) do
        if player:GetCollectibleNum(itemId, true) > 0 then
            count = count + 1
        end
    end
    return count
end

local function checkSetProgress(player)
    local idx = player.ControllerIndex
    if not playerSetProgress[idx] then
        playerSetProgress[idx] = {}
    end

    local setData = mod.SETS.DragonFlame
    local count = getSetCount(setData.items, player)
    playerSetProgress[idx].DragonFlame = count

    if count >= 2 and not activatedSets.DragonFlame then
        activatedSets.DragonFlame = true
    end
end

function mod:GetSetProgress(setName, player)
    if setName ~= "DragonFlame" then return 0 end
    if not player then return 0 end
    local idx = player.ControllerIndex
    local sp = playerSetProgress[idx]
    if not sp then return 0 end
    return sp.DragonFlame or 0
end

function mod:GetSetChance(setName, player)
    if setName ~= "DragonFlame" then return 0 end
    local count = mod:GetSetProgress(setName, player)
    return DRAGON_FLAME_CHANCES[count] or 0
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

    local player = srcEntity.SpawnerEntity
    if not player then return end

    local chance = mod:GetSetChance("DragonFlame", player)
    if chance > 0 and math.random() < chance then
        mod:FireChainMissile(srcEntity, entity)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player then
            checkSetProgress(player)
        end
    end
end)

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onMissileTakeDamage)
