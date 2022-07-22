//TESH.scrollpos=26
//TESH.alwaysfold=0
function Trig_ChangeClothesConditions takes nothing returns boolean
    return (udg_vip[1+GetPlayerId(GetTriggerPlayer())]>=1)and (((GetUnitTypeId(udg_hero[1+GetPlayerId(GetTriggerPlayer())]) == 'O02H') or (GetUnitTypeId(udg_hero[1+GetPlayerId(GetTriggerPlayer())]) == 'O023') or (GetUnitTypeId(udg_hero[1+GetPlayerId(GetTriggerPlayer())]) == 'O02I')))
endfunction

function Trig_ChangeClothesActions takes nothing returns nothing
    //if udg_HuanZhuangCD[1+GetPlayerId(GetTriggerPlayer())]==false then
        //set udg_HuanZhuangCD[1+GetPlayerId(GetTriggerPlayer())]=true
        //黑变绿或粉
        if ((GetUnitTypeId(udg_hero[1+GetPlayerId(GetTriggerPlayer())]) == 'O02H')) then
            if GetRandomInt(1, 2)==1 then
                call UnitAddAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A044' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A044' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'Avul' )
            else
                call UnitAddAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A047' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A047' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'Avul' )
            endif
            //call BJDebugMsg(GetUnitName(udg_hero[1+GetPlayerId(GetTriggerPlayer())]))
        //绿变粉或黑
        elseif ((GetUnitTypeId(udg_hero[1+GetPlayerId(GetTriggerPlayer())]) == 'O02I')) then
            if GetRandomInt(1, 2)==1 then
                call UnitAddAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A045' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A045' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'Avul' )
            else
                call UnitAddAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A048' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A048' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'Avul' )
            endif
            //call BJDebugMsg(GetUnitName(udg_hero[1+GetPlayerId(GetTriggerPlayer())]))
        //粉变黑或绿
        elseif ((GetUnitTypeId(udg_hero[1+GetPlayerId(GetTriggerPlayer())]) == 'O023')) then
            if GetRandomInt(1, 2)==1 then
                call UnitAddAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A043' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A043' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'Avul' )
            else
                call UnitAddAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A046' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'A046' )
                call UnitRemoveAbility( udg_hero[1+GetPlayerId(GetTriggerPlayer())], 'Avul' )
            endif
            //call BJDebugMsg(GetUnitName(udg_hero[1+GetPlayerId(GetTriggerPlayer())]))
        endif
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 11
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            if (I7[(GetPlayerId(GetTriggerPlayer()))*20+bj_forLoopAIndex]!='AEfk')then
                call UnitAddAbility(udg_hero[1+GetPlayerId(GetTriggerPlayer())], I7[(GetPlayerId(GetTriggerPlayer()))*20+bj_forLoopAIndex])
                call SetUnitAbilityLevel(udg_hero[1+GetPlayerId(GetTriggerPlayer())], I7[(GetPlayerId(GetTriggerPlayer()))*20+bj_forLoopAIndex],LoadInteger(YDHT, GetHandleId(GetTriggerPlayer()), I7[(GetPlayerId(GetTriggerPlayer()))*20+bj_forLoopAIndex]*5) )
            endif
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
        //call YDWEPolledWaitNull(300.)
        //set udg_HuanZhuangCD[1+GetPlayerId(GetTriggerPlayer())]=false
    //else
        //call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "换装功能CD中")
    //endif
endfunction

//===========================================================================
function InitTrig_ChangeClothes takes nothing returns nothing
    set gg_trg_ChangeClothes = CreateTrigger()
#ifdef DEBUG
    call YDWESaveTriggerName(gg_trg_ChangeClothes, "ChangeClothes")
#endif
    call TriggerRegisterPlayerChatEvent( gg_trg_ChangeClothes, Player(0), "换装", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ChangeClothes, Player(1), "换装", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ChangeClothes, Player(2), "换装", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ChangeClothes, Player(3), "换装", true )
    call TriggerRegisterPlayerChatEvent( gg_trg_ChangeClothes, Player(4), "换装", true )
    call TriggerAddCondition(gg_trg_ChangeClothes, Condition(function Trig_ChangeClothesConditions))
    call TriggerAddAction(gg_trg_ChangeClothes, function Trig_ChangeClothesActions)
endfunction

