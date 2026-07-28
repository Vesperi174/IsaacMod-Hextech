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
local setMessage = ""
local messageTimer = 0
local MESSAGE_DURATION = 60 -- 1秒

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
                setMessage = setData.name .. " Set Complete!"
                messageTimer = MESSAGE_DURATION
            end
        end
    end
end

function mod:FireChainMissile(tear, target)
    local player = tear.SpawnerEntity
    if not player or not target then return end

    mod.Missile.Fire(player, target, 1.0)
end

function mod:onMissileTakeDamage(entity, amount, flags, source, cooldownFrames)
    if not entity:IsVulnerableEnemy() then return end
    if not source or not source.Entity then return end

    local srcEntity = source.Entity
    local data = srcEntity:GetData()
    if not data or not data.isMissile then return end

    if activatedSets["DragonFlame"] then
        mod:FireChainMissile(srcEntity, entity)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    local player = Isaac.GetPlayer(0)
    if player then
        checkSetEffects(player)
    end

    if messageTimer > 0 then
        messageTimer = messageTimer - 1
    end
end)

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
    if messageTimer > 0 and setMessage ~= "" then
        local sw = Isaac.GetScreenWidth() or 480
        local sh = Isaac.GetScreenHeight() or 270
        Isaac.RenderText(setMessage, sw / 2 - 60, sh / 2 - 60, 255, 255, 0, 255)
    end
end)

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onMissileTakeDamage)
