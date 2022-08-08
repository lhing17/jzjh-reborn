// 1技能 银针飞花：向前方射出三道激光，造成大量伤害
// 毕业技能2 特殊：碧玉丹 +神木王鼎 和炼丹系统结合 可以使最劣的酒变成一等一的佳酿
// 阵法：九宫八卦阵
// 毕业技能1 心法：六合经
// 专属1：子午砂 攻击时深度中毒
// 专属2：观音泪
// 2技能 漫天花雨
// 3技能 烟雨夺魂

globals
    real array biYuAddition // 碧玉丹技能永久加成
    integer array liuHeFlag // 玩家是否判断存在六合经
endglobals

/*
* 技能：银针飞花
* 技能效果：主动施放，无目标，向角色前方射出三道激光，造成大量伤害
* 技能伤害：w1 = 30, w2 = 30
* 技能搭配：
* + 碧海潮声曲 致盲
* + 冰魄银针 激光所到之处会激活冰魄银针的效果
* + 斗转星移 伤害+ 90 %
* + 双手互搏 向角色前方射出六道激光
* + 小无相功 伤害+ 150 %
*/
function isYinZhen takes nothing returns boolean
    return GetSpellAbilityId() == 'A098'
endfunction

function yinZhenAction takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer max = LoadInteger(YDHT, GetHandleId(t), 0)
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 1)
    local integer j = LoadInteger(YDHT, GetHandleId(t), 2)
    local real angle = 0
    local location source = null
    local location target = null
    local real range = 1000
    if j < max then
        call SaveInteger(YDHT, GetHandleId(t), 2, j + 1)
        set angle = GetUnitFacing(u)
        set source = GetUnitLoc(u)
        set target = PolarProjectionBJ(source, range, angle)
        call CreateNUnitsAtLoc(1, 'e000', GetOwningPlayer(u), source, bj_UNIT_FACING)
        call ShowUnitHide(bj_lastCreatedUnit)
        call UnitAddAbility(bj_lastCreatedUnit, 'A099')
        call IssuePointOrderByIdLoc(bj_lastCreatedUnit, $D00FA, target)
        call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 3)
        call PolledWait(0.2)
        if GetUnitAbilityLevel(u, 'A07A') >= 1 then
            call CreateNUnitsAtLoc(1, 'e000', GetOwningPlayer(u), target, bj_UNIT_FACING)
            call ShowUnitHide(bj_lastCreatedUnit)
            call UnitAddAbility(bj_lastCreatedUnit, 'A07A')
            call IssueImmediateOrderById(bj_lastCreatedUnit, $D00D9)
            call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 3)
        endif
        call RemoveLocation(source)
        call RemoveLocation(target)
    else
        call FlushChildHashtable(YDHT, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endif
    set t = null
    set source = null
    set target = null
endfunction

function yinZhen takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer i = 1
    local integer max = 3
    local timer t = CreateTimer()
    
    call WuGongShengChong(u, 'A098', 250.)
    // + 双手互搏 向前射出六道激光
    if GetUnitAbilityLevel(u, 'A07U') >= 1 then
        set max = 6
    endif
    call SaveInteger(YDHT, GetHandleId(t), 0, max)
    call SaveUnitHandle(YDHT, GetHandleId(t), 1, u)
    call SaveInteger(YDHT, GetHandleId(t), 2, 0)
    call TimerStart(t, 0.2, true, function yinZhenAction)
   
    set t = null
    set u = null
endfunction

function isYinZhenDamage takes nothing returns boolean
    return GetEventDamage() == 0.92
endfunction

function yinZhenDamage takes nothing returns nothing
    local unit u = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real shxishu = 1
    local real shanghai = 0.
    if((GetUnitAbilityLevel(u, 'A07Q') != 0))then // 斗转星移
        set shxishu = shxishu + 0.9
    endif
    if((GetUnitAbilityLevel(u, 'A083') != 0))then // 加小无相功
        set shxishu = shxishu + 1.5
    endif
    if((GetUnitAbilityLevel(u, 'A018') != 0))then // 加碧海潮生曲 致盲
        call WanBuff(u, target, 15)
    endif

    // 专属加成
    // 子午砂
    if UnitHasDenomWeapon(u, 'I0EP') then
        set shxishu = shxishu * 2.0
    endif
    // 观音泪
    if UnitHasDenomWeapon(u, 'I0EQ') then
        set shxishu = shxishu * 3.0
    endif
    set shanghai = ShangHaiGongShi(u, target, 60, 60, shxishu, 'A098')
    call WuGongShangHai(u, target, shanghai)
endfunction

/*
* 技能：漫天花雨
* 技能效果：被动攻击施放，向角色周围1300范围内随机施放一枚导弹（模型可换）
* 技能伤害：w1 = 80, w2 = 90
* 技能搭配：
* + 双手互搏 额外发射一枚导弹
* + 冰魄银针 几率在导弹所到之处激活冰魄银针的效果
* + 葵花宝典 伤害+ 90 %
* + 六合经 破防
*/ 
function isManTian takes nothing returns boolean
    return PassiveWuGongCondition(GetAttacker(), GetTriggerUnit(), 'A09A')
endfunction

function manTianCondition takes nothing returns boolean
    return DamageFilter(GetAttacker(), GetFilterUnit())
endfunction

function manTian takes nothing returns nothing
    local unit u = GetAttacker()
    local unit ut = GetTriggerUnit()
    local unit target = null
    local unit dummy = null
    local group g = null
    local player p = GetOwningPlayer(u)
    local integer i = 1 + GetPlayerId(p)
    local integer j = 1
    local integer max = 4
    local real range = 1300
    if GetRandomInt(1, 100) < 15 + fuyuan[i] / 5 then
        call WuGongShengChong(u, 'A09A', 900.)
        // 双手互搏 双倍导弹
        if GetUnitAbilityLevel(u, 'A07U') >= 1 then
            set max = 8
        endif
        loop
            exitwhen j > max
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), range, Condition(function manTianCondition))
            set target = GroupPickRandomUnit(g)
            set dummy = CreateUnit(p, 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
            call ShowUnitHide(dummy)
            call UnitAddAbility(dummy, 'A09B')
            call IssueTargetOrderById( dummy, $D007F, target )
            call UnitApplyTimedLife(dummy, 'BHwe', 3)
            call DestroyGroup(g)
            call PolledWait(0.2)
            if GetUnitAbilityLevel(u, 'A07A') >= 1 and GetRandomInt(1, 100) <= 15 then
                set dummy = CreateUnit(p, 'e000', GetUnitX(target), GetUnitY(target), bj_UNIT_FACING)
                call ShowUnitHide(dummy)
                call UnitAddAbility(dummy, 'A07A')
                call IssueImmediateOrderById(dummy, $D00D9)
                call UnitApplyTimedLife(dummy, 'BHwe', 3)
            endif
            set j = j + 1
        endloop
    endif
    set u = null
    set ut = null
    set target = null
    set g = null
    set dummy = null
    set p = null
endfunction

function isManTianDamage takes nothing returns boolean
    return GetEventDamage() == 0.93
endfunction

function manTianDamage takes nothing returns nothing
    local unit u = udg_hero[1 + GetPlayerId(GetOwningPlayer(GetEventDamageSource()))]
    local unit target = GetTriggerUnit()
    local real shxishu = 1
    local real shanghai = 0.
    if((GetUnitAbilityLevel(u, 'A07T') != 0))then // 葵花宝典
        set shxishu = shxishu + 0.9
    endif
    if((GetUnitAbilityLevel(u, 'A0B6') != 0))then // 加六合经 破防
        call WanBuff(u, target, 9)
    endif
    // 子午砂
    if UnitHasDenomWeapon(u, 'I0EP') then
        set shxishu = shxishu * 2.0
    endif
    // 观音泪
    if UnitHasDenomWeapon(u, 'I0EQ') then
        set shxishu = shxishu * 3.0
    endif


    set shanghai = ShangHaiGongShi(u, target, 160, 180, shxishu, 'A09A')
    if GetUnitAbilityLevel(u, 'A0B3') != 0 then
        set shanghai = ShangHaiGongShi(u, target, 800, 900, shxishu, 'A0B3')
    endif
    call WuGongShangHai(u, target, shanghai)
endfunction


/*
* 技能：烟雨夺魂
* 技能效果：向角色周围区域施放烟雾，使周围敌人混乱并受到持续伤害，自己迅速移动到目标位置（冲刺）
* 技能伤害：w1 = 100, w2 = 100
* 技能搭配：
* + 双手互搏 在冲刺目标处也施放烟雨夺魂
* + 小无相功 触发被动烟雨夺魂，不冲刺
* + 擒龙控鹤 冲刺速度增加100 %
* + 七伤拳 伤害+ 150 %
*/ 
function isDuoHun takes nothing returns boolean
    return GetSpellAbilityId() == 'A0B0'
endfunction

function duoHun takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local real x = GetSpellTargetX()
    local real y = GetSpellTargetY()
    local real distance = SquareRoot((x - GetUnitX(u)) * (x - GetUnitX(u)) + (y - GetUnitY(u)) * (y - GetUnitY(u)))
    local real angle = Atan2BJ(y - GetUnitY(u), x - GetUnitX(u))
    local real speed = 1200
    // 向周围施放烟雾
    local unit dummy = CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
    if (GetUnitAbilityLevel(u, 'A03V') >= 1 ) then // +擒龙控鹤 冲刺速度加倍
        set speed = speed * 2
    endif
    call ShowUnitHide(dummy)
    call UnitAddAbility(dummy, 'A09C')
    call IssuePointOrderById( dummy, $D0208, GetUnitX(u), GetUnitY(u) )
    call UnitApplyTimedLife(dummy, 'BHwe', 3)
    // 向目标方向冲刺
    call YDWETimerPatternRushSlide( u, angle, distance, distance / speed, 0.03, 0, false, false, true, "origin", "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl", "Objects\\Spawnmodels\\Undead\\ImpaleTargetDust\\ImpaleTargetDust.mdl" )

    // 武功升重
    call WuGongShengChong(u, 'A0B0', 200.)

    call PolledWait(distance / 1000)
    if (GetUnitAbilityLevel(u, 'A07U') >= 1 ) then // +双手 在目标位置也施放烟雾
        set dummy = CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
        call ShowUnitHide(dummy)
        call UnitAddAbility(dummy, 'A09C')
        call IssuePointOrderById( dummy, $D0208, GetUnitX(u), GetUnitY(u) )
        call UnitApplyTimedLife(dummy, 'BHwe', 3)
    endif
    set u = null
    set dummy = null
endfunction

function isDuoHunPassive takes nothing returns boolean
    return GetUnitAbilityLevel(GetAttacker(), 'A0B0') >= 1 and GetUnitAbilityLevel(GetAttacker(), 'A083') >= 1 and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetAttacker()))
endfunction

function duoHunPassive takes nothing returns nothing
    local unit u = GetAttacker()
    local real distance = 1000
    local real angle = GetUnitFacing(u)
    local real speed = 1200
    local unit dummy = null
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    if GetRandomInt(1, 100) <= 15 + fuyuan[i] / 5 then
        // 向周围施放烟雾
        set dummy = CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
        if (GetUnitAbilityLevel(u, 'A03V') >= 1 ) then // +擒龙控鹤 冲刺速度加倍
            set speed = speed * 2
        endif
        call ShowUnitHide(dummy)
        call UnitAddAbility(dummy, 'A09C')
        call IssuePointOrderById( dummy, $D0208, GetUnitX(u), GetUnitY(u) )
        call UnitApplyTimedLife(dummy, 'BHwe', 3)
    endif

    set u = null
    set dummy = null
endfunction

function isDuoHunDamage takes nothing returns boolean
    return GetEventDamage() == 2.01
endfunction

function duoHunDamage takes nothing returns nothing
    local unit u = GetEventDamageSource()
    local unit target = GetTriggerUnit()
    local real shxishu = 1
    local real shanghai = 0.
    if((GetUnitAbilityLevel(u, 'A07M') != 0))then // 七伤拳
        set shxishu = shxishu + 1.5
    endif
    call WanBuff(u, target, 4)
    // 子午砂
    if UnitHasDenomWeapon(u, 'I0EP') then
        set shxishu = shxishu * 2.0
    endif
    // 观音泪
    if UnitHasDenomWeapon(u, 'I0EQ') then
        set shxishu = shxishu * 3.0
    endif
    set shanghai = ShangHaiGongShi(u, target, 100, 100, shxishu, 'A0B0')
    call WuGongShangHai(u, target, shanghai)
endfunction



/*
* 技能：六合经
* 技能效果：每10秒切换一种人物状态
* 疾：移速 经脉相关
* 猛：爆伤 根骨相关
* 迅：攻速 福缘相关
* 盾：防御 医术相关
* 绝：绝学 悟性相关
* 霸：伤害 胆魄相关
* 技能伤害：
* 技能搭配：
*/

function liuHeCondition takes nothing returns boolean
    return GetSpellAbilityId() == 'A0B6'
endfunction

function removeLiuHeState takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
    call UnitRemoveAbility(u, 'A00S')
    call PauseTimer(t)
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction

function liuHeAction takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    local integer key = $FFAFBF + i
    local integer which = LoadInteger(YDHT, key, 1) // 上一次随机到的项
    local real oldSpeed = LoadReal(YDHT, key, 2)
    local real oldSpeed2 = GetUnitMoveSpeedEx(u) - LoadReal(YDHT, key, 3)
    local real critical = LoadReal(YDHT, key, 4)
    local integer profound = LoadInteger(YDHT, key, 5)
    local real addition = LoadReal(YDHT, key, 6)
    local integer j = GetRandomInt(1, 6)
    local timer t = null
    // 清除上一次的状态
    if which == 1 then //移速
        call SetUnitMoveSpeed(u, RMaxBJ(RMinBJ(oldSpeed, oldSpeed2), 350.))
    elseif which == 2 then //爆伤
        set	udg_baojishanghai[i] = udg_baojishanghai[i] - critical
    elseif which == 3 then //攻速
        call UnitRemoveAbility(u, 'A0DB')
    elseif which == 4 then // 最大护甲
        call UnitRemoveAbility(u, 'A00S')
    elseif which == 5 then
        set	juexuelingwu[i] = juexuelingwu[i] - profound
    elseif which == 6 then
        set	udg_shanghaijiacheng[i] = udg_shanghaijiacheng[i] - addition
    endif

    // 增加本次的状态
    call SaveInteger(YDHT, key, 1, j)
    call SetUnitAbilityLevel(u, 'A0B4', j)
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl", u, "overhead"))
    if j == 1 then
        call SetUnitMoveSpeed(u, RMinBJ(GetUnitMoveSpeedEx(u) + jingmai[i] * 20, 1400))
        call SaveReal(YDHT, key, 2, GetUnitMoveSpeedEx(u))
        call SaveReal(YDHT, key, 3, jingmai[i] * 20)
    elseif j == 2 then
        set critical = 0.1 * gengu[i]
        call SaveReal(YDHT, key, 4, critical)
        set udg_baojishanghai[i] = udg_baojishanghai[i] + critical
    elseif j == 3 then
        call UnitAddAbility(u, 'A0DB')
        call SetUnitAbilityLevel(u, 'A0DB', IMinBJ(1 + fuyuan[i] / 20, 10))
    elseif j == 4 then
        call UnitAddAbility(u, 'A00S')
        set t = CreateTimer()
        call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
        call TimerStart(t, 10, false, function removeLiuHeState)
    elseif j == 5 then
        set profound = wuxing[i]
        call SaveInteger(YDHT, key, 5, profound)
        set	juexuelingwu[i] = juexuelingwu[i] + profound
    elseif j == 6 then
        set addition = 0.1 * danpo[i]
        call SaveReal(YDHT, key, 6, addition)
        set	udg_shanghaijiacheng[i] = udg_shanghaijiacheng[i] + addition
    endif
    call PolledWait(0.2)
    // 双手或小无相功的搭配
    if GetUnitAbilityLevel(u, 'A07U') >= 1 then
        call EXSetAbilityState(EXGetUnitAbility(u, 'A0B6'), 1, EXGetAbilityState(EXGetUnitAbility(u, 'A0B6'), 1) - 5)
    endif
    if GetUnitAbilityLevel(u, 'A083') >= 1 then
        call EXSetAbilityState(EXGetUnitAbility(u, 'A0B6'), 1, EXGetAbilityState(EXGetUnitAbility(u, 'A0B6'), 1) - 5)
    endif
    set u = null
    set t = null
endfunction

function liuHe takes nothing returns nothing
    local integer i = 1
    local timer t = null
    loop
        exitwhen i > 5
        if liuHeFlag[i] == 0 and GetUnitAbilityLevel(udg_hero[i], 'A0B6') >= 1 then
            set liuHeFlag[i] = 1
            call UnitAddAbility(udg_hero[i], 'A0B5' )
            call SetPlayerAbilityAvailable( GetOwningPlayer(udg_hero[i]), 'A0B5', false )
        endif
        set i = i + 1
    endloop
    set t = null
endfunction

/*
* 技能：碧玉丹
* 技能效果：群体伤害技能
* 技能伤害：w1 = 200, w2 = 200
* 技能搭配：
* 持有神木王鼎或炼丹师：伤害+ 200 %
* 医术：伤害
* 炼制丹药：每炼制一次伤害永久提升50 %
* 深度中毒：伤害+ 200 %
*/

function isBiYuDan takes nothing returns boolean
    return PassiveWuGongCondition(GetAttacker(), GetTriggerUnit(), 'A0B1')
endfunction

function biYuCondition takes nothing returns boolean
	return DamageFilter(GetAttacker(), GetFilterUnit())
endfunction

function biYuAction takes nothing returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(GetAttacker()))
	local real shxishu = (1. + I2R(yishu[i]) / 15.) * ( 1 + biYuAddition[i])
	// +深度中毒
	if UnitHasBuffBJ(GetEnumUnit(), 'B01J') then
		set shxishu = shxishu + 2.0
	endif
	// 神木王鼎或炼丹师
	if UnitHaveItem(GetAttacker(), 'I0AM') or Deputy_isDeputy(i, LIAN_DAN) then
        set shxishu = shxishu + 2.0
    endif
    // 搜魂侠加成
    if isTitle(i, 36) then
        set shxishu = shxishu * 2
    endif
    // 子午砂
    if UnitHasDenomWeapon(GetAttacker(), 'I0EP') then
        set shxishu = shxishu * 2.0
    endif
    // 观音泪
    if UnitHasDenomWeapon(GetAttacker(), 'I0EQ') then
        set shxishu = shxishu * 3.0
    endif
    call WuGongShangHai(GetAttacker(), GetEnumUnit(), ShangHaiGongShi(GetAttacker(), GetEnumUnit(), 200, 200, shxishu, 'A0B1'))
endfunction

function biYuDan takes nothing returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(GetAttacker()))
    local location loc = GetUnitLoc(GetAttacker())
    local unit dummy = null
    local group g = null
    if (GetRandomInt(1, 100) <= fuyuan[i] / 5 + 18) then
        set dummy = CreateUnit(GetOwningPlayer(GetAttacker()), 'e000', GetUnitX(GetAttacker()), GetUnitY(GetAttacker()), bj_UNIT_FACING)
        call ShowUnitHide(dummy)
        call UnitAddAbility(dummy, 'A0B2')
        call IssuePointOrderById( dummy, $D02AC, GetUnitX(GetAttacker()), GetUnitY(GetAttacker()) )
        call UnitApplyTimedLife(dummy, 'BHwe', 3)
        call PolledWait(0.3)

        set g = YDWEGetUnitsInRangeOfLocMatchingNull(800, loc, Condition(function biYuCondition))
        call ForGroup(g, function biYuAction)
        call DestroyGroup(g)
        call WuGongShengChong(GetAttacker(), 'A0B1', 700)
    endif
    call RemoveLocation(loc)
    set loc = null
    set dummy = null
    set g = null
endfunction

function isGuanYinLei takes nothing returns boolean
    return UnitHaveItem(GetAttacker(), 'I0EQ')
endfunction

function guanYinLei takes nothing returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(GetAttacker()))
    // 观音泪攻击深度中毒
    if GetRandomInt(1, 100) <= 15 + fuyuan[i] / 5 then
        call WanBuff(GetAttacker(), GetTriggerUnit(), 14)
    endif
endfunction

function tangMenTrigger takes nothing returns nothing
    local trigger t = CreateTrigger()
    local integer i = 1
    loop
        exitwhen i > 5
        // 初始化碧玉丹技能永久加成
        set biYuAddition[i] = 0
        // 初始化六合经标识
        set liuHeFlag[i] = 0
        set i = i + 1
    endloop

    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function isYinZhen))
    call TriggerAddAction(t, function yinZhen)

    set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddCondition(t, Condition(function isYinZhenDamage))
    call TriggerAddAction(t, function yinZhenDamage)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t, Condition(function isManTian))
    call TriggerAddAction(t, function manTian)

    set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddCondition(t, Condition(function isManTianDamage))
    call TriggerAddAction(t, function manTianDamage)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function isDuoHun))
    call TriggerAddAction(t, function duoHun)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t, Condition(function isDuoHunPassive))
    call TriggerAddAction(t, function duoHunPassive)

    set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddCondition(t, Condition(function isDuoHunDamage))
    call TriggerAddAction(t, function duoHunDamage)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t, Condition(function isBiYuDan))
    call TriggerAddAction(t, function biYuDan)

    set t = CreateTrigger()
    call TriggerRegisterTimerEventPeriodic(t, 1.)
    call TriggerAddAction(t, function liuHe)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function liuHeCondition))
    call TriggerAddAction(t, function liuHeAction)

    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t, Condition(function isGuanYinLei))
    call TriggerAddAction(t, function guanYinLei)

    set t = null

endfunction