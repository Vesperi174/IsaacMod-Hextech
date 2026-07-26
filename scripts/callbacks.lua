local mod = HextechMod
local game = mod.Game

function mod:OnNewLevel()
    mod:SpawnHextechPedestals()
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevel)
