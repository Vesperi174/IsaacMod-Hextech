local mod = HextechMod

local SPEED_DURATION = 300
local SPEED_MULTIPLIER = 2.0

function mod:onDodgeProvocationDamage(target, amount, flag, source, cooldown)
    if target.Type ~= EntityType.ENTITY_PLAYER then return nil end
    local player = target:ToPlayer()
    if not player or not player:HasCollectible(mod.ITEMS.DODGEPROVOCATION) then return nil end

    local pdata = player:GetData()
    pdata.dodgeSpeedTimer = SPEED_DURATION
    player:AddCacheFlags(CacheFlag.CACHE_SPEED)
    player:EvaluateItems()

    return nil
end

function mod:onDodgeProvocationUpdate(player)
    if not player:HasCollectible(mod.ITEMS.DODGEPROVOCATION) then return end
    local pdata = player:GetData()
    if pdata.dodgeSpeedTimer and pdata.dodgeSpeedTimer > 0 then
        pdata.dodgeSpeedTimer = pdata.dodgeSpeedTimer - 1
        if pdata.dodgeSpeedTimer == 0 then
            player:AddCacheFlags(CacheFlag.CACHE_SPEED)
            player:EvaluateItems()
        end
    end
end

function mod:onDodgeProvocationCache(player, flag)
    if not player:HasCollectible(mod.ITEMS.DODGEPROVOCATION) then return end
    if flag & CacheFlag.CACHE_SPEED == 0 then return end

    local pdata = player:GetData()
    if pdata.dodgeSpeedTimer and pdata.dodgeSpeedTimer > 0 then
        player.MoveSpeed = player.MoveSpeed * SPEED_MULTIPLIER
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onDodgeProvocationDamage)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onDodgeProvocationUpdate)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onDodgeProvocationCache)
