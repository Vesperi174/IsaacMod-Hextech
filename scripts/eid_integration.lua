local mod = HextechMod

if EID then
    -- ===== 白银阶 (Silver) =====
    -- L2
    EID:addCollectible(
        mod.ITEMS.BLUNTFORCE,
        "#攻击力 ×1.2",
        "大力",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.BLUNTFORCE,
        "#{{Damage}} ×1.2",
        "Hextech Blunt Force",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.DEFT,
        "#{{Tears}} 攻击速度+1.20",
        "灵巧",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.DEFT,
        "#{{Tears}} +1.20 fire rate",
        "Hextech Deft",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.DEMATERIALIZE,
        "#击杀敌人永久+0.01{{Damage}} 攻击力，无限叠加"
        .. "#多个去质提升每次击杀的叠加量",
        "去质",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.DEMATERIALIZE,
        "#Permanently +0.01{{Damage}} damage per enemy kill, no cap"
        .. "#Multiple copies increase the amount per kill",
        "Hextech Dematerialize",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.STATS,
        "#随机获得2项属性提升"
        .. "#{{Damage}} 攻击力+1 {{Tears}} 射速+0.7"
        .. "# 弹速+0.3 {{Range}} 射程+2.5 {{Speed}} 移速+0.3"
        .. "#{{Luck}} 幸运+1 {{Heart}} 空的心之容器+1"
        .. "#高概率: 弹速/射程/移速 > 中概率: 攻击力/射速 > 低概率: 幸运/心之容器",
        "属性",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.STATS,
        "#Randomly boosts 2 stats"
        .. "#{{Damage}} +1 DMG {{Tears}} +0.7 Tears"
        .. "# +0.3 Shot {{Range}} +2.5 Range {{Speed}} +0.3 Speed"
        .. "#{{Luck}} +1 Luck {{Heart}} +1 Empty Heart"
        .. "#High: Shot/Range/Speed > Med: DMG/Tears > Low: Luck/Heart",
        "Hextech Stats",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.SILVERSPOON,
        "#{{Damage}} 攻击力×（1+0.15×银汤匙数量×拥有的白银阶海克斯数量）"
        .. "#多个银汤匙可叠加，白银阶海克斯数量越多倍率越高",
        "银汤匙",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.SILVERSPOON,
        "#{{Damage}} ×(1+0.15×Silver Spoon count×total Silver tier items owned)"
        .. "#Multiple Silver Spoons stack, more Silver tier items = higher multiplier",
        "Hextech Silver Spoon",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TYPHOON,
        "#命中敌人时向该目标发射{{Damage}} 1.00伤害的追踪飞弹"
        .. "#多拿增加飞弹数量",
        "台风",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TYPHOON,
        "#On hit, fires a homing missile at the target dealing {{Damage}} 1.00 damage"
        .. "#Multiple copies increase missile count",
        "Hextech Typhoon",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TRANSMUTEGOLD,
        "#随机获得一个黄金阶海克斯道具",
        "质变：黄金阶",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TRANSMUTEGOLD,
        "#grants a random Gold tier hextech item",
        "Hextech Transmute Gold",
        "en_us"
    )

    -- ===== 黄金阶 (Gold) =====
    -- L2
    EID:addCollectible(
        mod.ITEMS.SLOWANDSTEADY,
        "#攻击速度锁定为0.67"
        .. "#{{Damage}} 超出/不足部分以2倍转化为攻击力加成/削减"
        .. "#{{Tears}} 低于0.67攻速会降低攻击力",
        "一板一眼",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.SLOWANDSTEADY,
        "#Locks fire rate to 0.67"
        .. "#{{Damage}} Excess/deficit converted to damage at 2x rate"
        .. "#{{Tears}} Fire rate below 0.67 reduces damage",
        "Hextech Slow and Steady",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.ITSKILLINGTIME,
        "#使用主动道具后，记录接下来5秒内对敌人造成的伤害"
        .. "#5秒后，对房间内所有敌人造成等量伤害"
        .. "#多次获取无额外效果",
        "杀戮时间到了",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.ITSKILLINGTIME,
        "#After using an active item, records damage dealt to enemies for 5 seconds"
        .. "#After 5 seconds, deals that damage to all enemies in the room"
        .. "#No additional effect from multiple copies",
        "Hextech It's Killing Time",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.NIGHTHUNT,
        "#击杀敌人后，房间内所有敌人混乱1.5秒"
        .. "#多个夜狩无额外效果",
        "夜狩",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.NIGHTHUNT,
        "#On kill, confuses all enemies in the room for 1.5 seconds"
        .. "#No additional effect from multiple copies",
        "Hextech Night Hunt",
        "en_us"
    )

    -- L3
    EID:addCollectible(
        mod.ITEMS.APEXINVENTOR,
        "#主动道具获得充能时额外获得1格充能"
        .. "#此法获得的能量可以溢出",
        "尖端发明家",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.APEXINVENTOR,
        "#Active item gains 1 extra charge whenever it gains charge"
        .. "#This bonus charge can exceed the charge limit",
        "Hextech Apex Inventor",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.CELESTIALBODY,
        "#获得4个心之容器，回复4红心，{{Damage}} 伤害倍率×0.8"
        .. "#多次获取无额外效果",
        "星界躯体",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.CELESTIALBODY,
        "#+4 heart containers, heals 4 hearts, {{Damage}} damage ×0.8"
        .. "#No additional effect from multiple copies",
        "Hextech Celestial Body",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATS,
        "#随机获得3项属性提升"
        .. "#{{Damage}} 攻击力+1 {{Tears}} 射速+0.7"
        .. "# 弹速+0.3 {{Range}} 射程+2.5 {{Speed}} 移速+0.3"
        .. "#{{Luck}} 幸运+1 {{Heart}} 空的心之容器+1"
        .. "#高概率: 弹速/射程/移速 > 中概率: 攻击力/射速 > 低概率: 幸运/心之容器",
        "属性叠属性",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATS,
        "#Randomly boosts 3 stats"
        .. "#{{Damage}} +1 DMG {{Tears}} +0.7 Tears"
        .. "# +0.3 Shot {{Range}} +2.5 Range {{Speed}} +0.3 Speed"
        .. "#{{Luck}} +1 Luck {{Heart}} +1 Empty Heart"
        .. "#High: Shot/Range/Speed > Med: DMG/Tears > Low: Luck/Heart",
        "Hextech Double Stats",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TRANSMUTEPRISMATIC,
        "#随机获得一个棱彩阶海克斯道具",
        "质变：棱彩阶",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TRANSMUTEPRISMATIC,
        "#grants a random Prismatic tier hextech item",
        "Hextech Transmute Prismatic",
        "en_us"
    )

    -- ===== 棱彩阶 (Prismatic) =====
    -- L4
    EID:addCollectible(
        mod.ITEMS.BACKTOBASICS,
        "#禁用主动道具、饰品、药丸和卡牌"
        .. "#攻击力 ×3"
        .. "#多次获取无额外效果",
        "回归基本功",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.BACKTOBASICS,
        "#Disables active items, trinkets, pills, and cards"
        .. "#Damage ×3"
        .. "#No additional effect from multiple copies",
        "Hextech Back to Basics",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.FANTHEHAMMER,
        "#四个方向各有独立6秒冷却"
        .. "#命中时若该方向冷却就绪，发射4枚{{Damage}} 0.5×攻击力伤害的飞弹"
        .. "#多个连拨击锤无额外效果",
        "连拨击锤",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.FANTHEHAMMER,
        "#Each of 4 directions has a separate 6s cooldown"
        .. "#On hit, if that direction is ready, fires 4 missiles dealing {{Damage}} 0.5× damage each"
        .. "#No additional effect from multiple copies",
        "Hextech Fan the Hammer",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.CANTTOUCHTHIS,
        "#使用主动道具后获得5秒无敌"
        .. "#多个你摸不到无额外效果",
        "你摸不到",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.CANTTOUCHTHIS,
        "#After using an active item, gain 5 seconds of invincibility"
        .. "#No additional effect from multiple copies",
        "Hextech Can't Touch This",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.JEWELEDGAUNTLET,
        "#获得每秒变化的伤害倍率，范围为1.50~2.25"
        .. "#每多一个提升0.5倍率上限",
        "珠光护手",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.JEWELEDGAUNTLET,
        "#Grants a damage multiplier that changes every second, range 1.50~2.25"
        .. "#+0.5 to multiplier range per extra copy",
        "Hextech Jeweled Gauntlet",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.MYSTICPUNCH,
        "#命中敌人时有15%概率为主动道具充能1格",
        "秘术冲拳",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.MYSTICPUNCH,
        "#15% chance on hit to add 1 charge to your active item",
        "Hextech Mystic Punch",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATSONSTATS,
        "#随机获得4项属性提升"
        .. "#{{Damage}} 攻击力+1 {{Tears}} 射速+0.7"
        .. "# 弹速+0.3 {{Range}} 射程+2.5 {{Speed}} 移速+0.3"
        .. "#{{Luck}} 幸运+1 {{Heart}} 空的心之容器+1"
        .. "#高概率: 弹速/射程/移速 > 中概率: 攻击力/射速 > 低概率: 幸运/心之容器",
        "属性叠属性叠属性",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATSONSTATS,
        "#Randomly boosts 4 stats"
        .. "#{{Damage}} +1 DMG {{Tears}} +0.7 Tears"
        .. "# +0.3 Shot {{Range}} +2.5 Range {{Speed}} +0.3 Speed"
        .. "#{{Luck}} +1 Luck {{Heart}} +1 Empty Heart"
        .. "#High: Shot/Range/Speed > Med: DMG/Tears > Low: Luck/Heart",
        "Hextech Triple Stats",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TAPDANCER,
        "#每次攻击命中敌人时+0.02移速，无叠加上限"
        .. "#{{Timer}} 5秒内未命中敌人则重置所有层数"
        .. "#{{Tears}} 攻击速度额外获得30%当前移速加成",
        "踢踏舞",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TAPDANCER,
        "#Gain +0.02 {{Speed}} speed on each hit, no cap"
        .. "#{{Timer}} Resets all stacks after 5 seconds of not hitting an enemy"
        .. "#{{Tears}} +30% of current speed as fire rate",
        "Hextech Tapdancer",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TRANSMUTECHAOS,
        "#随机获得两个海克斯道具，品质随机",
        "质变：混沌",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TRANSMUTECHAOS,
        "#grants 2 random hextech items of any tier",
        "Hextech Transmute Chaos",
        "en_us"
    )
end
