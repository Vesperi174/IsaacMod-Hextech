local mod = HextechMod
local game = mod.Game

local STACK_SPEED = 0.02
local RESET_FRAMES = 150
local FIRERATE_RATIO = 0.3

local playerData = {}

local function GetSourcePlayer(source)
    if not source.Entity then return nil end
    if source.Entity.Type == EntityType.ENTITY_PLAYER then
        return source.Entity:ToPlayer()
    end
    if source.Entity.SpawnerEntity
        and source.Entity.SpawnerEntity.Type == EntityType.ENTITY_PLAYER then
        return source.Entity.SpawnerEntity:ToPlayer()
    end
    return nil
end

function mod:onTapdancerHit(target, amount, flag, source, countdown)
    local player = GetSourcePlayer(source)
    if not player then return end
    if not player:HasCollectible(mod.ITEMS.TAPDANCER) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = { stacks = 0, lastHit = 0 }
    end

    playerData[idx].stacks = playerData[idx].stacks + 1
    playerData[idx].lastHit = game:GetFrameCount()

    player:AddCacheFlags(CacheFlag.CACHE_SPEED | CacheFlag.CACHE_FIREDELAY)
    player:EvaluateItems()
end

function mod:onTapdancerUpdate(player)
    local count = player:GetCollectibleNum(mod.ITEMS.TAPDANCER)
    if count <= 0 then return end

    local idx = player.ControllerIndex
    local data = playerData[idx]
    if not data then
        playerData[idx] = { stacks = 0, lastHit = 0 }
        data = playerData[idx]
    end

    if data.stacks > 0 then
        local elapsed = game:GetFrameCount() - data.lastHit
        if elapsed >= RESET_FRAMES then
            data.stacks = 0
            player:AddCacheFlags(CacheFlag.CACHE_SPEED)
            player:EvaluateItems()
        end
    end

    if data.stacks > 0 then
        local base = data.baseSpeed or player.MoveSpeed
        player.MoveSpeed = base + data.stacks * STACK_SPEED * count
    end

    local speed = player.MoveSpeed
    local baseFireDelay = data.baseFireDelay or player.MaxFireDelay
    local baseTears = 30 / (baseFireDelay + 1)
    local effectiveTears = baseTears + FIRERATE_RATIO * speed * count
    player.MaxFireDelay = math.max(0, 30 / effectiveTears - 1)
end

function mod:onTapdancerCache(player, flag)
    if not player:HasCollectible(mod.ITEMS.TAPDANCER) then return end

    local idx = player.ControllerIndex
    local data = playerData[idx]
    if not data then
        playerData[idx] = { stacks = 0, lastHit = 0 }
        data = playerData[idx]
    end

    if flag & CacheFlag.CACHE_SPEED ~= 0 then
        data.baseSpeed = player.MoveSpeed
    end

    if flag & CacheFlag.CACHE_FIREDELAY ~= 0 then
        data.baseFireDelay = player.MaxFireDelay
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onTapdancerHit)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onTapdancerUpdate)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onTapdancerCache)
