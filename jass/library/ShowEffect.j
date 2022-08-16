library ShowEffect
    // 新建特效(创建到坐标) [R]
    function AddSpecialEffectEx takes string modelName, real x, real y returns effect
        local integer i = 1 + GetPlayerId(GetLocalPlayer())
        if showEffect[i] then
            return AddSpecialEffect(modelName, x, y)
        endif
        return null
    endfunction
    // 新建特效(创建到点) [R]
    function AddSpecialEffectLocEx takes string modelName, location where returns effect
        local integer i = 1 + GetPlayerId(GetLocalPlayer())
        if showEffect[i] then
            return AddSpecialEffectLoc(modelName, where)
        endif
        return null
    endfunction
    // 新建特效(创建到单位) [R]
    function AddSpecialEffectTargetEx takes string modelName, widget targetWidget, string attachPointName returns effect
        local integer i = 1 + GetPlayerId(GetLocalPlayer())
        if showEffect[i] then
            return AddSpecialEffectTarget(modelName, targetWidget, attachPointName)
        endif
        return null
    endfunction

    function AddSpecialEffectLocBJEx takes location where, string modelName returns effect
        local integer i = 1 + GetPlayerId(GetLocalPlayer())
        if showEffect[i] then
            return AddSpecialEffectLocBJ(where, modelName)
        endif
        return null
    endfunction

    function AddSpecialEffectTargetUnitBJEx takes string attachPointName, widget targetWidget, string modelName returns effect
        local integer i = 1 + GetPlayerId(GetLocalPlayer())
        if showEffect[i] then
            return AddSpecialEffectTargetUnitBJ(attachPointName, targetWidget, modelName)
        endif
        return null
    endfunction

    // 销毁特效
    function DestroyEffectEx takes effect whichEffect returns nothing
        if whichEffect != null then
            call DestroyEffect(whichEffect)
        endif
    endfunction

endlibrary
