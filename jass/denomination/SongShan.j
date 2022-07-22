// 门派——嵩山

// 寒冰神掌 霜冻闪电
// 大嵩阳神掌 快速击退
// 无名内功 可以将内力隐藏起来，不让对方吸到一丝一毫。

// 与寒冰真气联动

// 专属
// 寒魄剑

// 称号
// 嵩山掌门
// 五岳盟主

// 嵩山剑法 被动白板
/*
 * 嵩山剑法 A0BF
 * 伤害系数：w1=24, w2=28
 * 伤害搭配：
 *		+双手互搏 A07U 伤害+80%
 *		+连城剑法 A06J 几率走火入魔
 */
function isSongShanJian takes unit u, unit ut returns boolean
	return PassiveWuGongCondition(u, ut, 'A0BF')
endfunction

function songShanCondition takes nothing returns boolean
	return DamageFilter(GetAttacker(), GetFilterUnit())
endfunction

function songSanAction takes nothing returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(GetAttacker()))

	// 双手互搏 +80%
	local real shxishu = 1. + DamageCoefficientByAbility(GetAttacker(),'A07U', 0.8)

	// 连城剑法=走火入魔
	if GetUnitAbilityLevel(GetAttacker(), 'A06J') >= 1 and GetRandomInt(1, 100) <= 60 then
    	call WanBuff(GetAttacker(), GetEnumUnit(), 2)
    endif

	// 专属 FIXME
	if UnitHaveItem(GetAttacker(), 'I0EJ') then
	    set shxishu = shxishu * 4
    endif
	call PassiveWuGongEffectAndDamage(GetAttacker(), GetEnumUnit(), "war3mapImported\\zhiyu.mdx", 24, 28, shxishu, 'A0BF')
endfunction

function songShanJianFa takes unit u, unit ut returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	call PassiveWuGongAction(u, ut, 15 + fuyuan[i] * 0.3, 700, Condition(function songShanCondition), function songSanAction, 'A0BF', 900.)
endfunction


// 子午十二剑 暴风雪 换个区域特效
function isZiWuJian takes nothing returns boolean
	return GetSpellAbilityId()=='A0BG'
endfunction
function ziWuJian takes nothing returns nothing
	local real x = GetSpellTargetX()
	local real y = GetSpellTargetY()
	local unit u = null
	call WuGongShengChong(GetTriggerUnit(),'A0BG',250)
	set u = null
endfunction

