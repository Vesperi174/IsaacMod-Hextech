local mod = HextechMod
local game = mod.Game

local CHARGE_PER_ITEM = 1

local prevCharges = {}

function mod:onApexInventorUpdate(player)
    local count = player:GetCollectibleNum(mod.ITEMS.APEXINVENTOR)
    if count <= 0 then
        prevCharges[player.ControllerIndex] = nil
        return
    end

    local idx = player.ControllerIndex
    if not prevCharges[idx] then
        prevCharges[idx] = {}
    end

    for i = 0, 3 do
        local activeItem = player:GetActiveItem(i)
        if activeItem > 0 then
            local currentCharge = player:GetActiveCharge(i)
            local prev = prevCharges[idx][i]

            if prev ~= nil and currentCharge > prev then
                local bonus = CHARGE_PER_ITEM * count
                player:SetActiveCharge(currentCharge + bonus, i)
                prevCharges[idx][i] = currentCharge + bonus
            else
                prevCharges[idx][i] = currentCharge
            end
        else
            prevCharges[idx][i] = nil
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.onApexInventorUpdate)
