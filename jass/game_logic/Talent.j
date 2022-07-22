// 天赋系统

globals
    integer array udg_talent
    constant integer MAX_TALENT_NUM = 7
endglobals

function addTalent takes nothing returns nothing
    local integer i = 1
    local integer j = 0
    loop
        exitwhen i > 5
        if udg_talent[i] == 0 and talent_flag[i] == 1 then
            if udg_hero[i] != null then
                set j = GetRandomInt(1, MAX_TALENT_NUM)
                call UnitAddAbility(udg_hero[i], 'A08M')
                call SetPlayerAbilityAvailable(Player(i-1), 'A08M', false)
                // call DisplayTextToPlayer(Player(i-1), 0, 0, "随机到天赋"+I2S(j))
                set udg_talent[i] = j
                call SetUnitAbilityLevel(udg_hero[i], 'A08L', j)
            endif
        endif
        set i = i + 1
    endloop
endfunction

function talentAction takes nothing returns nothing
    local integer i = 1
    loop
        exitwhen i > 5
        if udg_talent[i] == 2 then
            set fuyuan[i] = fuyuan[i] + 2 + bigTalent[i]
        elseif udg_talent[i] == 3 then
            set jingmai[i] = jingmai[i] + 2 + bigTalent[i]
        elseif udg_talent[i] == 4 then
            set wuxing[i] = wuxing[i] + 2 + bigTalent[i]
        elseif udg_talent[i] == 5 then
            set gengu[i] = gengu[i] + 2 + bigTalent[i]
        elseif udg_talent[i] == 6 then
            call AdjustPlayerStateBJ(5000 + 5000 * bigTalent[i], Player(i-1), PLAYER_STATE_RESOURCE_GOLD)
            call AdjustPlayerStateBJ(20 + 20 * bigTalent[i], Player(i-1), PLAYER_STATE_RESOURCE_LUMBER)
        endif
        set i = i + 1
    endloop

endfunction


function reserveVips takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local integer i = 1 + GetPlayerId(GetTriggerPlayer())
    if StringHash(s) == 1661513981 then
       set testVersion = true
       set udg_isTest[i-1] = true
    endif
endfunction
function talent takes nothing returns nothing
    local timer tm = CreateTimer()
    local timer tm2 = CreateTimer()
    local trigger t = CreateTrigger()
    local integer i = 1
    loop
        exitwhen i > 5
        set udg_talent[i] = 0
        set i = i + 1
    endloop
    call TimerStart(tm2, 1, true, function addTalent)
    call TimerStart(tm, 120, true, function talentAction)
	set i = 0
	loop
		exitwhen i > 6
		call TriggerRegisterPlayerChatEvent(t,Player(i),"",true)
		set i = i + 1
	endloop
	call TriggerAddAction(t,function reserveVips)
	set t = null
    set tm = null
    set tm2 = null
endfunction