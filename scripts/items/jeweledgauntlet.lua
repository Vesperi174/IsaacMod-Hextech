local mod = HextechMod
local game = mod.Game

local BASE_MIN = 1.50
local BASE_MAX = 2.25
local BONUS_PER_ITEM = 0.5
local TICK_INTERVAL = 30

local playerData = {}

function mod:onJeweledGauntletUpdate(player)
    if not player:HasCollectible(mod.ITEMS.JEWELEDGAUNTLET) then return end

    local idx = player.ControllerIndex
    if not playerData[idx] then
        playerData[idx] = { lastTick = -TICK_INTERVAL }
    end

    local data = playerData[idx]
    local frame = game:GetFrameCount()

    if frame - data.lastTick >= TICK_INTERVAL then
        data.lastTick = frame
        local count = player:GetCollectibleNum(mod.ITEMS.JEWELEDGAUNTLET)
        local bonus = BONUS_PER_ITEM * (count - 1)
        local minMult = BASE_MIN + bonus
        local maxMult = BASE_MAX + bonus
        data.currentMult = minMult + math.random() * (maxMult - minMult)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onJeweledGauntletUpdate)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.JEWELEDGAUNTLET) then return nil end
        local data = playerData[player.ControllerIndex]
        if not data or not data.currentMult then return nil end
        return data.currentMult
    end,
})
