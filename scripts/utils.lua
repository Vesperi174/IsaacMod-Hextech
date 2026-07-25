--[[
    utils.lua - 工具函数库
    提供日志、数据操作、数学计算等通用功能
]]

local mod = HextechMod
local game = mod.Game

-- ============================================================
-- 日志系统
-- ============================================================

function mod:Log(message)
    if mod.DEBUG.ENABLED then
        Isaac.DebugString(mod.DEBUG.LOG_PREFIX .. " " .. tostring(message))
    end
end

function mod:LogWarning(message)
    if mod.DEBUG.ENABLED then
        Isaac.DebugString(mod.DEBUG.LOG_PREFIX .. " [WARN] " .. tostring(message))
    end
end

-- ============================================================
-- 层级标识
-- ============================================================

-- 生成唯一层级标识符
function mod:GetFloorKey()
    local level = game:GetLevel()
    if not level then
        return nil
    end
    local stage = level:GetStage()
    local stageType = level:GetStageType()
    return tostring(stageType) .. "_" .. tostring(stage)
end

-- 检查层级是否已处理
function mod:IsFloorProcessed(floorKey)
    return mod.HEXTECH_DATA.PERSISTENT.processedFloors[floorKey] == true
end

-- 标记层级已处理
function mod:MarkFloorProcessed(floorKey)
    mod.HEXTECH_DATA.PERSISTENT.processedFloors[floorKey] = true
    mod:Log("Floor marked as processed: " .. floorKey)
end

-- ============================================================
-- 层级有效性检查
-- ============================================================

-- 检查当前层级是否应该触发三选一
function mod:IsValidFloor()
    local level = game:GetLevel()
    if not level then
        return false
    end

    local stageType = level:GetStageType()

    -- 检查 StageType 是否有效
    if not mod.VALID_STAGES[stageType] then
        mod:Log("Skipped: invalid stage type " .. tostring(stageType))
        return false
    end

    -- 检查是否在排除列表中
    if mod.EXCLUDED_STAGES[stageType] then
        mod:Log("Skipped: excluded stage type " .. tostring(stageType))
        return false
    end

    -- 检查房间类型
    local room = game:GetRoom()
    if room and mod.EXCLUDED_ROOM_TYPES[room:GetType()] then
        mod:Log("Skipped: excluded room type " .. tostring(room:GetType()))
        return false
    end

    return true
end

-- ============================================================
-- 位置计算
-- ============================================================

-- 计算底座在房间中的位置
function mod:CalculatePedestalPositions(room)
    local center = room:GetCenterPos()
    local spacing = mod.POOL_CONFIG.PEDESTAL_SPACING
    local count = mod.POOL_CONFIG.PEDESTAL_COUNT

    local positions = {}
    local startX = center.X - (count - 1) * spacing / 2

    for i = 0, count - 1 do
        positions[i + 1] = Vector(startX + i * spacing, center.Y)
    end

    return positions
end

-- ============================================================
-- 通用辅助
-- ============================================================

-- 检查表是否为空
function mod:IsTableEmpty(t)
    if t == nil then
        return true
    end
    for _ in pairs(t) do
        return false
    end
    return true
end

-- 获取数组长度
function mod:TableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end
