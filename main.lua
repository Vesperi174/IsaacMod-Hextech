HextechMod = RegisterMod("hextech", 1)
local mod = HextechMod
mod.VERSION = "1.0"

local game = Game()
mod.Game = game

local SCRIPTS = {
    "constants",
    "utils",
    "hextech_pool",
    "pedestal_spawner",
    "damage_pipeline",
    "callbacks",
    "items.tapdancer",
    "items.bluntforce",
    "items.stats",
    "items.slowandsteady",
    "items.itskillingtime",
    "items.deft",
    "items.dematerialize",
    "items.transmutegold",
    "items.transmuteprismatic",
    "items.transmutechaos",
    "items.celestialbody",
    "items.jeweledgauntlet",
    "items.apexinventor",
    "items.backtobasics",
    "eid_integration",
}

for _, script in ipairs(SCRIPTS) do
    include("scripts/" .. script)
end
