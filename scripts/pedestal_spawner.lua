local mod = HextechMod
local Pool = mod.HextechPool

function mod:SpawnHextechPedestals()
    local stage = mod.Game:GetLevel():GetStage()
    if stage < 1 or stage > mod.HEXTECH_CONFIG.MAX_STAGE then
        return
    end

    local tier = Pool:GetRandomTier()
    local items = Pool:GetRandomItems(tier, mod.HEXTECH_CONFIG.PEDESTAL_COUNT)
    if not items or #items == 0 then
        return
    end

    local room = mod.Game:GetRoom()
    local center = room:GetCenterPos()
    local count = #items
    local spacing = mod.HEXTECH_CONFIG.PEDESTAL_SPACING
    local startX = center.X - (count - 1) * spacing / 2

    for i = 1, count do
        local pos = Vector(startX + (i - 1) * spacing, center.Y + mod.HEXTECH_CONFIG.PEDESTAL_Y_OFFSET)
        local pedestal = Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COLLECTIBLE,
            items[i],
            pos,
            Vector(0, 0),
            nil
        )
        if pedestal then
            pedestal:ToPickup().OptionsPickupIndex = 1
        end
    end
end
