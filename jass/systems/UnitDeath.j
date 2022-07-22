// 任意单位死亡事件
function UnitDeath_Conditions takes nothing returns boolean
	local unit u = GetKillingUnit()
	local unit ut = GetTriggerUnit()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local integer count = IMaxBJ(LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT), 10)
	local integer j = 1
	if IsUnitEnemy(ut, GetOwningPlayer(u)) and GetUnitAbilityLevel(u, BI_BO_XIN_JING) >= 1 then
		set bibo_kill[i] = bibo_kill[i] + 1
		if bibo_kill[i] > count then
			set bibo_kill[i] = bibo_kill[i] - count
			if GetUnitAbilityLevel(u, QI_MEN_SHU_SHU) >= 1 then
				set j = 2
			endif
			call SaveInteger(YDHT, GetHandleId(u), BI_BO_POINT, LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT) + j)
			call DisplayTextToPlayer(Player(i - 1), 0, 0, "碧波心经点数+"+I2S(j))
		endif
	endif

	if GetUnitAbilityLevel(u, XUAN_MING_SHEN_ZHANG) > 0 and GetUnitAbilityLevel(u, JIU_YIN) > 0 and GetUnitAbilityLevel(u, JIU_YANG) == 0 then
		// 玄冥神掌杀100个敌人加1点特攻
		call xuanMingAddSpecialAttack(u)
	endif
	
	set u = null
	set ut = null
	return false
endfunction

//任意单位死亡事件系统
function UnitDeath takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH )
	call TriggerAddCondition(t,Condition(function UnitDeath_Conditions))
	set t = null
endfunction

