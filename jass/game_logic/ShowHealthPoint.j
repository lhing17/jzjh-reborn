// 展示BOSS血量

globals
    boolean array showHint
endglobals

function showHealthPointAction takes nothing returns nothing
    local integer i = 1 + GetPlayerId(GetTriggerPlayer())
    if showHint[i] and IsUnitEnemy(GetTriggerUnit(), GetTriggerPlayer()) and GetUnitState(GetTriggerUnit(), UNIT_STATE_MAX_LIFE) >= 999999 then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "单位"+GetUnitName(GetTriggerUnit())+"|r的血量为"+R2S(GetWidgetLife(GetTriggerUnit()))+" / " + R2S(GetUnitState(GetTriggerUnit(), UNIT_STATE_MAX_LIFE)))
    endif
    if showHint[i] and LoadReal(YDHT, GetHandleId(GetTriggerUnit()), $FED) > 0 then
        call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "单位"+GetUnitName(GetTriggerUnit())+"|r的护盾百分比为"+R2S(LoadReal(YDHT, GetHandleId(GetTriggerUnit()), $FED))+" %")
    endif
endfunction

function toggleHint takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local string s = GetEventPlayerChatString()

    if s == "qxts" then
        call DisplayTextToPlayer(p, 0, 0, "|cffffff00取消血量提示")
        set showHint[1 + GetPlayerId(p)] = false
    endif

    if s == "kqts" then
        call DisplayTextToPlayer(p, 0, 0, "|cffffff00开启血量提示")
        set showHint[1 + GetPlayerId(p)] = true
    endif

    if s == "maxDiff" and udg_isTest[GetPlayerId(p)] then
        set udg_nandu = 8
        call DisplayTextToPlayer(p, 0, 0, "|cffffff00难度设置为8")
    endif
    set p = null
endfunction

function showHealthPoint takes nothing returns nothing
    local trigger t = CreateTrigger()
    local integer i = 1
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SELECTED)
    call TriggerAddAction(t, function showHealthPointAction)
    loop
        exitwhen i > 5
        set showHint[i] = true
        set  i = i + 1
    endloop
	set i = 0
	loop
		exitwhen i > 6
		call TriggerRegisterPlayerChatEvent(t,Player(i),"",true)
		set i = i + 1
	endloop
	call TriggerAddAction(t,function toggleHint)
endfunction

