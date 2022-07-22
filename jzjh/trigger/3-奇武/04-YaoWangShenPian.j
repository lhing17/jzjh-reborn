//TESH.scrollpos=2
//TESH.alwaysfold=0
function Trig_YaoWangShenPianConditions takes nothing returns boolean
    return ((GetSpellAbilityId() == 'A03W'))
endfunction

function Trig_YaoWangShenPianFunc003001003 takes nothing returns boolean
    return ((IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) == true))
endfunction

function Trig_YaoWangShenPianFunc003Func006T takes nothing returns nothing
    local unit u = LoadUnitHandle(YDHT, GetHandleId(GetExpiredTimer()), 0)
    if (((GetUnitLifePercent(u) > 1.00) and (UnitHasBuffBJ(u, 'BUsl') == true))) then
        call SetUnitLifePercentBJ( u, ( GetUnitLifePercent(u) - 0.5 ) )
    else        
        call DestroyTimer(GetExpiredTimer())
    endif
endfunction

function Trig_YaoWangShenPianFunc003A takes nothing returns nothing
    local timer ydl_timer
    call CreateNUnitsAtLoc( 1, 'e000', GetOwningPlayer(GetTriggerUnit()), GetUnitLoc(GetEnumUnit()), bj_UNIT_FACING )
    call UnitAddAbility( GetLastCreatedUnit(), 'A03X' )
    call ShowUnitHide( GetLastCreatedUnit() )
    call UnitApplyTimedLife( GetLastCreatedUnit(), 'BHwe', 3.00 )
    call IssueTargetOrderById( GetLastCreatedUnit(), 852227, GetEnumUnit() )
    set ydl_timer = CreateTimer()
    call SaveUnitHandle(YDHT, GetHandleId(ydl_timer), 0, GetEnumUnit())
    call TimerStart(ydl_timer, 1.00, true, function Trig_YaoWangShenPianFunc003Func006T)
    set ydl_timer = null
endfunction

function Trig_YaoWangShenPianActions takes nothing returns nothing
    local real range = 900
    if ((GetUnitAbilityLevel(GetTriggerUnit(), 'A07A') != 0)) then
        set range = 1300
    endif
    call ForGroupBJ( GetUnitsInRangeOfLocMatching(range, GetUnitLoc(GetTriggerUnit()), Condition(function Trig_YaoWangShenPianFunc003001003)), function Trig_YaoWangShenPianFunc003A )
    
endfunction

//===========================================================================
function InitTrig_YaoWangShenPian takes nothing returns nothing
    set gg_trg_YaoWangShenPian = CreateTrigger()
#ifdef DEBUG
    call YDWESaveTriggerName(gg_trg_YaoWangShenPian, "YaoWangShenPian")
#endif
    call TriggerRegisterAnyUnitEventBJ( gg_trg_YaoWangShenPian, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition(gg_trg_YaoWangShenPian, Condition(function Trig_YaoWangShenPianConditions))
    call TriggerAddAction(gg_trg_YaoWangShenPian, function Trig_YaoWangShenPianActions)
endfunction

