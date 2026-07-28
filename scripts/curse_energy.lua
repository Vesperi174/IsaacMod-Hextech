local mod = HextechMod

mod.CurseEnergy = {}
local CurseEnergy = mod.CurseEnergy

CurseEnergy.relatedItems = {}

CurseEnergy.stacks = {}

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

function CurseEnergy.GetStacks(player)
    local idx = player.ControllerIndex
    return CurseEnergy.stacks[idx] or 0
end

function CurseEnergy.SetStacks(player, amount)
    local idx = player.ControllerIndex
    CurseEnergy.stacks[idx] = math.max(0, amount)
end

function CurseEnergy.AddStacks(player, amount)
    local idx = player.ControllerIndex
    CurseEnergy.stacks[idx] = (CurseEnergy.stacks[idx] or 0) + amount
end

function CurseEnergy.ResetStacks(player)
    CurseEnergy.stacks[player.ControllerIndex] = 0
end

function CurseEnergy.ResetAll()
    CurseEnergy.stacks = {}
end

function mod:onCurseEnergyRender()
    local game = Game()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if not player then goto continue end
        if not CurseEnergy.HasRelatedItem(player) then goto continue end

        local stacks = CurseEnergy.GetStacks(player)

        local sw = Isaac.GetScreenWidth() or 480
        local yOffset = 10 + i * 16
        local text = "P" .. (i + 1) .. " Curse Energy: " .. tostring(stacks)
        Isaac.RenderText(text, sw / 2 - 40, yOffset, 180, 100, 255, 255)

        ::continue::
    end
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.onCurseEnergyRender)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
    CurseEnergy.ResetAll()
end)
