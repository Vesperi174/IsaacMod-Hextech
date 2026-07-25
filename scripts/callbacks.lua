--[[
    callbacks.lua - 回调注册与调度
    负责所有 Mod 回调的注册和事件分发
]]

local mod = HextechMod
local game = mod.Game

-- ============================================================
-- 回调：游戏开始
-- ============================================================

function mod:OnGameStarted(isContinued)
    mod:Log("Game started, isContinued: " .. tostring(isContinued))

    if not isContinued then
        -- 新游戏：重置所有数据
        mod.HEXTECH_DATA.PERSISTENT.processedFloors = {}
        mod.PedestalSpawner:Reset()
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnGameStarted)

-- ============================================================
-- 回调：进入新层级
-- ============================================================

function mod:OnNewLevel()
    mod:Log("New level entered")

    -- 1. 检查层级有效性
    if not mod:IsValidFloor() then
        return
    end

    -- 2. 检查是否已处理
    local floorKey = mod:GetFloorKey()
    if not floorKey then
        mod:LogWarning("Could not get floor key")
        return
    end

    if mod:IsFloorProcessed(floorKey) then
        mod:Log("Floor already processed: " .. floorKey)
        return
    end

    -- 3. 生成三选一底座
    local success = mod.PedestalSpawner:Spawn()
    if success then
        mod:MarkFloorProcessed(floorKey)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevel)

-- ============================================================
-- 回调：每帧更新（用于底座拾取检测）
-- ============================================================

function mod:OnPostUpdate()
    mod.PedestalSpawner:Update()
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.OnPostUpdate)

-- ============================================================
-- 回调：游戏退出前（预留保存逻辑）
-- ============================================================

function mod:OnPreGameExit(shouldSave)
    mod:Log("Game exiting, shouldSave: " .. tostring(shouldSave))
    -- 预留：将来可在这里保存持久化数据
end

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnPreGameExit)
