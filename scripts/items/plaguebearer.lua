local mod = HextechMod
local game = mod.Game
local CurseEnergy = mod.CurseEnergy

CurseEnergy.RegisterItem(mod.ITEMS.PLAGUEBEARER)

local HARVEST_DELAY = 150
local HEART_THRESHOLD = 50

local HEART_TYPES = {
    { variant = 10, sub = 0 }, -- Red Heart (full)
    { variant = 10, sub = 1 }, -- Red Heart (half)
    { variant = 10, sub = 2 }, -- Soul Heart
    { variant = 10, sub = 3 }, -- Black Heart
    { variant = 10, sub = 4 }, -- Eternal Heart
    { variant = 10, sub = 5 }, -- Gold Heart
    { variant = 10, sub = 6 }, -- Bone Heart
    { variant = 10, sub = 7 }, -- Rotten Heart
}

local harvestedRooms = {}
local roomEntryFrame = 0
local lastRoomKey = ""
local lastThreshold = {}

local function getRoomKey()
    local level = game:GetLevel()
    local roomDesc = level:GetCurrentRoomDesc()
    return level:GetStage() .. "_" .. roomDesc.GridIndex
end

function mod:onPlaguebearerNewRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player and player:HasCollectible(mod.ITEMS.PLAGUEBEARER) then
            local roomKey = getRoomKey()
            lastRoomKey = roomKey
            if not harvestedRooms[roomKey] then
                roomEntryFrame = game:GetFrameCount()
            end
            return
        end
    end
end

function mod:onPlaguebearerUpdate()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if not player or not player:HasCollectible(mod.ITEMS.PLAGUEBEARER) then goto continue end

        local idx = player.ControllerIndex
        local stacks = CurseEnergy.GetStacks()
        local currentThreshold = math.floor(stacks / HEART_THRESHOLD)
        local prevThreshold = lastThreshold[idx] or 0

        if currentThreshold > prevThreshold then
            for t = prevThreshold + 1, currentThreshold do
                for j = 1, t do
                    local ht = HEART_TYPES[math.random(#HEART_TYPES)]
                    local offset = Vector(math.random(-40, 40), math.random(-40, 40))
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, ht.variant, ht.sub, player.Position + offset, Vector.Zero,
                        player)
                end
            end
            lastThreshold[idx] = currentThreshold
        end

        ::continue::
    end

    local roomKey = getRoomKey()
    if roomKey ~= lastRoomKey then
        lastRoomKey = roomKey
        if not harvestedRooms[roomKey] then
            roomEntryFrame = game:GetFrameCount()
        end
    end

    if harvestedRooms[roomKey] then return end
    if roomEntryFrame == 0 then return end

    if game:GetFrameCount() - roomEntryFrame >= HARVEST_DELAY then
        harvestedRooms[roomKey] = true

        local count = 0
        local entities = Isaac.GetRoomEntities()
        for _, ent in ipairs(entities) do
            if ent:IsVulnerableEnemy() then
                count = count + 1
            end
        end

        if count > 0 then
            CurseEnergy.AddStacks(count)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onPlaguebearerNewRoom)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onPlaguebearerUpdate)
