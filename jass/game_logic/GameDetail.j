//----------------------------------------------
//游戏细节处理——一般情况下不需要修改
// 1. 用移动模拟攻击、巡逻模拟移动 对地面
//----------------------------------------------

//右键点击己方单位
function uuxx takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetOrderedUnit()))==MAP_CONTROL_USER)and(IsPlayerAlly(GetOwningPlayer(GetOrderedUnit()),GetOwningPlayer(GetOrderTargetUnit())))and(GetIssuedOrderId()==$D0003))
endfunction
function vvxx takes nothing returns nothing
	call IssuePointOrderById(GetOrderedUnit(), $D0003, GetUnitX(GetOrderTargetUnit()), GetUnitY(GetOrderTargetUnit()))
endfunction

//优化速度加快
function Ax takes nothing returns nothing
	call Cheat("DooConV")
endfunction

//友方单位A基地
function Ux takes nothing returns boolean
	return((GetTriggerUnit()==udg_ZhengPaiWL)and(IsUnitAlly(GetAttacker(),Player(5))))
endfunction
function Vx takes nothing returns nothing
	call IssueImmediateOrderById(GetAttacker(),$D0004)
endfunction
function ga takes nothing returns nothing
	call IssuePointOrderByIdLoc(GetEnumUnit(),$D000F,v7[4])
endfunction
function ha takes nothing returns nothing
	call ForGroup(w7,function ga)
endfunction

function GameDetail_Trigger takes nothing returns nothing
	local trigger t = CreateTrigger()
	set t=CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
	call TriggerAddCondition(t,Condition(function uuxx))
	call TriggerAddAction(t,function vvxx)

	// 友方单位A基地
	set ei=CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(ei,EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(ei,Condition(function Ux))
	call TriggerAddAction(ei,function Vx)
	// 让怪A基地
	set kj=CreateTrigger()
	call TriggerRegisterTimerEventPeriodic(kj,5.)
	call TriggerAddAction(kj,function ha)
	// 游戏优化
	set Qh=CreateTrigger()
	call TriggerRegisterTimerEventSingle(Qh,.0)
	call TriggerAddAction(Qh,function Ax)
	set t = null
endfunction
