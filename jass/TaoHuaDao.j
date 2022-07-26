//------桃花岛系统------//
function IsTaoHua takes nothing returns boolean
	return (GetItemTypeId(GetManipulatedItem()) == 'I09S' or GetItemTypeId(GetManipulatedItem()) == 'I0A3')
endfunction
function TaoHuaDao takes nothing returns nothing
	local integer i = 1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
	if (GetItemTypeId(GetManipulatedItem()) == 'I09S') then
		if((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO)))then
			call SetUnitPosition(GetTriggerUnit(), 9631, 1139)
			call PanCameraToTimedForPlayer(GetOwningPlayer(GetTriggerUnit()), 9631, 1139, 0)
			call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cFFFFCC00有玩家进入桃花岛")
			call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cFFFFCC00”源思英年,巴巴西洛普,雪陆文出；源思英年,巴巴西洛普,雪陆文出！“")
		else
			call commonAddGold(GetOwningPlayer(GetTriggerUnit()), 500)
		endif
	elseif (GetItemTypeId(GetManipulatedItem()) == 'I0A3') then
		if((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO)))then
			call SetUnitPosition(GetTriggerUnit(), 12800, - 14800)
			call PanCameraToTimedForPlayer(GetOwningPlayer(GetTriggerUnit()), 12800, - 14800, 0)
			call DisplayTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, "|cFFFFCC00有玩家去救火")
		else
			call commonAddGold(GetOwningPlayer(GetTriggerUnit()), 200000)
		endif
	endif
endfunction

function TaoHuaGun takes nothing returns nothing
	local unit u = GetKillingUnit()
	//call BJDebugMsg("出现了么A")
	//set lh_r=Rect(8800,-4500,14300,4500)
	if RectContainsUnit(lh_r, u) then
		//call BJDebugMsg("出现了么B")
		if GetUnitTypeId(GetTriggerUnit()) == 'o021' or GetUnitTypeId(GetTriggerUnit()) == 'o022' or GetUnitTypeId(GetTriggerUnit()) == 'nwnr' or GetUnitTypeId(GetTriggerUnit()) == 'ogrk' or GetUnitTypeId(GetTriggerUnit()) == 'nslf' or GetUnitTypeId(GetTriggerUnit()) == 'n00A' or GetUnitTypeId(GetTriggerUnit()) == 'n00D' then
			call SetUnitPosition(u, - 1174, - 678)
			call PanCameraToTimedForPlayer(GetOwningPlayer(u), - 1174, - 678, 0)
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00有玩家杀死了" + GetUnitName(GetTriggerUnit()) + "，离开桃花岛")
			// 90级才爆武器
			if GetUnitLevel(u) >= 90 then
				// 黄药师掉落玉箫60%概率，寻宝大师90%
				if GetUnitTypeId(GetTriggerUnit()) == 'ogrk' and ((GetRandomInt(1, 100) <= 60) or (GetRandomInt(1, 100) <= 90 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
					call unitadditembyidswapped('I0A1', u)
				endif
				// 欧阳锋掉落蛇杖
				if GetUnitTypeId(GetTriggerUnit()) == 'nslf' and ((GetRandomInt(1, 100) <= 40) or (GetRandomInt(1, 100) <= 80 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
					call unitadditembyidswapped('I09B', u)
				endif
				// 洪七公掉落打狗棒
				if GetUnitTypeId(GetTriggerUnit()) == 'nwnr' and ((GetRandomInt(1, 100) <= 60) or (GetRandomInt(1, 100) <= 90 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
					call unitadditembyidswapped('I097', u)
				endif
			else
				call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00什么都没爆，请90级再来")
			endif
			

			if GetUnitTypeId(GetTriggerUnit()) == 'o021' and ((GetRandomInt(1, 100) <= 30) or (GetRandomInt(1, 100) <= 70 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
				call unitadditembyidswapped('I067', u)
			endif
			if GetUnitTypeId(GetTriggerUnit()) == 'o022' and ((GetRandomInt(1, 100) <= 30) or (GetRandomInt(1, 100) <= 70 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
				call unitadditembyidswapped('I061', u)
			endif
			if GetUnitTypeId(GetTriggerUnit()) == 'n00A' and ((GetRandomInt(1, 100) <= 30) or (GetRandomInt(1, 100) <= 70 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
				call unitadditembyidswapped('I060', u)
			endif
			// 失心疯n00D，寻宝大师100%爆逆九阴
			if GetUnitTypeId(GetTriggerUnit()) == 'n00D' and ((GetRandomInt(1, 100) <= 80) or (GetRandomInt(1, 100) <= 100 and Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())), XUN_BAO))) then
				call unitadditembyidswapped('I09G', u) // 逆九阴
			endif
		endif
	endif
	set u = null
endfunction
function TaoHua_Condition takes nothing returns boolean
	return GetOwningPlayer(GetTriggerUnit()) == Player(15) and (GetUnitTypeId(GetTriggerUnit()) == 'o022' or GetUnitTypeId(GetTriggerUnit()) == 'o021' or GetUnitTypeId(GetTriggerUnit()) == 'nwnr' or GetUnitTypeId(GetTriggerUnit()) == 'ogrk' or GetUnitTypeId(GetTriggerUnit()) == 'nslf' or GetUnitTypeId(GetTriggerUnit()) == 'n00A')
endfunction
function TaoHua_Action takes nothing returns nothing
	call SetUnitOwner(GetTriggerUnit(), Player(12), true)
	// 三老不加技能，强度和历练5一样
	// call UnitAddAbility(GetTriggerUnit(),'A07V')
	// call UnitAddAbility(GetTriggerUnit(),'A04I')
	// call UnitAddAbility(GetTriggerUnit(),'A04K')
endfunction
function OuYangFeng_Condition takes nothing returns boolean
	return RectContainsUnit(lh_r, GetTriggerUnit()) and GetUnitTypeId(GetTriggerUnit()) == 'nslf' and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetAttacker())) and (UnitHasBuffBJ(GetTriggerUnit(), 'Bcri') or UnitHasBuffBJ(GetTriggerUnit(), 'Bcrs') or UnitHasBuffBJ(GetTriggerUnit(), 'BNso'))
endfunction
function OuYangFeng_Action takes nothing returns nothing
	local location loc = GetUnitLoc(GetTriggerUnit())
	call KillUnit(GetTriggerUnit())
	call CreateNUnitsAtLoc(1, 'n00D', GetOwningPlayer(GetTriggerUnit()), loc, bj_UNIT_FACING)
	call RemoveLocation(loc)
	set loc = null
endfunction
function HongQiGong_Condition takes nothing returns boolean
	return RectContainsUnit(lh_r, GetTriggerUnit()) and GetUnitTypeId(GetTriggerUnit()) == 'nwnr' and IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetAttacker())) and (UnitHasBuffBJ(GetTriggerUnit(), 'BEsh') or UnitHasBuffBJ(GetTriggerUnit(), 'BIpb') or UnitHasBuffBJ(GetTriggerUnit(), 'BIpd'))
endfunction
function HongQiGong_Action takes nothing returns nothing
	call KillUnit(GetTriggerUnit())
	call ShowUnitShow(gg_unit_n00E_0066)
	call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFFCC00洪七公已中毒，现正在某处疗伤")
endfunction
//------桃花岛系统结束------//

function TaoHuaDao_Trigger takes nothing returns nothing
	local trigger t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(t, Condition(function IsTaoHua))
	call TriggerAddAction(t, function TaoHuaDao)
	set t = CreateTrigger()
	call TriggerRegisterPlayerUnitEventSimple(t, Player(12), EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddAction(t, function TaoHuaGun)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t, Condition(function TaoHua_Condition))
	call TriggerAddAction(t, function TaoHua_Action)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t, Condition(function OuYangFeng_Condition))
	call TriggerAddAction(t, function OuYangFeng_Action)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t, Condition(function HongQiGong_Condition))
	call TriggerAddAction(t, function HongQiGong_Action)
	set t = null
endfunction
