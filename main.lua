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
    "missile",
    "curse_energy",
    "callbacks",
    "items.tapdancer",
    "items.bluntforce",
    "items.stats",
    "items.slowandsteady",
    "items.itskillingtime",
    "items.nighthunt",
    "items.deft",
    "items.dematerialize",
    "items.silverspoon",
    "items.typhoon",
    "items.transmutegold",
    "items.transmuteprismatic",
    "items.transmutechaos",
    "items.celestialbody",
    "items.jeweledgauntlet",
    "items.mysticpunch",
    "items.apexinventor",
    "items.backtobasics",
    "items.fanthehammer",
    "items.canttouchthis",
    "items.homeguard",
    "items.plaguebearer",
    "eid_integration",
}

for _, script in ipairs(SCRIPTS) do
    include("scripts/" .. script)
end
