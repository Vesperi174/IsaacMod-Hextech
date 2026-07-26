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

    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        playerData[idx].baseDamage = player.Damage
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

    if not data.baseDamage or not data.baseMaxFireDelay then
        data.baseDamage = player.Damage
        data.baseMaxFireDelay = player.MaxFireDelay
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
        player:EvaluateItems()
        return
    end

    local lockedFireDelay = 30 / TARGET_TEARS - 1
    local currentMaxFireDelay = player.MaxFireDelay

    if math.abs(currentMaxFireDelay - lockedFireDelay) > 0.5 then
        data.baseMaxFireDelay = currentMaxFireDelay
    end

    local normalTears = 30 / (data.baseMaxFireDelay + 1)
    local delta = normalTears - TARGET_TEARS
    local damageBonus = delta * CONVERSION_RATE

    player.Damage = data.baseDamage + damageBonus
    player.MaxFireDelay = lockedFireDelay
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onSlowAndSteadyCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onSlowAndSteadyUpdate)
