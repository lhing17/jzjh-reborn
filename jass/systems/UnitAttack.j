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

// 紫怪攻击
function ziguaiAttack takes unit u, unit ut returns nothing
    local location loc = GetUnitLoc(ut)

	// 克制防御最大化
	if UnitHasBuffBJ(ut, 'Binf') and GetRandomInt(1, 100) <= 15 then
		call UnitRemoveBuffBJ('Binf', ut)
		call CreateTextTagLocBJ("防御失效",loc,60.,12.,65.,55.,42.,0)
		call Nw(3.,bj_lastCreatedTextTag)
        call SetTextTagVelocityBJ(bj_lastCreatedTextTag,100.,90)
	endif

	// 克制九阳神功
	if GetUnitAbilityLevel(ut, 'A0DL') >= 1 and GetRandomInt(1, 100) <= 15 then
		call UnitRemoveAbility(ut, 'A0DL')
		call UnitRemoveAbility(ut, 'A0DM')
		call UnitRemoveAbility(ut, 'A0CO')
		call UnitRemoveAbility(ut, 'A0CQ')
		call CreateTextTagLocBJ("九阳失效",loc,60.,12.,65.,55.,42.,0)
        call Nw(3.,bj_lastCreatedTextTag)
        call SetTextTagVelocityBJ(bj_lastCreatedTextTag,100.,90)
	endif

	// 破防
	if GetRandomInt(1, 100) <= 15 then
	    call WanBuff(u, ut, 9)
	endif

	call RemoveLocation(loc)
	set loc = null

endfunction

function UnitAttack_Conditions takes nothing returns boolean
	local unit u = GetAttacker()
	local unit ut = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
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

	// 玄冥神掌
	if GetUnitAbilityLevel(u, XUAN_MING_SHEN_ZHANG) > 0 and GetUnitAbilityLevel(u, JIU_YANG) == 0 and IsUnitEnemy(u, GetOwningPlayer(ut)) then
		call xuanMingShenZhang(u)
	endif

	// 雪山剑法
	if PassiveWuGongCondition(u, ut, XUE_SHAN_JIAN_FA)  and GetRandomReal(1, 100) <= 16 + fuyuan[i] * 0.2 then
		call xueShanJianFa(u, ut)
	endif

	// 金乌刀法
	if PassiveWuGongCondition(ut, u, JIN_WU_DAO_FA) and GetRandomReal(1, 100) <= 10 + fuyuan[1 + GetPlayerId(GetOwningPlayer(ut))] * 0.4 then
		call jinWuDaoFa(ut, u)
	endif

	// 无妄神功
	if PassiveWuGongCondition(u, ut, WU_WANG_SHEN_GONG) then
		call wuWangShenGongSpecial(u, ut)
	endif

	// 光明教：光明太极拳
	if PassiveWuGongCondition(u, ut, RI_YUE_TAI_JI_QUAN) and GetRandomReal(1, 100) <= 16 + fuyuan[i] * 0.2 then
		call riYueTaiJi(u)
	endif

	// 加入葵花派后被打触发光明太极拳
	if GetUnitAbilityLevel(ut, RI_YUE_TAI_JI_QUAN) >= 1 and IsUnitEnemy(u, GetOwningPlayer(ut)) and joinSunOrMoon[1 + GetPlayerId(GetOwningPlayer(ut))] == JOIN_MOON and GetRandomReal(1, 1000) <= 16 + fuyuan[1 + GetPlayerId(GetOwningPlayer(ut))] * 0.2 then
		call riYueTaiJi(ut)
	endif


	// 光明教：神教宝训
	if PassiveWuGongCondition(u, ut, SHEN_JIAO_BAO_XUN) and GetRandomReal(1, 100) <= 16 + fuyuan[i] * 0.2 then
		call shenJiaoBaoXun(u)
	endif

	// 紫怪攻击
	if LoadInteger(YDHT, GetHandleId(u), StringHash("color")) == 4 then
		call ziguaiAttack(u, ut)
	endif

	set u = null
	set ut = null

	set p = null
	set dummy = null
	return false
endfunction


function UnitAttack takes nothing returns nothing
	local trigger t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
	call TriggerAddCondition(t, Condition(function UnitAttack_Conditions))
	set t = null
endfunction
