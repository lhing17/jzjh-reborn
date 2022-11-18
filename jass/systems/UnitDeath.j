// 任意单位死亡事件
function UnitDeath_Conditions takes nothing returns boolean
	local unit u = GetKillingUnit()
	local unit ut = GetTriggerUnit()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local integer count = IMaxBJ(LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT), 10)
	local integer j = 1

	// 清空死亡单位的哈希表
	if GetPlayerController(GetOwningPlayer(ut)) != MAP_CONTROL_USER then
		call FlushChildHashtable(YDHT, GetHandleId(ut))
	endif

	if IsUnitEnemy(ut, GetOwningPlayer(u)) and GetUnitAbilityLevel(u, BI_BO_XIN_JING) >= 1 then
		set bibo_kill[i] = bibo_kill[i] + 1
		if bibo_kill[i] > count then
			set bibo_kill[i] = bibo_kill[i] - count
			if GetUnitAbilityLevel(u, QI_MEN_SHU_SHU) >= 1 then
				set j = 2
			endif
			call SaveInteger(YDHT, GetHandleId(u), BI_BO_POINT, LoadInteger(YDHT, GetHandleId(u), BI_BO_POINT) + j)
			call DisplayTextToPlayer(Player(i - 1), 0, 0, "碧波心经点数+" + I2S(j))
		endif
	endif

	if GetUnitAbilityLevel(u, XUAN_MING_SHEN_ZHANG) > 0 and GetUnitAbilityLevel(u, JIU_YIN) > 0 and GetUnitAbilityLevel(u, JIU_YANG) == 0 then
		// 玄冥神掌杀100个敌人加1点特攻
		call xuanMingAddSpecialAttack(u)
	endif

	if GetUnitTypeId(ut) == 'n016' then
		call CreateItem('I0EW', GetUnitX(ut), GetUnitY(ut))
		// 杀大汗掉落胡卜处迩
		if dahanTask[i] == 1 then
			set dahanTask[i] = 0
			call commonAddReputation(GetOwningPlayer(GetKillingUnit()), 1000)
			call DisplayTextToPlayer(Player(i - 1), 0, 0, "|cff00ff00成功刺杀大汗，奖励1000声望和胡卜处迩|r")
		endif
	endif

	if GetUnitTypeId(ut) == 'n015' then
		// 杀尼摩星获取中原武学散篇
		if nimoxingTask[i] == 1 then
			set nimoxingTask[i] = 0
			call CreateItem('I0F2', GetUnitX(ut), GetUnitY(ut))
			call commonAddReputation(GetOwningPlayer(GetKillingUnit()), 200)
			call DisplayTextToPlayer(Player(i - 1), 0, 0, "|cff00ff00成功刺杀尼摩星，奖励200声望和中原武学散篇|r")
		endif
	endif

	if GetUnitTypeId(ut) == 'n019' then
		call killGreenDragon()
		call RemoveUnit(ut)
	endif

	set heroKillCounter[i] = heroKillCounter[i] + 1
	if heroKillCounter[i] == 10000 then
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF00B2玩家" + GetPlayerName(Player(i - 1)) + "解锁了|CFF00FF00彩蛋：万人敌，获得|CFFFF00B2特攻+50")
		set special_attack[i] = special_attack[i] + 50
	endif

	
	
	set u = null
	set ut = null
	return false
endfunction

//任意单位死亡事件系统
function UnitDeath takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH )
	call TriggerAddCondition(t, Condition(function UnitDeath_Conditions))
	set t = null
endfunction

