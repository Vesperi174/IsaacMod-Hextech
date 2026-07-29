local mod = HextechMod
local game = mod.Game

function mod:onHitmePullDamage(target, amount, flag, source, cooldown)
    if target.Type ~= EntityType.ENTITY_PLAYER then return nil end
    local player = target:ToPlayer()
    if not player then return nil end

    local count = player:GetCollectibleNum(mod.ITEMS.HITMEPULL)
    if count <= 0 then return nil end

    local bomb = player:FireBomb(player.Position, Vector.Zero, player)
    if bomb then
        bomb.Parent = player
    end

    return nil
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onHitmePullDamage)
