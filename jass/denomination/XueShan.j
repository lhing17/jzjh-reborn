// 门派：雪山
// 1技能 雪山剑法：攻击随机造成前方直线上敌人冻住，并造成伤害
// 2技能 风沙莽莽
// 3技能 金乌刀法
// 毕业技能1 心法：雪花六出
// 毕业技能2 特殊：无妄神功
// 专属：雪山细剑
globals
    integer array wuwang_status
endglobals

function xueShanJianFa takes unit attacker, unit target returns nothing
    // 伤害系数
    local real coefficient = 1
    local real damage = 0
    local real range = 500
    local group g = CreateGroup()
    local real x = GetUnitX(attacker)
    local real y = GetUnitY(attacker)
    local unit enumUnit = null

    // 连城剑法加成
    if GetUnitAbilityLevel(attacker, 'A06J') > 0 then
        set coefficient = coefficient + 0.8
    endif

    // 罗汉伏魔功加成
    if GetUnitAbilityLevel(attacker, 'A07O') > 0 then
        set coefficient = coefficient + 0.8
    endif

    // 专属加成
    if UnitHasDenomWeapon(attacker, 'I0EZ') then
        set coefficient = coefficient * 4
    endif

    // 太玄经增加范围
    if GetUnitAbilityLevel(attacker, 'A0D8') > 0 then
        set range = range + 700
    endif

    call GroupEnumUnitsInRange(g, x, y, range, null)
    loop
        set enumUnit = FirstOfGroup(g)
        exitwhen enumUnit == null
        if IsUnitEnemy(enumUnit, GetOwningPlayer(attacker)) and IsUnitAliveBJ(enumUnit) then
            // 冰魄银针冰冻敌人
            if GetUnitAbilityLevel(attacker, 'A07A') > 0 then
                call WanBuff(attacker, enumUnit, 17)
            endif
            // 雪山剑法伤害
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Blizzard\\BlizzardTarget.mdl", enumUnit, "overhead"))
            set damage = ShangHaiGongShi(attacker, enumUnit, 15, 15, coefficient, XUE_SHAN_JIAN_FA)
            call WuGongShangHai(attacker, enumUnit, damage)
        endif
        call GroupRemoveUnit(g, enumUnit)
    endloop

    call WuGongShengChong(attacker, XUE_SHAN_JIAN_FA, 600)

    call DestroyGroup(g)
    set g = null
    set enumUnit = null
endfunction

function fengShaMangMang takes unit u returns nothing
    local player p = GetOwningPlayer(u)
    local real angle = 0
    local real x = 0
    local real y = 0
    local unit dummy = null
    local real lifetime = 0
    local integer i = 1
    local integer pId = GetPlayerId(p) + 1
    loop
        exitwhen i > 18
        set angle = i * 20
        set x = 350 * CosBJ(angle) * CosBJ(angle) * CosBJ(angle)
        set y = 350 * SinBJ(angle) * SinBJ(angle) * SinBJ(angle)
        set dummy = CreateUnit(p, 'e01M', GetUnitX(udg_hero[pId]) + x, GetUnitY(udg_hero[pId]) + y, 270)
        call IssueImmediateOrderById(dummy, $D00D1)
        if GetUnitAbilityLevel(udg_hero[pId], 'A07O') > 0 then
            set lifetime = 20
        else
            set lifetime = 10
        endif
        call UnitApplyTimedLife(dummy, 'BHwe', lifetime)

        // 太玄经 +攻速光环
        if GetUnitAbilityLevel(udg_hero[pId], 'A0D8') > 0 then
            set dummy = CreateUnit(p, 'e000', GetUnitX(udg_hero[pId]) + x, GetUnitY(udg_hero[pId]) + y, 270)
            call UnitAddAbility(dummy, 'A0F3')
            call ShowUnit(dummy, false)
            call UnitApplyTimedLife(dummy, 'BHwe', lifetime)
        endif
        set i = i + 1
    endloop

    call WuGongShengChong(u, FENG_SHA_MANG_MANG, 120)
    set dummy = null
    set p = null
endfunction

function fengShaMangMangDamage takes unit hero, unit target returns nothing
    local real coefficient = 1
    local real damage = 0
    local player p = GetOwningPlayer(hero)

    // 连城剑法加成
    if GetUnitAbilityLevel(hero, 'A06J') > 0 then
        set coefficient = coefficient + 0.7
    endif

    // 化骨绵掌加成
    if GetUnitAbilityLevel(hero, 'A06L') > 0 then
        set coefficient = coefficient + 0.8
    endif

    // 专属加成
    if UnitHasDenomWeapon(hero, 'I0EZ') then
        set coefficient = coefficient * 4
    endif

    set damage = ShangHaiGongShi(hero, target, 130, 150, coefficient, FENG_SHA_MANG_MANG)
    call WuGongShangHai(hero, target, damage)

    // 20%冰冻敌人
    if GetRandomInt(1, 100) <= 20 then
        call WanBuff(hero, target, 17)
    endif

    set p = null
endfunction

function jinWuDaoFa takes unit source, unit target returns nothing
    // 伤害系数
    local real coefficient = 1
    local real damage = 0
    local real range = 800
    local group g = CreateGroup()
    local real x = GetUnitX(source)
    local real y = GetUnitY(source)
    local unit enumUnit = null

    // 弹指神通加成
    if GetUnitAbilityLevel(source, 'A06H') > 0 then
        set coefficient = coefficient + 0.8
    endif

    // 罗汉伏魔功加成
    if GetUnitAbilityLevel(source, 'A07O') > 0 then
        set coefficient = coefficient + 0.8
    endif

    // 专属加成
    if UnitHasDenomWeapon(source, 'I0EZ') then
        set coefficient = coefficient * 4
    endif

    // 太玄经加成
    if GetUnitAbilityLevel(source, 'A0D8') > 0 then
        set coefficient = coefficient + 1.2
    endif

    call GroupEnumUnitsInRange(g, x, y, range, null)
    loop
        set enumUnit = FirstOfGroup(g)
        exitwhen enumUnit == null
        if IsUnitEnemy(enumUnit, GetOwningPlayer(source)) and IsUnitAliveBJ(enumUnit) then
            // 吸星大法造成重伤
            if GetUnitAbilityLevel(source, 'A06R') > 0 then
                call WanBuff(source, enumUnit, 6)
            endif

            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\firecut.mdx", enumUnit, "origin"))
            set damage = ShangHaiGongShi(source, enumUnit, 60, 60, coefficient, JIN_WU_DAO_FA)
            call WuGongShangHai(source, enumUnit, damage)
        endif
        call GroupRemoveUnit(g, enumUnit)
    endloop

    call WuGongShengChong(source, JIN_WU_DAO_FA, 720)

    call DestroyGroup(g)
    set g = null
    set enumUnit = null
endfunction

function xueHuaTaiXuan takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
    local real angle = LoadReal(YDHT, GetHandleId(t), 1)
    local integer j = LoadInteger(YDHT, GetHandleId(t), 2)
    local real x = 0
    local real y = 0
    if j > 200 then
        call FlushChildHashtable(YDHT, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    else
        call SaveInteger(YDHT, GetHandleId(t), 2, j + 1)
        call SetUnitX(u, GetUnitX(u) + 5 * CosBJ(angle))
        call SetUnitY(u, GetUnitY(u) + 5 * SinBJ(angle))
    endif
    set u = null
    set t = null
endfunction

function xueHuaLiuChu takes unit u returns nothing
    local player p = GetOwningPlayer(u)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local integer i = 1
    local unit dummy = null
    local timer t = null

    
    call WuGongShengChong(u, XUE_HUA_LIU_CHU, 120)
    
    loop
        exitwhen i > 6 
        set dummy = CreateUnit(p, 'e000', x, y, 270)
        call UnitAddAbility(dummy, 'A0EV')
        call ShowUnit(dummy, false)
        call IssuePointOrderById(dummy, $D00FA, x + 300 * CosBJ(60 * i), y + 300 * SinBJ(60 * i))
        call UnitApplyTimedLife(dummy, 'BHwe', 3)
        set i = i + 1
    endloop

    // 太玄经冲锋效果
    if GetUnitAbilityLevel(u, 'A0D8') > 0 then
        set t = CreateTimer()
        call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
        call SaveReal(YDHT, GetHandleId(t), 1, GetUnitFacing(u))
        call SaveInteger(YDHT, GetHandleId(t), 2, 0)
        call TimerStart(t, 0.01, true, function xueHuaTaiXuan)
    endif

    if GetUnitAbilityLevel(u, SHUANG_SHOU) > 0 then
        call YDWEPolledWaitNull(0.3)
        loop
            exitwhen i > 6 
            set dummy = CreateUnit(p, 'e000', x, y, 270)
            call UnitAddAbility(dummy, 'A0EV')
            call ShowUnit(dummy, false)
            call IssuePointOrderById(dummy, $D00FA, x + 300 * CosBJ(60 * i), y + 300 * SinBJ(60 * i))
            call UnitApplyTimedLife(dummy, 'BHwe', 3)
            set i = i + 1
        endloop
    endif


    set t = null
    set dummy = null
    set p = null
endfunction

function xueHuaLiChuDamage takes unit hero, unit target returns nothing
    local real coefficient = 1
    local real damage = 0
    local player p = GetOwningPlayer(hero)

    // 弹指神通加成
    if GetUnitAbilityLevel(hero, 'A06H') > 0 then
        set coefficient = coefficient + 0.8
    endif

    // 罗汉伏魔功加成
    if GetUnitAbilityLevel(hero, 'A07O') > 0 then
        set coefficient = coefficient + 0.9
    endif

    // 专属加成
    if UnitHasDenomWeapon(hero, 'I0EZ') then
        set coefficient = coefficient * 4
    endif

    set damage = ShangHaiGongShi(hero, target, 300, 500, coefficient, XUE_HUA_LIU_CHU)
    call WuGongShangHai(hero, target, damage)

    set p = null
endfunction

function wuWangShenGongEnd takes nothing returns nothing 
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)

    call UnitRemoveAbility(u, 'Agho')
    set wuwang_status[1 + GetPlayerId(GetOwningPlayer(u))] = 0

    call FlushChildHashtable(YDHT, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
    set u = null
    set t = null
endfunction

function wuWangShenGong takes unit u returns nothing
    local player p = GetOwningPlayer(u)
    local real time = GetUnitAbilityLevel(u, WU_WANG_SHEN_GONG) * 2
    local timer t = CreateTimer()
    call UnitAddAbility(u, 'Agho')
    set wuwang_status[1 + GetPlayerId(p)] = 1
    call WuGongShengChong(u, WU_WANG_SHEN_GONG, 60)
    call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
    call TimerStart(t, time, false, function wuWangShenGongEnd)
    set t = null
    set p = null
endfunction

function wuWangShenGongSpecial takes unit attacker, unit target returns nothing
    local player p = GetOwningPlayer(attacker)
    local integer i = 1 + GetPlayerId(p)
    local integer rand = 0

    call AdjustPlayerStateBJ(100 + GetRandomInt(1, 100), p, PLAYER_STATE_RESOURCE_GOLD)
    call WanBuff(attacker, target, 17)

    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl", attacker, "overhead"))

    if GetRandomInt(1, 100) <= 15 then
        call AdjustPlayerStateBJ(1, p, PLAYER_STATE_RESOURCE_LUMBER)
        // 小无相 几率永久增加暴击伤害
        if GetUnitAbilityLevel(attacker, 'A083') > 0 then
            set udg_baojishanghai[i] = udg_baojishanghai[i] + 0.01
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl", attacker, "overhead"))
        endif

        // 易筋经 几率永久增加六围
        if GetUnitAbilityLevel(attacker, 'A09D') > 0 then
            set rand = GetRandomInt(1, 6)
            if rand == 1 then
                set wuxing[i] = wuxing[i] + 1
            elseif rand == 2 then
                set gengu[i] = gengu[i] + 1
            elseif rand == 3 then
                set fuyuan[i] = fuyuan[i] + 1
            elseif rand == 4 then
                set danpo[i] = danpo[i] + 1
            elseif rand == 5 then
                set jingmai[i] = jingmai[i] + 1
            elseif rand == 6 then
                set yishu[i] = yishu[i] + 1
            endif
            call DestroyEffect(AddSpecialEffectTarget("war3mapImported\\frozenarmor.mdx", attacker, "overhead"))
        endif

        // 太玄经 几率永久增加内力
        if GetUnitAbilityLevel(attacker, 'A0D8') > 0 then
            call ModifyHeroStat(1, attacker, 0, 10)
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectCaster.mdl", attacker, "overhead"))
        endif
    endif

    set p = null
endfunction


function initXueShan takes nothing returns nothing
    local integer i = 1
    loop
        exitwhen i > 5
        set wuwang_status[i] = 0
        set i = i + 1
    endloop
endfunction

