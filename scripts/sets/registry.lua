local mod = HextechMod

-- 套装注册表：定义套装名称和包含的道具
mod.SETS = {
    DragonFlame = {
        name = "Dragon Flame",
        items = {
            mod.ITEMS.MAGICMISSILE,
            mod.ITEMS.FANTHEHAMMER,
            mod.ITEMS.TYPHOON,
            mod.ITEMS.DOUBLETAP,
            mod.ITEMS.BULLETHEAVEN,
        },
    },
    ExplosionArt = {
        name = "Explosion is Art",
        items = {
            mod.ITEMS.HITMEPULL,
        },
    },
    DiceRoller = {
        name = "Dice Roller",
        items = {
            mod.ITEMS.STATS,
            mod.ITEMS.STATSONSTATS,
            mod.ITEMS.STATSONSTATSONSTATS,
            mod.ITEMS.TRANSMUTEGOLD,
            mod.ITEMS.TRANSMUTEPRISMATIC,
            mod.ITEMS.TRANSMUTECHAOS,
        },
    },
}
