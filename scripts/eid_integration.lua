local mod = HextechMod

if EID then
    -- ===== 白银阶 (Silver) =====
    -- L2
    EID:addCollectible(
        mod.ITEMS.BLUNTFORCE,
        "#{{Damage}} ×1.2",
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
        "#{{Tears}} +1.20",
        "灵巧",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.DEFT,
        "#{{Tears}} +1.20",
        "Hextech Deft",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.DEMATERIALIZE,
        "#击杀敌人永久+0.01{{Damage}}，无限叠加"
        .. "#多次获得提升叠加量",
        "去质",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.DEMATERIALIZE,
        "#Permanently +0.01{{Damage}} per kill, no cap"
        .. "#Multiple copies increase the amount",
        "Hextech Dematerialize",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.STATS,
        "#随机获得2项属性提升"
        .. "#{{Damage}} +1 {{Tears}} +0.7"
        .. "# 弹速+0.3 {{Range}} +2.5 {{Speed}} +0.3"
        .. "#{{Luck}} +1 {{Heart}} +1心之容器"
        .. "#高概率: 弹速/射程/移速 > 中概率: 攻击力/射速 > 低概率: 幸运/心之容器",
        "属性",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.STATS,
        "#Randomly boosts 2 stats"
        .. "#{{Damage}} +1 {{Tears}} +0.7"
        .. "# +0.3 Shot {{Range}} +2.5 {{Speed}} +0.3"
        .. "#{{Luck}} +1 {{Heart}} +1 Heart Container"
        .. "#High: Shot/Range/Speed > Med: DMG/Tears > Low: Luck/Heart",
        "Hextech Stats",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.SILVERSPOON,
        "#{{Damage}} ×（1+0.15×银汤匙数量×白银阶海克斯数量）"
        .. "#多次获得可叠加",
        "银汤匙",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.SILVERSPOON,
        "#{{Damage}} ×(1+0.15×Silver Spoon count×Silver tier items)"
        .. "#Multiple Silver Spoons stack",
        "Hextech Silver Spoon",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TYPHOON,
        "#命中敌人时发射{{Damage}} 1.00追踪飞弹"
        .. "#多次获得增加飞弹数量",
        "台风",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TYPHOON,
        "#On hit, fires a homing missile for {{Damage}} 1.00"
        .. "#Multiple copies increase missile count",
        "Hextech Typhoon",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.HOMEGUARD,
        "#5秒内不受伤则移速翻倍"
        .. "#多次获得无额外效果",
        "家园卫士",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.HOMEGUARD,
        "#Doubles speed after 5s without taking damage"
        .. "#No additional effect from multiple copies",
        "Hextech Homeguard",
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
        "#攻速锁定为0.67"
        .. "#{{Damage}} 超出/不足部分以2倍转化为攻击力"
        .. "#{{Tears}} 低于0.67会降低攻击力",
        "一板一眼",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.SLOWANDSTEADY,
        "#Locks fire rate to 0.67"
        .. "#{{Damage}} Excess/deficit converted to damage at 2x rate"
        .. "#{{Tears}} Below 0.67 reduces damage",
        "Hextech Slow and Steady",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.ITSKILLINGTIME,
        "#使用主动道具后，记录5秒内造成的伤害"
        .. "#5秒后对房间所有敌人造成40%等量伤害"
        .. "#多次获得无额外效果",
        "杀戮时间到了",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.ITSKILLINGTIME,
        "#After using active item, records damage dealt for 5s"
        .. "#After 5s, deals 40% of that damage to all enemies"
        .. "#No additional effect from multiple copies",
        "Hextech It's Killing Time",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.NIGHTHUNT,
        "#击杀敌人后，房间所有敌人混乱1.5秒"
        .. "#多次获得无额外效果",
        "夜狩",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.NIGHTHUNT,
        "#On kill, confuses all enemies for 1.5s"
        .. "#No additional effect from multiple copies",
        "Hextech Night Hunt",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.MAGICMISSILE,
        "#使用主动道具后，对每个敌人发射3枚{{Damage}} 1.00飞弹"
        .. "#多次获得增加飞弹数量",
        "魔法飞弹",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.MAGICMISSILE,
        "#On active item use, fires 3 missiles at each enemy for {{Damage}} 1.00"
        .. "#Multiple copies increase missile count",
        "Hextech Magic Missile",
        "en_us"
    )

    -- L3
    EID:addCollectible(
        mod.ITEMS.APEXINVENTOR,
        "#主动道具获得充能时额外获得1格"
        .. "#可溢出充能上限",
        "尖端发明家",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.APEXINVENTOR,
        "#Active item gains +1 extra charge whenever it gains charge"
        .. "#Can exceed charge limit",
        "Hextech Apex Inventor",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.CELESTIALBODY,
        "#+4心之容器，回复4红心，{{Damage}} ×0.8"
        .. "#多次获得可叠加",
        "星界躯体",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.CELESTIALBODY,
        "#+4 heart containers, heals 4 hearts, {{Damage}} ×0.8"
        .. "#Multiple copies stack",
        "Hextech Celestial Body",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATS,
        "#随机获得3项属性提升"
        .. "#{{Damage}} +1 {{Tears}} +0.7"
        .. "# 弹速+0.3 {{Range}} +2.5 {{Speed}} +0.3"
        .. "#{{Luck}} +1 {{Heart}} +1心之容器"
        .. "#高概率: 弹速/射程/移速 > 中概率: 攻击力/射速 > 低概率: 幸运/心之容器",
        "属性叠属性",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATS,
        "#Randomly boosts 3 stats"
        .. "#{{Damage}} +1 {{Tears}} +0.7"
        .. "# +0.3 Shot {{Range}} +2.5 {{Speed}} +0.3"
        .. "#{{Luck}} +1 {{Heart}} +1 Heart Container"
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
        .. "#{{Damage}} ×3"
        .. "#多次获得无额外效果",
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
        .. "#命中时若冷却就绪，发射4枚{{Damage}} 0.5×飞弹"
        .. "#多次获得无额外效果",
        "连拨击锤",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.FANTHEHAMMER,
        "#Each direction has a separate 6s cooldown"
        .. "#On hit, fires 4 missiles for {{Damage}} 0.5× each if ready"
        .. "#No additional effect from multiple copies",
        "Hextech Fan the Hammer",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.CANTTOUCHTHIS,
        "#使用主动道具后获得5秒无敌"
        .. "#多次获得无额外效果",
        "你摸不到",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.CANTTOUCHTHIS,
        "#5s invincibility after using an active item"
        .. "#No additional effect from multiple copies",
        "Hextech Can't Touch This",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.JEWELEDGAUNTLET,
        "#每秒变化的伤害倍率，范围1.50~2.25"
        .. "#多次获得提升0.5上限",
        "珠光护手",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.JEWELEDGAUNTLET,
        "#Damage multiplier changes every second, range 1.50~2.25"
        .. "#+0.5 to max per extra copy",
        "Hextech Jeweled Gauntlet",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.PLAGUEBEARER,
        "#进入新房间5秒后，根据敌人数量获得诅咒能量"
        .. "#每50层诅咒能量生成随机心"
        .. "#多次获得无额外效果",
        "恐惧使者",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.PLAGUEBEARER,
        "#5s after entering a new room, gain Curse Energy per enemy"
        .. "#Every 50 stacks spawns random hearts"
        .. "#No additional effect from multiple copies",
        "Hextech Plaguebearer",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.MYSTICPUNCH,
        "#15%概率命中时主动道具充能+1",
        "秘术冲拳",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.MYSTICPUNCH,
        "#15% chance on hit to add 1 charge to active item",
        "Hextech Mystic Punch",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATSONSTATS,
        "#随机获得4项属性提升"
        .. "#{{Damage}} +1 {{Tears}} +0.7"
        .. "# 弹速+0.3 {{Range}} +2.5 {{Speed}} +0.3"
        .. "#{{Luck}} +1 {{Heart}} +1心之容器"
        .. "#高概率: 弹速/射程/移速 > 中概率: 攻击力/射速 > 低概率: 幸运/心之容器",
        "属性叠属性叠属性",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.STATSONSTATSONSTATS,
        "#Randomly boosts 4 stats"
        .. "#{{Damage}} +1 {{Tears}} +0.7"
        .. "# +0.3 Shot {{Range}} +2.5 {{Speed}} +0.3"
        .. "#{{Luck}} +1 {{Heart}} +1 Heart Container"
        .. "#High: Shot/Range/Speed > Med: DMG/Tears > Low: Luck/Heart",
        "Hextech Triple Stats",
        "en_us"
    )

    EID:addCollectible(
        mod.ITEMS.TAPDANCER,
        "#每次命中+0.02移速，无上限"
        .. "#{{Timer}} 5秒未命中则重置所有层数"
        .. "#{{Tears}} 额外获得30%当前移速加成",
        "踢踏舞",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TAPDANCER,
        "#+0.02 {{Speed}} per hit, no cap"
        .. "#{{Timer}} Resets after 5s of not hitting"
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

    -- ===== 套装进度显示 =====
    local DRAGON_FLAME_SET = {
        mod.ITEMS.MAGICMISSILE,
        mod.ITEMS.FANTHEHAMMER,
        mod.ITEMS.TYPHOON,
    }
    local DRAGON_FLAME_NAMES = {
        zh_cn = "神龙赤焰",
        en_us = "Dragon Flame",
    }
    local DRAGON_FLAME_LEVELS = {
        zh_cn = {
            [2] = "(2)40% 概率触发飞弹连锁",
            [3] = "(3)70% 概率触发飞弹连锁",
            [4] = "(4)100% 概率触发飞弹连锁",
        },
        en_us = {
            [2] = "(2) 40% chain missile chance",
            [3] = "(3) 70% chain missile chance",
            [4] = "(4) 100% chain missile chance",
        },
    }

    local function getSetProgress(setItems)
        local player = Isaac.GetPlayer(0)
        if not player then return 0 end
        local count = 0
        for _, itemId in ipairs(setItems) do
            if player:GetCollectibleNum(itemId, true) > 0 then
                count = count + 1
            end
        end
        return count
    end

    local function isDragonFlameItem(itemId)
        for _, setId in ipairs(DRAGON_FLAME_SET) do
            if setId == itemId then return true end
        end
        return false
    end

    EID:addDescriptionModifier(
        "hextech_dragonflame_set",
        function(descObj)
            return descObj.ObjSubType and isDragonFlameItem(descObj.ObjSubType)
        end,
        function(descObj)
            local collected = getSetProgress(DRAGON_FLAME_SET)
            local lang = EID:getLanguage()
            local setName = DRAGON_FLAME_NAMES[lang] or DRAGON_FLAME_NAMES.en_us

            local itemId = descObj.ObjSubType
            local player = Isaac.GetPlayer(0)
            local alreadyHave = player and player:GetCollectibleNum(itemId, false) > 0

            if alreadyHave then
                local warningText = lang == "zh_cn" and "你已经有了一个同名海克斯！" or "You already have this hextech!"
                local setInfo = "\n#" .. setName .. ":"
                for i = 2, 4 do
                    local line = DRAGON_FLAME_LEVELS[lang][i] or DRAGON_FLAME_LEVELS.en_us[i]
                    setInfo = setInfo .. "\n#{{ColorGray}}" .. line .. "{{CR}}"
                end
                setInfo = setInfo .. "\n#{{ColorRed}}" .. warningText .. "{{CR}}"
                descObj.Description = descObj.Description .. setInfo
            else
                local potentialCount = collected + 1

                local setInfo = "\n#" .. setName .. ":"
                for i = 2, 4 do
                    local line = DRAGON_FLAME_LEVELS[lang][i] or DRAGON_FLAME_LEVELS.en_us[i]
                    if i == potentialCount then
                        setInfo = setInfo .. "\n#{{ColorYellow}}" .. line .. "{{CR}}"
                    else
                        setInfo = setInfo .. "\n#{{ColorGray}}" .. line .. "{{CR}}"
                    end
                end

                descObj.Description = descObj.Description .. setInfo
            end
            return descObj
        end
    )
end
