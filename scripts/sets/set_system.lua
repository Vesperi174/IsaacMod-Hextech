local mod = HextechMod

-- 获取玩家套装进度（各套装自行实现 checkSetProgress）
function mod:GetSetProgress(setName, player)
    return 0
end

-- 获取套装效果触发概率（各套装自行实现）
function mod:GetSetChance(setName, player)
    return 0
end

-- 套装加成倍率（通用逻辑）
function mod:GetSetBoost(itemId, player)
    if not player then return 1.0 end

    for _, setData in pairs(mod.SETS) do
        for _, setId in ipairs(setData.items) do
            if setId == itemId then
                local collected = 0
                for _, sId in ipairs(setData.items) do
                    if player:GetCollectibleNum(sId, true) > 0 then
                        collected = collected + 1
                    end
                end

                if collected == 1 then
                    return 1.5
                elseif collected == 2 then
                    return 1.25
                else
                    return 1.0
                end
            end
        end
    end
    return 1.0
end

-- 获取所有玩家中最高套装进度（用于 EID 显示）
function mod:GetMaxSetProgress(setName)
    local maxCount = 0
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player then
            local count = mod:GetSetProgress(setName, player)
            if count > maxCount then
                maxCount = count
            end
        end
    end
    return maxCount
end
