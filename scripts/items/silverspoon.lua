local mod = HextechMod
local game = mod.Game

local RATIO = 0.15

local SILVER_ITEMS = {
    mod.ITEMS.BLUNTFORCE,
    mod.ITEMS.DEFT,
    mod.ITEMS.DEMATERIALIZE,
    mod.ITEMS.STATS,
    mod.ITEMS.TRANSMUTEGOLD,
    mod.ITEMS.SILVERSPOON,
}

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, base, current)
        local spoonCount = player:GetCollectibleNum(mod.ITEMS.SILVERSPOON)
        if spoonCount <= 0 then
            return nil
        end

        local silverCount = 0
        for _, itemId in ipairs(SILVER_ITEMS) do
            local n = player:GetCollectibleNum(itemId)
            if n > 0 then
                silverCount = silverCount + n
            end
        end

        return 1.0 + RATIO * spoonCount * silverCount
    end,
})
