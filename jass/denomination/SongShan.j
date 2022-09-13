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
	integer array wumingStatus // 无名内功状态：收/放
	constant integer HAN_PO_JIAN = 'I0EJ' // FIXME 寒魄剑（专属）


	constant integer SONG_SHAN_JIAN_FA = 'A0BF'
	constant integer ZI_WU_SHI_ER_JIAN = 'A0FA'
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
	if GetUnitAbilityLevel(GetAttacker(), 'A06J') >= 1 and GetRandomInt(1, 100) <= 60 then
		call WanBuff(GetAttacker(), GetEnumUnit(), 2)
	endif

	// 寒冰真气=冰冻
	if GetUnitAbilityLevel(GetAttacker(), 'A03L') >= 1 and GetRandomInt(1, 100) <= 20 then
		call WanBuff(GetAttacker(), GetEnumUnit(), 17)
	endif

	// 专属 FIXME
	if UnitHasDenomWeapon(GetAttacker(), HAN_PO_JIAN) then
		set shxishu = shxishu * 4
	endif
	call PassiveWuGongEffectAndDamage(GetAttacker(), GetEnumUnit(), "war3mapImported\\zhiyu.mdx", 24, 28, shxishu, SONG_SHAN_JIAN_FA)
endfunction

function songShanJianFa takes unit u, unit ut returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc1 = GetUnitLoc(u)
	local location loc2 = GetUnitLoc(ut)
	call PassiveWuGongAction(u, ut, 15 + fuyuan[i] * 0.3, 700, Condition(function songShanCondition), function songSanAction, SONG_SHAN_JIAN_FA, 900.)

	// 经脉>=50 几率打出万岳朝宗的效果（在空中召唤一个山形的召唤物，投射物为小山，类似于石廪书声）
	if jingmai[i] >= 50 and GetRandomInt(1, 100) <= 15 + fuyuan[i] / 5 then
		call CreateNUnitsAtLocFacingLocBJ(1, id, p, PolarProjectionBJ(loc1, 300, 180 + angle), loc2)
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
	if UnitHasDenomWeapon(u, HAN_PO_JIAN) then
		set shxishu = shxishu * 4
	endif
	set shanghai = ShangHaiGongShi(u, uc, 200., 180., shxishu, SONG_SHAN_JIAN_FA)
	call WuGongShangHai(u, uc, shanghai)
endfunction


// 二技能：子午十二剑 
function ziWuShiErJian takes unit u returns nothing
	local real angle = GetUnitFacing(u)
	local real distance = 1000.
	call YDWETimerPatternMoonPriestessArrow( u, angle, distance, 1, 0.03, 1, 'A02G', 'hpea', "attack", "overhead", "[jx3]normal_10a.mdx" )
endfunction


