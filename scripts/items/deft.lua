local mod = HextechMod
local game = mod.Game

local TEARS_BONUS = 1.20

function mod:onDeftCache(player, flag)
    local count = player:GetCollectibleNum(mod.ITEMS.DEFT)
    if count <= 0 then return end

    if flag & CacheFlag.CACHE_FIREDELAY ~= 0 then
        local baseTears = 30 / (player.MaxFireDelay + 1)
        local newTears = baseTears + TEARS_BONUS * count
        player.MaxFireDelay = math.max(0, 30 / newTears - 1)
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onDeftCache)
