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
end

function mod:onSlowAndSteadyUpdate(player)
    if not player:HasCollectible(mod.ITEMS.SLOWANDSTEADY) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
    end
    local data = playerData[idx]

    if not data.baseDamage then
        data.baseDamage = player.Damage
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY)
        player:EvaluateItems()
        return
    end

    local currentMaxFireDelay = player.MaxFireDelay
    local normalTears = 30 / (currentMaxFireDelay + 1)
    local delta = normalTears - TARGET_TEARS
    local damageBonus = delta * CONVERSION_RATE

    player.Damage = data.baseDamage + damageBonus
    player.MaxFireDelay = math.max(0, 30 / TARGET_TEARS - 1)
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onSlowAndSteadyCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onSlowAndSteadyUpdate)
