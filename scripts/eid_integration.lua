local mod = HextechMod

if EID then
    EID:addCollectible(
        mod.ITEMS.TAPDANCER,
        "#每次攻击命中敌人时获得一层{{Speed}}移速加成，"
        .. "#每层+0.02移速，无叠加上限"
        .. "#{{Timer}} 5秒内未命中敌人则重置所有层数"
        .. "#{{Tears}} 攻击速度额外获得30%当前移速加成",
        "踢踏舞",
        "zh_cn"
    )

    EID:addCollectible(
        mod.ITEMS.TAPDANCER,
        "#Gain a stack of {{Speed}} speed on each hit,"
        .. "#+0.02 speed per stack, no cap"
        .. "#{{Timer}} Resets all stacks after 5 seconds of not hitting an enemy"
        .. "#{{Tears}} +20% of current speed as fire rate",
        "Hextech Tapdancer",
        "en_us"
    )
end
