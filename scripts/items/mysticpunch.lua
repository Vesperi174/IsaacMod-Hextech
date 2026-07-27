local mod = HextechMod

local PROC_CHANCE = 15

function mod:onMysticPunchDamage(target, amount, flag, source, cooldown)
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

    local count = player:GetCollectibleNum(mod.ITEMS.MYSTICPUNCH)
    if count <= 0 then return end

    local npc = target:ToNPC()
    if not npc then return end

    local charges = 0
    for i = 1, count do
        if math.random(100) <= PROC_CHANCE then
            charges = charges + 1
        end
    end

    if charges > 0 then
        local current = player:GetActiveCharge(0)
        player:SetActiveCharge(current + charges, 0)
    end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onMysticPunchDamage)
