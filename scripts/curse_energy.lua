local mod = HextechMod

mod.CurseEnergy = {}
local CurseEnergy = mod.CurseEnergy

CurseEnergy.relatedItems = {}

CurseEnergy.stacks = 0

function CurseEnergy.RegisterItem(itemId)
    CurseEnergy.relatedItems[itemId] = true
end

function CurseEnergy.HasRelatedItem(player)
    for itemId, _ in pairs(CurseEnergy.relatedItems) do
        if player:HasCollectible(itemId) then
            return true
        end
    end
    return false
end

function CurseEnergy.GetStacks()
    return CurseEnergy.stacks
end

function CurseEnergy.SetStacks(amount)
    CurseEnergy.stacks = math.max(0, amount)
end

function CurseEnergy.AddStacks(amount)
    CurseEnergy.stacks = CurseEnergy.stacks + amount
end

function CurseEnergy.ResetStacks()
    CurseEnergy.stacks = 0
end

function CurseEnergy.ResetAll()
    CurseEnergy.stacks = 0
end

function mod:onCurseEnergyRender()
    local game = Game()
    local hasAny = false
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player and CurseEnergy.HasRelatedItem(player) then
            hasAny = true
            break
        end
    end
    if not hasAny then return end

    local stacks = CurseEnergy.GetStacks()
    local sw = Isaac.GetScreenWidth() or 480
    local text = "Curse Energy: " .. tostring(stacks)
    Isaac.RenderText(text, sw / 2 - 40, 10, 180, 100, 255, 255)
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.onCurseEnergyRender)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
    CurseEnergy.ResetAll()
end)
