local mod = HextechMod

local CONFUSION_DURATION = 60
local FLAG_CONFUSION = EntityFlag and EntityFlag.FLAG_CONFUSION or (1 << 5)

local confusionTimer = 0

function mod:onNightHuntKill(entity)
    local player = Isaac.GetPlayer(0)
    if not player or not player:HasCollectible(mod.ITEMS.NIGHTHUNT) then return end

    confusionTimer = CONFUSION_DURATION

    local entities = Isaac.GetRoomEntities()
    for _, ent in ipairs(entities) do
        if ent:IsEnemy() and not ent:IsDead() then
            if ent.AddEntityFlags then
                ent:AddEntityFlags(FLAG_CONFUSION)
            elseif ent.EntityFlags then
                ent.EntityFlags = ent.EntityFlags | FLAG_CONFUSION
            end
        end
    end
end

function mod:onNightHuntUpdate(player)
    if confusionTimer <= 0 then return end

    confusionTimer = confusionTimer - 1
    if confusionTimer > 0 then return end

    local entities = Isaac.GetRoomEntities()
    for _, ent in ipairs(entities) do
        if ent:IsEnemy() then
            if ent.ClearEntityFlags then
                ent:ClearEntityFlags(FLAG_CONFUSION)
            elseif ent.EntityFlags then
                ent.EntityFlags = ent.EntityFlags & ~FLAG_CONFUSION
            end
        end
    end
end

function mod:onNightHuntNewRoom()
    confusionTimer = 0
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.onNightHuntKill)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onNightHuntUpdate)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onNightHuntNewRoom)
