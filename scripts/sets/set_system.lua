local mod = HextechMod

mod._setProgressGetters = {}
mod._setChanceGetters = {}

function mod:GetSetProgress(setName, player)
    local getter = mod._setProgressGetters[setName]
    if getter then return getter(player) end
    return 0
end

function mod:GetSetChance(setName, player)
    local getter = mod._setChanceGetters[setName]
    if getter then return getter(player) end
    return 0
end

function mod:GetSetBoost(itemId, player)
    if not player then return 1.0 end

    for setName, setData in pairs(mod.SETS) do
        for _, setId in ipairs(setData.items) do
            if setId == itemId then
                local collected = mod:GetSetProgress(setName, player)
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
