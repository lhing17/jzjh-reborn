//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig____________________005Conditions takes nothing returns boolean
    return ((UnitHasItemOfTypeBJ(GetTriggerUnit(), 'texp') == true))
endfunction

function Trig____________________005Actions takes nothing returns nothing
    call YDWENewItemsFormula( 'I099', 1, 'I09A', 1, 'I09P', 1, 'ches', 0, 'ches', 0, 'ches', 0, 'I09C' )
    call SelectHeroSkill( gg_unit_N007_0055, 'AHbz' )
endfunction

//===========================================================================
function InitTrig____________________005 takes nothing returns nothing
    //set gg_trg____________________005 = CreateTrigger()
#ifdef DEBUG
    //call YDWESaveTriggerName(gg_trg____________________005, "未命名触发器 005")
#endif
    //call YDWESyStemItemCombineRegistTrigger( gg_trg____________________005 )
    //call TriggerAddCondition(gg_trg____________________005, Condition(function Trig____________________005Conditions))
    //call TriggerAddAction(gg_trg____________________005, function Trig____________________005Actions)
endfunction

