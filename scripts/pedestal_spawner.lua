local mod = HextechMod
local Pool = mod.HextechPool

local ALLOWED_STAGES = { [1] = true, [2] = true, [4] = true, [6] = true }
local spawnedStages = {}
local currentRunSeed = nil

local pendingQueue = {}
local activeOptionsIndex = nil
local currentTier = nil
local nextOptionsIndex = 1
local processedPlayerCount = 0

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
    activeOptionsIndex = optionsIndex
end

local function hasActivePedestals()
    if not activeOptionsIndex then return false end
    local entities = Isaac.GetRoomEntities()
    for _, e in ipairs(entities) do
        if e.Type == EntityType.ENTITY_PICKUP
            and e.Variant == PickupVariant.PICKUP_COLLECTIBLE then
            local pickup = e:ToPickup()
            if pickup and pickup.OptionsPickupIndex == activeOptionsIndex then
                return true
            end
        end
    end
    return false
end

local function spawnNextInQueue()
    if #pendingQueue == 0 then
        activeOptionsIndex = nil
        return
    end
    local entry = table.remove(pendingQueue, 1)
    spawnPedestals(entry.items, entry.optionsIndex, entry.x, entry.y)
end

local function enqueuePlayer(playerIndex)
    local player = Isaac.GetPlayer(playerIndex)
    if not player then return end
    local room = Game():GetRoom()
    local center = room:GetCenterPos()
    local yBase = center.Y + mod.HEXTECH_CONFIG.PEDESTAL_Y_OFFSET
    local y = yBase + playerIndex * 40

    local items = Pool:GetRandomItems(currentTier, mod.HEXTECH_CONFIG.PEDESTAL_COUNT, player)
    table.insert(pendingQueue, {
        items = items,
        optionsIndex = nextOptionsIndex,
        x = center.X,
        y = y,
    })
    nextOptionsIndex = nextOptionsIndex + 1
    processedPlayerCount = processedPlayerCount + 1

    if not activeOptionsIndex then
        spawnNextInQueue()
    end
end

function mod:SpawnHextechPedestals()
    local seeds = mod.Game:GetSeeds()
    local startSeed = seeds:GetStartSeed()

    if startSeed ~= currentRunSeed then
        spawnedStages = {}
        pendingQueue = {}
        activeOptionsIndex = nil
        currentTier = nil
        nextOptionsIndex = 1
        processedPlayerCount = 0
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

    currentTier = Pool:GetRandomTier()
    pendingQueue = {}
    nextOptionsIndex = 1
    processedPlayerCount = 0

    local numPlayers = mod.Game:GetNumPlayers()
    for i = 0, numPlayers - 1 do
        enqueuePlayer(i)
    end
end

local frameCounter = 0

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    frameCounter = frameCounter + 1
    if frameCounter % 10 ~= 0 then return end

    if currentTier then
        local numPlayers = Game():GetNumPlayers()
        while numPlayers > processedPlayerCount do
            enqueuePlayer(processedPlayerCount)
        end
    end

    if activeOptionsIndex and not hasActivePedestals() then
        spawnNextInQueue()
    end
end)
