local mod = HextechMod
local game = mod.Game

local TARGET_TEARS = 0.67
local CONVERSION_RATE = 2.0

local playerData = {}

function mod:onSlowAndSteadyCache(player, flag)
    if not player:HasCollectible(mod.ITEMS.SLOWANDSTEADY) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
    end

    if flag & CacheFlag.CACHE_FIREDELAY ~= 0 then
        playerData[idx].baseMaxFireDelay = player.MaxFireDelay
    end
end

function mod:onSlowAndSteadyUpdate(player)
    if not player:HasCollectible(mod.ITEMS.SLOWANDSTEADY) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
    end
    local data = playerData[idx]

    if not data.baseMaxFireDelay then
        data.baseMaxFireDelay = player.MaxFireDelay
        player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
        player:EvaluateItems()
        return
    end

    local lockedFireDelay = 30 / TARGET_TEARS - 1
    local currentMaxFireDelay = player.MaxFireDelay

    if math.abs(currentMaxFireDelay - lockedFireDelay) > 0.5 then
        data.baseMaxFireDelay = currentMaxFireDelay
    end

    player.MaxFireDelay = lockedFireDelay
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onSlowAndSteadyCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onSlowAndSteadyUpdate)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.FLAT,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.SLOWANDSTEADY) then return nil end
        local idx = player.ControllerIndex
        local data = playerData[idx]
        if not data or not data.baseMaxFireDelay then return nil end

        local normalTears = 30 / (data.baseMaxFireDelay + 1)
        local delta = normalTears - TARGET_TEARS
        if delta <= 0 then return nil end

        return delta * CONVERSION_RATE
    end,
})
