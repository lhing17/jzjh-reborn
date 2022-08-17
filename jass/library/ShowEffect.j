library ShowEffect initializer initShowEffect
    globals 

        force showEffectForce = CreateForce()
        constant string BLANK = ""
    endglobals
    

    function initShowEffect takes nothing returns nothing
        local integer LoopA = 0
        loop
            exitwhen LoopA > 11
            call ForceAddPlayer(showEffectForce, Player(LoopA))
            set LoopA = LoopA + 1
        endloop
	endfunction

endlibrary

// 新建特效(创建到坐标) [R]
function AddSpecialEffectEx takes string modelName, real x, real y returns effect
    local string z = BLANK
    if IsPlayerInForce(GetLocalPlayer(), showEffectForce) then
        set z = modelName
    endif
    return AddSpecialEffect(z, x, y)
endfunction
// 新建特效(创建到点) [R]
function AddSpecialEffectLocEx takes string modelName, location where returns effect
    local string z = BLANK
    if IsPlayerInForce(GetLocalPlayer(), showEffectForce) then
        set z = modelName
    endif
    return AddSpecialEffectLoc(z, where)
endfunction
// 新建特效(创建到单位) [R]
function AddSpecialEffectTargetEx takes string modelName, widget targetWidget, string attachPointName returns effect
    local string z = BLANK
    if IsPlayerInForce(GetLocalPlayer(), showEffectForce) then
        set z = modelName
    endif
    return AddSpecialEffectTarget(z, targetWidget, attachPointName)
endfunction

function AddSpecialEffectLocBJEx takes location where, string modelName returns effect
    local string z = BLANK
    if IsPlayerInForce(GetLocalPlayer(), showEffectForce) then
        set z = modelName
    endif
    return AddSpecialEffectLocBJ( where, z)
endfunction

function AddSpecialEffectTargetUnitBJEx takes string attachPointName, widget targetWidget, string modelName returns effect
    local string z = BLANK
    if IsPlayerInForce(GetLocalPlayer(), showEffectForce) then
        set z = modelName
    endif
    return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget,z )
endfunction

// 销毁特效
function DestroyEffectEx takes effect whichEffect returns nothing
    call DestroyEffect(whichEffect)
endfunction

