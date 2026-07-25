local mod = HextechMod
local game = mod.Game

function mod:OnNewLevel()
    local stage = game:GetLevel():GetStage()

    if stage < 1 or stage > mod.HEXTECH_CONFIG.MAX_STAGE then
        return
    end

    local room = game:GetRoom()
    local center = room:GetCenterPos()
    local count = mod.HEXTECH_CONFIG.PEDESTAL_COUNT
    local spacing = mod.HEXTECH_CONFIG.PEDESTAL_SPACING
    local startX = center.X - (count - 1) * spacing / 2
    local itemPool = game:GetItemPool()
    local poolType = mod.HEXTECH_CONFIG.ITEM_POOL

    for i = 0, count - 1 do
        local itemId = itemPool:GetCollectible(poolType)
        local pos = Vector(startX + i * spacing, center.Y + mod.HEXTECH_CONFIG.PEDESTAL_Y_OFFSET)
        local pedestal = Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COLLECTIBLE,
            itemId,
            pos,
            Vector(0, 0),
            nil
        )
        if pedestal then
            pedestal:ToPickup().OptionsPickupIndex = 1
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevel)
