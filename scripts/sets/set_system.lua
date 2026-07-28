local mod = HextechMod

mod.SETS = {
    DragonFlame = {
        name = "Dragon Flame",
        items = {
            mod.ITEMS.MAGICMISSILE,
            mod.ITEMS.FANTHEHAMMER,
            mod.ITEMS.TYPHOON,
        },
    },
}

local activatedSets = {}

local function checkSetEffects(player)
    for setName, setData in pairs(mod.SETS) do
        if not activatedSets[setName] then
            local allCollected = true
            for _, itemId in ipairs(setData.items) do
                if player:GetCollectibleNum(itemId, true) == 0 then
                    allCollected = false
                    break
                end
            end

            if allCollected then
                activatedSets[setName] = true
                Isaac.ConsoleOutput(setData.name .. " set activated!\n")
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    local player = Isaac.GetPlayer(0)
    if player then
        checkSetEffects(player)
    end
end)
