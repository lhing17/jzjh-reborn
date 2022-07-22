//===========================================================
//被动技能范围伤害
//attacker = 攻击者
//attacker = 被攻击者
//spell_id = 技能ID
//range    = 技能范围
//damage   = 伤害值
//effects  = 特效
//possibility = 概率
//mana_cost = 蓝耗
//===========================================================
globals

endglobals


function UnitAttack_Conditions takes nothing returns boolean
	local unit u = GetAttacker()
	local unit ut = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(u)
	local location loc2 = GetUnitLoc(ut)
	local location temp_loc = null
	local group g = null
	local integer j = 0
	local integer k = 0
	local real x = 0
	local real y = 0
	local unit dummy = null

	// 嵩山剑法
	if isSongShanJian(u, ut) then
		call songShanJianFa(u, ut)
	endif

	// 千蛛手
    if PassiveWuGongCondition(u, ut, QIAN_ZHU_SHOU) then
        call qianZhuShou()
    endif

    // 千蛛手的蜘蛛攻击
    if GetUnitTypeId(u) == 'n00Y' then
        call qianZhuZhu()
    endif

    // 驭蛇奇术
    if PassiveWuGongCondition(u, ut, YU_SHE_SHU) then
        call yuSheShu()
	endif
	
	// 落英剑法
	if PassiveWuGongCondition(u, ut, LUO_YING_JIAN) and GetRandomReal(1, 100) <= 18 + fuyuan[i] * 0.2 then
		call luoYingJian(u, ut)
	endif
	
	// 旋风扫叶腿
	if PassiveWuGongCondition(u, ut, XUAN_FENG_TUI) and GetRandomReal(1, 100) <= 18 + fuyuan[i] * 0.2 then
		call xuanFengTui(u, ut)
	endif

	// 遭雷劈
	if PassiveWuGongCondition(u, ut, ZAO_LEI_PI) and GetRandomReal(1, 100) <= 16 + fuyuan[i] * 0.2 then
		call zaoLeiPi(u, ut)
	endif

	call RemoveLocation(loc)
	call RemoveLocation(loc2)
	set u = null
	set ut = null
	set loc = null
	set loc2 = null
	set p = null
	set dummy = null
	return false
endfunction


function UnitAttack takes nothing returns nothing
	local trigger t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t,Condition(function UnitAttack_Conditions))
	set t = null
endfunction
