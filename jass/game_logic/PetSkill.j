// 宠物技能
globals
	unit pickingUnit = null // 正在一键拾取的宝宝
endglobals


// 悟空：猴子猴孙
function isSonOfMonkey takes nothing returns boolean
	return GetSpellAbilityId() == 'A0BD'
endfunction

function sonOfMonkey takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1
	local integer imax = GetRandomInt(5, 8)
	local unit ut = null
	if GetRandomInt(1, 100) <= 50 then
		set shengwang[1 + GetPlayerId(p)] = shengwang[1 + GetPlayerId(p)] + 100
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|cfffff000玩家" + GetPlayerName(p) + "的悟空发动了|CFF00EE00猴子猴孙|r技能，|CFF00EE00声望|r增加100点|r")
	else
		set shoujiajf[1 + GetPlayerId(p)] = shoujiajf[1 + GetPlayerId(p)] + 100
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|cfffff000玩家" + GetPlayerName(p) + "的悟空发动了|CFF00EE00猴子猴孙|r技能，|CFF00EE00守家积分|r增加100点|r")
	endif
	loop
		exitwhen i > imax
		set ut = CreateUnit(p, 'n00X', - 768. + GetRandomReal(- 100, 100), - 768. + GetRandomReal(- 100, 100), 270.)
		call IssueTargetOrderById( ut, $D0038, udg_ZhengPaiWL)
		set i = i + 1
	endloop
	set u = null
	set p = null
	set ut = null
 // 正派武林所在位置 -768.,-768
endfunction

// 一键拾取
function isFastPickup takes nothing returns boolean
	return GetSpellAbilityId() == 'A0EB'
endfunction

function doPickup takes nothing returns nothing
	call UnitAddItem(pickingUnit, GetEnumItem())
endfunction

function fastPickup takes nothing returns nothing
	local rect r = null
	set pickingUnit = GetTriggerUnit()
	set r = Rect(GetUnitX(pickingUnit) - 300, GetUnitY(pickingUnit) - 300, GetUnitX(pickingUnit) + 300, GetUnitY(pickingUnit) + 300)
	call EnumItemsInRect(r, null, function doPickup)
	call RemoveRect(r)
	set r = null
endfunction

// 一键丢弃
function isFastDrop takes nothing returns boolean
	return GetSpellAbilityId() == 'A0EC'
endfunction
function fastDrop takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local integer i = 0
	loop
		exitwhen i >= 6
		call UnitRemoveItemFromSlot(u, i)
		set i = i + 1
	endloop
	set u = null
endfunction

function isPetMove takes nothing returns boolean
	return (GetIssuedOrderId() == $D0012 or GetIssuedOrderId() == $D0003) and (GetUnitTypeId(GetTriggerUnit()) == 'n00W' or GetUnitTypeId(GetTriggerUnit()) == 'n00V' or GetUnitTypeId(GetTriggerUnit()) == 'nvul')
endfunction

function petMove takes nothing returns nothing
	local real x = GetUnitX(GetTriggerUnit())
	local real y = GetUnitY(GetTriggerUnit())
	local real dx = 0
	local real dy = 0
	if GetOrderTarget() != null then
		set dx =  GetWidgetX(GetOrderTarget()) - x
		set dy =  GetWidgetY(GetOrderTarget()) - y
		if SquareRoot(dx * dx + dy * dy) > 200 then
			call IssuePointOrderById(GetOrderedUnit(), $D022D, GetWidgetX(GetOrderTarget()), GetWidgetY(GetOrderTarget()))
		endif
	else
		call IssuePointOrderById(GetTriggerUnit(), $D022D, GetOrderPointX(), GetOrderPointY())
	endif
endfunction

function initPetSkill takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t, Condition(function isSonOfMonkey))
	call TriggerAddAction(t, function sonOfMonkey)
	
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t, Condition(function isFastPickup))
	call TriggerAddAction(t, function fastPickup)

	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t, Condition(function isFastDrop))
	call TriggerAddAction(t, function fastDrop)

	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER)
	call TriggerAddCondition(t, Condition(function isPetMove))
	call TriggerAddAction(t, function petMove)
	
	set t = null
endfunction
