--[[
    pedestal_spawner.lua - 三选一底座生成与清理
    核心逻辑：生成3个底座道具，检测拾取，清理剩余
]]

local mod = HextechMod
local game = mod.Game

-- ============================================================
-- 底座生成器对象
-- ============================================================

mod.PedestalSpawner = {}

-- 当前活跃的底座实体列表
mod.PedestalSpawner.activePedestals = {}

-- 生成三选一底座
function mod.PedestalSpawner:Spawn()
    mod:Log("Spawning 3 pedestals...")

    -- 1. 获取房间和位置
    local room = game:GetRoom()
    if not room then
        mod:LogWarning("No room found, aborting spawn")
        return false
    end

    local positions = mod:CalculatePedestalPositions(room)

    -- 2. 从道具池抽取3个道具
    local items = mod.HextechPool:GetRandomItems(mod.POOL_CONFIG.PEDESTAL_COUNT)

    if mod:IsTableEmpty(items) then
        mod:LogWarning("No items drawn, aborting spawn")
        return false
    end

    -- 3. 生成底座
    self.activePedestals = {}
    for i, itemId in ipairs(items) do
        if itemId and positions[i] then
            local pedestal = Isaac.Spawn(
                EntityType.ENTITY_PICKUP,
                PickupVariant.PICKUP_COLLECTIBLE,
                itemId,
                positions[i],
                Vector(0, 0),
                nil
            )

            if pedestal then
                table.insert(self.activePedestals, pedestal)
                mod:Log("Pedestal " .. i .. " spawned at (" ..
                    tostring(positions[i].X) .. ", " .. tostring(positions[i].Y) .. ")")
            else
                mod:LogWarning("Failed to spawn pedestal " .. i)
            end
        end
    end

    -- 4. 标记活跃状态
    mod.HEXTECH_DATA.PERSISTENT.activePickup = true

    mod:Log("Spawned " .. #self.activePedestals .. " pedestals")
    return true
end

-- 检查是否已有底座被拾取
function mod.PedestalSpawner:HasAnyBeenPickedUp()
    for _, pedestal in ipairs(self.activePedestals) do
        if pedestal and pedestal:Exists() then
            -- 底座被拾取时 Wait 属性会变为正数
            if pedestal.Wait > mod.PICKUP_CONFIG.PICKED_UP_WAIT_THRESHOLD then
                return true
            end
        else
            -- 实体已不存在（被拾取并移除）
            return true
        end
    end
    return false
end

-- 清理未拾取的底座
function mod.PedestalSpawner:CleanupRemaining()
    local removedCount = 0
    for _, pedestal in ipairs(self.activePedestals) do
        if pedestal and pedestal:Exists() and pedestal.Wait <= 0 then
            pedestal:Remove()
            removedCount = removedCount + 1
        end
    end

    -- 清空引用
    self.activePedestals = {}
    mod.HEXTECH_DATA.PERSISTENT.activePickup = false

    if removedCount > 0 then
        mod:Log("Cleaned up " .. removedCount .. " remaining pedestals")
    end
end

-- 每帧更新（由 callbacks.lua 调用）
mod.PedestalSpawner.frameCounter = 0

function mod.PedestalSpawner:Update()
    if not mod.HEXTECH_DATA.PERSISTENT.activePickup then
        return
    end

    -- 性能优化：每 N 帧检查一次
    self.frameCounter = self.frameCounter + 1
    if self.frameCounter < mod.PICKUP_CONFIG.CHECK_INTERVAL then
        return
    end
    self.frameCounter = 0

    -- 检查是否有底座被拾取
    if self:HasAnyBeenPickedUp() then
        mod:Log("Pedestal picked up, cleaning up remaining...")
        self:CleanupRemaining()
    end
end

-- 重置状态（新游戏开始时调用）
function mod.PedestalSpawner:Reset()
    self.activePedestals = {}
    self.frameCounter = 0
    mod.HEXTECH_DATA.PERSISTENT.activePickup = false
    mod:Log("PedestalSpawner reset")
end
