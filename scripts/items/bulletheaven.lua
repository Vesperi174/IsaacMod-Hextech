local mod = HextechMod

local MISSILES_PER_ENEMY = 10

function mod:onBulletHeavenUse(_, _, player)
    if not player or not player:HasCollectible(mod.ITEMS.BULLETHEAVEN) then return end

    local enemies = {}
    local roomEntities = Isaac.GetRoomEntities()
    for _, entity in ipairs(roomEntities) do
        if entity:IsVulnerableEnemy() then
            table.insert(enemies, entity)
        end
    end

    if #enemies == 0 then return end

    for _, enemy in ipairs(enemies) do
        for j = 1, MISSILES_PER_ENEMY do
            mod.Missile.Fire(player, enemy, player.Damage, mod.ITEMS.BULLETHEAVEN)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.onBulletHeavenUse, mod.ITEMS.BULLETHEAVEN)
