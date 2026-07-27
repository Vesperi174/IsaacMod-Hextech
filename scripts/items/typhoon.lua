local mod = HextechMod

local MISSILE_DAMAGE = 1.0

function mod:onTyphoonDamage(target, amount, flag, source, cooldown)
    local srcEntity = source.Entity
    if not srcEntity then return end

    local data = srcEntity:GetData()
    if data and data.isMissile then return end

    local player = srcEntity:ToPlayer()
    if not player then
        local spawner = srcEntity.SpawnerEntity
        if spawner then
            player = spawner:ToPlayer()
        end
    end
    if not player then return end

    if not player:HasCollectible(mod.ITEMS.TYPHOON) then return end

    local npc = target:ToNPC()
    if not npc then return end

    local count = player:GetCollectibleNum(mod.ITEMS.TYPHOON)
    for i = 1, count do
        mod.Missile.Fire(player, npc, MISSILE_DAMAGE)
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onTyphoonDamage)
