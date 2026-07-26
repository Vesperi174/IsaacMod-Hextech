local mod = HextechMod
local game = mod.Game

function mod:onTransmuteGoldUpdate(player)
    if not player:HasCollectible(mod.ITEMS.TRANSMUTEGOLD) then return end

    local count = player:GetCollectibleNum(mod.ITEMS.TRANSMUTEGOLD)
    player:RemoveCollectible(mod.ITEMS.TRANSMUTEGOLD)

    for i = 1, count do
        local goldItem = mod.HextechPool:GetRandomItem(mod.HextechPool.GOLD)
        if goldItem then
            player:AddCollectible(goldItem, 0, false)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onTransmuteGoldUpdate)
