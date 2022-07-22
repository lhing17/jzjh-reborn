// 门派：雪山
// 1技能 雪山剑法：攻击随机造成前方直线上敌人冻住，并造成伤害
// 2技能 风沙莽莽
// 3技能 金乌刀法
// 毕业技能1 心法：雪花六出
// 毕业技能2 特殊：无妄神功
// 专属：雪山细剑

/*
 * 雪山剑法
 * FIXME 
 */
// function xueShanJianFaCondition takes nothing returns boolean
//     return IsUnitAliveBJ(GetFilterUnit()) and IsUnitEnemy(GetFilterUnit(), Player(0))
// endfunction

// function xueShanJianFaDizzy takes nothing returns nothing
//     local timer t = GetExpiredTimer()
//     local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 6)
//     local location loc = GetUnitLoc(GetEnumUnit())
//     call CreateNUnitsAtLoc(1, 'e000', GetOwningPlayer(u),loc,bj_UNIT_FACING)
//     call ShowUnitHide(bj_lastCreatedUnit)
//     call UnitAddAbility(bj_lastCreatedUnit,'A0DF')
//     call IssueTargetOrder(bj_lastCreatedUnit,"thunderbolt", GetEnumUnit())
//     call UnitApplyTimedLife(bj_lastCreatedUnit,1112045413,3.)
//     call RemoveLocation(loc)
//     set u = null
//     set t = null
//     set loc = null
// endfunction

// function xueShanJianFaAction takes nothing returns nothing
//     local timer t = GetExpiredTimer()
//     local integer times = LoadInteger(YDHT, GetHandleId(t), 0)
//     local real sourceX = LoadReal(YDHT, GetHandleId(t), 1)
//     local real sourceY = LoadReal(YDHT, GetHandleId(t), 2)
//     local real angle = LoadReal(YDHT, GetHandleId(t), 5)
//     local real x
//     local real y
//     local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 6)
//     local group g = null

//     set x = sourceX + 100 * times * Cos(angle * bj_DEGTORAD)
//     set y = sourceY + 100 * times * Sin(angle * bj_DEGTORAD)
//     if times < 11 then
//         call YDWETimerDestroyEffect(0.10, AddSpecialEffect("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", x, y))
//         call YDWETimerRemoveUnit( 2.00, CreateUnit(GetOwningPlayer(u), 'nhem', x, y, GetRandomDirectionDeg()))
//     elseif times > 24 and times < 35 then
//         call YDWETimerDestroyEffect(0.10, AddSpecialEffect("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", x, y))
//         set g = GetUnitsInRangeMatching(170.00, x, y, Condition(function xueShanJianFaCondition))
//         call ForGroup(g, function xueShanJianFaDizzy)
//         call DestroyGroup(g)
//     elseif times >= 35 then
//         call FlushChildHashtable(YDHT, GetHandleId(t))
//         call PauseTimer(t)
//         call DestroyTimer(t)
//     endif
//     call SaveInteger(YDHT, GetHandleId(t), 0, times + 1)
//     set g = null
//     set t = null
//     set u = null
// endfunction

// function xueShanJianFa takes nothing returns nothing
//     local timer t = CreateTimer()
//     local real sourceX = GetUnitX(GetTriggerUnit())
//     local real sourceY = GetUnitY(GetTriggerUnit())
//     local real targetX = GetSpellTargetX()
//     local real targetY = GetSpellTargetY()
//     local real angle = Atan2(targetY - sourceY, targetX - sourceX)
//     call SaveInteger(YDHT, GetHandle(t), 0, 0) // 计数35次
//     call SaveReal(YDHT, GetHandle(t), 1, sourceX)
//     call SaveReal(YDHT, GetHandle(t), 2, sourceY)
//     call SaveReal(YDHT, GetHandle(t), 5, angle)
//     call SaveUnitHandle(YDHT, GetHandle(t), 6, GetTriggerUnit())
//     call TimerStart(t, 0.02, true, function xueShanJianFaAction)
//     set t = null
// endfunction
