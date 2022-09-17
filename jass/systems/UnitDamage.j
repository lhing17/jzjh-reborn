
function UnitDamage_Conditions takes nothing returns boolean
	local unit u = GetEventDamageSource()
	local unit uc = null
	local unit ut = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(u)
	local location loc2 = GetUnitLoc(ut)
	local real damage = GetEventDamage()
	local trigger t = null
	
	if damage == 5.93 then
		call wanChuEffect()
	endif
	
	if damage == 5.41 then
		call wuDuZhouDamage()
	endif
	
	// 落英神剑掌
	if damage == 6.01 then
		call luoYingZhangDamage(udg_hero[i], ut)
	endif
	
	// 落英剑法
	if damage == 6.02 then
		call luoYingJianDamage(udg_hero[i], ut)
	endif
	
	// 旋风扫叶腿
	if damage == 6.03 then
		call xuanFengTuiDamage(udg_hero[i], ut)
	endif

	// 奇门术数
	if damage == 6.04 then
		call qiMenShuShuDamage(udg_hero[i], ut)
	endif
	
	// 遭雷劈
	if damage == 6.05 then
		call zaoLeiPiDamage(udg_hero[i], ut)
	endif

	// 大功告成
	if damage > GetWidgetLife(ut) and GetUnitAbilityLevel(ut, DA_GONG_GAO_CHENG) >= 1 then
		call daGongGaoCheng(ut)
	endif

	// 风沙莽莽
	if damage == 0.58 then
		call fengShaMangMangDamage(udg_hero[i], ut)
	endif

	// 雪花六出
	if damage == 0.59 then
		call xueHuaLiChuDamage(udg_hero[i], ut)
	endif

	// 嵩山剑法-万岳朝宗
	if GetUnitTypeId(u) == 'o030' then
		call wanYueChaoZong(udg_hero[i], ut)
	endif

	// 嵩山-子午十二剑
	if damage == 0.94 then
		call ziWuShiErJianDamage(udg_hero[i], ut)
	endif

	// 嵩山-寒冰神掌
	// if GetUnitAbilityLevel(ut, HAN_BING_SHEN_ZHANG) >= 1 then
	// 	call hanBingShenZhangDamaged(ut, damage)
	// endif
	
	set t = null
	set u = null
	set ut = null
	set uc = null
	set loc = null
	set loc2 = null
	set p = null
	return false
endfunction




//任意单位伤害事件系统
function UnitDamage takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call YDWESyStemAnyUnitDamagedRegistTrigger( t )
	call TriggerAddCondition(t,Condition(function UnitDamage_Conditions))
	set t = null
endfunction
