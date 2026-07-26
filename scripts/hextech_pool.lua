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

function mod.HextechPool:Register(itemId, tier, weight)
    if not self.items[tier] then
        return
    end
    table.insert(self.items[tier], { id = itemId, weight = weight or 1 })
end

function mod.HextechPool:GetRandomItem(tier)
    if not self.items[tier] or #self.items[tier] == 0 then
        return nil
    end
    local pool = self.items[tier]
    local index = math.random(1, #pool)
    return pool[index].id
end

function mod.HextechPool:GetRandomItems(tier, count)
    if not self.items[tier] or #self.items[tier] == 0 then
        return nil
    end
    local pool = {}
    for i = 1, #self.items[tier] do
        pool[i] = self.items[tier][i].id
    end
    local result = {}
    for i = 1, math.min(count, #pool) do
        local index = math.random(1, #pool)
        result[i] = pool[index]
        table.remove(pool, index)
    end
    return result
end

mod.HextechPool:Register(mod.ITEMS.TAPDANCER, mod.HextechPool.PRISMATIC, 1)
mod.HextechPool:Register(mod.ITEMS.BLUNTFORCE, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.DEFT, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.TRANSMUTEGOLD, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.TRANSMUTEPRISMATIC, mod.HextechPool.GOLD, 1)
mod.HextechPool:Register(mod.ITEMS.STATS, mod.HextechPool.SILVER, 1)
mod.HextechPool:Register(mod.ITEMS.STATSONSTATS, mod.HextechPool.GOLD, 1)
mod.HextechPool:Register(mod.ITEMS.STATSONSTATSONSTATS, mod.HextechPool.PRISMATIC, 1)
mod.HextechPool:Register(mod.ITEMS.SLOWANDSTEADY, mod.HextechPool.GOLD, 1)

Isaac.ConsoleOutput("[hextech] Prismatic: " .. #mod.HextechPool.items[mod.HextechPool.PRISMATIC] .. "\n")
Isaac.ConsoleOutput("[hextech] Gold: " .. #mod.HextechPool.items[mod.HextechPool.GOLD] .. "\n")
Isaac.ConsoleOutput("[hextech] Silver: " .. #mod.HextechPool.items[mod.HextechPool.SILVER] .. "\n")
