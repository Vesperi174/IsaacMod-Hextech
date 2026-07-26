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

local ROLL_COUNTS = {}
ROLL_COUNTS[mod.ITEMS.STATS] = 2
ROLL_COUNTS[mod.ITEMS.STATSONSTATS] = 3
ROLL_COUNTS[mod.ITEMS.STATSONSTATSONSTATS] = 4

local playerBonuses = {}
local playerBaseStats = {}
local processedItems = {}

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
    if not playerBonuses[idx] then
        playerBonuses[idx] = { damage = 0, tears = 0, shotSpeed = 0, range = 0, speed = 0, luck = 0, maxHearts = 0 }
    end
    if not playerBaseStats[idx] then
        playerBaseStats[idx] = {}
    end
    if not processedItems[idx] then
        processedItems[idx] = {}
    end
end

local function processItem(player, itemId)
    local idx = player.ControllerIndex
    ensurePlayerData(idx)

    if processedItems[idx][itemId] then
        return
    end

    local rollCount = ROLL_COUNTS[itemId]
    if not rollCount then return end

    local awards = rollAwards(rollCount)
    processedItems[idx][itemId] = true

    if awards.maxHearts > 0 then
        player:AddMaxHearts(math.floor(awards.maxHearts * 2))
    end

    playerBonuses[idx].damage = playerBonuses[idx].damage + awards.damage
    playerBonuses[idx].tears = playerBonuses[idx].tears + awards.tears
    playerBonuses[idx].shotSpeed = playerBonuses[idx].shotSpeed + awards.shotSpeed
    playerBonuses[idx].range = playerBonuses[idx].range + awards.range
    playerBonuses[idx].speed = playerBonuses[idx].speed + awards.speed
    playerBonuses[idx].luck = playerBonuses[idx].luck + awards.luck

    player:AddCacheFlags(CacheFlag.CACHE_ALL)
    player:EvaluateItems()
end

function mod:onStatsCache(player, flag)
    local idx = player.ControllerIndex
    ensurePlayerData(idx)

    if flag & CacheFlag.CACHE_DAMAGE ~= 0 then
        playerBaseStats[idx].damage = player.Damage
    end
    if flag & CacheFlag.CACHE_FIREDELAY ~= 0 then
        playerBaseStats[idx].maxFireDelay = player.MaxFireDelay
    end
    if flag & CacheFlag.CACHE_SHOTSPEED ~= 0 then
        playerBaseStats[idx].shotSpeed = player.ShotSpeed
    end
    if flag & CacheFlag.CACHE_RANGE ~= 0 then
        playerBaseStats[idx].tearRange = player.TearRange
    end
    if flag & CacheFlag.CACHE_SPEED ~= 0 then
        playerBaseStats[idx].moveSpeed = player.MoveSpeed
    end
    if flag & CacheFlag.CACHE_LUCK ~= 0 then
        playerBaseStats[idx].luck = player.Luck
    end
end

function mod:onStatsUpdate(player)
    local idx = player.ControllerIndex
    ensurePlayerData(idx)

    local hasStats = player:HasCollectible(mod.ITEMS.STATS)
        or player:HasCollectible(mod.ITEMS.STATSONSTATS)
        or player:HasCollectible(mod.ITEMS.STATSONSTATSONSTATS)

    if hasStats then
        if player:HasCollectible(mod.ITEMS.STATS) then
            processItem(player, mod.ITEMS.STATS)
        end
        if player:HasCollectible(mod.ITEMS.STATSONSTATS) then
            processItem(player, mod.ITEMS.STATSONSTATS)
        end
        if player:HasCollectible(mod.ITEMS.STATSONSTATSONSTATS) then
            processItem(player, mod.ITEMS.STATSONSTATSONSTATS)
        end
    end

    local bonuses = playerBonuses[idx]
    local hasBonus = false
    for _, v in pairs(bonuses) do
        if v ~= 0 then
            hasBonus = true
            break
        end
    end
    if not hasBonus then return end

    local base = playerBaseStats[idx]

    if bonuses.damage ~= 0 and base.damage then
        player.Damage = base.damage + bonuses.damage
    end

    if bonuses.tears ~= 0 and base.maxFireDelay then
        local baseTears = 30 / (base.maxFireDelay + 1)
        local newTears = baseTears + bonuses.tears
        player.MaxFireDelay = math.max(0, 30 / newTears - 1)
    end

    if bonuses.shotSpeed ~= 0 and base.shotSpeed then
        player.ShotSpeed = base.shotSpeed + bonuses.shotSpeed
    end

    if bonuses.range ~= 0 and base.tearRange then
        player.TearRange = base.tearRange + bonuses.range
    end

    if bonuses.speed ~= 0 and base.moveSpeed then
        player.MoveSpeed = base.moveSpeed + bonuses.speed
    end

    if bonuses.luck ~= 0 and base.luck then
        player.Luck = base.luck + bonuses.luck
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.onStatsCache)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onStatsUpdate)
