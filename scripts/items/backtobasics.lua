local mod = HextechMod

local DAMAGE_MULT = 3.0

local ENTITY_PICKUP = 5
local PICKUP_COLLECTIBLE = 100
local PICKUP_TRINKET = 350
local PICKUP_PILL = 70
local PICKUP_TAROTCARD = 300

function mod:onBackToBasicsUpdate(player)
    if not player:HasCollectible(mod.ITEMS.BACKTOBASICS) then return end

    local pos = player.Position

    -- Drop active items (primary, secondary, pocket)
    local activeSlots = { 0, 1, 2 }
    for _, slot in ipairs(activeSlots) do
        local itemId = player:GetActiveItem(slot)
        if itemId > 0 then
            Isaac.Spawn(ENTITY_PICKUP, PICKUP_COLLECTIBLE, itemId, pos, Vector(0, 0), player, 0, 0)
            player:RemoveCollectible(itemId, false, slot)
        end
    end

    -- Drop held trinket
    local trinket = player:GetTrinket(0)
    if trinket ~= 0 then
        Isaac.Spawn(ENTITY_PICKUP, PICKUP_TRINKET, trinket, pos, Vector(0, 0), player, 0, 0)
        player:TryRemoveTrinket(trinket)
    end

    -- Drop smelted trinket
    local smelted = player:GetTrinket(1)
    if smelted ~= 0 then
        Isaac.Spawn(ENTITY_PICKUP, PICKUP_TRINKET, smelted, pos, Vector(0, 0), player, 0, 0)
        player:TryRemoveTrinket(smelted)
    end

    -- Drop pill
    local pill = player:GetPill(0)
    if pill > 0 then
        Isaac.Spawn(ENTITY_PICKUP, PICKUP_PILL, pill, pos, Vector(0, 0), player, 0, 0)
        player:SetPill(0, 0)
    end

    -- Drop card/rune
    local card = player:GetCard(0)
    if card > 0 then
        Isaac.Spawn(ENTITY_PICKUP, PICKUP_TAROTCARD, card, pos, Vector(0, 0), player, 0, 0)
        player:SetCard(0, 0)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onBackToBasicsUpdate)

mod.DamagePipeline:Register({
    type = mod.DamagePipeline.MULTIPLY,
    callback = function(player, raw, current)
        if not player:HasCollectible(mod.ITEMS.BACKTOBASICS) then return nil end
        return DAMAGE_MULT
    end,
})
