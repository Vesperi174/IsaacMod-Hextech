--[[
    hextech_pool.lua - 海克斯道具池管理
    负责道具池的初始化、抽取、权重管理
]]

local mod = HextechMod
local game = mod.Game

-- ============================================================
-- 道具池对象
-- ============================================================

mod.HextechPool = {}

-- 初始化道具池
function mod.HextechPool:Init()
    mod:Log("HextechPool initialized")
end

-- 获取当前活跃的道具池类型
function mod.HextechPool:GetActivePoolType()
    -- 初版使用原版 treasure 池
    return mod.POOL_TYPE.DEFAULT
end

-- 从道具池中随机抽取一个道具
function mod.HextechPool:GetRandomItem(usedIds)
    local poolType = self:GetActivePoolType()
    local itemPool = mod.ItemPool
    local maxRetries = mod.POOL_CONFIG.MAX_RETRIES
    local itemId

    for _ = 1, maxRetries do
        itemId = itemPool:GetCollectible(poolType, true, mod.RNG)

        -- 检查是否已使用
        if not usedIds[itemId] then
            return itemId
        end
    end

    -- 去重失败，返回最后一个
    mod:LogWarning("Failed to get unique item after " .. maxRetries .. " retries")
    return itemId
end

-- 抽取多个不重复的道具
function mod.HextechPool:GetRandomItems(count)
    local items = {}
    local usedIds = {}
    local seed = game:GetSeeds():GetStartSeed()

    for i = 1, count do
        local itemId = self:GetRandomItem(usedIds)
        if itemId then
            usedIds[itemId] = true
            items[i] = itemId
            mod:Log("Drawn item #" .. i .. ": " .. tostring(itemId))
        else
            mod:LogWarning("Failed to draw item #" .. i)
        end
    end

    return items
end

-- 初始化
mod.HextechPool:Init()
