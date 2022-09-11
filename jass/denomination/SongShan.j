// 门派——嵩山

// 十七路剑法
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
	if UnitHasDenomWeapon(GetAttacker(), 'I0EJ') then
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

