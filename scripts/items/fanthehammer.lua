local mod = HextechMod

local MISSILE_COUNT = 4
local MISSILE_DELAY = 3
local COOLDOWN_FRAMES = 6 * 30
local NUM_DIRECTIONS = 4

function mod:onFthDamage(target, amount, flag, source, cooldown)
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

    if not player:HasCollectible(mod.ITEMS.FANTHEHAMMER) then return end

    local npc = target:ToNPC()
    if not npc then return end

    local pdata = player:GetData()
    if not pdata.fthCooldowns then
        pdata.fthCooldowns = { 0, 0, 0, 0 }
    end

    local dir = player.HeadDirection
    if not dir then
        local vel = player.Velocity
        local absX = math.abs(vel.X)
        local absY = math.abs(vel.Y)
        if absX > absY then
            if vel.X > 0 then dir = 1 else dir = 3 end
        else
            if vel.Y > 0 then dir = 2 else dir = 0 end
        end
    end

    if pdata.fthCooldowns[dir + 1] and pdata.fthCooldowns[dir + 1] > 0 then
        return
    end

    pdata.fthCooldowns[dir + 1] = COOLDOWN_FRAMES

    local missileDamage = player.Damage * 0.5
    pdata.fthQueue = {
        remaining = MISSILE_COUNT,
        target = npc,
        targetPos = npc.Position,
        timer = 0,
        damage = missileDamage,
    }
end

function mod:onFthUpdate(player)
    local pdata = player:GetData()

    if pdata.fthCooldowns then
        for i = 1, NUM_DIRECTIONS do
            if pdata.fthCooldowns[i] > 0 then
                pdata.fthCooldowns[i] = pdata.fthCooldowns[i] - 1
            end
        end
    end

    local queue = pdata.fthQueue
    if not queue then return end

    if queue.remaining <= 0 then
        pdata.fthQueue = nil
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

    mod.Missile.Fire(player, npc or queue.targetPos, queue.damage)
    queue.remaining = queue.remaining - 1
    queue.timer = MISSILE_DELAY
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onFthDamage)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onFthUpdate)
