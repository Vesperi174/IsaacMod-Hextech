local mod = HextechMod

local INVINCIBLE_DURATION = 150

local invincibleTimer = 0

function mod:onCantTouchThisUse()
    local player = Isaac.GetPlayer(0)
    if not player or not player:HasCollectible(mod.ITEMS.CANTTOUCHTHIS) then return end

    invincibleTimer = INVINCIBLE_DURATION
end

function mod:onCantTouchThisUpdate()
    if invincibleTimer <= 0 then return end
    invincibleTimer = invincibleTimer - 1
end

function mod:onCantTouchThisRender()
    if invincibleTimer <= 0 then return end

    local seconds = math.ceil(invincibleTimer / 30)

    local sw = Isaac.GetScreenWidth() or 480
    local sh = Isaac.GetScreenHeight() or 270

    Isaac.RenderText(tostring(seconds), sw / 2 - 4, sh / 2 - 40, 255, 255, 255, 255)
end

function mod:onCantTouchThisDamage(target, amount, flag, source, cooldown)
    if invincibleTimer <= 0 then return nil end

    if target.Type == EntityType.ENTITY_PLAYER then
        return false
    end

    return nil
end

function mod:onCantTouchThisNewRoom()
    invincibleTimer = 0
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onCantTouchThisUse)
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.onCantTouchThisUpdate)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onCantTouchThisDamage)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onCantTouchThisNewRoom)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.onCantTouchThisRender)
