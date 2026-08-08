local mod = HextechMod
local game = mod.Game

local function getPassiveItem(tier)
    for _ = 1, 10 do
        local item = mod.HextechPool:GetRandomItem(tier)
        if item and Isaac.GetItemConfig():GetCollectible(item).Type ~= 0 then
            return item
        end
    end
    return nil
end

function mod:onTransmuteGoldUpdate(player)
    if not player:HasCollectible(mod.ITEMS.TRANSMUTEGOLD) then return end

    local count = player:GetCollectibleNum(mod.ITEMS.TRANSMUTEGOLD)
    player:RemoveCollectible(mod.ITEMS.TRANSMUTEGOLD)
    player:GetData().diceTransmuteGold = true

    for i = 1, count do
        local goldItem = getPassiveItem(mod.HextechPool.GOLD)
        if goldItem then
            player:AddCollectible(goldItem, 0, false)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onTransmuteGoldUpdate)
