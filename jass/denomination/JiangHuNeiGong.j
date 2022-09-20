

//-----------江湖内功和九阴武功开始-----------
//使用罗汉伏魔功
function uI takes nothing returns boolean
	return GetKillingUnit() != null and((GetUnitAbilityLevel(GetKillingUnit(), 'A07O') > 0))
endfunction
function vI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	set G9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (G9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((G9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= 100))then
		set G9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		call YDWEGeneralBounsSystemUnitSetBonus(GetKillingUnit(), 2, 0, $A)
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "防御+10")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//使用化功大法
function xI takes nothing returns boolean
	return((GetSpellAbilityId() == 'A07P')and(UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO)))
endfunction
function yI takes nothing returns boolean
	local integer id = GetHandleId(GetTriggeringTrigger())
	return(((IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), $59BEA0CB))))and(IsUnitAliveBJ(GetFilterUnit()))))
endfunction
function zI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	call SaveLocationHandle(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $3348E012, GetUnitLoc(GetEnumUnit()))
	call AddLightningLoc("DRAM", LoadLocationHandle(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $72C3E060), LoadLocationHandle(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $3348E012))
	call Lw(2, bj_lastCreatedLightning)
	call SaveInteger(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), $45541105, (LoadInteger(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), $45541105) + 1))
endfunction
function AI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	local integer i = GetUnitAbilityLevel(GetTriggerUnit(), 'A07P')
	if GetUnitAbilityLevel(GetTriggerUnit(), 'A0BQ') >= 1 then
		if UnitHaveItem(GetTriggerUnit(), 'I0AM') then
			call WuGongShengChong(GetTriggerUnit(), 'A07P', 150)
		else
			call WuGongShengChong(GetTriggerUnit(), 'A07P', 300)
		endif
	endif
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveUnitHandle(YDHT, id * cx, $59BEA0CB, GetTriggerUnit())
	call SaveLocationHandle(YDHT, id * cx, - $72C3E060, GetUnitLoc(LoadUnitHandle(YDHT, id * cx, $59BEA0CB)))
	call SaveInteger(YDHT, id * cx, $45541105, 0)
	call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(1000., LoadLocationHandle(YDHT, id * cx, - $72C3E060), Condition(function yI)), function zI)
	call ModifyHeroStat(1, LoadUnitHandle(YDHT, id * cx, $59BEA0CB), 0, (i * 50 * LoadInteger(YDHT, id * cx, $45541105)))
	call DisplayTimedTextToPlayer(GetOwningPlayer(LoadUnitHandle(YDHT, id * cx, $59BEA0CB)), 0, 0, 5., ("内力提升 ： " + I2S((i * 50 * LoadInteger(YDHT, id * cx, $45541105)))))
	call YDWEWaitForLocalVariable(20.)
	call ModifyHeroStat(1, LoadUnitHandle(YDHT, id * cx, $59BEA0CB), 1, (i * 50 * LoadInteger(YDHT, id * cx, $45541105)))
	call YDWELocalVariableEnd()
	call FlushChildHashtable(YDHT, id * cx)
endfunction

//使用吸星大法
function BI takes nothing returns boolean
	return GetKillingUnit() != null and((GetUnitAbilityLevel(GetKillingUnit(), 1093678930) > 0))
endfunction
function bI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	set H9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (H9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((H9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= $C8))then
		set H9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		call ModifyHeroStat(1, GetKillingUnit(), 0, $A)
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "内力+10")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction

//==================九阴真经系统开始==================//
//摧坚神抓和摧心掌
function JiuYin_Condition takes nothing returns boolean
	return(GetUnitAbilityLevel(GetAttacker(), 'A0D1') >= 1 or GetUnitAbilityLevel(GetAttacker(), 'A0D3') >= 1)and(IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetAttacker())))
endfunction
function CuiJian_Condition takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetAttacker()))and IsUnitAliveBJ(GetFilterUnit())
endfunction
function CuiJian_Action takes nothing returns nothing
	local integer i = 1 + GetPlayerId(GetOwningPlayer(GetEventDamageSource()))
	local unit u = GetAttacker()
	local unit uc = GetEnumUnit()
	local location loc = GetUnitLoc(uc)
	local real shxishu = 1.
	local real shanghai = 0.
	call DestroyEffectEx(AddSpecialEffectLocBJEx(loc, "Abilities\\Spells\\Items\\AIil\\AIilTarget.mdl"))
	if GetUnitAbilityLevel(GetAttacker(), 'A07S') >= 1 then
		// 九阴内功
		set shxishu = shxishu + 1.
	endif
	if isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 37) then 
		// 九阴真人
		set shxishu = shxishu * 40
	endif
	if isTitle(i, 41) then
		// 瑶琴
		set shxishu = shxishu * 10
	endif
	set shanghai = ShangHaiGongShi(u, uc, 30., 30., shxishu, 'A0D1')
	call WuGongShangHai(u, uc, shanghai)
	if((GetUnitAbilityLevel(u, 'A07N') != 0)and(GetRandomReal(.0, 100.) <= 10.)and(UnitHasBuffBJ(uc, 'B008') == false))then
		call WanBuff(u, uc, 11)
	endif
	call RemoveLocation(loc)
	set loc = null
	set u = null
	set uc = null
endfunction

function JiuYin_Action takes nothing returns nothing
	local unit u = GetAttacker()
	local unit uc = GetTriggerUnit()
	local location loc = GetUnitLoc(u)
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local real shanghai = 0.
	local real shxishu = 1.

	//摧坚神抓
	if GetUnitAbilityLevel(GetAttacker(), 'A0D1') >= 1 then
		if GetRandomReal(.0, 100.) <= 15. + I2R(fuyuan[i]) / 5. then
			call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(500., loc, Condition(function CuiJian_Condition)), function CuiJian_Action)
			call WuGongShengChong(GetAttacker(), 'A0D1', 700.)
		endif
	endif

	//摧心掌
	if GetUnitAbilityLevel(GetAttacker(), 'A0D3') >= 1 then
		if GetRandomReal(.0, 100.) <= 15. + I2R(fuyuan[i]) / 5. then
			if GetUnitAbilityLevel(u, 'A07S') >= 1 then
				set shxishu = shxishu + 1.
			endif
			if isTitle(i, 37) then // 九阴真人
				set shxishu = shxishu * 40
			endif
			if((GetUnitAbilityLevel(u, 'A0D2') != 0)and(GetRandomInt(1, $A) < 5)and(UnitHasBuffBJ(uc, 'Bcri') == false))then
				call WanBuff(u, uc, 4)
			endif
			if((GetUnitAbilityLevel(u, 'A0D6') != 0)and(GetRandomInt(1, $A) < 5)and(UnitHasBuffBJ(uc, 1110454324) == false))then
				call WanBuff(u, uc, 7)
			endif
			set shanghai = ShangHaiGongShi(u, uc, 80, 64, shxishu, 'A0D3')
			call AddSpecialEffectTargetUnitBJEx( "overhead", GetTriggerUnit(), "Abilities\\Spells\\Items\\OrbDarkness\\OrbDarkness.mdl")
			call DestroyEffectEx( GetLastCreatedEffectBJ() )
			call WuGongShangHai(u, uc, shanghai)
			call WuGongShengChong(u, 'A0D3', 1050.)
		endif
	endif
	call RemoveLocation(loc)
	set u = null
	set uc = null
	set loc = null
	set p = null
endfunction


function cI takes nothing returns boolean
	return(GetUnitAbilityLevel(GetKillingUnit(), 'A07S') > 0 or GetUnitAbilityLevel(GetKillingUnit(), 'A0D2') > 0 or GetUnitAbilityLevel(GetKillingUnit(), 'A0D6') > 0)
endfunction
//九阴真经杀100怪
function DI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	local integer i = 1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))
	local integer beishu = 1 // 内功加成倍数
	// 九阴真人称号
	if isTitle(i, 37) then
		set beishu = 4
	endif
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	set I9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (I9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((I9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= 100))then
		set I9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		if GetUnitAbilityLevel(GetKillingUnit(), 'A07S') > 0 then
			// 九阴
			call ModifyHeroStat(0, GetKillingUnit(), 0, 10 * beishu)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "招式伤害+" + I2S(10 * beishu))
		endif
		if GetUnitAbilityLevel(GetKillingUnit(), 'A0D2') > 0 then
			// 逆九阴
			if GetRandomInt(1, 2) == 1 then
				call ModifyHeroStat(0, GetKillingUnit(), 1, 10 * beishu)
				call ModifyHeroStat(1, GetKillingUnit(), 0, 30 * beishu)
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "招式伤害-" + I2S(10 * beishu))
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "内力+" + I2S(30 * beishu))
			else
				call ModifyHeroStat(2, GetKillingUnit(), 0, 10 * beishu)
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "真实伤害+" + I2S(10 * beishu))
			endif
		endif
		if GetUnitAbilityLevel(GetKillingUnit(), 'A0D6') > 0 then
			// 易筋锻骨篇
			if GetRandomInt(1, 6) == 1 then
				set wuxing[i] = wuxing[i] + beishu
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "悟性+" + I2S(beishu))
			elseif GetRandomInt(1, 5) == 1 then
				set gengu[i] = gengu[i] + beishu
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "根骨+" + I2S(beishu))
			elseif GetRandomInt(1, 4) == 1 then
				set danpo[i] = danpo[i] + beishu
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "胆魄+" + I2S(beishu))
			elseif GetRandomInt(1, 3) == 1 then
				set yishu[i] = yishu[i] + beishu
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "医术+" + I2S(beishu))
			elseif GetRandomInt(1, 2) == 1 then
				set jingmai[i] = jingmai[i] + beishu
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "经脉+" + I2S(beishu))
			else
				set fuyuan[i] = fuyuan[i] + beishu
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "福缘+" + I2S(beishu))
			endif
			// if GetRandomInt(1, 5) <= 2 then
			// 	if GetRandomInt(1, 6) == 1 then
			// 		set wuxing[i] = wuxing[i] - beishu
			// 		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "悟性-" + I2S(beishu))
			// 	elseif GetRandomInt(1, 5) == 1 then
			// 		set gengu[i] = gengu[i] - beishu
			// 		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "根骨-" + I2S(beishu))
			// 	elseif GetRandomInt(1, 4) == 1 then
			// 		set danpo[i] = danpo[i] - beishu
			// 		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "胆魄-" + I2S(beishu))
			// 	elseif GetRandomInt(1, 3) == 1 then
			// 		set yishu[i] = yishu[i] - beishu
			// 		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "医术-" + I2S(beishu))
			// 	elseif GetRandomInt(1, 2) == 1 then
			// 		set jingmai[i] = jingmai[i] - beishu
			// 		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "经脉-" + I2S(beishu))
			// 	else
			// 		set fuyuan[i] = fuyuan[i] - beishu
			// 		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "福缘-" + I2S(beishu))
			// 	endif
			// endif
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//==================九阴真经系统结束==================//
//双手互搏
function FI takes nothing returns boolean
	return((GetSpellAbilityId() == 'A07U')and(UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO)))
endfunction
function GI takes nothing returns nothing
	call UnitResetCooldown(GetTriggerUnit())
endfunction
function isShuangShouBeiDong takes nothing returns boolean
	// 学会双手，老顽童或郭大侠或小龙女称号
	return GetUnitAbilityLevel(GetAttacker(), 'A07U') >= 1 and (isTitle(1 + GetPlayerId(GetOwningPlayer(GetAttacker())), 13) or isTitle(1 + GetPlayerId(GetOwningPlayer(GetAttacker())), 43) or isTitle(1 + GetPlayerId(GetOwningPlayer(GetAttacker())), 6))
endfunction
function shuangShouBeiDong takes nothing returns nothing
	local unit u = GetAttacker()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	// 被动双手刷新概率
	if GetRandomReal(1., 2000) <= RMinBJ(fuyuan[i], 100) then
		call DisplayTextToPlayer(p, 0, 0, "|cff00FF66双手被动刷新")
		call UnitResetCooldown(u)
	endif
	set u = null
	set p = null
endfunction

//使用九阳神功
function II takes nothing returns boolean
	return GetKillingUnit() != null and ((GetUnitAbilityLevel(GetKillingUnit(), 'A0DN') > 0))
endfunction
function lI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	set l9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (l9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((l9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= 100))then
		set l9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "生命值提高2000")
		call unitadditembyidswapped('I04T', GetKillingUnit())
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//-----------江湖内功和九阴武功结束-----------
//模拟九阳神功
function IsJiuYang takes nothing returns boolean
	return GetSpellAbilityId() == 'A0DN' or GetSpellAbilityId() == 'A01B' or GetSpellAbilityId() == 'A01C' or GetSpellAbilityId() == 'A01D'
endfunction
function JiuYang_End takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	call UnitRemoveAbility(u, 'A0DL')
	call UnitRemoveAbility(u, 'A0DM')
	call UnitRemoveAbility(u, 'A0CO')
	call UnitRemoveAbility(u, 'A0CQ')
	call FlushChildHashtable(YDHT, GetHandleId(t))
	call PauseTimer(t)
	call DestroyTimer(t)
	set t = null
	set u = null
endfunction
function JiuYang takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local timer t = CreateTimer()
	local real r = 0.
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	// 九阳加攻击
	call UnitAddAbility(u, 'A0DL')
	// 九阳加护甲
	call UnitAddAbility(u, 'A0DM')
	// 九阳加
	call UnitAddAbility(u, 'A0CO')
	call UnitAddAbilityBJ( 'A0CQ', u )
	call SetPlayerAbilityAvailableBJ( false, 'A0CQ', GetOwningPlayer(u) )
	if GetSpellAbilityId() == 'A0DN' then
		set r = 30
	elseif GetSpellAbilityId() == 'A01B' then
		set r = 12
	elseif GetSpellAbilityId() == 'A01C' then
		set r = 20
	elseif GetSpellAbilityId() == 'A01D' then
		set r = 30
	endif
	call TimerStart(t, r, false, function JiuYang_End)
	set t = null
	set u = null
endfunction

//医疗篇
function IsYiLiao takes nothing returns boolean
	return ( ( GetSpellAbilityId() == 'A0D4' ) )
endfunction
function YiLiaoPian takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local unit uc = GetSpellTargetUnit()
	call SetWidgetLife(uc, GetWidgetLife(u) + 20000)
	if isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 37) then
		call SetWidgetLife(uc, GetWidgetLife(u) + 380000)
	endif
	set u = null
	set uc = null
endfunction


//使用洗髓经
function QI takes nothing returns boolean
	return((GetSpellAbilityId() == 1093679152)and(UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO)))
endfunction
function RI takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetUnitLoc(GetTriggerUnit()))
	call CreateNUnitsAtLoc(1, 'e000', GetOwningPlayer(GetTriggerUnit()), LoadLocationHandle(YDHT, id * cx, $5E83114F), bj_UNIT_FACING)
	call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, 1093679153)
	call ShowUnitHide(bj_lastCreatedUnit)
	call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 26.)
	call IssueImmediateOrderById(bj_lastCreatedUnit, $D00D8)
	call FlushChildHashtable(YDHT, id * cx)
endfunction


function JiangHuNeiGong_Trigger takes nothing returns nothing
	local trigger t = null
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t, Condition(function JiuYin_Condition))
	call TriggerAddAction(t, function JiuYin_Action)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t, Condition(function IsJiuYang))
	call TriggerAddAction(t, function JiuYang)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t, Condition(function IsYiLiao))
	call TriggerAddAction(t, function YiLiaoPian)
	set bn = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(bn, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(bn, Condition(function uI))
	call TriggerAddAction(bn, function vI)
	set Cn = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Cn, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(Cn, Condition(function xI))
	call TriggerAddAction(Cn, function AI)
	set cn = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(cn, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(cn, Condition(function BI))
	call TriggerAddAction(cn, function bI)
	set Dn = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Dn, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(Dn, Condition(function cI))
	call TriggerAddAction(Dn, function DI)
	set En = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(En, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(En, Condition(function FI))
	call TriggerAddAction(En, function GI)
	// 双手被动
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t, Condition(function isShuangShouBeiDong))
	call TriggerAddAction(t, function shuangShouBeiDong)
	set Fn = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Fn, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(Fn, Condition(function II))
	call TriggerAddAction(Fn, function lI)
	set In = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(In, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(In, Condition(function QI))
	call TriggerAddAction(In, function RI)
	// 特殊事件——辽国进攻
	set t = CreateTrigger()
	call TriggerRegisterTimerEventSingle(t, 2100.)
	call TriggerAddAction(t, function LiaoGuoJinGong)
	// 特殊事件——灵鹫宫进攻
	set t = CreateTrigger()
	call TriggerRegisterTimerEventSingle(t, 3000.)
	call TriggerAddAction(t, function LingJiuGongJinGong)
	set t = null
endfunction
