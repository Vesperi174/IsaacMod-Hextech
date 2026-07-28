local mod = HextechMod
local game = mod.Game
local CurseEnergy = mod.CurseEnergy

CurseEnergy.RegisterItem(mod.ITEMS.PLAGUEBEARER)

local HARVEST_DELAY = 150

local harvestedRooms = {}
local roomEntryFrame = 0
local lastRoomKey = ""

local function getRoomKey()
    local level = game:GetLevel()
    local roomDesc = level:GetCurrentRoomDesc()
    return level:GetStage() .. "_" .. roomDesc.GridIndex
end

function mod:onPlaguebearerNewRoom()
    local player = Isaac.GetPlayer(0)
    if not player or not player:HasCollectible(mod.ITEMS.PLAGUEBEARER) then return end

    local roomKey = getRoomKey()
    lastRoomKey = roomKey
    if not harvestedRooms[roomKey] then
        roomEntryFrame = game:GetFrameCount()
    end
end

function mod:onPlaguebearerUpdate()
    local player = Isaac.GetPlayer(0)
    if not player or not player:HasCollectible(mod.ITEMS.PLAGUEBEARER) then return end

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
            CurseEnergy.AddStacks(player, count)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onPlaguebearerNewRoom)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onPlaguebearerUpdate)
