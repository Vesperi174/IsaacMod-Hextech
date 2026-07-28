local mod = HextechMod

local firedThisFrame = false

function mod:onDoubleTapMissileFired(tear)
    local data = tear:GetData()
    if not data or not data.isMissile then return end
    if data.sourceItem == mod.ITEMS.DOUBLETAP then return end

    if not firedThisFrame then
        firedThisFrame = true
        local player = tear.SpawnerEntity
        if not player then return end

        local target = data.target
        local damage = tear.CollisionDamage

        if target and target:Exists() then
            mod.Missile.Fire(player, target, damage, mod.ITEMS.DOUBLETAP)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, function()
    firedThisFrame = false
end)

mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.onDoubleTapMissileFired)
