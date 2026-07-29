local mod = HextechMod
local game = mod.Game

local DAMAGE_MULTIPLIER = 0.8
local HEART_CONTAINERS = 4
local HEAL_AMOUNT = 4

function mod:onCelestialBodyUpdate(player)
    if not player:HasCollectible(mod.ITEMS.CELESTIALBODY) then return end

    local pdata = player:GetData()
    local count = player:GetCollectibleNum(mod.ITEMS.CELESTIALBODY)

    if not pdata.celestialLastCount then
        pdata.celestialLastCount = 0
    end

    if count > pdata.celestialLastCount then
        local diff = count - pdata.celestialLastCount
        player:AddMaxHearts(HEART_CONTAINERS * diff * 2, false)
        player:AddHearts(HEAL_AMOUNT * diff * 2)
        pdata.celestialLastCount = count
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
