local mod = HextechMod

local tracked = {}
local augment404Used = false

local HEX_ITEMS = {
    mod.ITEMS.TAPDANCER, mod.ITEMS.BLUNTFORCE, mod.ITEMS.DEFT,
    mod.ITEMS.DEMATERIALIZE, mod.ITEMS.SILVERSPOON, mod.ITEMS.TYPHOON,
    mod.ITEMS.TRANSMUTEGOLD, mod.ITEMS.TRANSMUTEPRISMATIC, mod.ITEMS.TRANSMUTECHAOS,
    mod.ITEMS.CELESTIALBODY, mod.ITEMS.JEWELEDGAUNTLET, mod.ITEMS.MYSTICPUNCH,
    mod.ITEMS.STATS, mod.ITEMS.STATSONSTATS, mod.ITEMS.STATSONSTATSONSTATS,
    mod.ITEMS.SLOWANDSTEADY, mod.ITEMS.ITSKILLINGTIME, mod.ITEMS.NIGHTHUNT,
    mod.ITEMS.APEXINVENTOR, mod.ITEMS.BACKTOBASICS, mod.ITEMS.FANTHEHAMMER,
    mod.ITEMS.CANTTOUCHTHIS, mod.ITEMS.HOMEGUARD, mod.ITEMS.PLAGUEBEARER,
    mod.ITEMS.MAGICMISSILE, mod.ITEMS.DOUBLETAP,
}

local function init()
    local player = Isaac.GetPlayer(0)
    if not player then return end
    for _, id in ipairs(HEX_ITEMS) do
        tracked[id] = player:GetCollectibleNum(id, false)
    end
end

function mod:onAugment404Check()
    local player = Isaac.GetPlayer(0)
    if not player then return end

    if not next(tracked) then
        init()
        return
    end

    for _, id in ipairs(HEX_ITEMS) do
        local current = player:GetCollectibleNum(id, false)
        local previous = tracked[id] or 0
        if current > previous then
            if player:HasCollectible(mod.ITEMS.AUGMENT404) then
                if not player:HasCollectible(mod.ITEMS.AUGMENT405) then
                    player:RemoveCollectible(id)
                    player:RemoveCollectible(mod.ITEMS.AUGMENT404)
                    player:AddCollectible(mod.ITEMS.AUGMENT405, 0, false)
                    augment404Used = true
                end
            elseif not augment404Used and math.random(100) == 1 then
                player:RemoveCollectible(id)
                player:AddCollectible(mod.ITEMS.AUGMENT404, 0, false)
                augment404Used = true
            end
        end
        tracked[id] = current
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.onAugment404Check)
