local mod = HextechMod

local DAMAGE_MULT = 3.0

function mod:onBackToBasicsUpdate(player)
    if not player:HasCollectible(mod.ITEMS.BACKTOBASICS) then return end

    local held = player:GetTrinket(0)
    if held ~= 0 then
        player:TryRemoveTrinket(held)
    end
    local smelted = player:GetTrinket(1)
    if smelted ~= 0 then
        player:TryRemoveTrinket(smelted)
    end

    player:SetPill(0, 0)
    player:SetCard(0, 0)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onBackToBasicsUpdate)

function mod:onBackToBasicsPreUse(collectibleType, rng, player)
    if player:HasCollectible(mod.ITEMS.BACKTOBASICS) then
        return { Discharge = false, ShowAnim = false, PlaySound = false }
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.onBackToBasicsPreUse)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.BACKTOBASICS) then return nil end
        return DAMAGE_MULT
    end,
})
