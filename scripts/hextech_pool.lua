local mod = HextechMod

mod.HextechPool = {
    PRISMATIC = "PRISMATIC",
    GOLD = "GOLD",
    SILVER = "SILVER",
}

mod.HextechPool.items = {
    [mod.HextechPool.PRISMATIC] = {},
    [mod.HextechPool.GOLD] = {},
    [mod.HextechPool.SILVER] = {},
}

mod.HextechPool.LEVEL_WEIGHTS = {
    [1] = 1.0,
    [2] = 0.7,
    [3] = 0.5,
    [4] = 0.35,
}

function mod.HextechPool:Register(itemId, tier, level)
    if not self.items[tier] then
        return
    end
    table.insert(self.items[tier], { id = itemId, level = level or 1 })
end

function mod.HextechPool:GetRandomItem(tier)
    if not self.items[tier] or #self.items[tier] == 0 then
        return nil
    end
    return self:GetRandomItems(tier, 1)[1]
end

function mod.HextechPool:GetRandomItems(tier, count)
    if not self.items[tier] or #self.items[tier] == 0 then
        return nil
    end

    local pool = {}
    for i = 1, #self.items[tier] do
        pool[i] = self.items[tier][i]
    end

    local result = {}
    local n = math.min(count, #pool)
    for _ = 1, n do
        local totalWeight = 0
        for i = 1, #pool do
            totalWeight = totalWeight + self.LEVEL_WEIGHTS[pool[i].level]
        end

        if totalWeight <= 0 then
            result[#result + 1] = pool[1].id
            table.remove(pool, 1)
        else
            local roll = math.random() * totalWeight
            local cumulative = 0
            for i = 1, #pool do
                cumulative = cumulative + self.LEVEL_WEIGHTS[pool[i].level]
                if roll <= cumulative then
                    result[#result + 1] = pool[i].id
                    table.remove(pool, i)
                    break
                end
            end
        end
    end

    return result
end

function mod.HextechPool:GetRandomTier()
    local tiers = { self.SILVER, self.GOLD, self.PRISMATIC }
    return tiers[math.random(1, 3)]
end

mod.HextechPool:Register(mod.ITEMS.TAPDANCER, mod.HextechPool.PRISMATIC, 4)
mod.HextechPool:Register(mod.ITEMS.BLUNTFORCE, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.DEFT, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.DEMATERIALIZE, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.TRANSMUTEGOLD, mod.HextechPool.SILVER, 2)
mod.HextechPool:Register(mod.ITEMS.TRANSMUTEPRISMATIC, mod.HextechPool.GOLD, 3)
mod.HextechPool:Register(mod.ITEMS.TRANSMUTECHAOS, mod.HextechPool.PRISMATIC, 4)
mod.HextechPool:Register(mod.ITEMS.CELESTIALBODY, mod.HextechPool.GOLD, 3)
mod.HextechPool:Register(mod.ITEMS.JEWELEDGAUNTLET, mod.HextechPool.PRISMATIC, 4)
mod.HextechPool:Register(mod.ITEMS.STATS, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.STATSONSTATS, mod.HextechPool.GOLD, 3)
mod.HextechPool:Register(mod.ITEMS.STATSONSTATSONSTATS, mod.HextechPool.PRISMATIC, 4)
mod.HextechPool:Register(mod.ITEMS.SLOWANDSTEADY, mod.HextechPool.GOLD, 2)
mod.HextechPool:Register(mod.ITEMS.APEXINVENTOR, mod.HextechPool.GOLD, 3)
mod.HextechPool:Register(mod.ITEMS.BACKTOBASICS, mod.HextechPool.PRISMATIC, 4)

Isaac.ConsoleOutput("[hextech] Prismatic: " .. #mod.HextechPool.items[mod.HextechPool.PRISMATIC] .. "\n")
Isaac.ConsoleOutput("[hextech] Gold: " .. #mod.HextechPool.items[mod.HextechPool.GOLD] .. "\n")
Isaac.ConsoleOutput("[hextech] Silver: " .. #mod.HextechPool.items[mod.HextechPool.SILVER] .. "\n")
