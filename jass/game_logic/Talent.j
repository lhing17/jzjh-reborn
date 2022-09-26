// 天赋系统

globals
    integer array udg_talent
    constant integer MAX_TALENT_NUM = 7


    // 天赋树相关等级
    // 攻击天赋 三围->暴击->特攻
    // 攻击天赋-特攻
    integer array talent_special_attack
    // 攻击天赋-暴击倍数
    integer array talent_critical_attack
    // 攻击天赋-三围
    integer array talent_three_attribute

    // 防御天赋 护甲->回血->伤害吸收上限
    // 防御天赋-护甲
    integer array talent_armor
    //  防御天赋-伤害吸收上限
    integer array talent_damage_absorption
    // 防御天赋-回血
    integer array talent_recover_hp

    // 资源天赋 金币->声望->木材/六围
    // 资源天赋-金币
    integer array talent_gold
    // 资源天赋-木材
    integer array talent_lumber
    // 资源天赋-声望
    integer array talent_reputation
    // 资源天赋-六围
    integer array talent_six_attribute


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
                call SetPlayerAbilityAvailable(Player(i - 1), 'A08M', false)
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
            call commonAddGold( Player(i - 1), 5000 + 5000 * bigTalent[i])
            call commonAddLumber( Player(i - 1), 20 + 20 * bigTalent[i])
        endif
        set i = i + 1
    endloop

endfunction


function reserveVips takes nothing returns nothing
    local string s = GetEventPlayerChatString()
    local integer i = 1 + GetPlayerId(GetTriggerPlayer())
    if StringHash(s) == 1661513981 then
        set testVersion = true
        set udg_isTest[i - 1] = true
    endif
endfunction

function setTalentAttr takes nothing returns nothing
    local integer i = 1
    loop
        exitwhen i > 5
        set special_attack[i] = special_attack[i] + talent_special_attack[i] * 2
        set udg_baojishanghai[i] = udg_baojishanghai[i] + talent_critical_attack[i] * 0.1
        set max_damage_absorb[i] = max_damage_absorb[i] + talent_damage_absorption[i] * 0.02
        if talent_six_attribute[i] >= 1 then
            set wuxing[i] = wuxing[i] + 2
        elseif talent_six_attribute[i] >= 2 then
            set gengu[i] = gengu[i] + 2
        elseif talent_six_attribute[i] >= 3 then
            set jingmai[i] = jingmai[i] + 2
        elseif talent_six_attribute[i] >= 4 then
            set danpo[i] = danpo[i] + 2
        elseif talent_six_attribute[i] >= 5 then
            set yishu[i] = yishu[i] + 2
        endif
        set i = i + 1
    endloop
    call DestroyTimer(GetExpiredTimer())
endfunction


function talent takes nothing returns nothing
    local timer tm = CreateTimer()
    local timer tm2 = CreateTimer()
    local timer tm3 = CreateTimer()
    local trigger t = CreateTrigger()
    local integer i = 1
    loop
        exitwhen i > 5
        set udg_talent[i] = 0

        set talent_special_attack[i] = 0
        set talent_critical_attack[i] = 0
        set talent_three_attribute[i] = 0

        set talent_armor[i] = 0
        set talent_damage_absorption[i] = 0
        set talent_recover_hp[i] = 0

        set talent_gold[i] = 0
        set talent_lumber[i] = 0
        set talent_reputation[i] = 0
        set talent_six_attribute[i] = 0

        set i = i + 1
    endloop
    call TimerStart(tm2, 1, true, function addTalent)
    call TimerStart(tm, 120, true, function talentAction)
    call TimerStart(tm3, 1, false, function setTalentAttr)
	set i = 0
	loop
		exitwhen i > 6
		call TriggerRegisterPlayerChatEvent(t, Player(i), "", true)
		set i = i + 1
	endloop
	call TriggerAddAction(t, function reserveVips)
	set t = null
    set tm = null
    set tm2 = null
    set tm3 = null
endfunction