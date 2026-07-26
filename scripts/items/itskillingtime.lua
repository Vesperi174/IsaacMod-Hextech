local mod = HextechMod
local game = mod.Game

local DURATION = 150

local playerData = {}

function mod:onKillingTimeNewRoom()
    playerData = {}
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onKillingTimeNewRoom)

function mod:onKillingTimeUse(collectibleType, rng, player, useFlags, activeSlot)
    if not player:HasCollectible(mod.ITEMS.ITSKILLINGTIME) then
        return
    end

    playerData[player.ControllerIndex] = {
        startFrame = game:GetFrameCount(),
        damage = 0,
    }
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onKillingTimeUse)

function mod:onKillingTimeDamage(target, amount, flag, source, cooldown)
    local srcEntity = source.Entity
    if not srcEntity then
        return
    end

    local player = srcEntity:ToPlayer()
    if not player then
        local sp = srcEntity.SpawnerEntity
        if sp then
            if sp.GetEntity then
                local ent = sp:GetEntity()
                if ent then
                    player = ent:ToPlayer()
                end
            end
            if not player then
                for i = 0, game:GetNumPlayers() - 1 do
                    local p = Isaac.GetPlayer(i)
                    if p and p:HasCollectible(mod.ITEMS.ITSKILLINGTIME) then
                        player = p
                        break
                    end
                end
            end
        end
    end
    if not player then
        return
    end
    if not player:HasCollectible(mod.ITEMS.ITSKILLINGTIME) then
        return
    end

    local npc = target:ToNPC()
    if not npc then
        return
    end

    local data = playerData[player.ControllerIndex]
    if not data then
        return
    end

    local frame = game:GetFrameCount()
    if frame - data.startFrame < DURATION then
        data.damage = data.damage + amount
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onKillingTimeDamage)

function mod:onKillingTimeUpdate()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player then
            local idx = player.ControllerIndex

            if player:HasCollectible(mod.ITEMS.ITSKILLINGTIME) then
                local data = playerData[idx]
                if data then
                    local frame = game:GetFrameCount()
                    if frame - data.startFrame >= DURATION then
                        local totalDmg = data.damage
                        local entities = Isaac.GetRoomEntities()
                        for _, entity in ipairs(entities) do
                            local npc = entity:ToNPC()
                            if npc and npc:IsVulnerableEnemy() then
                                npc:TakeDamage(totalDmg, 0, EntityRef(player), 0)
                            end
                        end
                        playerData[idx] = nil
                    end
                end
            else
                playerData[idx] = nil
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onKillingTimeUpdate)
