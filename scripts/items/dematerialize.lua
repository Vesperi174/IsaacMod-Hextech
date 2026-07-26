local mod = HextechMod
local game = mod.Game

local DAMAGE_PER_KILL = 0.01
local playerBonuses = {}

function mod:onDematerializeKill(entity)
    if not entity:IsEnemy() then
        return
    end

    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player and player:HasCollectible(mod.ITEMS.DEMATERIALIZE) then
            local count = player:GetCollectibleNum(mod.ITEMS.DEMATERIALIZE)
            local idx = player.ControllerIndex
            if not playerBonuses[idx] then
                playerBonuses[idx] = 0
            end
            playerBonuses[idx] = playerBonuses[idx] + DAMAGE_PER_KILL * count
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.onDematerializeKill)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.FLAT,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.DEMATERIALIZE) then
            playerBonuses[player.ControllerIndex] = nil
            return nil
        end
        return playerBonuses[player.ControllerIndex] or 0
    end,
})
