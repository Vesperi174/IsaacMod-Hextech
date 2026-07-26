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
    "callbacks",
    "items.tapdancer",
    "items.bluntforce",
    "items.stats",
    "items.slowandsteady",
    "items.deft",
    "items.transmutegold",
    "items.transmuteprismatic",
    "items.transmutechaos",
    "items.celestialbody",
    "eid_integration",
}

for _, script in ipairs(SCRIPTS) do
    include("scripts/" .. script)
end
