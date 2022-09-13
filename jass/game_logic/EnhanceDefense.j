// 怪物和BOSS提升防御
// 难七下怪物增加防御力，BOSS增加对数盾

function isUnitAttacker takes integer id returns boolean
    local integer i = 1
    loop
        exitwhen i > 28
        if id == y7[i] then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function isUnitAttackerBoss takes integer id returns boolean
    local integer i = 1
    loop
        exitwhen i > 8
        if id == u7[i] then
            return true
        endif
        set i = i + 1
    endloop
    return false
endfunction

function doEnhanceDefense takes nothing returns nothing
    local unit u = GetEnteringUnit()
    local integer id = GetUnitTypeId(u)
    if udg_nandu >= 6 and isUnitAttacker(id) then
		call YDWEGeneralBounsSystemUnitSetBonus(u,2,0, udg_boshu * udg_boshu * 5)
    endif
    if udg_nandu >= 6 and isUnitAttackerBoss(id) then
        call SaveEffectHandle(YDHT, GetHandleId(u), $DEF, AddSpecialEffectTargetEx("war3mapImported\\DefensiveBarrierBig.mdx", u, "chest"))
        call SaveReal(YDHT, GetHandleId(u), $FED, 100)
    endif
    set u = null
endfunction

// 对数盾减伤
function shieldReduceDamage takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer boss_index = 0
    local real loss = 0
    // 需要剔除小伤害
    if LoadReal(YDHT, GetHandleId(u), $FED) > 0 and GetEventDamage() > 50 then
        set boss_index = (udg_boshu - 1) / 4 + 1
        // call BJDebugMsg(R2S(YDWELogarithmLg(GetEventDamage())))
        set loss = Pow(2,YDWELogarithmLg(GetEventDamage())) * 100 / Pow(2, 9 + boss_index)
        call EXSetEventDamage(0)
        call SaveReal(YDHT, GetHandleId(u), $FED, LoadReal(YDHT, GetHandleId(u), $FED) - loss)
    endif
    if LoadReal(YDHT, GetHandleId(u), $FED) <= 0 then
        call DestroyEffectEx(LoadEffectHandle(YDHT, GetHandleId(u), $DEF))
    endif
    set u = null
endfunction

function enhanceDefense takes nothing returns nothing
    local region r = CreateRegion()
    local trigger t = CreateTrigger()
    call RegionAddRect(r, bj_mapInitialPlayableArea)
    call TriggerRegisterEnterRegion(t, r, null)
    call TriggerAddAction(t, function doEnhanceDefense)

    set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddAction(t, function shieldReduceDamage)
    set r = null
    set t = null
endfunction