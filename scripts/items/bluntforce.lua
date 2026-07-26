local mod = HextechMod
local game = mod.Game

local DAMAGE_RATIO = 0.2

local playerData = {}

function mod:onBluntForceCache(player, flag)
    local count = player:GetCollectibleNum(mod.ITEMS.BLUNTFORCE)
    if count <= 0 then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
    end

    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        playerData[idx].baseDamage = player.Damage
    end
end

function mod:onBluntForceUpdate(player)
    local count = player:GetCollectibleNum(mod.ITEMS.BLUNTFORCE)
    if count <= 0 then return end

    local idx = player.ControllerIndex
    local data = playerData[idx]
    if not data or not data.baseDamage then return end

    player.Damage = data.baseDamage + data.baseDamage * DAMAGE_RATIO * count
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onBluntForceCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onBluntForceUpdate)
