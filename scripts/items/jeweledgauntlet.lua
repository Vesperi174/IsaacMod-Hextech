local mod = HextechMod
local game = mod.Game

local BASE_MIN = 1.25
local BASE_MAX = 2.0
local BONUS_PER_ITEM = 0.5

function mod:onJeweledGauntletFire(tear)
    local player = tear.SpawnerEntity
    if not player or player.Type ~= EntityType.ENTITY_PLAYER then return end
    player = player:ToPlayer()

    local count = player:GetCollectibleNum(mod.ITEMS.JEWELEDGAUNTLET)
    if count <= 0 then return end

    local bonus = BONUS_PER_ITEM * (count - 1)
    local minMult = BASE_MIN + bonus
    local maxMult = BASE_MAX + bonus
    local mult = minMult + math.random() * (maxMult - minMult)

    tear.CollisionDamage = tear.CollisionDamage * mult
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.onJeweledGauntletFire)
