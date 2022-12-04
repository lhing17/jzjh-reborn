//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig_ZeiGeConditions takes nothing returns boolean
    return (((GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER) and (IsUnitType(GetTriggerUnit(), UNIT_TYPE_HERO) == true)))
endfunction

function Trig_ZeiGeActions takes nothing returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
    if ((GetRandomInt(1, 10) == 5)) then
        call DisplayTextToPlayer( GetOwningPlayer(GetTriggerUnit()), 0, 0, "你不错！" )
        set udg_listen_zeige[i] = udg_listen_zeige[i] + 1
        if udg_listen_zeige[i] == 3 then
            call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF00B2玩家" + GetPlayerName(GetOwningPlayer(GetTriggerUnit())) + "解锁了|CFF00FF00彩蛋：贼哥的教诲，|CFFFF00B2获得10点福缘")
            set fuyuan[i] = fuyuan[i] + 10
        endif
    endif
endfunction

//===========================================================================
function InitTrig_ZeiGe takes nothing returns nothing
    set gg_trg_ZeiGe = CreateTrigger()
#ifdef DEBUG
    call YDWESaveTriggerName(gg_trg_ZeiGe, "ZeiGe")
#endif
    call TriggerRegisterEnterRectSimple( gg_trg_ZeiGe, gg_rct______________000 )
    call TriggerAddCondition(gg_trg_ZeiGe, Condition(function Trig_ZeiGeConditions))
    call TriggerAddAction(gg_trg_ZeiGe, function Trig_ZeiGeActions)
endfunction

