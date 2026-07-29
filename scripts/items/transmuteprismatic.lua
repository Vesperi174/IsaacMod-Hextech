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

function mod:onTransmutePrismaticUpdate(player)
    if not player:HasCollectible(mod.ITEMS.TRANSMUTEPRISMATIC) then return end

    local count = player:GetCollectibleNum(mod.ITEMS.TRANSMUTEPRISMATIC)
    player:RemoveCollectible(mod.ITEMS.TRANSMUTEPRISMATIC)

    for i = 1, count do
        local prismaticItem = getPassiveItem(mod.HextechPool.PRISMATIC)
        if prismaticItem then
            player:AddCollectible(prismaticItem, 0, false)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onTransmutePrismaticUpdate)
