local mod = HextechMod
local Pool = mod.HextechPool

local ALLOWED_STAGES = { [1] = true, [2] = true, [4] = true, [6] = true }
local spawnedStages = {}
local currentRunSeed = nil

local function spawnPedestals(items, optionsIndex, x, y)
    if not items or #items == 0 then return end
    local count = #items
    local spacing = mod.HEXTECH_CONFIG.PEDESTAL_SPACING
    local startX = x - (count - 1) * spacing / 2

    for i = 1, count do
        local pos = Vector(startX + (i - 1) * spacing, y)
        local pedestal = Isaac.Spawn(
            EntityType.ENTITY_PICKUP,
            PickupVariant.PICKUP_COLLECTIBLE,
            items[i],
            pos,
            Vector(0, 0),
            nil
        )
        if pedestal then
            pedestal:ToPickup().OptionsPickupIndex = optionsIndex
        end
    end
end

function mod:SpawnHextechPedestals()
    local seeds = mod.Game:GetSeeds()
    local startSeed = seeds:GetStartSeed()

    if startSeed ~= currentRunSeed then
        spawnedStages = {}
        currentRunSeed = startSeed
    end

    local stage = mod.Game:GetLevel():GetAbsoluteStage()
    if not ALLOWED_STAGES[stage] then
        return
    end
    if spawnedStages[stage] then
        return
    end
    spawnedStages[stage] = true

    local tier = Pool:GetRandomTier()
    local room = mod.Game:GetRoom()
    local center = room:GetCenterPos()
    local yBase = center.Y + mod.HEXTECH_CONFIG.PEDESTAL_Y_OFFSET
    local playerYOffset = 40

    local numPlayers = mod.Game:GetNumPlayers()
    for i = 0, numPlayers - 1 do
        local player = Isaac.GetPlayer(i)
        if not player then goto continue end

        local items = Pool:GetRandomItems(tier, mod.HEXTECH_CONFIG.PEDESTAL_COUNT, player)
        local y = yBase + i * playerYOffset
        spawnPedestals(items, i + 1, center.X, y)

        ::continue::
    end
end
