//----------------------------------------------
//游戏细节处理——一般情况下不需要修改
// 1. 用移动模拟攻击、巡逻模拟移动 对地面
//----------------------------------------------

//右键点击己方单位
function uuxx takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetOrderedUnit())) == MAP_CONTROL_USER)and(IsPlayerAlly(GetOwningPlayer(GetOrderedUnit()), GetOwningPlayer(GetOrderTargetUnit())))and(GetIssuedOrderId() == $D0003))
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
	return((GetTriggerUnit() == udg_ZhengPaiWL)and(IsUnitAlly(GetAttacker(), Player(5))))
endfunction
function Vx takes nothing returns nothing
	call IssueImmediateOrderById(GetAttacker(), $D0004)
endfunction
function ga takes nothing returns nothing
	call IssuePointOrderByIdLoc(GetEnumUnit(), $D000F, v7[4])
endfunction
function ha takes nothing returns nothing
	call ForGroup(w7, function ga)
endfunction

function onUpdate takes nothing returns nothing
	call SavePlayerHandle(YDLOC, 0x4481DC09, 0xBAB343BB, GetLocalPlayer())
	call SetCameraFieldForPlayer(LoadPlayerHandle(YDLOC, 0x4481DC09, 0xBAB343BB), CAMERA_FIELD_TARGET_DISTANCE, I2R(LoadInteger(YDHT, GetHandleId(Player(0)), 0xA816E128)), 0.00)
	call SetCameraFieldForPlayer(LoadPlayerHandle(YDLOC, 0x4481DC09, 0xBAB343BB), CAMERA_FIELD_ANGLE_OF_ATTACK, 304.00, 0.00)
	// call SaveReal(YDLOC, 0x4481DC09, 0xED01DBD2, (I2R(( DzGetMouseX() - DzGetWindowX() )) / ( I2R(DzGetWindowWidth()) / 0.80 ))) // INLINED!!
	// call SaveReal(YDLOC, 0x4481DC09, 0x8EBA3885, (I2R(( ( DzGetWindowHeight() + DzGetWindowY() ) - DzGetMouseY() )) / ( I2R(DzGetWindowHeight()) / 0.60 ))) // INLINED!!
endfunction

function changeCameraDistance takes nothing returns nothing
	call SavePlayerHandle(YDLOC, 0x4F134CEC, 0xBAB343BB, DzGetTriggerKeyPlayer())
	if ( ( DzGetWheelDelta() > 0 ) ) then
		if ( ( LoadInteger(YDHT, GetHandleId(Player(0)), 0xA816E128) > 400 ) ) then
			call SaveInteger(YDHT, GetHandleId(Player(0)), 0xA816E128, ( LoadInteger(YDHT, GetHandleId(Player(0)), 0xA816E128) - 100 ))
		else
		endif
	else
		if ( ( LoadInteger(YDHT, GetHandleId(Player(0)), 0xA816E128) < 3500 ) ) then
			call SaveInteger(YDHT, GetHandleId(Player(0)), 0xA816E128, ( LoadInteger(YDHT, GetHandleId(Player(0)), 0xA816E128) + 100 ))
		else
		endif
	endif
endfunction

function registerWheelEvent takes nothing returns nothing
	if GetLocalPlayer() == GetLocalPlayer() then
		call DzFrameSetUpdateCallbackByCode(function onUpdate)
		call DzTriggerRegisterMouseWheelEventByCode(null, false, function changeCameraDistance)
	endif
endfunction

function GameDetail_Trigger takes nothing returns nothing
	local trigger t = CreateTrigger()
	local timer tm = CreateTimer()
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ISSUED_TARGET_ORDER)
	call TriggerAddCondition(t, Condition(function uuxx))
	call TriggerAddAction(t, function vvxx)

	// 友方单位A基地
	set ei = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(ei, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(ei, Condition(function Ux))
	call TriggerAddAction(ei, function Vx)
	// 让怪A基地
	set kj = CreateTrigger()
	call TriggerRegisterTimerEventPeriodic(kj, 5.)
	call TriggerAddAction(kj, function ha)
	// 游戏优化
	set Qh = CreateTrigger()
	call TriggerRegisterTimerEventSingle(Qh, .0)
	call TriggerAddAction(Qh, function Ax)

	// 为本地玩家注册滚轮事件（滚轮缩放视角）
	call TimerStart(tm, 0.05, false, function registerWheelEvent)
	set tm = null
	set t = null
endfunction
