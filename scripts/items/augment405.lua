local mod = HextechMod

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.AUGMENT405) then return nil end
        return 10.0
    end,
})
