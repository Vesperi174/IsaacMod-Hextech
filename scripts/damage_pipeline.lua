local mod = HextechMod

mod.DamagePipeline = {}
local DP = mod.DamagePipeline

DP.FLAT = "flat"
DP.MULTIPLY = "multiply"

local flatModifiers = {}
local multiplyModifiers = {}
local rawBaseDamage = {}

function DP:Register(modifier)
    if modifier.type == DP.FLAT then
        flatModifiers[#flatModifiers + 1] = modifier
    elseif modifier.type == DP.MULTIPLY then
        multiplyModifiers[#multiplyModifiers + 1] = modifier
    end
end

function mod:onDamagePipelineCache(player, flag)
    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        rawBaseDamage[player.ControllerIndex] = player.Damage
    end
end

function mod:onDamagePipelineUpdate(player)
    local raw = rawBaseDamage[player.ControllerIndex]
    if not raw then return end

    local damage = raw

    for _, m in ipairs(flatModifiers) do
        local value = m.callback(player, raw, damage)
        if value then
            damage = damage + value
        end
    end

    for _, m in ipairs(multiplyModifiers) do
        local value = m.callback(player, raw, damage)
        if value then
            damage = damage * value
        end
    end

    player.Damage = damage
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onDamagePipelineCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onDamagePipelineUpdate)
