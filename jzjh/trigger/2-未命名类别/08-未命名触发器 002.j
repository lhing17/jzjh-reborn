//TESH.scrollpos=0
//TESH.alwaysfold=0
function Trig____________________002Actions takes nothing returns nothing
    call YDWEGeneralBounsSystemUnitSetBonus( GetTriggerUnit(), 0, 0, 300 )
    call YDWEGeneralBounsSystemUnitSetBonus( GetTriggerUnit(), 1, 0, 300 )
    call YDWEGeneralBounsSystemUnitSetBonus( GetTriggerUnit(), 3, 0, 300 )
    call YDWEGeneralBounsSystemUnitSetBonus( GetTriggerUnit(), 2, 0, 300 )
    call YDWEJumpTimer( GetTriggerUnit(), 0, 0.00, 2, 0.01, GetRandomReal(100,500) )
    call YDWEJumpTimer( GetTriggerUnit(), 0, 0.00, 2, 0.01, GetRandomReal(100,500) )
    call YDWETimerDestroyEffect( 15., AddSpecialEffectLoc("war3mapImported\\kineticfield_fx_stand.mdx", Location(0,0)))
    call YDWETimerDestroyLightning( 2, GetLastCreatedLightningBJ() )
endfunction

//===========================================================================
function InitTrig____________________002 takes nothing returns nothing
    set gg_trg____________________002 = CreateTrigger()
#ifdef DEBUG
    call YDWESaveTriggerName(gg_trg____________________002, "未命名触发器 002")
#endif
    call TriggerAddAction(gg_trg____________________002, function Trig____________________002Actions)
endfunction

