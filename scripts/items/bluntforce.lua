local mod = HextechMod
local game = mod.Game

local DAMAGE_RATIO = 0.2

local playerData = {}

function mod:onBluntForceCache(player, flag)
    if not player:HasCollectible(mod.ITEMS.BLUNTFORCE) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
    end

    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        playerData[idx].baseDamage = player.Damage
    end
end

function mod:onBluntForceUpdate(player)
    if not player:HasCollectible(mod.ITEMS.BLUNTFORCE) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
        return
    end

    local baseDamage = playerData[idx].baseDamage
    if baseDamage then
        player.Damage = baseDamage + baseDamage * DAMAGE_RATIO
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onBluntForceCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onBluntForceUpdate)
