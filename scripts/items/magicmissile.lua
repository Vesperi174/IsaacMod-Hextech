local mod = HextechMod

local BASE_MISSILES = 3
local MISSILE_DAMAGE = 1.0
local MISSILE_DELAY = 2

function mod:onMagicMissileUse(_, _, player)
    if not player:HasCollectible(mod.ITEMS.MAGICMISSILE) then return end

    local count = player:GetCollectibleNum(mod.ITEMS.MAGICMISSILE)
    local missilesPerEnemy = BASE_MISSILES * count

    local enemies = {}
    local entities = Isaac.GetRoomEntities()
    for _, ent in ipairs(entities) do
        if ent:IsVulnerableEnemy() then
            table.insert(enemies, ent)
        end
    end

    if #enemies == 0 then return end

    local total = #enemies * missilesPerEnemy
    local pdata = player:GetData()
    pdata.magicMissileQueue = {
        remaining = total,
        enemies = enemies,
        perEnemy = missilesPerEnemy,
        timer = 0,
    }
end

function mod:onMagicMissileUpdate(player)
    if not player:HasCollectible(mod.ITEMS.MAGICMISSILE) then return end

    local pdata = player:GetData()
    local queue = pdata.magicMissileQueue
    if not queue then return end

    if queue.remaining <= 0 then
        pdata.magicMissileQueue = nil
        return
    end

    if queue.timer > 0 then
        queue.timer = queue.timer - 1
        return
    end

    local enemyIndex = #queue.enemies - math.floor(queue.remaining / queue.perEnemy)
    local enemy = queue.enemies[enemyIndex]
    if enemy and enemy:Exists() then
        mod.Missile.Fire(player, enemy, MISSILE_DAMAGE, mod.ITEMS.MAGICMISSILE)
    end

    queue.remaining = queue.remaining - 1
    queue.timer = MISSILE_DELAY
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onMagicMissileUse)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onMagicMissileUpdate)
