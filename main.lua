--[[
    hextech Mod - 海克斯大乱斗
    每层初始房间出现三选一底座道具
]]

HextechMod = RegisterMod("hextech", 1)
local mod = HextechMod
mod.VERSION = "1.0"

-- 全局引用
local game = Game()
mod.Game = game
mod.ItemPool = game:GetItemPool()

-- 数据存储
mod.HEXTECH_DATA = {
    PERSISTENT = {
        processedFloors = {},  -- 已处理层级: { [stage] = { [levelType] = true } }
        spawnedPedestals = {}, -- 当前活跃底座实体引用
        activePickup = false,  -- 是否有活跃的三选一
    }
}

-- 脚本加载（按依赖顺序）
local SCRIPTS = {
    "constants",
    "utils",
    "hextech_pool",
    "pedestal_spawner",
    "callbacks",
}

for _, script in ipairs(SCRIPTS) do
    include("scripts/" .. script)
end