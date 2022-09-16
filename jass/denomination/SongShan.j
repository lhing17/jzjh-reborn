// 门派——嵩山

// 嵩山剑法 十七路剑法
// 寒冰神掌 霜冻闪电 dota巫妖的大
// 子午十二剑  马可波罗突突枪
// 大嵩阳神掌 快速击退
// 无名内功 可以将内力隐藏起来，不让对方吸到一丝一毫。可以将内力快速转换为真实伤害，或反向转换（潮起潮落的机制）。每内化一个武功，转换时被转的属性有机率额外增加1点。

// 与寒冰真气联动

// 专属
// 寒魄剑

// 称号
// 嵩山掌门 四个技能都达到6重
// 五岳盟主 嵩山掌门+寒冰真气+寒魄剑
// 五岳盟主2 如果集齐五个门派掌门，再获得五岳盟主称号，奖励非常多

globals
	integer array wumingBaseCount // 无名内功基础内力
	integer array wumingCount // 无名内功总数
	integer array wumingStr // 无名内功转换为招式伤害
	integer array wumingAgi // 无名内功转换为内力
	integer array wumingInt // 无名内功转换为真实伤害
endglobals

// call YDWETimerPatternMoonPriestessArrow( GetTriggerUnit(), 0, 800, 1, 0.03, 1, 'A02G', 'hpea', "attack", "overhead", "[jx3]normal_10a.mdx" )

// 一技能：嵩山剑法 被动白板
/*
* 嵩山剑法 A0BF
* 伤害系数：w1 = 24, w2 = 28
* 伤害搭配：
*		+双手互搏 A07U 伤害+ 80 %
*		+连城剑法 A06J 几率走火入魔
*       +寒冰真气 A03L 几率冰冻
*       经脉>= 50 几率打出万岳朝宗的效果（在空中召唤一个山形的召唤物，投射物为小山，类似于石廪书声）
*/
function isSongShanJian takes unit u, unit ut returns boolean
	return PassiveWuGongCondition(u, ut, SONG_SHAN_JIAN_FA)
endfunction

function songShanCondition takes nothing returns boolean
	return DamageFilter(GetAttacker(), GetFilterUnit())
endfunction

function songSanAction takes nothing returns nothing
	local integer i = 1 + GetPlayerId(GetOwningPlayer(GetAttacker()))

	// 双手互搏 +80%
	local real shxishu = 1. + DamageCoefficientByAbility(GetAttacker(), 'A07U', 0.8)

	// 连城剑法=走火入魔
	if GetUnitAbilityLevel(GetAttacker(), LIAN_CHENG_JIAN_FA) >= 1 and GetRandomInt(1, 100) <= 30 then
		call WanBuff(GetAttacker(), GetEnumUnit(), 2)
	endif

	// 寒冰真气=冰冻
	if GetUnitAbilityLevel(GetAttacker(), HAN_BING_ZHEN_QI) >= 1 and GetRandomInt(1, 100) <= 20 then
		call WanBuff(GetAttacker(), GetEnumUnit(), 17)
	endif

	// 专属
	if UnitHasDenomWeapon(GetAttacker(), ITEM_HAN_PO_JIAN) then
		set shxishu = shxishu * 4
	endif
	call PassiveWuGongEffectAndDamage(GetAttacker(), GetEnumUnit(), "war3mapImported\\zhiyu.mdx", 12, 16, shxishu, SONG_SHAN_JIAN_FA)
endfunction

function songShanJianFa takes unit u, unit ut returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc1 = GetUnitLoc(u)
	local location loc2 = GetUnitLoc(ut)
	call PassiveWuGongAction(u, ut, 45 + fuyuan[i] * 0.3, 700, Condition(function songShanCondition), function songSanAction, SONG_SHAN_JIAN_FA, 600.)

	// 经脉>=50 几率打出万岳朝宗的效果（在空中召唤一个山形的召唤物，投射物为小山，类似于石廪书声）
	if jingmai[i] >= 50 and GetRandomInt(1, 100) <= 15 + fuyuan[i] / 5 then
		call CreateNUnitsAtLocFacingLocBJ(1, 'o030', p, PolarProjectionBJ(loc1, 300, 180 + GetUnitFacing(u)), loc2)
		call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', 10.)
	endif

	set p = null
	set loc1 = null
	set loc2 = null
endfunction

// 嵩山剑法 万岳朝宗特效


function wanYueChaoZong takes unit u, unit uc returns nothing
	local real shanghai = 0.
	local real shxishu = 1.

	// 专属
	if UnitHasDenomWeapon(u, ITEM_HAN_PO_JIAN) then
		set shxishu = shxishu * 4
	endif
	set shanghai = ShangHaiGongShi(u, uc, 200., 180., shxishu, SONG_SHAN_JIAN_FA)
	call WuGongShangHai(u, uc, shanghai)
endfunction


// 二技能：子午十二剑 
function ziWuShiErJianAction takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local integer j = LoadInteger(YDHT, GetHandleId(t), 1)
	local integer jMax = LoadInteger(YDHT, GetHandleId(t), 2)
	local real angle = GetUnitFacing(u)
	local real distance = 1000.
	local real duration = 1
	local unit dummy

	if j >= jMax then
		call FlushChildHashtable(YDHT, GetHandleId(t))
		call DestroyTimer(t)
	else
		call SaveInteger(YDHT, GetHandleId(t), 1, j + 1)
		set dummy = CreateUnit(GetOwningPlayer(u), 'h00O', GetUnitX(u), GetUnitY(u), angle)
		call YDWETimerPatternMoonPriestessArrow(dummy, angle, distance, duration, 0.03, 1, 'A0FB', 'e000', "thunderbolt", "overhead", "war3mapImported\\zhiyu.mdx" )
	endif

	set dummy = null
	set t = null
	set u = null
endfunction

function ziWuCdFive takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)

	// CD变为5秒
	call EXSetAbilityState(EXGetUnitAbility(u, ZI_WU_SHI_ER_JIAN), 1, 5)

	call FlushChildHashtable(YDHT, GetHandleId(t))
	call DestroyTimer(t)
	set t = null
	set u = null
endfunction

function ziWuShiErJian takes unit u returns nothing
	local integer count = 12
	local timer t = CreateTimer()
	local timer tm = null

	call WuGongShengChong(u, ZI_WU_SHI_ER_JIAN, 180)

	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call SaveInteger(YDHT, GetHandleId(t), 1, 0)
	call SaveInteger(YDHT, GetHandleId(t), 2, count)
	call TimerStart(t, 0.2, true, function ziWuShiErJianAction)

	// 左盟主称号 CD变为5秒
	if isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 50) then
		set tm = CreateTimer()
		call SaveUnitHandle(YDHT, GetHandleId(tm), 0, u)
		call TimerStart(tm, 0.2, false, function ziWuCdFive)
	endif


	set t = null
	set tm = null
endfunction


function ziWuShiErJianDamage takes unit u, unit ut returns nothing
	local real shanghai = 0.
	local real shxishu = 1.

	// 连城剑法 伤害+100%
	if GetUnitAbilityLevel(u, LIAN_CHENG_JIAN_FA) >= 1 then
		set shxishu = shxishu + 1
	endif

	// 辟邪剑法 伤害+150%
	if GetUnitAbilityLevel(u, BI_XIE_JIAN_FA) >= 1 then
		set shxishu = shxishu + 1.5
	endif

	// 专属
	if UnitHasDenomWeapon(u, ITEM_HAN_PO_JIAN) then
		set shxishu = shxishu * 4
	endif

	// 寒冰真气 几率冰冻
	if GetUnitAbilityLevel(u, HAN_BING_ZHEN_QI) >= 1 and GetRandomInt(1, 100) <= 20 then
		call WanBuff(u, ut, 17)
	endif

	set shanghai = ShangHaiGongShi(u, ut, 50., 50., shxishu, ZI_WU_SHI_ER_JIAN)
	call WuGongShangHai(u, ut, shanghai)
endfunction

// 三技能 寒冰神掌 每次受伤害最大掉血15%，主动使用时冰冻自己同时快速回复气血（每秒10%），并对周围单位造成持续伤害
// +寒冰真气 不再冰冻自己
// +无名内功 伤害和胆魄相关
// +双手互搏 回血速度加倍
// +洗髓经 每次受伤害最大掉血10%
function hanBingShenZhangDamaged takes unit u, real damage returns nothing
	local real coeff = 15
	if GetUnitAbilityLevel(u, XI_SUI_JING) >= 1 then
		set coeff = 10
	endif
	if damage > GetUnitState(u, UNIT_STATE_MAX_LIFE) * coeff / 100 then
		call WuDi(u)
		call BJDebugMsg(R2S(GetUnitLifePercent(u)))
		call SetUnitLifePercentBJ(u, GetUnitLifePercent(u) - coeff)
	endif
endfunction

function hanBingShenZhangDamage takes unit u, unit ut returns nothing
	local real shanghai = 0.
	local real shxishu = 1.

	// 专属
	if UnitHasDenomWeapon(u, ITEM_HAN_PO_JIAN) then
		set shxishu = shxishu * 4
	endif

	set shanghai = ShangHaiGongShi(u, ut, 50., 50., shxishu, HAN_BING_SHEN_ZHANG)
	call WuGongShangHai(u, ut, shanghai)
endfunction

function hanBingShenZhangAction takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local integer j = LoadInteger(YDHT, GetHandleId(t), 1)
	local group g
	local unit ut
	if j >= 6 then
		call FlushChildHashtable(YDHT, GetHandleId(t))
		call PauseTimer(t)
		call DestroyTimer(t)
	else
		call SaveInteger(YDHT, GetHandleId(t), 1, j + 1)
		if GetUnitAbilityLevel(u, SHUANG_SHOU) >= 1 then
			call SetWidgetLife(u, GetWidgetLife(u) + 0.2 * GetUnitState(u, UNIT_STATE_MAX_LIFE))
		else
			call SetWidgetLife(u, GetWidgetLife(u) + 0.1 * GetUnitState(u, UNIT_STATE_MAX_LIFE))
		endif
		set g = CreateGroup()
		call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 700, null)
		loop
			exitwhen CountUnitsInGroup(g) <= 0
			set ut = FirstOfGroup(g)
			if IsUnitEnemy(ut, GetOwningPlayer(u)) and IsUnitAliveBJ(ut) then
				call hanBingShenZhangDamage(u, ut)
			endif
			call GroupRemoveUnit(g, ut)
		endloop
		call DestroyGroup(g)
	endif
	set g = null
	set t = null
	set ut = null
endfunction

function hanBingShenZhang takes unit u returns nothing
	local unit dummy = CreateUnit(Player(6), 'e000', GetUnitX(u), GetUnitY(u), 270)
	local timer t = CreateTimer()

	call ShowUnit(dummy, false)
	call WuGongShengChong(u, HAN_BING_SHEN_ZHANG, 200)
	if GetUnitAbilityLevel(u, HAN_BING_ZHEN_QI) < 1 then
		call WanBuff(dummy, u, 17)
	endif
	call UnitApplyTimedLife(dummy, 'BHwe', 3.)

	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call SaveInteger(YDHT, GetHandleId(t), 1, 0)
	call TimerStart(t, 1, true, function hanBingShenZhangAction)

	set t = null
endfunction

// 毕业技 无名内功 增加100*等级的内力（第一次使用时加），主动使用时将增加的内力重新分配为招式伤害、内力、真实伤害。
// 每内化一个武功，重新分配时，分配总数增加10点
// +寒冰真气 每级后额外增加50点内力
// +北冥神功 内化加成额外增加10点
function wuMingNeiGong takes unit u returns nothing
	local integer level = GetUnitAbilityLevel(u, WU_MING_NEI_GONG)
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local integer base = 100

	call WuGongShengChong(u, WU_MING_NEI_GONG, 120)

	// +寒冰真气 每级后额外增加50点内力
	if GetUnitAbilityLevel(u, HAN_BING_ZHEN_QI) >= 1 then
		set base = base + 50
	endif

	// 先将之前增加的三围减掉
	call ModifyHeroStat(bj_HEROSTAT_STR, u, bj_MODIFYMETHOD_SUB, wumingStr[i])
	call ModifyHeroStat(bj_HEROSTAT_AGI, u, bj_MODIFYMETHOD_SUB, wumingAgi[i])
	call ModifyHeroStat(bj_HEROSTAT_INT, u, bj_MODIFYMETHOD_SUB, wumingInt[i])

	// 如果加的基础内力不到等级*100，就加到等级*100
	if wumingBaseCount[i] < level * base then
		// call ModifyHeroStat(bj_HEROSTAT_AGI, u, bj_MODIFYMETHOD_ADD, - wumingBaseCount[i] + level * base)
		set wumingAgi[i] = wumingAgi[i] - wumingBaseCount[i] + level * base
		set wumingBaseCount[i] = level * base
	endif

	// 重新随机分配招式伤害、内力和真实伤害
	set wumingCount[i] = wumingStr[i] + wumingAgi[i] + wumingInt[i]

	// 每内化一个武功，重新分配时，分配总数增加10点 +北冥神功 内化后额外增加10点内力
	if alreadyInternalizedCount[i] > 0 then
		set wumingCount[i] = wumingCount[i] + alreadyInternalizedCount[i] * 10 * (1 + GetUnitAbilityLevel(u, BEI_MING_SHEN_GONG))
	endif

	set wumingStr[i] = GetRandomInt(0, wumingCount[i])
	set wumingAgi[i] = GetRandomInt(0, wumingCount[i] - wumingStr[i])
	set wumingInt[i] = wumingCount[i] - wumingStr[i] - wumingAgi[i]
	call ModifyHeroStat(bj_HEROSTAT_STR, u, bj_MODIFYMETHOD_ADD, wumingStr[i])
	call ModifyHeroStat(bj_HEROSTAT_AGI, u, bj_MODIFYMETHOD_ADD, wumingAgi[i])
	call ModifyHeroStat(bj_HEROSTAT_INT, u, bj_MODIFYMETHOD_ADD, wumingInt[i])

endfunction



// 毕业技 大嵩阳神掌 主动使用，将敌方缓慢牵引至自己身边
// +寒冰真气 牵引结束后，对牵引的敌人造成伤害
// +北冥神功 牵引速度减慢
function daSongYangShenZhangAction takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit ut = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 1)

	call PauseUnit(ut, false)
	// +寒冰真气 牵引结束后，对牵引的敌人造成伤害
	if GetUnitAbilityLevel(u, HAN_BING_ZHEN_QI) >= 1 and IsUnitAliveBJ(ut) then
		call WuGongShangHai(u, ut, ShangHaiGongShi(u, ut, 1000, 1000, 1, DA_SONG_YANG_SHEN_ZHANG))
	endif


	call FlushChildHashtable(YDHT, GetHandleId(t))
	call DestroyTimer(t)

	set u = null
	set ut = null
	set t = null
endfunction

function daSongYangShenZhang takes unit u, unit ut returns nothing
	local real time = RMinBJ(4, ( YDWEDistanceBetweenUnits(u , ut) / 300.00 ))
	local timer t = CreateTimer()

	// +北冥神功 牵引速度减慢
	if GetUnitAbilityLevel(u, BEI_MING_SHEN_GONG) >= 1 then
		set time = time * 2
	endif

	call WuGongShengChong(u, DA_SONG_YANG_SHEN_ZHANG, 180)
	call PauseUnit(ut, true)
	call YDWETimerPatternRushSlide(ut , YDWEAngleBetweenUnits(ut , u) , RMinBJ(1200.00, YDWEDistanceBetweenUnits(u , ut)) , time , 0.02 , 0 , false , false , true , "origin" , "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl" , "Abilities\\Spells\\Human\\FlakCannons\\FlakTarget.mdl")
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, ut)
	call SaveUnitHandle(YDHT, GetHandleId(t), 1, u)
	call TimerStart(t, time, false, function daSongYangShenZhangAction)
	set t = null

endfunction

