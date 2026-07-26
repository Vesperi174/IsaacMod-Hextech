local mod = HextechMod
local game = mod.Game

local DAMAGE_MULTIPLIER = 0.8
local HEART_CONTAINERS = 4
local HEAL_AMOUNT = 4

local playerData = {}

function mod:onCelestialBodyCache(player, flag)
    if not player:HasCollectible(mod.ITEMS.CELESTIALBODY) then return end

    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        player.Damage = player.Damage * DAMAGE_MULTIPLIER
    end
end

function mod:onCelestialBodyUpdate(player)
    if not player:HasCollectible(mod.ITEMS.CELESTIALBODY) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = { applied = false }
    end

    if not playerData[idx].applied then
        player:AddMaxHearts(HEART_CONTAINERS * 2, false)
        player:AddHearts(HEAL_AMOUNT * 2)
        playerData[idx].applied = true
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onCelestialBodyCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onCelestialBodyUpdate)
