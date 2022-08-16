

/*
 * 技能：千蛛手
 * 技能效果：被动攻击触发，造成AOE伤害
 * 技能伤害：w1 = 16, w2 = 20
 * 升重速度：900
 * 技能搭配：
 *  经脉 > 20：对AOE伤害的目标30%几率造成中毒
 *  福缘 > 20：被动攻击时几率召唤毒蛛，与AOE几率单独结算 
 *      毒蛛攻击w1 = 64, w2 = 78，攻击时几率造成中毒/深度中毒
 *  + 双手：福缘>20时召唤毒蛛数量加倍
 *  特殊攻击 >= 10：伤害+(70 + 3 * 特攻)%
 *  + 葵花：伤害+80%
 *  FIXME 更换特效模型
 */
// 千蛛手的蜘蛛
function qianZhuZhu takes nothing returns nothing
	local player p = GetOwningPlayer(GetAttacker())
	local integer i = 1 + GetPlayerId(p)
	local unit u = udg_hero[i]
	local unit uc = GetTriggerUnit()
	local real shanghai = 0.
	local real shxishu = 1. //初始伤害系数

    // 特攻伤害加成
    if special_attack[i] >= 10 then
        set shxishu = shxishu + 0.7 + 0.03 * special_attack[i]
    endif

    // 葵花伤害加成
    if GetUnitAbilityLevel(u, KUI_HUA)>=1 then
        set shxishu = shxishu + 0.8
    endif

    // 专属加成
    if UnitHasDenomWeapon(u, ITEM_HAN_SHA) then
        set shxishu = shxishu * ( 2 + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_HAN_SHA)))
    endif

	set shanghai = ShangHaiGongShi(u, uc, 64., 78., shxishu, QIAN_ZHU_SHOU)
	call WuGongShangHai(u, uc, shanghai)

    // 毒蛛攻击触发中毒效果
	if GetRandomInt(1, 100) <= 20 then
	    call WanBuff(u, uc, 13) // 中毒
	elseif GetRandomInt(1, 100) <= 20 then
	    call WanBuff(u, uc, 14) // 深度中毒
	endif

	set uc = null
	set u = null
	set p = null
endfunction


function qianZhuShouCondition takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker())) and IsUnitAliveBJ(GetFilterUnit())
endfunction

// 千蛛手的AOE效果
function qianZhuShouAoe takes nothing returns nothing
    local unit uc = GetEnumUnit()
	local unit u = GetAttacker()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local real shxishu=1.
	local real shanghai=0.

    // 特攻伤害加成
    if special_attack[i] >= 10 then
        set shxishu = shxishu + 0.7 + 0.03 * special_attack[i]
    endif

    // 葵花伤害加成
    if GetUnitAbilityLevel(u, KUI_HUA)>=1 then
        set shxishu = shxishu + 0.8
    endif

    // 专属加成
    if UnitHasDenomWeapon(u, ITEM_HAN_SHA) then
        set shxishu = shxishu * ( 2 + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_HAN_SHA)))
    endif

	set shanghai=ShangHaiGongShi(u, uc, 16., 20.,shxishu, QIAN_ZHU_SHOU)
	call WuGongShangHai(u,uc,shanghai)

    // AOE的特效
    call DestroyEffectEx(AddSpecialEffectTargetEx("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", uc, "origin"))

    // 经脉达到20有一定概率触发中毒
    if jingmai[i] >= 20 and GetRandomInt(1, 100) < 30 then
        call WanBuff(u, uc, 13)
    endif



	set u=null
    set uc=null
endfunction


// 千蛛手：对周围敌人造成少量AOE伤害
function qianZhuShou takes nothing returns nothing
    local unit u = GetAttacker()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer id = 'n00Y'
	local unit temp = null
    local group g=CreateGroup()
    local real r = 500. + 40. * GetUnitAbilityLevel(u, QIAN_ZHU_SHOU)

    // AOE效果
    if GetRandomInt(1, 100) <= 15 + fuyuan[i] / 5 then
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), r, Condition(function qianZhuShouCondition))
        call ForGroup(g, function qianZhuShouAoe)
        call WuGongShengChong(u, QIAN_ZHU_SHOU, 900.)
    endif

    // 福缘达到20，召唤毒蛛效果
    if fuyuan[i] >=20 and GetRandomInt(1, 100) <= 15 + fuyuan[i] / 5 then
        set temp = CreateUnit(p, id, GetUnitX(u), GetUnitY(u), 270)
    	call UnitApplyTimedLifeBJ(5, 'BTLF', temp)
    	call WuGongShengChong(u, QIAN_ZHU_SHOU, 900.)

        // 搭配双手：双倍毒蛛效果
    	if GetUnitAbilityLevel(u, SHUANG_SHOU)>=1 then
    	    set temp = CreateUnit(p, id, GetUnitX(u), GetUnitY(u), 270)
            call UnitApplyTimedLifeBJ(5, 'BTLF', temp)
    	endif

    endif

    call GroupClear(g)
    call DestroyGroup(g)
    set g=null
	set p=null
	set u=null
	set temp = null
endfunction

/*
 * 技能：五毒笛咒
 * 技能效果：主动释放，放出毒雾造成AOE伤害，造成随机不良效果，毒雾持续时间为5秒。
 * 技能伤害：w1 = 14, w2 = 80
 * 升重速度：100
 * 技能搭配：
 *  + 葵花：伤害+80%
 *  + 化骨：伤害+80%
 *  + 化功：伤害+80%
 */
// 五毒笛咒
function wuDuZhou takes nothing returns nothing
    local unit temp = null
    local unit u = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    call WuGongShengChong(u, WU_DU_ZHOU, 100)
    set temp = CreateUnit(p, 'e000', x, y, 270)
    call UnitAddAbility(temp, 'A0DW')
    call SetUnitAbilityLevel(temp, 'A0DW', GetUnitAbilityLevel(u, WU_DU_ZHOU))
    call ShowUnitHide(temp)
    call IssuePointOrderById(temp, $D0208, x, y)
    call UnitApplyTimedLife(temp, 'BHwe', 3.)

    set temp = null
    set u = null
    set p = null
endfunction


function wuDuZhouDamage takes nothing returns nothing
	local unit u = udg_hero[(1+GetPlayerId(GetOwningPlayer(GetEventDamageSource())))]
    local unit uc = GetTriggerUnit()
    local real shxishu = 1.
    local real shanghai = 0.

    // 一定概率随机产生一种debuff
    if GetRandomInt(1, 100) <= 25 then
        call WanBuff(u, uc, GetRandomInt(1, 16))
    endif

    if GetUnitAbilityLevel(u, KUI_HUA)!=0 then
        set shxishu = shxishu + 0.8
    endif
    if GetUnitAbilityLevel(u, HUA_GU)!=0 then
        set shxishu = shxishu + 0.8
    endif
    if GetUnitAbilityLevel(u, HUA_GONG)!=0 then
        set shxishu = shxishu + 0.8
	endif

	// 专属加成
    if UnitHasDenomWeapon(u, ITEM_HAN_SHA) then
        set shxishu = shxishu * ( 2 + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_HAN_SHA)))
    endif

    set shanghai=ShangHaiGongShi(u,uc,14,80,shxishu, WU_DU_ZHOU)
    call WuGongShangHai(u,uc,shanghai)

    set u=null
    set uc=null
endfunction

/*
 * 技能：噬心剑法
 * 技能效果：被动攻击触发，造成单体伤害
 * 技能伤害：w1 = 30, w2 = 160
 * 升重速度：600
 * 技能搭配：
 *  被攻击单位中毒：引发毒爆AOE伤害：w1 = 16, w2 = 80
 *  + 蛇杖：伤害 + 200%
 *  + 化骨绵掌：破防
 *  + 葵花：虚弱
 */
// 驭蛇术引发毒爆
function yuSheShuExplosion takes nothing returns nothing
    local unit uc = GetEnumUnit()
	local unit u = GetAttacker()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local real shxishu=1.
	local real shanghai=0.

    // 蛇杖效果 毒爆伤害+200%
    if UnitHaveItem(u, ITEM_SHE_ZHANG) then
        set shxishu = shxishu + 2
    endif

    // 专属加成
    if UnitHasDenomWeapon(u, ITEM_HAN_SHA) then
        set shxishu = shxishu * ( 2 + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_HAN_SHA)))
    endif


	set shanghai=ShangHaiGongShi(u, uc, 16., 80.,shxishu, YU_SHE_SHU)
    call DestroyEffectEx(AddSpecialEffectTargetEx("Objects\\Spawnmodels\\NightElf\\EntBirthTarget\\EntBirthTarget.mdl", uc, "origin"))
	call WuGongShangHai(u,uc,shanghai)

	set u=null
    set uc=null
endfunction


// 噬心剑法
function yuSheShu takes nothing returns nothing
    local unit u = GetAttacker()
    local unit ut = GetTriggerUnit()
    local player p = GetOwningPlayer(u)
    local integer i = 1 + GetPlayerId(p)
    local real shxishu = 1.
    local real damage = 1.
    local real range = 600
    local group g = null

    // 1. 造成单体伤害
    if GetRandomInt(1, 100) <= fuyuan[i] / 5 + 15 then

        // 5. 蛇杖效果 伤害+200%，毒爆伤害也+200%伤害
        if UnitHaveItem(u, ITEM_SHE_ZHANG) then
            set shxishu = shxishu + 2
        endif

        // 专属加成
        if UnitHasDenomWeapon(u, ITEM_HAN_SHA) then
            set shxishu = shxishu * ( 2 + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_HAN_SHA)))
        endif
        
        set damage = ShangHaiGongShi(u, ut, 30, 160, shxishu, YU_SHE_SHU)
        call DestroyEffectEx(AddSpecialEffectTargetEx("Objects\\Spawnmodels\\Undead\\UDeathSmall\\UDeathSmall.mdl", ut, "overhead"))
        call WuGongShangHai(u, ut, damage)

        // 3. 技能搭配 + 化骨：破防 
        if GetUnitAbilityLevel(u, HUA_GU)>=1 then
            call WanBuff(u, ut, 9)
        endif

        // 4. 技能搭配 + 葵花：虚弱
        if GetUnitAbilityLevel(u, KUI_HUA)>=1 then
            call WanBuff(u, ut, 16)
        endif

        // 2. 如果目标有中毒/深度中毒BUFF，造成毒爆
        if UnitHasBuffBJ(ut, POISONED_BUFF) or UnitHasBuffBJ(ut, DEEP_POISONED_BUFF) then
            // 深度中毒毒爆范围扩大
            if UnitHasBuffBJ(ut, DEEP_POISONED_BUFF) then
                set range = 900
            endif

            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, GetUnitX(ut), GetUnitY(ut), range, Condition(function qianZhuShouCondition))
            call ForGroup(g, function yuSheShuExplosion)
            call DestroyGroup(g)
        endif

        // 6. 武功升重
        call WuGongShengChong(u, YU_SHE_SHU, 600.)
    endif

    set g = null
    set u = null
    set ut = null
endfunction

/*
 * 技能：补天心经
 * 技能效果：使用后可以增加气血值或真实伤害，但是有一定概率直接死亡
 * 升重速度：60
 * 技能CD：60秒
 * 技能搭配：
 *  + 葵花：增加量翻倍，死亡概率翻倍
 *  + 小无相：不会死亡
 *  + 吸星大法：使用后10秒内大幅提升攻速
 *  + 龙象般若功：CD减半
 */

function buTianHalfCd takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)

    // 搭配 +龙象般若功 CD减半
    if GetUnitAbilityLevel(u, LONG_XIANG) >= 1 then
        call EXSetAbilityState(EXGetUnitAbility(u, BU_TIAN_JING), 1, EXGetAbilityState(EXGetUnitAbility(u, BU_TIAN_JING), 1) / 2)
    endif

    call FlushChildHashtable(YDHT, GetHandleId(t))
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction

// 补天心经
function buTianJing takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local integer level = GetUnitAbilityLevel(u, BU_TIAN_JING)
    local integer lifeBase = 500
    local integer realDamageBase = 10
    local integer deathPossibility = 15 - level
    local timer t = CreateTimer()

    call WuGongShengChong(u, BU_TIAN_JING, 60.)

    // 搭配 +葵花 提升增加量，但同时提升死亡概率
    if GetUnitAbilityLevel(u, KUI_HUA)>=1 then
        set lifeBase = lifeBase * 2
        set deathPossibility = deathPossibility * 2
    endif 

    // 搭配 +小无相 不会死亡
    if GetUnitAbilityLevel(u, XIAO_WU_XIANG)>=1 then
        set deathPossibility = 0
    endif 

    // 搭配 +吸星大法 10秒之内提升攻速
    if GetUnitAbilityLevel(u, XI_XING)>=1 then
        call maJiaUseLeveldAbilityAtTargetLoc(u, 'e000',  'A08F', 4, $D0085, u, 3)
    endif 
    
    // 50%概率增加气血上限，50%概率增加真实伤害
    if GetRandomInt(1, 100) <= 50 then
        call DestroyEffectEx(AddSpecialEffectTargetEx("war3mapImported\\zhiyu.mdx", u, "overhead"))
        call LifeChange(u, 1, - lifeBase * level, 'A0DQ')
    else
        call DestroyEffectEx(AddSpecialEffectTargetEx("war3mapImported\\lifebreak.mdx", u, "overhead"))
        call ModifyHeroStat(2, u, 0, realDamageBase * level)
    endif


    // 一定概率死亡
    if GetRandomInt(1, 100) <= deathPossibility then
        call KillUnit(u)
    endif

    call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
    call TimerStart(t, 0.2, false, function buTianHalfCd)
    

    set t = null
    set u = null
endfunction

/*
 * 技能：万蜍噬心
 * 技能效果：向周围1200码内敌人掷出数枚暗器毒蛤，造成当前血量百分比伤害，并使其深度中毒
 * 公式：23 + 0.3 * 等级
 * 升重速度：120
 * 技能CD：20秒
 * 技能搭配：
 *  + 双手：暗器数量加倍
 *  + 含沙射影：暗器数量加倍
 *  + 葵花：增加百分比伤害
 *  + 小无相：CD减半
 */
function wanChuCondition takes nothing returns boolean
    return DamageFilter(LoadUnitHandle(YDHT, GetHandleId(GetExpiredTimer()), 0), GetFilterUnit())
endfunction

function wanChuAction takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
    local player p = GetOwningPlayer(u)
    local integer j = LoadInteger(YDHT, GetHandleId(t), 1)
    local integer jmax = 4
    local group g = null
    local unit target = null
    local unit dummy = null

    // 搭配双手：暗器数量加倍
    if GetUnitAbilityLevel(u, SHUANG_SHOU)>=1 then
        set jmax = jmax * 2
    endif

    // 搭配含沙射影：暗器数量加倍
    if UnitHasDenomWeapon(u, ITEM_HAN_SHA) then
        set jmax = jmax * 2
    endif
    
    if j == 1 then
        // 搭配 +小无相 CD减半
        if GetUnitAbilityLevel(u, XIAO_WU_XIANG) >= 1 then
            call EXSetAbilityState(EXGetUnitAbility(u, WAN_CHU_SHI_XIN), 1, EXGetAbilityState(EXGetUnitAbility(u, WAN_CHU_SHI_XIN), 1) / 2)
        endif
        // "婆婆姊姊"称号 CD减半
        if isTitle(1 + GetPlayerId(p), 45) then
            // call EXSetAbilityState(EXGetUnitAbility(u, WAN_CHU_SHI_XIN), 1, 0)
            call EXSetAbilityState(EXGetUnitAbility(u, WAN_CHU_SHI_XIN), 1, EXGetAbilityState(EXGetUnitAbility(u, WAN_CHU_SHI_XIN), 1) / 2)
        endif
    endif

    if j < jmax then 
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, GetUnitX(u), GetUnitY(u), 1200, Condition(function wanChuCondition))
        set target = GroupPickRandomUnit(g)
        set dummy = CreateUnit(p, 'e000', GetUnitX(u), GetUnitY(u), bj_UNIT_FACING)
        call ShowUnitHide(dummy)
        call UnitAddAbility(dummy, 'A0DK')
        call IssueTargetOrderById( dummy, $D007F, target )
        call UnitApplyTimedLife(dummy,'BHwe', 3)
        call DestroyGroup(g)
        call SaveInteger(YDHT, GetHandleId(t), 1, j + 1)
    else
        call FlushChildHashtable(YDHT, GetHandleId(t))
        call PauseTimer(t)
        call DestroyTimer(t)
    endif

    set g = null
    set target = null
    set dummy = null
    set t = null
    set u = null
    set p = null
endfunction

// 万蜍噬心
function wanChuShiXin takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local timer t = CreateTimer()
    call WuGongShengChong(u, WAN_CHU_SHI_XIN, 120.)

    call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
    call TimerStart(t, 0.2, true, function wanChuAction)

    

    set u = null
endfunction


function wanChuEffect takes nothing returns nothing
    local unit u = udg_hero[1 + GetPlayerId(GetOwningPlayer(GetEventDamageSource()))]
    local unit target = GetTriggerUnit()
    // 葵花搭配：增加百分比伤害
    local real coeff = 0.77 - 0.03 * GetUnitAbilityLevel(u, WAN_CHU_SHI_XIN) * (1 + GetUnitAbilityLevel(u, KUI_HUA))

    call percentDamage(target, 100 - 100 * coeff , false)
    call WanBuff(u, target, 14)

    set u = null
    set target = null
endfunction
