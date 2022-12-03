//TESH.scrollpos=117
//TESH.alwaysfold=0
function Trig_youLingChuanConditions takes nothing returns boolean
    return ((GetSpellAbilityId() == 'A17C'))
endfunction

function Trig_youLingChuanFunc014Func001Func021003003 takes nothing returns boolean
    return (((IsUnitType(GetFilterUnit(), UNIT_TYPE_HERO) == true) and ((IsUnitAliveBJ(GetFilterUnit()) == true) and ((IsUnitInGroup(GetFilterUnit(), YDLocalGet(GetExpiredTimer(), group, "gro2")) == false) and (IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(YDLocalGet(GetExpiredTimer(), unit, "chuFa"))) == false)))))
endfunction

function Trig_youLingChuanFunc014Func001Func022Func005Conditions takes nothing returns nothing
    if ((UnitHasBuffBJ(GetTriggerUnit(), 'B023') == true)) then
        call SetUnitLifeBJ( YDLocalGet(GetTriggeringTrigger(), unit, "xuanQu"), ( GetUnitState(YDLocalGet(GetTriggeringTrigger(), unit, "xuanQu"), UNIT_STATE_LIFE) + ( GetEventDamage() * 0.50 ) ) )
        call YDUserDataSet(unit, YDLocalGet(GetTriggeringTrigger(), unit, "xuanQu"), "jianShang", real, ( YDUserDataGet(unit, YDLocalGet(GetTriggeringTrigger(), unit, "xuanQu"), "jianShang", real) + ( GetEventDamage() * 0.50 ) ))
    else
        call YDLocal4Release()
        call DestroyTrigger(GetTriggeringTrigger())
    endif
endfunction

function Trig_youLingChuanFunc014Func001Func022Func006T takes nothing returns nothing
    call UnitRemoveAbility( YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), 'A17F' )
    call UnitRemoveAbility( YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), 'A17E' )
    call UnitRemoveAbility( YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), 'B023' )
    if ((( GetUnitState(YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), UNIT_STATE_LIFE) + 2.00 ) <= YDUserDataGet(unit, YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), "jianShang", real))) then
        call SetUnitLifeBJ( YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), 2.00 )
    else
        call SetUnitLifeBJ( YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), ( GetUnitState(YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), UNIT_STATE_LIFE) - YDUserDataGet(unit, YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), "jianShang", real) ) )
    endif
    call YDUserDataSet(unit, YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), "jianShang", real, 0.00)
    call YDLocal3Release()
    call DestroyTimer(GetExpiredTimer())
endfunction

function Trig_youLingChuanFunc014Func001Func022A takes nothing returns nothing
    local trigger ydl_trigger
    local timer ydl_timer
    call GroupAddUnit( YDLocalGet(GetExpiredTimer(), group, "gro2"), GetEnumUnit() )
    call UnitAddAbility( GetEnumUnit(), 'A17E' )
    call YDLocalSet(GetExpiredTimer(), unit, "xuanQu", GetEnumUnit())
    call SetPlayerAbilityAvailable( GetOwningPlayer(GetEnumUnit()), 'A17E', false )
    set ydl_trigger = CreateTrigger()
    call YDLocalSet(ydl_trigger, unit, "xuanQu", YDLocalGet(GetExpiredTimer(), unit, "xuanQu"))
    call TriggerRegisterUnitEvent( ydl_trigger, YDLocalGet(GetExpiredTimer(), unit, "xuanQu"), EVENT_UNIT_DAMAGED )
    call TriggerRegisterTimerEventSingle( ydl_trigger, 10.00 )
    call TriggerAddCondition(ydl_trigger, Condition(function Trig_youLingChuanFunc014Func001Func022Func005Conditions))
    set ydl_timer = CreateTimer()
    call YDLocalSet(ydl_timer, unit, "xuanQu", YDLocalGet(GetExpiredTimer(), unit, "xuanQu"))
    call TimerStart(ydl_timer, 10.00, false, function Trig_youLingChuanFunc014Func001Func022Func006T)
    set ydl_trigger = null
    set ydl_timer = null
endfunction

function Trig_youLingChuanFunc014T takes nothing returns nothing
    local group ydl_group
    local unit ydl_unit
    local trigger ydl_trigger
    local timer ydl_timer
    if ((IsUnitAliveBJ(YDLocalGet(GetExpiredTimer(), unit, "maJia")) == true)) then
        call SetUnitX( YDLocalGet(GetExpiredTimer(), unit, "maJia"), YDWECoordinateX(( GetLocationX(YDLocalGet(GetExpiredTimer(), location, "point3")) + ( ( 20.00 * YDLocalGet(GetExpiredTimer(), real, "ciShu") ) * CosBJ(AngleBetweenPoints(YDLocalGet(GetExpiredTimer(), location, "point3"), YDLocalGet(GetExpiredTimer(), location, "point4"))) ) )) )
        call SetUnitY( YDLocalGet(GetExpiredTimer(), unit, "maJia"), YDWECoordinateY(( GetLocationY(YDLocalGet(GetExpiredTimer(), location, "point3")) + ( ( 20.00 * YDLocalGet(GetExpiredTimer(), real, "ciShu") ) * SinBJ(AngleBetweenPoints(YDLocalGet(GetExpiredTimer(), location, "point3"), YDLocalGet(GetExpiredTimer(), location, "point4"))) ) )) )
        call YDLocalSet(GetExpiredTimer(), real, "ciShu", ( YDLocalGet(GetExpiredTimer(), real, "ciShu") + 1 ))
        call YDLocalSet(GetExpiredTimer(), location, "point5", GetUnitLoc(YDLocalGet(GetExpiredTimer(), unit, "maJia")))
        call YDLocalSet(GetExpiredTimer(), group, "gro1", GetUnitsInRangeOfLocMatching(525.00, YDLocalGet(GetExpiredTimer(), location, "point5"), Condition(function Trig_youLingChuanFunc014Func001Func021003003)))
        call ForGroupBJ( YDLocalGet(GetExpiredTimer(), group, "gro1"), function Trig_youLingChuanFunc014Func001Func022A )
    else
        call CreateNUnitsAtLoc( 1, 'e10E', YDLocalGet(GetExpiredTimer(), player, "GetTriggerPlayer"), YDLocalGet(GetExpiredTimer(), location, "point4"), AngleBetweenPoints(YDLocalGet(GetExpiredTimer(), location, "point1"), YDLocalGet(GetExpiredTimer(), location, "point2")) )
        call YDUserDataSet(unit, GetLastCreatedUnit(), "fuQin", unit, YDLocalGet(GetExpiredTimer(), unit, "chuFa"))
        call YDLocalSet(GetExpiredTimer(), unit, "maJia2", GetLastCreatedUnit())
        call UnitAddAbility( YDLocalGet(GetExpiredTimer(), unit, "maJia2"), 'A17D' )
        call SetUnitAbilityLevelSwapped( 'A17D', YDLocalGet(GetExpiredTimer(), unit, "maJia2"), GetUnitAbilityLevel(YDLocalGet(GetExpiredTimer(), unit, "chuFa"), 'A17C') )
        call IssueImmediateOrder( YDLocalGet(GetExpiredTimer(), unit, "maJia2"), "stomp" )
        call YDWETimerRemoveUnit( 2, YDLocalGet(GetExpiredTimer(), unit, "maJia2") )
        call RemoveLocation( YDLocalGet(GetExpiredTimer(), location, "point1") )
        call RemoveLocation( YDLocalGet(GetExpiredTimer(), location, "point2") )
        call RemoveLocation( YDLocalGet(GetExpiredTimer(), location, "point3") )
        call RemoveLocation( YDLocalGet(GetExpiredTimer(), location, "point4") )
        call RemoveLocation( YDLocalGet(GetExpiredTimer(), location, "point5") )
        call DestroyGroup( YDLocalGet(GetExpiredTimer(), group, "gro1") )
        call DestroyGroup( YDLocalGet(GetExpiredTimer(), group, "gro2") )
        call YDLocal3Release()
        call DestroyTimer(GetExpiredTimer())
    endif
    set ydl_group = null
    set ydl_unit = null
    set ydl_trigger = null
    set ydl_timer = null
endfunction

function Trig_youLingChuanActions takes nothing returns nothing
    local timer ydl_timer
    YDLocalInitialize()
    call YDLocal1Set(unit, "chuFa", GetTriggerUnit())
    call YDLocal1Set(location, "point1", GetUnitLoc(GetTriggerUnit()))
    call YDLocal1Set(location, "point2", GetSpellTargetLoc())
    call YDLocal1Set(location, "point3", PolarProjectionBJ(YDLocal1Get(location, "point1"), 1000.00, AngleBetweenPoints(YDLocal1Get(location, "point2"), YDLocal1Get(location, "point1"))))
    call YDLocal1Set(location, "point4", PolarProjectionBJ(YDLocal1Get(location, "point1"), 1000.00, AngleBetweenPoints(YDLocal1Get(location, "point1"), YDLocal1Get(location, "point2"))))
    call YDLocal1Set(real, "ciShu", 1.00)
    call YDLocal1Set(group, "gro2", CreateGroup())
    call DestroyEffect( AddSpecialEffectLoc("war3mapImported\\whirlpool.mdx", YDLocal1Get(location, "point4")) )
    if ((GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 1)) then
        call CreateNUnitsAtLoc( 1, 'etrs', GetOwningPlayer(YDLocal1Get(unit, "chuFa")), YDLocal1Get(location, "point3"), AngleBetweenPoints(YDLocal1Get(location, "point1"), YDLocal1Get(location, "point2")) )
    else
        if ((GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 2)) then
            call CreateNUnitsAtLoc( 1, 'udes', GetOwningPlayer(YDLocal1Get(unit, "chuFa")), YDLocal1Get(location, "point3"), AngleBetweenPoints(YDLocal1Get(location, "point1"), YDLocal1Get(location, "point2")) )
        else
            if ((GetUnitAbilityLevel(GetTriggerUnit(), GetSpellAbilityId()) == 3)) then
                call CreateNUnitsAtLoc( 1, 'uubs', GetOwningPlayer(YDLocal1Get(unit, "chuFa")), YDLocal1Get(location, "point3"), AngleBetweenPoints(YDLocal1Get(location, "point1"), YDLocal1Get(location, "point2")) )
            else
            endif
        endif
    endif
    call YDLocal1Set(unit, "maJia", GetLastCreatedUnit())
    call AddSpecialEffectTargetUnitBJ( "origin", GetLastCreatedUnit(), "Abilities\\Spells\\Items\\ClarityPotion\\ClarityTarget.mdl" )
    call YDWETimerDestroyEffect( 3.00, bj_lastCreatedEffect )
    call UnitApplyTimedLife( GetLastCreatedUnit(), 'BHwe', 3.00 )
    set ydl_timer = CreateTimer()
    call YDLocalSet(ydl_timer, player, "GetTriggerPlayer", GetTriggerPlayer())
    call YDLocalSet(ydl_timer, unit, "chuFa", YDLocal1Get(unit, "chuFa"))
    call YDLocalSet(ydl_timer, real, "ciShu", YDLocal1Get(real, "ciShu"))
    call YDLocalSet(ydl_timer, group, "gro1", YDLocal1Get(group, "gro1"))
    call YDLocalSet(ydl_timer, group, "gro2", YDLocal1Get(group, "gro2"))
    call YDLocalSet(ydl_timer, unit, "maJia", YDLocal1Get(unit, "maJia"))
    call YDLocalSet(ydl_timer, unit, "maJia2", YDLocal1Get(unit, "maJia2"))
    call YDLocalSet(ydl_timer, location, "point1", YDLocal1Get(location, "point1"))
    call YDLocalSet(ydl_timer, location, "point2", YDLocal1Get(location, "point2"))
    call YDLocalSet(ydl_timer, location, "point3", YDLocal1Get(location, "point3"))
    call YDLocalSet(ydl_timer, location, "point4", YDLocal1Get(location, "point4"))
    call YDLocalSet(ydl_timer, location, "point5", YDLocal1Get(location, "point5"))
    call YDLocalSet(ydl_timer, unit, "xuanQu", YDLocal1Get(unit, "xuanQu"))
    call TimerStart(ydl_timer, 0.03, true, function Trig_youLingChuanFunc014T)
    call YDLocal1Release()
    set ydl_timer = null
endfunction

//===========================================================================
function InitTrig_youLingChuan takes nothing returns nothing
    set udg_youLingChuan = CreateTrigger()
#ifdef DEBUG
    call YDWESaveTriggerName(udg_youLingChuan, "youLingChuan")
#endif
    call TriggerRegisterAnyUnitEventBJ( udg_youLingChuan, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition(udg_youLingChuan, Condition(function Trig_youLingChuanConditions))
    call TriggerAddAction(udg_youLingChuan, function Trig_youLingChuanActions)
endfunction

