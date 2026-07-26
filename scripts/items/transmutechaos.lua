local mod = HextechMod
local game = mod.Game

local ALL_TIERS = { mod.HextechPool.SILVER, mod.HextechPool.GOLD, mod.HextechPool.PRISMATIC }

function mod:onTransmuteChaosUpdate(player)
    if not player:HasCollectible(mod.ITEMS.TRANSMUTECHAOS) then return end

    local count = player:GetCollectibleNum(mod.ITEMS.TRANSMUTECHAOS)
    player:RemoveCollectible(mod.ITEMS.TRANSMUTECHAOS)

    for i = 1, count do
        for j = 1, 2 do
            local tier = ALL_TIERS[math.random(1, #ALL_TIERS)]
            local item = mod.HextechPool:GetRandomItem(tier)
            if item then
                player:AddCollectible(item, 0, false)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onTransmuteChaosUpdate)
