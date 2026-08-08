local mod = HextechMod

local DICE_ROLLER_CHANCES = {
    [2] = 0.3,
    [3] = 0.5,
    [4] = 0.8,
}

local AWARDS = {
    { type = "shotSpeed", value = 0.3, weight = 5 },
    { type = "range",     value = 2.5, weight = 5 },
    { type = "speed",     value = 0.3, weight = 5 },
    { type = "damage",    value = 1.0, weight = 3 },
    { type = "tears",     value = 0.7, weight = 3 },
    { type = "luck",      value = 1.0, weight = 2 },
    { type = "maxHearts", value = 1.0, weight = 2 },
}

local TRANSMUTE_IDS = {
    [mod.ITEMS.TRANSMUTEGOLD] = true,
    [mod.ITEMS.TRANSMUTEPRISMATIC] = true,
    [mod.ITEMS.TRANSMUTECHAOS] = true,
}

local TRANSMUTE_FLAGS = {
    [mod.ITEMS.TRANSMUTEGOLD] = "diceTransmuteGold",
    [mod.ITEMS.TRANSMUTEPRISMATIC] = "diceTransmutePrismatic",
    [mod.ITEMS.TRANSMUTECHAOS] = "diceTransmuteChaos",
}

local function weightedRandom()
    local total = 0
    for _, award in ipairs(AWARDS) do
        total = total + award.weight
    end
    local r = math.random() * total
    local cumulative = 0
    for _, award in ipairs(AWARDS) do
        cumulative = cumulative + award.weight
        if r <= cumulative then
            return award.type, award.value
        end
    end
end

local function getSetCount(player)
    local setData = mod.SETS.DiceRoller
    local count = 0
    local pdata = player:GetData()
    for _, itemId in ipairs(setData.items) do
        if TRANSMUTE_IDS[itemId] then
            if pdata[TRANSMUTE_FLAGS[itemId]] then
                count = count + 1
            end
        else
            if player:GetCollectibleNum(itemId, true) > 0 then
                count = count + 1
            end
        end
    end
    return count
end

mod._setProgressGetters.DiceRoller = function(player)
    if not player then return 0 end
    return getSetCount(player)
end

mod._setChanceGetters.DiceRoller = function(player)
    local count = mod:GetSetProgress("DiceRoller", player)
    return DICE_ROLLER_CHANCES[count] or 0
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    local room = Game():GetRoom()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player then
            local pdata = player:GetData()
            pdata.diceRoomCleared = false
            pdata.diceRoomWasClear = room:IsClear()
        end
    end
end)

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    local room = Game():GetRoom()
    if not room:IsClear() then return end

    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if not player then goto continue end

        local pdata = player:GetData()
        if pdata.diceRoomCleared then goto continue end
        if pdata.diceRoomWasClear then goto continue end
        pdata.diceRoomCleared = true

        local count = getSetCount(player)
        if count < 2 then goto continue end

        local chance = DICE_ROLLER_CHANCES[count] or 0
        local roll = math.random()
        if roll < chance then
            local awardType, awardValue = weightedRandom()
            if not pdata.diceRollerStats then
                pdata.diceRollerStats = { damage = 0, tears = 0, shotSpeed = 0, range = 0, speed = 0, luck = 0, maxHearts = 0 }
            end
            pdata.diceRollerStats[awardType] = pdata.diceRollerStats[awardType] + awardValue

            if awardType == "maxHearts" then
                player:AddMaxHearts(awardValue * 2)
            end

            player:AddCacheFlags(CacheFlag.CACHE_ALL)
            player:EvaluateItems()
        end

        ::continue::
    end
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player, flag)
    local pdata = player:GetData()
    local stats = pdata.diceRollerStats
    if not stats then return end

    if flag & CacheFlag.CACHE_FIREDELAY ~= 0 then
        local baseTears = 30 / (player.MaxFireDelay + 1)
        local newTears = baseTears + (stats.tears or 0)
        player.MaxFireDelay = math.max(0, 30 / math.max(0.1, newTears) - 1)
    end
    if flag & CacheFlag.CACHE_SHOTSPEED ~= 0 then
        player.ShotSpeed = player.ShotSpeed + (stats.shotSpeed or 0)
    end
    if flag & CacheFlag.CACHE_RANGE ~= 0 then
        player.TearRange = player.TearRange + (stats.range or 0)
    end
    if flag & CacheFlag.CACHE_SPEED ~= 0 then
        player.MoveSpeed = player.MoveSpeed + (stats.speed or 0)
    end
    if flag & CacheFlag.CACHE_LUCK ~= 0 then
        player.Luck = player.Luck + (stats.luck or 0)
    end
end)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.FLAT,
    callback = function(player, base)
        local pdata = player:GetData()
        local stats = pdata.diceRollerStats
        if stats and stats.damage and stats.damage > 0 then
            return stats.damage
        end
        return nil
    end,
})
