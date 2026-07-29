local mod = HextechMod

local INVINCIBLE_DURATION = 300
local INTERNAL_CD = 600

function mod:onCantTouchThisUse(_, _, player)
    if not player or not player:HasCollectible(mod.ITEMS.CANTTOUCHTHIS) then return end
    local pdata = player:GetData()
    if pdata.cantTouchCd and pdata.cantTouchCd > 0 then return end

    pdata.cantTouchTimer = INVINCIBLE_DURATION
    pdata.cantTouchCd = INTERNAL_CD
end

function mod:onCantTouchThisUpdate(player)
    local pdata = player:GetData()
    if pdata.cantTouchTimer and pdata.cantTouchTimer > 0 then
        pdata.cantTouchTimer = pdata.cantTouchTimer - 1
    end
    if pdata.cantTouchCd and pdata.cantTouchCd > 0 then
        pdata.cantTouchCd = pdata.cantTouchCd - 1
    end
end

function mod:onCantTouchThisRender(player)
    local pdata = player:GetData()
    local timer = pdata.cantTouchTimer
    if not timer or timer <= 0 then return end

    local seconds = math.ceil(timer / 30)
    local sw = Isaac.GetScreenWidth() or 480
    local sh = Isaac.GetScreenHeight() or 270

    Isaac.RenderText(tostring(seconds), sw / 2 - 4, sh / 2 - 40, 255, 255, 255, 255)
end

function mod:onCantTouchThisDamage(target, amount, flag, source, cooldown)
    if target.Type ~= EntityType.ENTITY_PLAYER then return nil end
    local player = target:ToPlayer()
    if not player then return nil end
    local pdata = player:GetData()
    if pdata.cantTouchTimer and pdata.cantTouchTimer > 0 then
        return false
    end
    return nil
end

function mod:onCantTouchThisNewRoom()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player then
            local pdata = player:GetData()
            pdata.cantTouchTimer = 0
            pdata.cantTouchCd = 0
        end
    end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onCantTouchThisUse)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onCantTouchThisUpdate)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onCantTouchThisDamage)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onCantTouchThisNewRoom)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.onCantTouchThisRender)
