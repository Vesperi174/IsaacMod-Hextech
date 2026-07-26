local mod = HextechMod
local game = mod.Game

local DAMAGE_RATIO = 0.2

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, base, current)
        local count = player:GetCollectibleNum(mod.ITEMS.BLUNTFORCE)
        if count <= 0 then return nil end
        return 1.0 + DAMAGE_RATIO * count
    end,
})
