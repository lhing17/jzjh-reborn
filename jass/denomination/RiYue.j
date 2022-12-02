// 日月神教
// 1技能：日月太极拳
// 2技能：神教宝训
// 3技能：天魔拳
// 4技能：吸星神掌
// 5技能：葵花心法

globals
    // 加入吸星派还是葵花派
    integer array joinSunOrMoon 
    integer array joinSunPoint
    integer array joinMoonPoint
    // 加入吸星派
    constant integer JOIN_SUN = 1
    // 加入葵花派
    constant integer JOIN_MOON = 2
endglobals

// 1技能：日月太极拳
function riYueTaiJi takes unit u returns nothing
    local real facing = GetUnitFacing(u)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local real targetX = x + 200 * CosBJ(facing)
    local real targetY = y + 200 * SinBJ(facing)
    local unit dummy = CreateUnit(GetOwningPlayer(u), 'e000', x, y, facing)
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    call ShowUnitHide(dummy)
    call UnitAddAbility(dummy, 'A0FI')
    call IssuePointOrderById( dummy, $D00FA, targetX, targetY )
    call UnitApplyTimedLife(dummy, 'BHwe', 3)
    call WuGongShengChong(u, RI_YUE_TAI_JI_QUAN, 800.)

    // 吸星派效果：额外两道波
    if joinSunOrMoon[i] == JOIN_SUN then
        set targetX = x + 200 * CosBJ(facing + 30)
        set targetY = y + 200 * SinBJ(facing + 30)
        set dummy = CreateUnit(GetOwningPlayer(u), 'e000', x, y, facing)
        call ShowUnitHide(dummy)
        call UnitAddAbility(dummy, 'A0FI')
        call IssuePointOrderById( dummy, $D00FA, targetX, targetY )
        call UnitApplyTimedLife(dummy, 'BHwe', 3)

        set targetX = x + 200 * CosBJ(facing - 30)
        set targetY = y + 200 * SinBJ(facing - 30)
        set dummy = CreateUnit(GetOwningPlayer(u), 'e000', x, y, facing)
        call ShowUnitHide(dummy)
        call UnitAddAbility(dummy, 'A0FI')
        call IssuePointOrderById( dummy, $D00FA, targetX, targetY )
        call UnitApplyTimedLife(dummy, 'BHwe', 3)
    endif


    set dummy = null
endfunction

function riYueTaiJiDamage takes unit u, unit ut returns nothing
    local real shanghai = 0.
	local real shxishu = 1.

	// +斗转星移：伤害+80%
	if GetUnitAbilityLevel(u, DOU_ZHUAN) >= 1 then
		set shxishu = shxishu + 0.8
	endif

	// +九阳神功：伤害+80%
	if GetUnitAbilityLevel(u, JIU_YANG) >= 1 then
		set shxishu = shxishu + 0.8
	endif

    // +化骨绵掌：几率打出内伤状态
    if GetUnitAbilityLevel(u, HUA_GU) >= 1 then
        call WanBuff(u, ut, 1)
    endif
       
    // +七伤拳：几率打出昏迷状态
    if GetUnitAbilityLevel(u, QI_SHANG_QUAN) >= 1 then
        call WanBuff(u, ut, 5)
    endif

	// 专属
	if UnitHasDenomWeapon(u, ITEM_RI_YUE_SHUANG_REN) then
		set shxishu = shxishu * 4
	endif

	set shanghai = ShangHaiGongShi(u, ut, 25., 25., shxishu, RI_YUE_TAI_JI_QUAN)
	call WuGongShangHai(u, ut, shanghai)
endfunction

// 2技能：神教宝训 获得 5 * 技能等级点特殊攻击
function shenJiaoBaoXun takes unit u returns nothing
    call WuGongShengChong(u, SHEN_JIAO_BAO_XUN, 700.)
endfunction

// 3技能：天魔拳 主动使用
function tianMoQuanTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
    local real distance = LoadReal(YDHT, GetHandleId(t), 1)
    set distance = distance + 15
    if distance > 650 then
        call KillUnit(u)
        call FlushChildHashtable(YDHT, GetHandleId(t))
        call DestroyTimer(t)
    else
        call SaveReal(YDHT, GetHandleId(t), 1, distance)
        call SetUnitX(u, GetUnitX(u) + 15 * CosBJ(GetUnitFacing(u)))
        call SetUnitY(u, GetUnitY(u) + 15 * SinBJ(GetUnitFacing(u)))
    endif
    set t = null
    set u = null
endfunction

function tianMoQuan takes unit u returns nothing
    local integer j
    local unit dummy
    local timer t
    call WuGongShengChong(u, TIAN_MO_QUAN, 180.)
    set j = 1
    loop
        exitwhen j > 18
        set dummy = CreateUnit(GetOwningPlayer(u), 'e01N', GetUnitX(u), GetUnitY(u), j * 20)
        call UnitAddAbility(dummy, 'A0FK')
        // 吸星派 持续伤害
        if joinSunOrMoon[1 + GetPlayerId(GetOwningPlayer(u))] == JOIN_SUN then
            call SetUnitAbilityLevel(dummy, 'A0FK', 2)
        endif
        set t = CreateTimer()
        call SaveUnitHandle(YDHT, GetHandleId(t), 0, dummy)
        call SaveReal(YDHT, GetHandleId(t), 1, 0)
        call TimerStart(t, 0.03, true, function tianMoQuanTimer)
        set j = j + 1
    endloop
    set dummy = null
    set t = null
endfunction

function tianMoQuanDamage takes unit u, unit ut returns nothing
    local real shanghai = 0.
	local real shxishu = 1.

	// +化功大法：伤害+100%
	if GetUnitAbilityLevel(u, HUA_GONG) >= 1 then
		set shxishu = shxishu + 1
	endif

	// +斗转星移：伤害+80%
	if GetUnitAbilityLevel(u, DOU_ZHUAN) >= 1 then
		set shxishu = shxishu + 0.8
	endif

    // 葵花派：造成封穴
    if joinSunOrMoon[1 + GetPlayerId(GetOwningPlayer(u))] == JOIN_MOON and not UnitHasBuffBJ(ut, 'B008') then
        call WanBuff(u, ut, 11)
    endif

	// 专属
	if UnitHasDenomWeapon(u, ITEM_RI_YUE_SHUANG_REN) then
		set shxishu = shxishu * 4
	endif

	set shanghai = ShangHaiGongShi(u, ut, 50., 50., shxishu, TIAN_MO_QUAN)
	call WuGongShangHai(u, ut, shanghai)
endfunction

// 4技能：吸星神掌 主动使用 屠夫肉钩
function xiXingShenZhang takes unit u returns nothing
    
endfunction

// 5技能：葵花心法 欲练神功，必先自宫 血量永远不超过上限的 50%，每次使用技能对自己造成当前血量 50% 的伤害，同时永久提升三围或六围
// 葵花派 改为每次使用技能减血75%，同时额外提升永久伤害加成
// 吸星派 每次使用临时提升暴击率和暴击倍数
function kuiHuaXinFaTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = LoadInteger(YDHT, GetHandleId(t), 0)
    local real x = LoadReal(YDHT, GetHandleId(t), 1)
    local real y = LoadReal(YDHT, GetHandleId(t), 2)
    set udg_baojilv[i] = udg_baojilv[i] - x
    set udg_baojishanghai[i] = udg_baojishanghai[i] - y
    call FlushChildHashtable(YDHT, GetHandleId(t))
    call DestroyTimer(t)
    set t = null
endfunction

function kuiHuaXinFaHalfCd takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	
	call EXSetAbilityState(EXGetUnitAbility(u, BI_BO_XIN_JING), 1, EXGetAbilityState(EXGetUnitAbility(u, KUI_HUA_XIN_FA), 1) / 2)
	
	call FlushChildHashtable(YDHT, GetHandleId(t))
	call PauseTimer(t)
	call DestroyTimer(t)
	set t = null
	set u = null
endfunction

function kuiHuaXinFa takes unit u returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    local integer level = GetUnitAbilityLevel(u, KUI_HUA_XIN_FA)
    local integer rand = GetRandomInt(1, 9)
    local integer count = GetRandomInt(1, 10 * level)
    local string s = ""
    local location loc = GetUnitLoc(u)
    local real add = 0
    local timer t = null

    call WuGongShengChong(u, KUI_HUA_XIN_FA, 120.)
    
    // 东方不败称号，数量翻倍
    if isTitle(i, 56) then
        set count = count * 2
    endif

    call DestroyEffectEx(AddSpecialEffectTargetEx("war3mapImported\\58.mdx", u, "origin"))

    if rand == 1 then
        set wuxing[i] = wuxing[i] + count
        set s = "悟性+" + I2S(count)
    elseif rand == 2 then
        set gengu[i] = gengu[i] + count
        set s = "根骨+" + I2S(count)
    elseif rand == 3 then
        set fuyuan[i] = fuyuan[i] + count
        set s = "福缘+" + I2S(count)
    elseif rand == 4 then
        set danpo[i] = danpo[i] + count
        set s = "胆魄+" + I2S(count)
    elseif rand == 5 then
        set jingmai[i] = jingmai[i] + count
        set s = "经脉+" + I2S(count)
    elseif rand == 6 then
        set yishu[i] = yishu[i] + count
        set s = "医术+" + I2S(count)
    elseif rand == 7 then
        call ModifyHeroStat(0, udg_hero[i], 0, count * 5)
        set s = "招式伤害+" + I2S(count * 5)
    elseif rand == 8 then
        call ModifyHeroStat(1, udg_hero[i], 0, count * 5)
        set s = "内力+" + I2S(count * 5)
    elseif rand == 9 then
        call ModifyHeroStat(2, udg_hero[i], 0, count * 5)
        set s = "真实伤害+" + I2S(count * 5)
    endif
    call CreateTextTagLocBJ(s, loc, 0, 15., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
    call Nw(3,bj_lastCreatedTextTag)
    call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(70, 110))
    call RemoveLocation(loc)

    if joinSunOrMoon[i] == JOIN_MOON then
        call SetWidgetLife(u, GetWidgetLife(u) * 0.25)
        set udg_shanghaijiacheng[i] = udg_shanghaijiacheng[i] + 0.002 * level
        if isTitle(i, 56) then
            set udg_shanghaijiacheng[i] = udg_shanghaijiacheng[i] + 0.002 * level
        endif
    else
        call SetWidgetLife(u, GetWidgetLife(u) * 0.5)
    endif

    if joinSunOrMoon[i] == JOIN_SUN then
        set udg_baojilv[i] = udg_baojilv[i] + 0.05 * level
        set add = GetRandomReal(0.01, 2) * level
        if isTitle(i, 55) then
            set add = add * 2
        endif
        set udg_baojishanghai[i] = udg_baojishanghai[i] + add
        set t = CreateTimer()
        call SaveInteger(YDHT, GetHandleId(t), 0, i)
        call SaveReal(YDHT, GetHandleId(t), 1,  0.05 * level)
        call SaveReal(YDHT, GetHandleId(t), 2,  add)
        call TimerStart(t, 20., false, function kuiHuaXinFaTimer)

    endif

    if GetUnitAbilityLevel(u, KUI_HUA) >= 1 then
        set t = CreateTimer()
        call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
        call TimerStart(t, 0.2, false, function kuiHuaXinFaHalfCd)
    endif

    set loc = null
    set t = null

endfunction

function initRiYue takes nothing returns nothing
    local integer j
    set j = 1
    loop
        exitwhen j > 5
        // 0是未加入，1是加入吸星，2是加入葵花
        set joinSunOrMoon[j] = 0 
        set joinSunPoint[j] = 0
        set joinMoonPoint[j] = 0
        set j = j + 1
    endloop

endfunction
