local mod = HextechMod

local MISSILE_DAMAGE = 1.0
local MISSILE_DELAY = 3

function mod:onTyphoonDamage(target, amount, flag, source, cooldown)
    local srcEntity = source.Entity
    if not srcEntity then return end

    local data = srcEntity:GetData()
    if data and data.isMissile then return end

    local player = srcEntity:ToPlayer()
    if not player then
        local spawner = srcEntity.SpawnerEntity
        if spawner then
            player = spawner:ToPlayer()
        end
    end
    if not player then return end

    if not player:HasCollectible(mod.ITEMS.TYPHOON) then return end

    local npc = target:ToNPC()
    if not npc then return end

    local count = player:GetCollectibleNum(mod.ITEMS.TYPHOON)
    local pdata = player:GetData()
    pdata.typhoonQueue = {
        remaining = count,
        target = npc,
        targetPos = npc.Position,
        timer = 0,
    }
end

function mod:onTyphoonUpdate(player)
    local pdata = player:GetData()
    local queue = pdata.typhoonQueue
    if not queue then return end

    if queue.remaining <= 0 then
        pdata.typhoonQueue = nil
        return
    end

    if queue.timer > 0 then
        queue.timer = queue.timer - 1
        return
    end

    local npc = queue.target
    if not npc or not npc:Exists() then
        npc = nil
    end

    mod.Missile.Fire(player, npc or queue.targetPos, MISSILE_DAMAGE, mod.ITEMS.TYPHOON)
    queue.remaining = queue.remaining - 1
    queue.timer = MISSILE_DELAY
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onTyphoonDamage)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onTyphoonUpdate)
