HextechMod = RegisterMod("hextech", 1)
local mod = HextechMod
mod.VERSION = "1.0"

local game = Game()
mod.Game = game

-- 核心脚本（按依赖顺序）
local CORE_SCRIPTS = {
    "constants",
    "utils",
    "hextech_pool",
    "pedestal_spawner",
    "damage_pipeline",
    "missile",
    "curse_energy",
    "callbacks",
    "sets.registry",
    "sets.set_system",
    "sets.dragonflame",
    "sets.explosionart",
    "eid_integration",
}

-- 道具脚本（按字母排序，新增时插入对应位置即可）
local ITEM_SCRIPTS = {
    "items.apexinventor",
    "items.augment404",
    "items.augment405",
    "items.backtobasics",
    "items.bluntforce",
    "items.canttouchthis",
    "items.deft",
    "items.dematerialize",
    "items.doubletap",
    "items.fanthehammer",
    "items.hitmepull",
    "items.homeguard",
    "items.itskillingtime",
    "items.jeweledgauntlet",
    "items.magicmissile",
    "items.mysticpunch",
    "items.nighthunt",
    "items.plaguebearer",
    "items.silverspoon",
    "items.slowandsteady",
    "items.stats",
    "items.tapdancer",
    "items.transmutechaos",
    "items.transmutegold",
    "items.transmuteprismatic",
    "items.typhoon",
}

-- 合并并加载
local allScripts = {}
for _, s in ipairs(CORE_SCRIPTS) do table.insert(allScripts, s) end
for _, s in ipairs(ITEM_SCRIPTS) do table.insert(allScripts, s) end

for _, script in ipairs(allScripts) do
    include("scripts/" .. script)
end
