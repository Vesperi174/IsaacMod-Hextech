local mod = HextechMod
local game = mod.Game

local DAMAGE_COOLDOWN = 150
local SPEED_MULTIPLIER = 2.0

local playerData = {}

function mod:onHomeguardDamage(target, amount, flag, source, cooldown)
    if target.Type ~= EntityType.ENTITY_PLAYER then return nil end
    local player = target:ToPlayer()
    if not player or not player:HasCollectible(mod.ITEMS.HOMEGUARD) then return nil end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = {}
    end
    playerData[idx].damageTimer = 0
    playerData[idx].speedBoosted = false

    player:AddCacheFlags(CacheFlag.CACHE_SPEED)
    player:EvaluateItems()

    return nil
end

function mod:onHomeguardUpdate()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player and player:HasCollectible(mod.ITEMS.HOMEGUARD) then
            local idx = player.ControllerIndex
            if not playerData[idx] then
                playerData[idx] = { damageTimer = 0, speedBoosted = false }
            end
            local data = playerData[idx]

            data.damageTimer = data.damageTimer + 1

            if data.damageTimer >= DAMAGE_COOLDOWN and not data.speedBoosted then
                data.speedBoosted = true
                player:AddCacheFlags(CacheFlag.CACHE_SPEED)
                player:EvaluateItems()
            end
        end
    end
end

function mod:onHomeguardCache(player, flag)
    if not player:HasCollectible(mod.ITEMS.HOMEGUARD) then return end

    local idx = player.ControllerIndex
    local data = playerData[idx]
    if not data or not data.speedBoosted then return end

    if flag & CacheFlag.CACHE_SPEED ~= 0 then
        player.MoveSpeed = player.MoveSpeed * SPEED_MULTIPLIER
    end
end

function mod:onHomeguardNewRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player then
            local idx = player.ControllerIndex
            playerData[idx] = { damageTimer = 0, speedBoosted = false }
        end
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onHomeguardDamage)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onHomeguardUpdate)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onHomeguardCache)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onHomeguardNewRoom)
