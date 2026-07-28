local mod = HextechMod
local game = mod.Game

local DAMAGE_MULTIPLIER = 0.8
local HEART_CONTAINERS = 4
local HEAL_AMOUNT = 4

local playerData = {}

function mod:onCelestialBodyUpdate(player)
    if not player:HasCollectible(mod.ITEMS.CELESTIALBODY) then return end

    local idx = player.ControllerIndex
    local count = player:GetCollectibleNum(mod.ITEMS.CELESTIALBODY)

    if not playerData[idx] then
        playerData[idx] = { lastCount = 0 }
    end

    if count > playerData[idx].lastCount then
        local diff = count - playerData[idx].lastCount
        player:AddMaxHearts(HEART_CONTAINERS * diff * 2, false)
        player:AddHearts(HEAL_AMOUNT * diff * 2)
        playerData[idx].lastCount = count
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onCelestialBodyUpdate)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.CELESTIALBODY) then return nil end
        local count = player:GetCollectibleNum(mod.ITEMS.CELESTIALBODY)
        return DAMAGE_MULTIPLIER ^ count
    end,
})
