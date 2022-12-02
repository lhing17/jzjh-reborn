/*
* @version：决战江湖1.6.35
* @author: zei_kale
* @date:2020.3.26
*
* 桃花岛武功：落英神剑掌、落英剑法、旋风扫叶腿、碧波心经、奇门术数
*/
// 桃花岛
globals
	constant integer BI_BO_POINT = $FEDC // 碧波心经点数
	
	integer array bibo_kill // 碧波心经杀人计数
	boolean array tide_rising // 潮起
endglobals

// 落英神剑掌
function luoYingZhang takes unit u returns nothing
	local real radius = 350
	local real duration = 3
	local real frequency = 0.03
	local real angleSpeed = 3.6
	
	// 武功升重
	call WuGongShengChong(u, LUO_YING_ZHANG, 300)
	
	// +九阴真经·内功：持续时间翻倍
	if GetUnitAbilityLevel(u, JIU_YIN) >= 1 then
		set duration = duration * 2
	endif
	
	// +碧海潮生曲：持续时间翻倍
	if GetUnitAbilityLevel(u, BI_HAI) >= 1 then
		set duration = duration * 2
	endif
	
	// +双手互搏：额外发一个反向旋转的花盘
	if GetUnitAbilityLevel(u, SHUANG_SHOU) >= 1 then
		call YDWECreateEwsp( u, 'e01H', 1, radius, duration, frequency, -angleSpeed )
	endif
	call YDWECreateEwsp( u, 'e01H', 1, radius, duration, frequency, angleSpeed )
endfunction

function luoYingZhangDamage takes unit u, unit ut returns nothing
	local real shxishu = 1.
	local real shanghai = 0.
	
	// +弹指神通：伤害+80%
	if GetUnitAbilityLevel(u, TAN_ZHI)!=0 then
		set shxishu = shxishu + 0.8
	endif
 
	// 专属加成
	if UnitHasDenomWeapon(u, ITEM_YU_XIAO) then
		set shxishu = shxishu * 3
	endif
	
	set shanghai=ShangHaiGongShi(u, ut, 25, 25, shxishu, LUO_YING_ZHANG)
	call WuGongShangHai(u, ut, shanghai)
	
	set u=null
	set ut=null
endfunction

// 落英剑法
function luoYingJian takes unit u, unit ut returns nothing
	
	local group g = CreateGroup()
	local group gt
	local unit current_unit
	local unit dummy
	local real range = 600
	
	
	// 武功升重
	call WuGongShengChong(u, LUO_YING_JIAN, 700)
	
	//+九阴真经内功：增加伤害范围
	if GetUnitAbilityLevel(u, JIU_YIN) >= 1 then
		set range = range + 300
	endif
	
	call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), range, Condition(function isAttackerEnemy))
	loop
	exitwhen CountUnitsInGroup(g) == 0
		set current_unit=FirstOfGroup(g)
		set dummy=CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
		call ShowUnitHide(dummy)
		call UnitAddAbility(dummy, 'A0EF') // 马甲技能
		call IssueTargetOrderById(dummy, $D007F, current_unit)
		call UnitApplyTimedLife(dummy, 'BHwe', 3)
		call GroupRemoveUnit(g, current_unit)
		// +九阴白骨爪：剑法弹射一次
		if GetUnitAbilityLevel(u, JIU_ZHAO) >= 1 then
			set gt = CreateGroup()
			call GroupEnumUnitsInRange(gt, GetUnitX(current_unit), GetUnitY(current_unit), range, Condition(function isAttackerEnemy))
			set dummy=CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(current_unit), GetUnitY(current_unit), bj_UNIT_FACING)
			set current_unit = GroupPickRandomUnit(gt)
			call ShowUnitHide(dummy)
			call UnitAddAbility(dummy, 'A0EF') // 马甲技能
			call IssueTargetOrderById(dummy, $D007F, current_unit)
			call UnitApplyTimedLife(dummy, 'BHwe', 3)
			call GroupRemoveUnit(g, current_unit)
			call GroupClear(gt)
			call DestroyGroup(gt)
		endif
	endloop
	call DestroyGroup(g)
	set g = null
	set gt = null
	set current_unit = null
	set dummy = null
	
endfunction

function luoYingJianDamage takes unit u, unit ut returns nothing
	local real shxishu = 1.
	local real shanghai = 0.
	local integer biBoPoint = LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT)
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	// +弹指神通：伤害+80%
	if GetUnitAbilityLevel(u, TAN_ZHI) != 0 then
		set shxishu = shxishu + 0.8
	endif
	// 碧波心经点数：伤害
	if biBoPoint > 0 then
		set shxishu = shxishu + biBoPoint * 0.02
	endif
	// 根骨和胆魄：增加伤害
	if gengu[i] >= 20 and danpo[i] >= 20 then
		set shxishu = shxishu + 0.03 * (gengu[i] - 20) + 0.03 * (danpo[i] - 20)
	endif
	// +打狗棒法：造成流血
	if GetUnitAbilityLevel(u, DA_GOU) != 0 then
		call WanBuff(u, ut, 3)
	endif
 
	// 专属加成
	if UnitHasDenomWeapon(u, ITEM_YU_XIAO) then
		set shxishu = shxishu * 3
	endif
	
	set shanghai = ShangHaiGongShi(u, ut, 80, 80, shxishu, LUO_YING_JIAN)
	call WuGongShangHai(u, ut, shanghai)
	
endfunction

// 旋风扫叶腿
function xuanFengTui takes unit u, unit ut returns nothing
	local unit dummy
	local integer level = 1
	local integer biBoPoint = LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT)
	
	// 武功升重
	call WuGongShengChong(u, XUAN_FENG_TUI, 600)
	
	// 碧波心经点数：持续时间
	if biBoPoint > 0 then
		set level = IMinBJ(9, R2I(level + biBoPoint * 0.2))
	endif
	
	// +双手互搏：额外形成一阵旋风
	set dummy = CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
	call ShowUnitHide(dummy)
	call UnitAddAbility(dummy, 'A0EJ') // 马甲技能
	if level <= 9 then
		call SetUnitAbilityLevel(dummy, 'A0EJ', level)
	endif
	call IssueTargetOrderById(dummy, $D0275, ut)
	call UnitApplyTimedLife(dummy, 'BHwe', 3)
	
	if GetUnitAbilityLevel(u, SHUANG_SHOU) >= 1 then
		set dummy = CreateUnit(GetOwningPlayer(u), 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
		call ShowUnitHide(dummy)
		call UnitAddAbility(dummy, 'A0EJ') // 马甲技能
		call SetUnitAbilityLevel(dummy, 'A0EJ', level)
		call IssueTargetOrderById(dummy, $D0275, ut)
		call UnitApplyTimedLife(dummy, 'BHwe', 3)
	endif
	set dummy = null
endfunction

function xuanFengTuiDamage takes unit u, unit ut returns nothing
	
	local real shxishu = 1.
	local real shanghai = 0.
	local integer biBoPoint = LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT)
	// +弹指神通：伤害+80%
	if GetUnitAbilityLevel(u, TAN_ZHI) != 0 then
		set shxishu = shxishu + 0.8
	endif
	
	// +九阴真经内功：伤害+70%
	if GetUnitAbilityLevel(u, JIU_YIN) != 0 then
		set shxishu = shxishu + 0.7
	endif
 
	// 专属加成
	if UnitHasDenomWeapon(u, ITEM_YU_XIAO) then
		set shxishu = shxishu * 3
	endif
	
	set shanghai=ShangHaiGongShi(u, ut, 15, 20, shxishu, XUAN_FENG_TUI)
	call WuGongShangHai(u, ut, shanghai)
	
endfunction

// 奇门术数
function qimenCd takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local real cdPercent = LoadReal(YDHT, GetHandleId(t), 1)
	
	call EXSetAbilityState(EXGetUnitAbility(u, QI_MEN_SHU_SHU), 1, EXGetAbilityState(EXGetUnitAbility(u, QI_MEN_SHU_SHU), 1) * cdPercent)
	
	call FlushChildHashtable(YDHT, GetHandleId(t))
	call PauseTimer(t)
	call DestroyTimer(t)
	set t = null
	set u = null
endfunction

function qiMenShuShu takes unit u returns nothing
	local integer base = 10
	local integer num0
	local integer num1
	local string s = ""
	local integer opera = 0 // 0为加法，1为乘法
	local integer count
	local location loc = GetUnitLoc(u)
	local group g
	local integer rand = GetRandomInt(1, 3)
	local unit currentUnit
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    local real damage
    local unit dummy
	local real param = 1
	local timer t
	local real cdPercent = 1
    // 专属加成
	if UnitHasDenomWeapon(u, ITEM_YU_XIAO) then
		set param = param * 3
	endif
    //     “女中诸葛称号”：将加法变为乘法
	if isTitle(i, 46) then
		set opera = 1
	endif
    // 悟性大于50：改为随机计算20以内的加法（或乘法）
    if wuxing[i] >= 50 then
        set base = 20
    endif
	// 武功升重
	call WuGongShengChong(u, QI_MEN_SHU_SHU, 70)
	
	set num0 = GetRandomInt(1, base)
	set num1 = GetRandomInt(1, base)
	if opera == 0 then
		set count = num0 + num1
		set s = I2S(num0) + "+" + I2S(num1) + "=" + I2S(count)
	elseif opera == 1 then
		set count = num0 * num1
		set s = I2S(num0) + "×" + I2S(num1) + "=" + I2S(count)
	endif
	
	call CreateTextTagLocBJ(s, loc, 0, 16., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
	call Nw(3,bj_lastCreatedTextTag)
	call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(70, 110))
	
	if qimen_status[i] == 0 then
		// 效果1 火切
		set g = CreateGroup()
		call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 2000, Condition(function isTriggerEnemy))
		loop
		exitwhen count <= 0 or CountUnitsInGroup(g) <= 0
			set currentUnit = FirstOfGroup(g)
			
			call DestroyEffectEx(AddSpecialEffectTargetEx("war3mapImported\\huoqie.mdx" , currentUnit, "origin"))
			set damage = ShangHaiGongShi(u, currentUnit, 800, 800, param, QI_MEN_SHU_SHU)
			call WuGongShangHai(u, currentUnit, damage)
			
			set count = count - 1
			call GroupRemoveUnit(g, currentUnit)
        endloop
		call DestroyGroup(g)
		set cdPercent = 0.2
	elseif qimen_status[i] == 1 then
		// 效果2 随机加六围
		call DestroyEffectEx(AddSpecialEffectTargetEx("war3mapImported\\lifebreak.mdx", u, "overhead"))
		call DestroyEffectEx(AddSpecialEffectTargetEx("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", u, "overhead"))
		if count > 50 then
			set count = 50
		endif
		if GetRandomInt(1, 6) == 1 then
			set wuxing[i] = wuxing[i] + count
			set s = "悟性+" + I2S(count)
		elseif GetRandomInt(1, 5) == 1 then
			set gengu[i] = gengu[i] + count
			set s = "根骨+" + I2S(count)
		elseif GetRandomInt(1, 4) == 1 then
			set fuyuan[i] = fuyuan[i] + count
			set s = "福缘+" + I2S(count)
		elseif GetRandomInt(1, 3) == 1 then
			set danpo[i] = danpo[i] + count
			set s = "胆魄+" + I2S(count)
		elseif GetRandomInt(1, 2) == 1 then
			set jingmai[i] = jingmai[i] + count
			set s = "经脉+" + I2S(count)
		else
			set yishu[i] = yishu[i] + count
			set s = "医术+" + I2S(count)
		endif
		call CreateTextTagLocBJ(s, loc, 0, 15., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
		call Nw(3,bj_lastCreatedTextTag)
		call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(70, 110))
		set cdPercent = 0.8
	elseif qimen_status[i] == 2 then
        // 效果3 大球
		call YDWECreateEwsp( u, 'e01J', 2, 450, count, 0.03, 3.6 )
		set cdPercent = 0.5
	endif
	set t = CreateTimer()
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call SaveReal(YDHT, GetHandleId(t), 1, cdPercent)
	call TimerStart(t, 0.2, false, function qimenCd)
    call RemoveLocation(loc)
    set dummy = null
	set currentUnit = null
	set g = null
	set loc = null
	set t = null
endfunction

function qiMenShuShuDamage takes unit u, unit ut returns nothing
    local real shxishu = 1.
	local real shanghai = 0.

	// 专属加成
	if UnitHasDenomWeapon(u, ITEM_YU_XIAO) then
		set shxishu = shxishu * 3
	endif
	
	set shanghai = ShangHaiGongShi(u, ut, 90, 90, shxishu, QI_MEN_SHU_SHU)
	call WuGongShangHai(u, ut, shanghai)
	
endfunction

// 碧波心经
function biBoXinJingRemoveBuff takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)        
	call UnitRemoveAbility(u,'A0DB')
	call UnitRemoveAbility(u,'A0DC')
	call FlushChildHashtable(YDHT, GetHandleId(t))
	call PauseTimer(t)
	call DestroyTimer(t)
	set u = null
	set t = null
endfunction

function biBoXinJingHalfCd takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	
	call EXSetAbilityState(EXGetUnitAbility(u, BI_BO_XIN_JING), 1, EXGetAbilityState(EXGetUnitAbility(u, BI_BO_XIN_JING), 1) / 2)
	
	call FlushChildHashtable(YDHT, GetHandleId(t))
	call PauseTimer(t)
	call DestroyTimer(t)
	set t = null
	set u = null
endfunction

function biBoXinJing takes unit u returns nothing
	local integer point = LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT)
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer level = GetUnitAbilityLevel(u, BI_BO_XIN_JING)
	local timer t 
	local string s = ""
	local location loc
	if tide_rising[i] then
		// 潮起
		if point < 5 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFDD0000碧波心经点数不足，无法使用")
			call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + 120)
			call UnitRemoveAbility(u, BI_BO_XIN_JING)
			call UnitAddAbility(u, BI_BO_XIN_JING)
			call SetUnitAbilityLevel(u, BI_BO_XIN_JING, level)
		else
			call SaveInteger(YDHT, GetHandleId(u), BI_BO_POINT, LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT) - 5)
			call DestroyEffectEx(AddSpecialEffectTargetEx("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", u, "overhead"))
			call WuGongShengChong(u, BI_BO_XIN_JING, 70)
			call ModifyHeroStat(0, u, 0, 30 * level)
			call ModifyHeroStat(1, u, 0, 30 * level)
			call ModifyHeroStat(2, u, 0, 30 * level)
			
			set loc = GetUnitLoc(u)
			set s = "招式伤害+" + I2S(30 * level)
			call CreateTextTagLocBJ(s, loc, 0, 15., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(70, 110))
			set s = "内力+" + I2S(30 * level)
			call CreateTextTagLocBJ(s, loc, 0, 15., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(70, 110))
			set s = "真实伤害+" + I2S(30 * level)
			call CreateTextTagLocBJ(s, loc, 0, 15., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(70, 110))
			call RemoveLocation(loc)
			
			if GetUnitAbilityLevel(u, DA_GOU) >= 1 then
				set t = CreateTimer()
				call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
				call TimerStart(t, 0.2, false, function biBoXinJingHalfCd)
			endif
		endif
	else
		// 潮落
		if point < 3 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFDD0000碧波心经点数不足，无法使用")
			call UnitRemoveAbility(u, BI_BO_XIN_JING)
			call UnitAddAbility(u, BI_BO_XIN_JING)
			call SetUnitAbilityLevel(u, BI_BO_XIN_JING, level)
		else
			call SaveInteger(YDHT, GetHandleId(u), BI_BO_POINT, LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT) - 3)
			call DestroyEffectEx(AddSpecialEffectTargetEx("war3mapImported\\zhiyu.mdx", u, "overhead"))
			call UnitAddAbility(u, 'A0DB')
			call UnitAddAbility(u, 'A0DC')
			call SetUnitAbilityLevel(u, 'A0DB', level)
			call SetUnitAbilityLevel(u, 'A0DC', level)
			
			set t = CreateTimer()
			call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
			call TimerStart(t, 25, false, function biBoXinJingRemoveBuff)
			call WuGongShengChong(u, BI_BO_XIN_JING, 70)
			if GetUnitAbilityLevel(u, DA_GOU) >= 1 then
				set t = CreateTimer()
				call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
				call TimerStart(t, 0.2, false, function biBoXinJingHalfCd)
			endif
		endif
	endif
	set loc = null
	set t = null
	set p = null
endfunction

