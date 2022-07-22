/*
* @version：决战江湖1.6.38
* @author: zei_kale
* @date:2020.04.02
*
* 野螺派武功：装逼遭雷劈 八面玲珑 反手牵猪 乾坤一掷 大功告成
*/

// - 装逼遭雷劈 我装逼你遭雷劈 被动
//     - 我能打20位伤害
//     - 今天天气好好哦
//     - 送每人一套决战江湖
//     - +无魅雷手 伤害+200% 让雷来得更猛烈一些 小伤害6.05
function zaoLeiPiAction takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local real x = LoadReal(YDHT, GetHandleId(t), 1)
	local real y = LoadReal(YDHT, GetHandleId(t), 2)
	local unit dummy = CreateUnit(GetOwningPlayer(u), 'e01K', x, y, bj_UNIT_FACING)
	local group g = CreateGroup()
	call UnitAddAbility(dummy, 'A0EU') // 马甲技能
	call UnitApplyTimedLife(dummy, 'BHwe', 2)
	call GroupEnumUnitsInRange(g, GetUnitX(dummy), GetUnitY(dummy), 900, Condition(function isPlayersEnemy))
	call IssueTargetOrderById(dummy, $D026B, FirstOfGroup(g))
	call GroupClear(g)
	call DestroyGroup(g)
	set g = null
	set t = null
	set dummy = null
endfunction

function zaoLeiPi takes unit u, unit ut returns nothing
	local timer t = CreateTimer()
	local location loc = null
	local string s = ""
	local integer rand = GetRandomInt(1, 100)

	call WuGongShengChong(u, ZAO_LEI_PI, 700)
	
	
	set loc = GetUnitLoc(u)
	if rand < 50 then
		set s = "20位伤害随便打"
	else
		set s = "单手快速一波七"
	endif
	call CreateTextTagLocBJ(s, loc, 0, 15., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
	call Nw(3,bj_lastCreatedTextTag)
	call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
	call RemoveLocation(loc)
	
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call SaveReal(YDHT, GetHandleId(t), 1, GetUnitX(ut))
	call SaveReal(YDHT, GetHandleId(t), 2, GetUnitY(ut))
	call TimerStart(t, 0.3, true, function zaoLeiPiAction)
	call YDWETimerDestroyTimer(3.1, t)
	set t = null
	set loc = null
endfunction

function zaoLeiPiDamage takes unit u, unit ut returns nothing
	local real shxishu = 1.
	local real shanghai = 0.
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
 
	// 无魅雷手
	if UnitHaveItem(u, 'I00S') then
		set shxishu = shxishu + 2
	endif
	
	// 专属
	if UnitHasDenomWeapon(u, ITEM_YE_LUO) then
		set shxishu = shxishu * ( 2 + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_YE_LUO)))
	endif
	
	// 胆魄加成伤害
	set shxishu = shxishu + danpo[i] * 0.03
	
	set shanghai = ShangHaiGongShi(u, ut, 20, 20, shxishu, ZAO_LEI_PI)
	call WuGongShangHai(u, ut, shanghai)
endfunction

function isShopDecoration takes integer id returns boolean
	return id == 'I01Z' or id == 'I01Y' or id == 'I01V' or id == 'I01K' or id == 'I018' or id == 'I01I'
endfunction

function isShopWeapon takes integer id returns boolean
	return id == 'I01F' or id == 'I013' or id == 'I016'
endfunction

function isShopEuqip takes integer id returns boolean
	return id == 'I01T' or id == 'I01H' or id == 'I017'
endfunction

function isShopKungfu takes integer id returns boolean
	local integer i = 1
	loop
	exitwhen i > 18
		if id == udg_jianghu[i] then
			return true
		endif
		set i = i + 1
	endloop
	set i = 1
	loop
	exitwhen i > 10
		if id == udg_juexue[i] then
			return true
		endif
		set i = i + 1
	endloop
	set i = 1
	loop
	exitwhen i > 8
		if id == udg_juenei[i] then
			return true
		endif
		set i = i + 1
	endloop
	return id == 'I0AI' or id == 'I0AH' or id == 'I0AJ'
endfunction

function isShopOther takes integer id returns boolean
	return id == 'I08W' or id == 'I0D1' or id == 'I00E' 
endfunction


// - 八面玲珑 被动
//     - 讨价还价 买东西返利20% + 3*等级 +龙象 返利+30%
//     - 通融通融 历练用钱不用声望 （10% * 历练数）金钱 
function baMianLingLong takes unit u, item it returns nothing
	local integer gold = S2I(EXExecuteScript("(require'jass.slk').item[" + I2S(GetItemTypeId(it)) + "].goldcost"))
	local integer lumber = S2I(EXExecuteScript("(require'jass.slk').item[" + I2S(GetItemTypeId(it)) + "].lumbercost"))
	local integer level = GetUnitAbilityLevel(u, BA_MIAN_LING_LONG)
	local real rate = 0.01 * (20 + 3 * level)
	local integer gold_return
	local integer lumber_return
	local integer id = GetItemTypeId(it)
	if not IsUnitType(u, UNIT_TYPE_DEAD) and (isShopDecoration(id) or isShopWeapon(id) or isShopEuqip(id) or isShopKungfu(id) or isShopOther(id)) then
		if GetUnitAbilityLevel(u, LONG_XIANG) >= 1 then
			set rate = rate + 0.3
		endif
		
		set gold_return = R2I(gold * rate) + 1
		set lumber_return = R2I(lumber * rate) + 1
		
		call AdjustPlayerStateBJ(gold_return, GetOwningPlayer(u),PLAYER_STATE_RESOURCE_GOLD)
		call AdjustPlayerStateBJ(lumber_return, GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
		call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00购买成功，返利金币+"+I2S(gold_return)+"，珍稀币+"+I2S(lumber_return))
		
		call WuGongShengChong(u, BA_MIAN_LING_LONG, 50)
	endif
endfunction




// - 反手牵猪 偷钱 偷木 主动
//     - +寻宝师副职 偷奇武 
//     - +妙手 偷秘籍（不含奇武）
//     - +炼丹师副职 偷丹药
//     - +寻宝大师 偷武器
function fanShouQianZhu takes unit u, unit ut returns nothing
	local integer qiwu_rand = GetRandomInt(1, 15)
	local integer miji_rand
	local integer item_id
	local integer dan_rand = GetRandomInt(1, 11)
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local real addition = 1
	local integer gold_num
	local integer lumber_num
	
	if UnitHasDenomWeapon(u, ITEM_YE_LUO) then
		set addition = addition + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_YE_LUO))
	endif
	
	call WuGongShengChong(u, FAN_SHOU_QIAN_ZHU, 80)
	call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl", ut, "chest"))
	// 判断目标是否为BOSS
	if ModuloInteger(GetUnitPointValue(ut), 100)==1 or ModuloInteger(GetUnitPointValue(ut), 100)==2 then
		set gold_num = R2I(1000 * GetRandomInt(2, 20) * addition)
		set lumber_num = R2I(6 * GetRandomInt(2, 20) * addition)
		call AdjustPlayerStateBJ(gold_num, GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD)
		call AdjustPlayerStateBJ(lumber_num, GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER)
		call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了金币+|r" + I2S(gold_num))
		call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了珍稀币+|r" + I2S(lumber_num))
		if Deputy_isDeputy(i, XUN_BAO) and GetRandomInt(1, 100) <= R2I(20 * addition) then
			call UnitAddItemById(u, udg_qiwu[qiwu_rand])
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了奇武|r" + GetObjectName(udg_qiwu[qiwu_rand]))
		endif
		if GetUnitAbilityLevel(u, MIAO_SHOU_KONG_KONG) >= 1 and GetRandomInt(1, 100) <= R2I(20 * addition) then
			if GetRandomInt(1, 100) <= 80 then
				set miji_rand = GetRandomInt(1, 18)
				set item_id = udg_jianghu[miji_rand]
			elseif GetRandomInt(1, 100) <= 80 then
				set miji_rand = GetRandomInt(1, 10)
				set item_id = udg_juexue[miji_rand]
			elseif GetRandomInt(1, 100) <= 80 then
				set miji_rand = GetRandomInt(1, 8)
				set item_id = udg_juenei[miji_rand]
			else
				set miji_rand = GetRandomInt(1, 11)
				set item_id = udg_canzhang[miji_rand]
			endif
			call UnitAddItemById(u, item_id)
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了秘籍|r" + GetObjectName(item_id))
		endif
		if Deputy_isDeputy(i, LIAN_DAN) and GetRandomInt(1, 100) <= R2I(20 * addition) then
			call UnitAddItemById(u, udg_dan[dan_rand])
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了丹药|r" + GetObjectName(udg_dan[dan_rand]))
		endif
		if Deputy_isMaster(i, XUN_BAO) and GetRandomInt(1, 100) <= R2I(20 * addition) then
			if GetRandomInt(1, 100) <= 50 then
				set item_id = ITEM_YE_LUO
				call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了野螺|r")
			else
				set item_id = udg_weapon[GetRandomInt(1, 30)]
				call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了武器|r" + GetObjectName(item_id))
			endif
			call UnitAddItemById(u, item_id)
		endif
	else
		set gold_num = R2I(500 * GetRandomInt(2, 20) * addition)
		set lumber_num = R2I(3 * GetRandomInt(2, 20) * addition)
		call AdjustPlayerStateBJ(gold_num, GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD)
		call AdjustPlayerStateBJ(lumber_num, GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER)
		call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了金币+|r" + I2S(gold_num))
		call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了珍稀币+|r" + I2S(lumber_num))
		if Deputy_isDeputy(i, XUN_BAO) and GetRandomInt(1, 100) <= R2I(7 * addition) then
			call UnitAddItemById(u, udg_qiwu[qiwu_rand])
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了奇武" + GetObjectName(udg_qiwu[qiwu_rand]))
		endif
		if GetUnitAbilityLevel(u, MIAO_SHOU_KONG_KONG) >= 1 and GetRandomInt(1, 100) <= R2I(7 * addition) then
			if GetRandomInt(1, 100) <= 80 then
				set miji_rand = GetRandomInt(1, 18)
				set item_id = udg_jianghu[miji_rand]
			elseif GetRandomInt(1, 100) <= 80 then
				set miji_rand = GetRandomInt(1, 10)
				set item_id = udg_juexue[miji_rand]
			elseif GetRandomInt(1, 100) <= 80 then
				set miji_rand = GetRandomInt(1, 8)
				set item_id = udg_juenei[miji_rand]
			else
				set miji_rand = GetRandomInt(1, 11)
				set item_id = udg_canzhang[miji_rand]
			endif
			call UnitAddItemById(u, item_id)
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了秘籍|r" + GetObjectName(item_id))
		endif
		if Deputy_isDeputy(i, LIAN_DAN) and GetRandomInt(1, 100) <= R2I(7 * addition) then
			call UnitAddItemById(u, udg_dan[dan_rand])
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了丹药|r" + GetObjectName(udg_dan[dan_rand]))
		endif
		if Deputy_isMaster(i, XUN_BAO) and GetRandomInt(1, 100) <= R2I(7 * addition) then
			if GetRandomInt(1, 100) <= 50 then
				set item_id = ITEM_YE_LUO
				call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了野螺|r")
			else
				set item_id = udg_weapon[GetRandomInt(1, 30)]
				call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00偷取了武器|r" + GetObjectName(item_id))
			endif
			call UnitAddItemById(u, item_id)
		endif
	endif
	
endfunction

// - 乾坤一掷  主动
//     - 点数 * 3000金钱换 （1 ~ 点数 * 30点）三围
//     - 点数 * 100木换 （1 ~ 点数 * 5）绝学领悟
function qianKunYiZhi takes unit u returns nothing
	local integer rand = GetRandomInt(1, 6)
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer gold = GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD)
	local integer lumber = GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)
	local integer add
	local location loc
	local string s
	local real addition = 1
	local integer goldBase = 3000
	
	if UnitHasDenomWeapon(u, ITEM_YE_LUO) then
		set addition = addition + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_YE_LUO))
	endif
	call WuGongShengChong(u, QIAN_KUN_YI_ZHI, 60)
	call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", u, "overhead"))
	call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00掷出了" + I2S(rand) + "点|r")
	if GetRandomInt(1, 2) == 1 then
		if gold > rand * goldBase then
			set add = R2I(GetRandomInt(1, rand * 30) * addition)
			call ModifyHeroStat(0, u, 0, add)
			call ModifyHeroStat(1, u, 0, add)
			call ModifyHeroStat(2, u, 0, add)
			
			set loc = GetUnitLoc(u)
			set s = "金币-" + I2S(rand * goldBase)
			call AdjustPlayerStateBJ( - rand * goldBase, GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD)
			call CreateTextTagLocBJ(s, loc, 0, 12., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
			set s = "招式伤害+" + I2S(add)
			call CreateTextTagLocBJ(s, loc, 0, 12., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
			set s = "内力+" + I2S(add)
			call CreateTextTagLocBJ(s, loc, 0, 12., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
			set s = "真实伤害+" + I2S(add)
			call CreateTextTagLocBJ(s, loc, 0, 12., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
			call RemoveLocation(loc)
		else
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00金钱不足，无法兑换|r")
		endif
	else
		if lumber > rand * 100 then
			set add = R2I(GetRandomInt(1, rand * 5) * addition)
			set juexuelingwu[i] = juexuelingwu[i] + add
			
			set loc = GetUnitLoc(u)
			set s = "珍稀币-" + I2S(rand * 100)
			call AdjustPlayerStateBJ( - rand * 100, GetOwningPlayer(u), PLAYER_STATE_RESOURCE_LUMBER)
			call CreateTextTagLocBJ(s, loc, 0, 12., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
			set s = "绝学领悟+" + I2S(add)
			call CreateTextTagLocBJ(s, loc, 0, 12., GetRandomReal(0., 100), GetRandomReal(0., 100), GetRandomReal(0., 100), .0)
			call Nw(3,bj_lastCreatedTextTag)
			call SetTextTagVelocityBJ(bj_lastCreatedTextTag, GetRandomReal(50, 70),GetRandomReal(50, 130))
			call RemoveLocation(loc)
		else
			call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"|cFFFFCC00珍稀币不足，无法兑换|r")
		endif
	endif
	set p = null
	set loc = null
endfunction


// - 大功告成 被动
//     - 野螺派的精神胜利法
//     - （35 + 5 * 等级）% 概率免死并回满血
//     - +龟息功 死后原地复活
//     - +枯荣禅功 死亡时间减半
function daGongGaoCheng takes unit u returns nothing
	local integer level = GetUnitAbilityLevel(u, DA_GONG_GAO_CHENG)
	local real addition = 1
	if UnitHasDenomWeapon(u, ITEM_YE_LUO) then
		set addition = addition + 0.03 * GetItemCharges(FetchUnitItem(u, ITEM_YE_LUO))
	endif
	call WuGongShengChong(u, DA_GONG_GAO_CHENG, 200)
	if GetRandomInt(1, 100) <= R2I((35 + 5 * level) * addition) then
		call WuDi(u)
		call SetUnitLifePercentBJ(u, 100)
	endif
	
endfunction


