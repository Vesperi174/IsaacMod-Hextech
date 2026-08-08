local mod = HextechMod
local game = mod.Game

function mod:onDrawYourSwordUpdate(player)
    if not player:HasCollectible(mod.ITEMS.DRAWYOURSWORD) then return end

    local pdata = player:GetData()
    if pdata.drawSwordGiven then return end

    pdata.drawSwordGiven = true
    player:AddCollectible(CollectibleType.COLLECTIBLE_SPIRIT_SWORD, 0, false)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onDrawYourSwordUpdate)
