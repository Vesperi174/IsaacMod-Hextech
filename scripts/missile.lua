local mod = HextechMod

mod.Missile = {}
local Missile = mod.Missile

local ENTITY_TEAR = 2
local TEAR_SPECTRAL = TearFlags and TearFlags.TEAR_SPECTRAL or 1
local TEAR_HOMING = TearFlags and TearFlags.TEAR_HOMING or 4
local FLAG_APPLY_GRAVITY = EntityFlag and EntityFlag.FLAG_APPLY_GRAVITY or (1 << 14)
local MISSILE_SPEED_INIT = 5
local MISSILE_SPEED_MAX = 20
local MISSILE_ACCEL = 1.04
local MISSILE_HEIGHT = -20

local sideCounter = 0

function Missile.Fire(player, target, damage, sourceItem)
    local pos = player.Position
    local targetPos = target.Position or target
    local dir = (targetPos - pos):Normalized()

    local sideDir
    if sideCounter % 2 == 0 then
        sideDir = Vector(-dir.Y, dir.X)
    else
        sideDir = Vector(dir.Y, -dir.X)
    end
    sideCounter = sideCounter + 1
    local vel = sideDir * MISSILE_SPEED_INIT

    local tear = Isaac.Spawn(ENTITY_TEAR, 0, 0, pos, vel, player, 0, 0)
    if not tear then return end

    local t = tear:ToTear()
    if not t then return end

    t.TearFlags = TEAR_SPECTRAL | TEAR_HOMING
    if t.AddTearFlags then
        t:AddTearFlags(TEAR_SPECTRAL | TEAR_HOMING)
    end

    t.CollisionDamage = damage
    if target.Position then
        t.Target = target
    end

    t.Height = MISSILE_HEIGHT
    t.FallingSpeed = 0
    t.FallingAcceleration = 0
    if tear.ClearEntityFlags then
        tear:ClearEntityFlags(FLAG_APPLY_GRAVITY)
    elseif tear.EntityFlags then
        tear.EntityFlags = tear.EntityFlags & ~FLAG_APPLY_GRAVITY
    end

    tear:GetData().isMissile = true
    tear:GetData().sourceItem = sourceItem
    if target.Position then
        tear:GetData().target = target
    end
end

function mod:onMissileUpdate(tear)
    local data = tear:GetData()
    if not data.isMissile then return end

    local vel = tear.Velocity
    local speed = vel:Length()
    if speed < MISSILE_SPEED_MAX then
        local newSpeed = math.min(speed * MISSILE_ACCEL, MISSILE_SPEED_MAX)
        tear.Velocity = vel:Normalized() * newSpeed
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.onMissileUpdate)
