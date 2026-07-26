local mod = HextechMod
local game = mod.Game

local AWARDS = {
    { type = "shotSpeed", value = 0.3, weight = 5 },
    { type = "range",     value = 2.5, weight = 5 },
    { type = "speed",     value = 0.3, weight = 5 },
    { type = "damage",    value = 1.0, weight = 3 },
    { type = "tears",     value = 0.7, weight = 3 },
    { type = "luck",      value = 1.0, weight = 2 },
    { type = "maxHearts", value = 1.0, weight = 2 },
}

local ROLLS_PER_ITEM = {}
ROLLS_PER_ITEM[mod.ITEMS.STATS] = 2
ROLLS_PER_ITEM[mod.ITEMS.STATSONSTATS] = 3
ROLLS_PER_ITEM[mod.ITEMS.STATSONSTATSONSTATS] = 4

local STATS_ITEMS = { mod.ITEMS.STATS, mod.ITEMS.STATSONSTATS, mod.ITEMS.STATSONSTATSONSTATS }

local playerAwards = {}
local playerHearts = {}
local playerCounts = {}

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

local function rollAwards(count)
    local awards = { damage = 0, tears = 0, shotSpeed = 0, range = 0, speed = 0, luck = 0, maxHearts = 0 }
    for i = 1, count do
        local awardType, awardValue = weightedRandom()
        awards[awardType] = awards[awardType] + awardValue
    end
    return awards
end

local function ensurePlayerData(idx)
    if not playerAwards[idx] then
        playerAwards[idx] = {}
    end
    if not playerHearts[idx] then
        playerHearts[idx] = {}
    end
    if not playerCounts[idx] then
        playerCounts[idx] = {}
    end
end

function mod:onStatsUpdate(player)
    local idx = player.ControllerIndex
    ensurePlayerData(idx)

    for _, itemId in ipairs(STATS_ITEMS) do
        local count = player:GetCollectibleNum(itemId)
        local lastCount = playerCounts[idx][itemId] or 0

        if count ~= lastCount then
            if count > lastCount and playerAwards[idx][itemId] then
                local newRolls = (count - lastCount) * ROLLS_PER_ITEM[itemId]
                local newAwards = rollAwards(newRolls)
                for k, v in pairs(newAwards) do
                    playerAwards[idx][itemId][k] = (playerAwards[idx][itemId][k] or 0) + v
                end
            else
                local totalRolls = count * ROLLS_PER_ITEM[itemId]
                playerAwards[idx][itemId] = rollAwards(totalRolls)
            end
            playerCounts[idx][itemId] = count

            local newHearts = math.floor((playerAwards[idx][itemId].maxHearts or 0) * 2)
            local oldHearts = playerHearts[idx][itemId] or 0
            local delta = newHearts - oldHearts
            if delta > 0 then
                player:AddMaxHearts(delta)
            end
            playerHearts[idx][itemId] = newHearts

            player:AddCacheFlags(CacheFlag.CACHE_ALL)
            player:EvaluateItems()
        end
    end
end

function mod:onStatsCache(player, flag)
    local idx = player.ControllerIndex
    ensurePlayerData(idx)

    local total = { damage = 0, tears = 0, shotSpeed = 0, range = 0, speed = 0, luck = 0 }
    for _, itemId in ipairs(STATS_ITEMS) do
        local awards = playerAwards[idx][itemId]
        if awards then
            total.damage = total.damage + (awards.damage or 0)
            total.tears = total.tears + (awards.tears or 0)
            total.shotSpeed = total.shotSpeed + (awards.shotSpeed or 0)
            total.range = total.range + (awards.range or 0)
            total.speed = total.speed + (awards.speed or 0)
            total.luck = total.luck + (awards.luck or 0)
        end
    end

    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        player.Damage = player.Damage + total.damage
    end
    if flag & CacheFlag.CACHE_FIREDELAY ~= 0 then
        local baseTears = 30 / (player.MaxFireDelay + 1)
        local newTears = baseTears + total.tears
        player.MaxFireDelay = math.max(0, 30 / newTears - 1)
    end
    if flag & CacheFlag.CACHE_SHOTSPEED ~= 0 then
        player.ShotSpeed = player.ShotSpeed + total.shotSpeed
    end
    if flag & CacheFlag.CACHE_RANGE ~= 0 then
        player.TearRange = player.TearRange + total.range
    end
    if flag & CacheFlag.CACHE_SPEED ~= 0 then
        player.MoveSpeed = player.MoveSpeed + total.speed
    end
    if flag & CacheFlag.CACHE_LUCK ~= 0 then
        player.Luck = player.Luck + total.luck
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onStatsUpdate)
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onStatsCache)
