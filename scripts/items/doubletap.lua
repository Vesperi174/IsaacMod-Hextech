local mod = HextechMod

function mod:onDoubleTapUpdate(tear)
    local data = tear:GetData()
    if not data or not data.isMissile then return end
    if data.doubleTapDone then return end
    if data.sourceItem == mod.ITEMS.DOUBLETAP then return end

    data.doubleTapDone = true

    local player = tear.SpawnerEntity
    if not player then return end
    local playerObj = player:ToPlayer()
    if not playerObj then return end
    if not playerObj:HasCollectible(mod.ITEMS.DOUBLETAP) then return end

    local target = data.target
    local damage = tear.CollisionDamage

    if target and target:Exists() then
        mod.Missile.Fire(playerObj, target, damage, mod.ITEMS.DOUBLETAP)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.onDoubleTapUpdate)
