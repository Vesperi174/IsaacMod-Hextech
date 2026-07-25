--[[
    constants.lua - 常量定义
    集中管理所有魔法数字、ID、枚举值
]]

local mod = HextechMod

-- ============================================================
-- 道具池常量
-- ============================================================

-- 海克斯道具池使用原版 treasure 池作为基础
-- 后续可替换为自定义道具池
mod.POOL_TYPE = {
    DEFAULT = ItemPoolType.POOL_TREASURE, -- 默认使用宝箱房池
    -- 后续可扩展为: POOL_HEXTECH = ??? (自定义池)
}

-- 道具池抽取数量
mod.POOL_CONFIG = {
    PEDESTAL_COUNT = 3,    -- 三选一底座数量
    PEDESTAL_SPACING = 80, -- 底座间距（像素）
    MAX_RETRIES = 10,      -- 去重抽取最大重试次数
}

-- ============================================================
-- 层级有效性配置
-- ============================================================

-- 需要触发的 Stage 类型
mod.VALID_STAGES = {
    [StageType.STAGETYPE_ORIGINAL] = true,   -- 原版（Basement/Depths等）
    [StageType.STAGETYPE_WOTB] = true,       -- 忏悔（Downpour/Mines等）
    [StageType.STAGETYPE_REPENTANCE] = true, -- 忏悔后期（Corpse等）
}

-- 不触发的特殊 Stage
mod.EXCLUDED_STAGES = {
    -- 后续根据测试添加
}

-- 不触发的房间类型
-- 这些房间类型中不应生成三选一
mod.EXCLUDED_ROOM_TYPES = {
    [RoomType.ROOM_BOSSRUSH] = true,
    [RoomType.ROOM_DEVIL] = true,
    [RoomType.ROOM_ANGEL] = true,
    [RoomType.ROOM_SHOP] = true,
    [RoomType.ROOM_ERROR] = true,
}

-- ============================================================
-- 拾取检测常量
-- ============================================================

-- 底座被拾取时 Wait 变为正数
mod.PICKUP_CONFIG = {
    PICKED_UP_WAIT_THRESHOLD = 0, -- Wait > 0 表示已被拾取
    CHECK_INTERVAL = 3,           -- 每3帧检测一次（性能优化）
}

-- ============================================================
-- 调试常量
-- ============================================================

mod.DEBUG = {
    ENABLED = true,
    LOG_PREFIX = "[hextech]",
}
