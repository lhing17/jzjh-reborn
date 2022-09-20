#ifndef CommonFuncIncluded
#define CommonFuncIncluded
globals
	/*
	* 常量定义
	*/
	constant integer MAX_WU_GONG_NUM = 56 // 江湖、绝学、绝内的最大武功种类数
	constant integer MAX_BAN_LV_NUM = 14
	constant integer LIAN_DAN = 1 // 炼丹师
	constant integer DUAN_ZAO = 2 // 锻造师
	constant integer BING_QI = 3 // 兵器师
	constant integer JIAN_DING = 4 // 鉴定师
	constant integer LIAN_QI = 5 // 练气师
	constant integer XUN_BAO = 6 // 寻宝师
	constant integer YA_HUAN = 7 // 丫鬟
	constant integer JING_WU = 8 // 精武师
	constant integer MAX_DEPUTY = 8 // 最大副职数（根据目前的设计，这一值不能超过30）
	
	
	constant integer QIAN_ZHU_SHOU = 'A0BL' // 千蛛手
	constant integer WU_DU_ZHOU = 'A0DU' // 五毒笛咒
	constant integer YU_SHE_SHU = 'A0DT' // 驭蛇奇术
	constant integer BU_TIAN_JING = 'A0DS' // 补天心经
	constant integer WAN_CHU_SHI_XIN = 'A0DR' // 万蜍噬心
	
	constant integer LUO_YING_ZHANG = 'A0EE' // 落英神剑掌
	constant integer LUO_YING_JIAN = 'A0EG' // 落英剑法
	constant integer XUAN_FENG_TUI = 'A0EI' // 旋风扫叶腿
	constant integer BI_BO_XIN_JING = 'A0EK' // 碧波心经
	constant integer QI_MEN_SHU_SHU = 'A0EL' // 奇门术数

	constant integer ZAO_LEI_PI = 'A0EP' // 遭雷劈
	constant integer BA_MIAN_LING_LONG = 'A0EQ' // 八面玲珑
	constant integer FAN_SHOU_QIAN_ZHU = 'A0ES' // 反手牵猪
	constant integer QIAN_KUN_YI_ZHI = 'A0ET' // 乾坤一掷
	constant integer DA_GONG_GAO_CHENG = 'A0ER' // 大功告成

	// 雪山武功
	constant integer XUE_SHAN_JIAN_FA = 'A0EX' // 雪山剑法
	constant integer FENG_SHA_MANG_MANG = 'A0EY' // 风沙莽莽
	constant integer JIN_WU_DAO_FA = 'A0EZ' // 金乌刀法
	constant integer XUE_HUA_LIU_CHU = 'A0F0' // 雪花六出
	constant integer WU_WANG_SHEN_GONG = 'A0F1' // 无妄神功

	// 汝阳王府武功
	constant integer TOU_KAN_TOU_XUE = 'A0F4' // 偷看偷学
	constant integer XUAN_MING_SHEN_ZHANG = 'A0F6' // 玄冥神掌
	constant integer JIA_YI_SHEN_GONG = 'A0F5' // 嫁衣神功

	// 嵩山派武功
	constant integer SONG_SHAN_JIAN_FA = 'A0BF' // 嵩山剑法
	constant integer ZI_WU_SHI_ER_JIAN = 'A0FA' // 子午十二剑
	constant integer HAN_BING_SHEN_ZHANG = 'A0FC' // 寒冰神掌
	constant integer DA_SONG_YANG_SHEN_ZHANG = 'A0FE' // 大嵩阳神掌
	constant integer WU_MING_NEI_GONG = 'A0FD' // 无名内功
	
	constant integer SHUANG_SHOU = 'A07U' // 双手互搏
	constant integer KUI_HUA = 'A07T' // 葵花宝典
	constant integer HUA_GU = 'A06L' // 化骨绵掌
	constant integer XI_XING = 'A07R' // 吸星大法
	constant integer HUA_GONG = 'A07R' // 化功大法
	constant integer TAN_ZHI = 'A06H' // 弹指神通
	constant integer BI_HAI = 'A018' // 碧海潮生曲
	constant integer JIU_YIN = 'A07S' // 九阴真经内功
	constant integer JIU_ZHAO = 'A07N' // 九阴白骨爪
	constant integer QIAN_KUN = 'A07W' // 乾坤大挪移
	constant integer QI_SHANG_QUAN = 'A07M' // 七伤拳
	constant integer JIU_YANG = 'A0DN' // 九阳神功
	constant integer LIAN_CHENG_JIAN_FA = 'A06J' // 连城剑法
	
	constant integer DA_GOU = 'A07L' // 打狗棒法
	constant integer BI_XIE_JIAN_FA = 'A07J' // 辟邪剑法
	constant integer ZI_CHUANG_WU_XUE = 'A036' // 自创武学
	
	constant integer LONG_XIANG = 'S002' // 龙象般若功
	constant integer XIAO_WU_XIANG = 'A083' // 小无相功
	constant integer XI_SUI_JING = 'A080' // 洗髓经
	constant integer BEI_MING_SHEN_GONG = 'A082' // 北冥神功

	constant integer MIAO_SHOU_KONG_KONG = 'A03O' // 妙手空空
	constant integer GUI_XI_GONG = 'A0CE' // 龟息功
	constant integer SHEN_XING_BAI_BIAN = 'A03N' // 神行百变
	constant integer HAN_BING_ZHEN_QI = 'A03L' // 寒冰真气
	
	constant integer POISONED_BUFF = 'BEsh' // 中毒buff
	constant integer DEEP_POISONED_BUFF = 'B01J' // 深度中毒buff
	
	constant integer ITEM_SHE_ZHANG = 'I09B' // 蛇杖物品
	constant integer ITEM_YU_XIAO = 'I09D' // 玉箫物品
	constant integer ITEM_HAN_SHA = 'I0AE' // 含沙射影
	constant integer ITEM_YE_LUO = 'I0EU' // 野螺
	constant integer ITEM_HAN_PO_JIAN = 'I0F6' // FIXME 寒魄剑（专属）
	
	
endglobals
library Deputy requires YDWEBitwise
	// 判断是否具备某副职
	public function isDeputy takes integer i, integer whichDeputy returns boolean
		return YDWEBitwise_AND(deputy[i], YDWEBitwise_LShift(1, whichDeputy - 1)) != 0
	endfunction
	
	// 设置副职
	public function setDeputy takes integer i, integer whichDeputy returns nothing
		set deputy[i] = YDWEBitwise_OR(deputy[i], YDWEBitwise_LShift(1, whichDeputy - 1))
	endfunction
	
	// 判断是否具备某副职的大师
	public function isMaster takes integer i, integer whichMaster returns boolean
		return YDWEBitwise_AND(master[i], YDWEBitwise_LShift(1, whichMaster - 1)) != 0
	endfunction
	
	// 设置副职大师
	public function setMaster takes integer i, integer whichMaster returns nothing
		set master[i] = YDWEBitwise_OR(master[i], YDWEBitwise_LShift(1, whichMaster - 1))
	endfunction
endlibrary


//==================武器契合度系统开始==================//
library WuQiQiHeSystem initializer init requires Deputy
	//武器等级
	function WeaponLevel takes integer itemid returns integer
		//call BJDebugMsg("什么情况3")
		if itemid == 'I04F' then
			return 3
		elseif itemid == 'I00P' then
			return 5
		elseif itemid == 'I00Q' then
			return 5
		elseif itemid == 'I01L' then
			return 2
		elseif itemid == 'I01N' then
			return 2
		elseif itemid == 'I00X' then
			return 4
		elseif itemid == 'I00C' then
			return 6
		elseif itemid == 'I00D' then
			return 6
		elseif itemid == 'I00B' then
			return 6
		elseif itemid == 'I01F' then
			return 1
		elseif itemid == 'I01S' then
			return 1
		elseif itemid == 'I020' then
			return 0
		elseif itemid == 'I01E' then
			return 2
		elseif itemid == 'I021' then
			return 0
		elseif itemid == 'I016' then
			return 2
		elseif itemid == 'I013' then
			return 4
		elseif itemid == 'I08V' then
			return 7
		elseif itemid == 'I097' then
			return 7
		elseif itemid == 'I098' then
			return 7
		elseif itemid == 'I099' then
			return 7
		elseif itemid == 'I09A' then
			return 7
		elseif itemid == 'I09B' then
			return 7
		elseif itemid == 'I09C' then
			return 7
		elseif itemid == 'I09D' then
			return 7
		elseif itemid == 'I0DK' then
			return 7
		elseif itemid == 'I0DU' then
			return 7
		elseif itemid == 'I0DY' then
			return 7
		elseif itemid == 'I0DZ' then
			return 7
		elseif itemid == 'I0E0' then
			return 7
		elseif itemid == 'I0E2' then
			return 7
		endif
		return - 1
	endfunction
	//武器熟练度
	function WeaponQiHe takes unit u, unit uc, integer itemid returns nothing
		local real r = 0.
		local integer level = WeaponLevel(itemid)
		//call BJDebugMsg("什么情况4，"+I2S(level))
		if level == 0 then
			set r = 7.0
		elseif level == 1 then
			set r = 6.0
		elseif level == 2 then
			set r = 5.0
		elseif level == 3 then
			set r = 4.5
		elseif level == 4 then
			set r = 4.0
		elseif level == 5 then
			set r = 3.0
		elseif level == 6 then
			set r = 2.5
		elseif level == 7 then
			set r = 2.0
		endif
		if LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid) < 3000. * (1 + WeaponLevel(itemid)) or (LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid) < 5000. * (1 + WeaponLevel(itemid)) and Deputy_isDeputy(1 + GetPlayerId(GetOwningPlayer(u)), BING_QI)) then
			if(ModuloInteger(GetUnitPointValue(uc), 50) != 0) and (GetUnitPointValue(uc) / 100 == 1 or GetUnitPointValue(uc) / 100 >= 5)  then
				call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid, LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid) + r * 200 * udg_lilianxishu[1 + GetPlayerId(GetOwningPlayer(u))] * wugongxiuwei[1 + GetPlayerId(GetOwningPlayer(u))])
			else
				call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid, LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid) + r * 2 * udg_lilianxishu[1 + GetPlayerId(GetOwningPlayer(u))] * wugongxiuwei[1 + GetPlayerId(GetOwningPlayer(u))])
			endif
		endif
		if Deputy_isMaster(1 + GetPlayerId(GetOwningPlayer(u)), BING_QI) and LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid) < 10000. * (1 + WeaponLevel(itemid))  then
			call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid, LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), itemid) + r * 6 * udg_lilianxishu[1 + GetPlayerId(GetOwningPlayer(u))] * wugongxiuwei[1 + GetPlayerId(GetOwningPlayer(u))])
		endif
		//call BJDebugMsg("什么情况2，"+R2S(r)+","+R2S(LoadReal(YDHT,GetHandleId(GetOwningPlayer(u)),itemid)))
	endfunction
	function WeaponPoSun_Condition takes nothing returns boolean
		return IsUnitEnemy(GetTriggerUnit(), GetOwningPlayer(GetKillingUnit())) and GetPlayerController(GetOwningPlayer(GetKillingUnit())) == MAP_CONTROL_USER and GetPlayerSlotState(GetOwningPlayer(GetKillingUnit())) == PLAYER_SLOT_STATE_PLAYING
	endfunction
	//武器耐久度
	function WeaponPoSun takes nothing returns nothing
		local unit u = GetKillingUnit()
		local player p = GetOwningPlayer(u)
		local integer j = 1 + GetPlayerId(p)
		local integer i = 0
		local item it = null
		set i = 1
		loop
			exitwhen i > 6
			if(GetItemType(UnitItemInSlotBJ(GetKillingUnit(), i)) == ITEM_TYPE_ARTIFACT)then
				set it = UnitItemInSlotBJ(GetKillingUnit(), i)
				if GetItemTypeId(it) == 'I02S' then
					call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it), 2000)
				elseif GetItemTypeId(it) == 'I02M' then
					call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it), 6000)
				elseif GetItemTypeId(it) == 'I02Q' then
					call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it), 10000)
				elseif GetItemTypeId(it) == 'I02R' then
					call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it), 14000)
				elseif GetItemTypeId(it) == 'I02P' then
					call SaveReal(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it), 20000)
				endif
				//非镇妖
				if GetItemTypeId(it) != 'I02S' and GetItemTypeId(it) != 'I02M' and GetItemTypeId(it) != 'I02Q' and GetItemTypeId(it) != 'I02R' and GetItemTypeId(it) != 'I02P'  then
					call WeaponQiHe(u, GetTriggerUnit(), GetItemTypeId(it))
					if not Deputy_isMaster(i, BING_QI) and Deputy_isDeputy(j, BING_QI) then
						if LoadBoolean(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it)) == false and LoadReal(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it)) >= 5000. * (1 + WeaponLevel(GetItemTypeId(it)))  then
							//set udg_bqds[j] = udg_bqds[j] + 1
							call SaveBoolean(YDHT, GetHandleId(GetOwningPlayer(u)), GetItemTypeId(it), true)
							// call DisplayTextToPlayer(p, 0, 0, "|CFF66FF00恭喜您炼成了第"+I2S(udg_bqds[j])+"把武器，您需要炼成3把武器才能获得兵器大师哦")
						endif
					endif
					if LoadInteger(YDHT, GetHandleId(it), 0) > 0 then
						if not Deputy_isDeputy(1 + GetPlayerId(GetOwningPlayer(u)), BING_QI) then
							call SaveInteger(YDHT, GetHandleId(it), 0, LoadInteger(YDHT, GetHandleId(it), 0) - 1)
						endif
					endif
				endif
			endif
			set i = i + 1
		endloop
		
		set u = null
		set it = null
		set p = null
	endfunction
	function init takes nothing returns nothing
		local trigger t = CreateTrigger()
		call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DEATH)
		call TriggerAddCondition(t, Condition(function WeaponPoSun_Condition))
		call TriggerAddAction(t, function WeaponPoSun)
		set t = null
	endfunction
	//重写创造物品的函数
	function createitemloc takes integer id, location loc returns item
		local item it = null
		set it = CreateItemLoc(id, loc)
		set it = null
		return bj_lastCreatedItem
	endfunction
	function createitem takes integer id, real x, real y returns item
		return CreateItem(id, x, y)
	endfunction
	function unitadditembyidswapped takes integer itemId, unit whichHero returns item
		local item it = null
		set it = UnitAddItemByIdSwapped(itemId, whichHero)
		set it = null
		return bj_lastCreatedItem
	endfunction
endlibrary
//==================武器契合度系统结束==================//
//A项和B项性格
function AddCharacterABuff takes unit u, integer characterA returns nothing
	call UnitAddAbilityBJ( 'A066', u )
	call SetPlayerAbilityAvailableBJ( false, 'A066', GetOwningPlayer(u) )
	call SetUnitAbilityLevel(u, 'A068', characterA)
endfunction
function AddCharacterBBuff takes unit u, integer characterB returns nothing
	call UnitAddAbilityBJ( 'A067', u )
	call SetPlayerAbilityAvailableBJ( false, 'A067', GetOwningPlayer(u) )
	call SetUnitAbilityLevel(u, 'A069', characterB)
endfunction
function XingGeA takes integer xingge returns string
	local string s = null
	if xingge == 1 then
		set s = "愚钝"
	elseif xingge == 2 then
		set s = "笨拙"
	elseif xingge == 3 then
		set s = "平平"
	elseif xingge == 4 then
		set s = "聪明"
	elseif xingge == 5 then
		set s = "聪慧"
	endif
	return s
endfunction
function XingGeB takes integer xingge returns string
	local string s = null
	if xingge == 1 then
		set s = "浮躁"
	elseif xingge == 2 then
		set s = "轻浮"
	elseif xingge == 3 then
		set s = "耐心"
	elseif xingge == 4 then
		set s = "稳重"
	elseif xingge == 5 then
		set s = "沉稳"
	endif
	return s
endfunction
//副本倒计时
function FBdaojishi takes nothing returns nothing
	local player p = GetTriggerPlayer()
	call DisplayTimedTextToPlayer(p, 0, 0, 30, ("|cFFFF00331号副本重置倒计时：|cFF33FFFF" + (I2S(R2I(TimerGetRemaining(Hd[1]))) + "秒")))
	call DisplayTimedTextToPlayer(p, 0, 0, 30, ("|cFFFF00332号副本重置倒计时：|cFF33FFFF" + (I2S(R2I(TimerGetRemaining(Hd[2]))) + "秒")))
	call DisplayTimedTextToPlayer(p, 0, 0, 30, ("|cFFFF00333号副本重置倒计时：|cFF33FFFF" + (I2S(R2I(TimerGetRemaining(Hd[3]))) + "秒")))
	call DisplayTimedTextToPlayer(p, 0, 0, 30, ("|cFFFF00334号副本重置倒计时：|cFF33FFFF" + (I2S(R2I(TimerGetRemaining(Hd[4]))) + "秒")))
	call DisplayTimedTextToPlayer(p, 0, 0, 30, ("|cFFFF00335号副本重置倒计时：|cFF33FFFF" + (I2S(R2I(TimerGetRemaining(Hd[5]))) + "秒")))
	call DisplayTimedTextToPlayer(p, 0, 0, 30, ("|cFFFF00336号副本重置倒计时：|cFF33FFFF" + (I2S(R2I(TimerGetRemaining(Hd[6]))) + "秒")))
	set p = null
endfunction
//伴侣属性
function BanLvShuXing takes nothing returns nothing
	local trigger t = GetTriggeringTrigger()
	local player p = GetTriggerPlayer()
	local integer i = 1 + GetPlayerId(p)
	set bj_forLoopBIndex = 1
	set bj_forLoopBIndexEnd = MAX_BAN_LV_NUM
	loop
		exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
		if((GetUnitTypeId(k8[i]) == R8[bj_forLoopBIndex]))then
			call DisplayTextToPlayer(p, 0, 0, ("|cFFFFFF00伴侣：" + GetUnitName(k8[i])))
			if((udg_blgg[bj_forLoopBIndex] > 0))then
				call DisplayTextToPlayer(p, 0, 0, ("|cFF00FFFF根骨 ：   " + I2S(udg_blgg[bj_forLoopBIndex])))
			endif
			if((udg_blwx[bj_forLoopBIndex] > 0))then
				call DisplayTextToPlayer(p, 0, 0, ("|cFF00FFFF悟性 ：   " + I2S(udg_blwx[bj_forLoopBIndex])))
			endif
			if((udg_bljm[bj_forLoopBIndex] > 0))then
				call DisplayTextToPlayer(p, 0, 0, ("|cFF00FFFF经脉 ：   " + I2S(udg_bljm[bj_forLoopBIndex])))
			endif
			if((udg_blfy[bj_forLoopBIndex] > 0))then
				call DisplayTextToPlayer(p, 0, 0, ("|cFF00FFFF福缘 ：   " + I2S(udg_blfy[bj_forLoopBIndex])))
			endif
			if((udg_bldp[bj_forLoopBIndex] > 0))then
				call DisplayTextToPlayer(p, 0, 0, ("|cFF00FFFF胆魄 ：   " + I2S(udg_bldp[bj_forLoopBIndex])))
			endif
			if((udg_blys[bj_forLoopBIndex] > 0))then
				call DisplayTextToPlayer(p, 0, 0, ("|cFF00FFFF医术 ：   " + I2S(udg_blys[bj_forLoopBIndex])))
			endif
		endif
		set bj_forLoopBIndex = bj_forLoopBIndex + 1
	endloop
	set t = null
	set p = null
endfunction
function IsYaoCao takes integer id returns boolean
	local integer i = 1
	loop
		exitwhen i > 12
		if id == YaoCao[i] then
			return true
		endif
		set i = i + 1
	endloop
	return false
endfunction
//宝物掉落函数
function BaoWuDiaoLuo takes unit u, unit ut, integer baolv1, integer id1, integer id2, integer id3, integer id4, integer baolv2, integer id5 returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(ut)
	local integer array idn
	local integer j = 4
	set idn[1] = id1
	set idn[2] = id2
	set idn[3] = id3
	set idn[4] = id4
	if id4 == 0 then
		set j = 3
	endif
	if id3 == 0 then
		set j = 2
	endif
	if id2 == 0 then
		set j = 1
	endif
	if id1 == 0 then
		set j = 0
	endif
	if (GetRandomInt(1, 1000) <= fuyuan[i] or (GetRandomInt(1, 100) <= 35 and Deputy_isDeputy(i, XUN_BAO))) then
		set MM7 = 2
	else
		set MM7 = 1
	endif
	set N7 = 1
	loop
		exitwhen N7 > MM7
		//第一类宝物
		if (j > 0) then
			if(GetRandomInt(0, 100) <= baolv1)then
				call createitemloc(idn[GetRandomInt(1, j)], loc)
			endif
		endif
		//第二类宝物（药物或古董）
		if (baolv2 != 0) then
			if((GetRandomInt(1, 100) <= baolv2))then
				call createitemloc(id5, loc)
				if IsYaoCao(id5) and Deputy_isMaster(i, LIAN_DAN) then
					call createitemloc(id5, loc)
				endif
			endif
		endif
		set N7 = N7 + 1
	endloop
	call RemoveLocation(loc)
	set p = null
	set loc = null
endfunction
//击杀怪物后百分比概率掉落宝物的函数
//如果副职为寻宝师或者1-1000间取随机数小于福缘成立的话，双倍掉落宝物

//unit是击杀者
//possibility:第一种宝物掉落的概率
//itemId:第一种宝物的id
//itemId2:第二种宝物掉落的id，如果没有第二种宝物可以为0
function dropItem takes unit u, integer itemId, integer itemId2, integer possibility returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(u)
	if(GetRandomInt(1, 1000) <= fuyuan[i] or (GetRandomInt(1, 100) <= 30 and Deputy_isDeputy(i, XUN_BAO)))then
		set MM7 = 2
	else
		set MM7 = 1
	endif
	set N7 = 1
	loop
		exitwhen N7 > MM7
		if (GetRandomInt(0, 100) <= possibility) then
			call createitemloc(itemId, loc)
		else
			call createitemloc(itemId2, loc)
		endif
		set N7 = N7 + 1
		
	endloop
	call RemoveLocation(loc)
	set u = null
	set p = null
	set loc = null
endfunction
//查询药性
function YaoXing takes nothing returns integer
	local player p = GetTriggerPlayer()
	local integer i = 1 + GetPlayerId(p)
	local integer yin = 0
	local integer yang = 0
	set bj_forLoopAIndex = 1
	set bj_forLoopAIndexEnd = 6
	loop
		exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
		if((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[11]))then
			set yin = yin + 5
			set yang = yang + 1
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[9]))then
			set yin = yin + 0
			set yang = yang + 4
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[10]))then
			set yin = yin + 3
			set yang = yang + 4
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[8]))then
			set yin = yin + 4
			set yang = yang + 3
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[7]))then
			set yin = yin + 4
			set yang = yang + 0
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[12]))then
			set yin = yin + 1
			set yang = yang + 5
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[6]))then
			set yin = yin + 2
			set yang = yang + 3
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[1]))then
			set yin = yin + 2
			set yang = yang + 1
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[2]))then
			set yin = yin + 1
			set yang = yang + 2
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[3]))then
			set yin = yin + 3
			set yang = yang - 1
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[4]))then
			set yin = yin - 1
			set yang = yang + 3
		elseif((GetItemTypeId(UnitItemInSlotBJ(P4[i], bj_forLoopAIndex)) == YaoCao[5]))then
			set yin = yin + 3
			set yang = yang + 2
		endif
		set bj_forLoopAIndex = bj_forLoopAIndex + 1
	endloop
	call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10., ("|cff00ff33总药性（阴）：" + I2S(yin)))
	call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10., ("|cff00ff33总药性（阳）：" + I2S(yang)))
	set p = null
	return yin * 100 + yang 
endfunction
//转化剑意
function TransferJY takes nothing returns nothing
	local player p = GetTriggerPlayer()
	local integer i = 1 + GetPlayerId(p)
	if((xd[i] == 0))then
		call DisplayTimedTextToPlayer(p, 0, 0, 30, "|cffff0000英雄，你的剑意不够哦")
	else
		if((yd[i] == 1))then
			call DisplayTextToPlayer(p, 0, 0, ("|cff00ff00当前已将" + (I2S(xd[i]) + "点剑意转化成了悟性")))
		elseif((yd[i] == 2))then
			call DisplayTextToPlayer(p, 0, 0, ("|cff00ff00当前已将" + (I2S(xd[i]) + "点剑意转化成了根骨")))
		elseif((yd[i] == 3))then
			call DisplayTextToPlayer(p, 0, 0, ("|cff00ff00当前已将" + (I2S(xd[i]) + "点剑意转化成了胆魄")))
		elseif((yd[i] == 4))then
			call DisplayTextToPlayer(p, 0, 0, ("|cff00ff00当前已将" + (I2S(xd[i]) + "点剑意转化成了医术")))
		elseif((yd[i] == 5))then
			call DisplayTextToPlayer(p, 0, 0, ("|cff00ff00当前已将" + (I2S(xd[i]) + "点剑意转化成了福缘")))
		elseif((yd[i] == 6))then
			call DisplayTextToPlayer(p, 0, 0, ("|cff00ff00当前已将" + (I2S(xd[i]) + "点剑意转化成了经脉")))
		endif
		if((GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) < 5))then
			call DisplayTimedTextToPlayer(p, 0, 0, 30, "|cffff0000转化剑意需要至少5个黄金")
		else
			call DialogSetMessage(v8[i], ("你拥有" + (I2S(xd[i]) + "点剑意，请选择要转化的属性")))
			call DialogAddButtonBJ(v8[i], "根骨")
			set w8[i] = bj_lastCreatedButton
			call DialogAddButtonBJ(v8[i], "悟性")
			set y8[i] = bj_lastCreatedButton
			call DialogAddButtonBJ(v8[i], "福缘")
			set z8[i] = bj_lastCreatedButton
			call DialogAddButtonBJ(v8[i], "胆魄")
			set A8[i] = bj_lastCreatedButton
			call DialogAddButtonBJ(v8[i], "医术")
			set a8[i] = bj_lastCreatedButton
			call DialogAddButtonBJ(v8[i], "经脉")
			set x8[i] = bj_lastCreatedButton
			call DialogAddButtonBJ(v8[i], "取消")
			set B8[i] = bj_lastCreatedButton
			call DialogDisplay(p, v8[i], true)
			set Ad[i] = true
		endif
	endif
	set p = null
endfunction

// 按几何正态分布进行随机
function GetGeoNormRandomReal takes real r1, real r2 returns real
	local real rr1 = YDWELogarithmLg(r1)
	local real rr2 = YDWELogarithmLg(r2)
	local real rr3 = GetRandomReal(rr1, rr2)
	local real rr4 = GetRandomReal(rr1, rr2)
	local real rr5 = GetRandomReal(rr1, rr2)
	local real rr6 = GetRandomReal(rr1, rr2)
	local real rr7 = GetRandomReal(rr1, rr2)
	local real rr8 = GetRandomReal(rr1, rr2)
	local real rr9 = (rr3 + rr4 + rr5 + rr6 + rr7 + rr8) / 6.0
	return Pow(10., rr9)
endfunction

//返回玩家数
function GetNumPlayer takes nothing returns integer
	local integer i = 0
	local player p = null
	local integer n = 0
	loop
		exitwhen i > 11
		set p = Player(i)
		if GetPlayerController(p) == MAP_CONTROL_USER and GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING then
			set n = n + 1
		endif
		set i = i + 1
	endloop
	set p = null
	return n
endfunction

function UnitTypeNotNull takes unit u, unittype i returns boolean
	return(IsUnitType(u, i) != null)
endfunction
//距离loc r1距离r2角度的点
function pu takes location loc, real r1, real r2 returns location
	return Location(GetLocationX(loc) + r1 * Cos(r2 * bj_DEGTORAD), GetLocationY(loc) + r1 * Sin(r2 * bj_DEGTORAD))
endfunction

function Eu takes nothing returns integer
	local integer Fu = Kt
	if(Fu != 0)then
		set Kt = Mt[Fu]
	else
		set Lt = Lt + 1
		set Fu = Lt
	endif
	if(Fu > 8190)then
		return 0
	endif
	set Pt[Fu] = null
	set Qt[Fu] = null
	set Rt[Fu] = .0
	set St[Fu] = .0
	set Tt[Fu] = .0
	set Ut[Fu] = .0
	set Vt[Fu] = .0
	set Wt[Fu] = .0
	set Xt[Fu] = .0
	set Yt[Fu] = .0
	set Zt[Fu] = 0
	set Mt[Fu] =- 1
	return Fu
endfunction
function Gu takes integer Fu returns nothing
	if Fu == null then
		return
	elseif(Mt[Fu] !=- 1)then
		return
	endif
	set Mt[Fu] = Kt
	set Kt = Fu
endfunction

function Nu takes unit Ou, integer cu returns nothing
	local integer i = 0
	loop
		exitwhen i >= M
		if L[i] == cu then
			set w = Ou
			if K[i] != null and TriggerEvaluate(K[i])and IsTriggerEnabled(K[i])then
				call TriggerExecute(K[i])
			endif
		endif
		set i = i + 1
	endloop
endfunction

//万能属性系统
//以下函数仅仅是让技能ID出现在代码里，不然SLK优化器会删除这些技能
function DisplayAllAbilityId takes nothing returns nothing
	local integer aid = 0
	set aid = 'YDl0'
	set aid = 'YDl1'
	set aid = 'YDl2'
	set aid = 'YDl3'
	set aid = 'YDl4'
	set aid = 'YDl5'
	set aid = 'YDl6'
	set aid = 'YDl7'
	set aid = 'YDl8'
	set aid = 'YDl9'
	set aid = 'YDla'
	set aid = 'YDlb'
	set aid = 'YDlc'
	set aid = 'YDld'
	set aid = 'YDle'
	set aid = 'YDlf'
	set aid = 'YDm0'
	set aid = 'YDm1'
	set aid = 'YDm2'
	set aid = 'YDm3'
	set aid = 'YDm4'
	set aid = 'YDm5'
	set aid = 'YDm6'
	set aid = 'YDm7'
	set aid = 'YDm8'
	set aid = 'YDm9'
	set aid = 'YDma'
	set aid = 'YDmb'
	set aid = 'YDmc'
	set aid = 'YDmd'
	set aid = 'YDme'
	set aid = 'YDmf'
	set aid = 'YDc0'
	set aid = 'YDc1'
	set aid = 'YDc2'
	set aid = 'YDc3'
	set aid = 'YDc4'
	set aid = 'YDc5'
	set aid = 'YDc6'
	set aid = 'YDc7'
	set aid = 'YDc8'
	set aid = 'YDc9'
	set aid = 'YDca'
	set aid = 'YDcb'
	set aid = 'YDcc'
	set aid = 'YDb0'
	set aid = 'YDb1'
	set aid = 'YDb2'
	set aid = 'YDb3'
	set aid = 'YDb4'
	set aid = 'YDb5'
	set aid = 'YDb6'
	set aid = 'YDb7'
	set aid = 'YDb8'
	set aid = 'YDb9'
	set aid = 'YDba'
	set aid = 'YDbb'
	set aid = 'YDbc'
	set aid = 'YDbd'
	set aid = 'YDbe'
	set aid = 'YDbg'
	set aid = 'YDbh'
	set aid = 'YDbi'
	set aid = 'YDbj'
	set aid = 'YDbk'
	set aid = 'YDbl'
	set aid = 'YDbm'
	set aid = 'YDbn'
endfunction
function kv takes nothing returns nothing
	local integer i = 0
	local integer m = 0
	set P[0] = 0
	set P[1] = 15
	set P[2] = 30
	set P[3] = 43
	set P[4] = 67
	set Q[0] = 15
	set Q[1] = 15
	set Q[2] = $D
	set Q[3] = 24
	loop
		exitwhen i > 9
		set V[i] = 48 + m
		set m = m + 1
		set i = i + 1
	endloop
	set m = 0
	loop
		exitwhen i > 26
		set V[i] = 97 + m
		set m = m + 1
		set i = i + 1
	endloop
	set i = 0
	set m = 0
	loop
		exitwhen m > (Q[0] - 1)
		set S[i] = 1497656368 - 48 + V[m]
		set i = i + 1
		set m = m + 1
	endloop
	set m = 0
	loop
		exitwhen m > (Q[1] - 1)
		set S[i] = 1497656624 - 48 + V[m]
		set i = i + 1
		set m = m + 1
	endloop
	set m = 0
	loop
		exitwhen m > (Q[2] - 1)
		set S[i] = 1497654064 - 48 + V[m]
		set i = i + 1
		set m = m + 1
	endloop
	set m = 0
	loop
		exitwhen m > (Q[3] - 1)
		set S[i] = 1497653808 - 48 + V[m]
		set i = i + 1
		set m = m + 1
	endloop
endfunction
function mv takes nothing returns nothing
	local integer i = 1
	local unit u
	local integer n = 0
	local integer nv = 0
	call kv()
	loop
		set i = 1
		set T[nv] = 1
		loop
			set T[nv + 1] = T[nv] * 2
			set nv = nv + 1
			set i = i + 1
			exitwhen i == Q[n]
		endloop
		set X[n] = T[nv] - 1
		set Y[n] =- T[nv]
		set nv = nv + 1
		set n = n + 1
		exitwhen n >= 4
	endloop
	if W then
		set u = CreateUnit(Player(15), U, 0, 0, 0)
		set i = 0
		loop
			exitwhen i == P[5]
			call UnitAddAbility(u, S[i])
			set i = i + 1
		endloop
		call RemoveUnit(u)
		set u = null
	endif
endfunction
function ov takes player pv returns force
	local force f = CreateForce()
	call ForceAddPlayer(f, pv)
	set Z = f
	set f = null
	return Z
endfunction
function FetchUnitItem takes unit u, integer j returns item
	local integer i = 0
	loop
		set d4 = UnitItemInSlot(u, i)
		if GetItemTypeId(d4) == j then
			return d4
		endif
		set i = i + 1
		exitwhen i >= 6
	endloop
	return null
endfunction
function YDWEGetUnitsInRectOfPlayerNull takes rect r, player whichPlayer returns group
	local group g = CreateGroup()
	set bj_groupEnumOwningPlayer = whichPlayer
	call GroupEnumUnitsInRect(g, r, filterGetUnitsInRectOfPlayer)
	set yd_NullTempGroup = g
	set g = null
	return yd_NullTempGroup
endfunction
function YDWEGetRandomSubGroupEnumNull takes nothing returns nothing
	if ( bj_randomSubGroupWant > 0 ) then
		if ( bj_randomSubGroupWant >= bj_randomSubGroupTotal ) or ( GetRandomInt(1, bj_randomSubGroupTotal) <= bj_randomSubGroupWant ) then
			// We either need every remaining unit, or the unit passed its chance check.
			call GroupAddUnit(bj_randomSubGroupGroup, GetEnumUnit())
			set bj_randomSubGroupWant = bj_randomSubGroupWant - 1
		endif
	endif
	set bj_randomSubGroupTotal = bj_randomSubGroupTotal - 1
endfunction
function YDWEGetRandomSubGroupNull takes integer count, group sourceGroup returns group
	set bj_randomSubGroupGroup = CreateGroup()
	set bj_randomSubGroupWant = count
	set bj_randomSubGroupTotal = CountUnitsInGroup(sourceGroup)
	if ( bj_randomSubGroupWant <= 0 or bj_randomSubGroupTotal <= 0 ) then
		return bj_randomSubGroupGroup
	endif
	call ForGroup(sourceGroup, function YDWEGetRandomSubGroupEnumNull)
	return bj_randomSubGroupGroup
endfunction
function YDWEGetItemOfTypeFromUnitBJNull takes unit whichUnit, integer itemId returns item
	local integer index = 0
	loop
		set yd_NullTempItem = UnitItemInSlot(whichUnit, index)
		if GetItemTypeId(yd_NullTempItem) == itemId then
			return yd_NullTempItem
		endif
		set index = index + 1
		exitwhen index >= bj_MAX_INVENTORY
	endloop
	return null
endfunction
function YDWETriggerActionUnitRescuedBJNull takes nothing returns nothing
	local unit theUnit = GetTriggerUnit()
	if IsUnitType(theUnit, UNIT_TYPE_STRUCTURE) then
		call RescueUnitBJ(theUnit, GetOwningPlayer(GetRescuer()), bj_rescueChangeColorBldg)
	else
		call RescueUnitBJ(theUnit, GetOwningPlayer(GetRescuer()), bj_rescueChangeColorUnit)
	endif
	set theUnit = null
endfunction
function YDWETryInitRescuableTriggersBJNull takes nothing returns nothing
	local integer index
	if ( bj_rescueUnitBehavior == null ) then
		set bj_rescueUnitBehavior = CreateTrigger()
		set index = 0
		loop
			call TriggerRegisterPlayerUnitEvent(bj_rescueUnitBehavior, Player(index), EVENT_PLAYER_UNIT_RESCUED, null)
			set index = index + 1
			exitwhen index == bj_MAX_PLAYER_SLOTS
		endloop
		call TriggerAddAction(bj_rescueUnitBehavior, function YDWETriggerActionUnitRescuedBJNull)
	endif
endfunction
function YDWEInitRescuableBehaviorBJNull takes nothing returns nothing
	local integer index
	set index = 0
	loop
		// If at least one player slot is "Rescuable"-controlled, init the
		// rescue behavior triggers.
		if ( GetPlayerController(Player(index)) == MAP_CONTROL_RESCUABLE ) then
			call YDWETryInitRescuableTriggersBJNull()
			return
		endif
		set index = index + 1
		exitwhen index == bj_MAX_PLAYERS
	endloop
endfunction
function wv takes rect r, boolexpr vv returns group
	local group g = CreateGroup()
	call GroupEnumUnitsInRect(g, r, vv)
	call DestroyBoolExpr(vv)
	set e4 = g
	set g = null
	return e4
endfunction
function AddPlayerUnitIntoGroup takes player pv, boolexpr vv returns group
	local group g = CreateGroup()
	call GroupEnumUnitsOfPlayer(g, pv, vv)
	call DestroyBoolExpr(vv)
	set e4 = g
	set g = null
	return e4
endfunction
function yv takes multiboard mb, integer zv, integer Av, real av, real Bv, real bv, real Cv returns nothing
	local integer cv = 0
	local integer Dv = 0
	local integer Ev = MultiboardGetRowCount(mb)
	local integer Fv = MultiboardGetColumnCount(mb)
	local multiboarditem Gv = null
	loop
		set cv = cv + 1
		exitwhen cv > Ev
		if(Av == 0 or Av == cv)then
			set Dv = 0
			loop
				set Dv = Dv + 1
				exitwhen Dv > Fv
				if(zv == 0 or zv == Dv)then
					set Gv = MultiboardGetItem(mb, cv - 1, Dv - 1)
					call MultiboardSetItemValueColor(Gv, PercentTo255(av), PercentTo255(Bv), PercentTo255(bv), PercentTo255(100. - Cv))
					call MultiboardReleaseItem(Gv)
				endif
			endloop
		endif
	endloop
	set Gv = null
endfunction
function DuoMianBan takes multiboard mb, integer zv, integer Av, string Iv returns nothing
	local integer cv = 0
	local integer Dv = 0
	local integer Ev = MultiboardGetRowCount(mb)
	local integer Fv = MultiboardGetColumnCount(mb)
	local multiboarditem Gv = null
	loop
		set cv = cv + 1
		exitwhen cv > Ev
		if(Av == 0 or Av == cv)then
			set Dv = 0
			loop
				set Dv = Dv + 1
				exitwhen Dv > Fv
				if(zv == 0 or zv == Dv)then
					set Gv = MultiboardGetItem(mb, cv - 1, Dv - 1)
					call MultiboardSetItemValue(Gv, Iv)
					call MultiboardReleaseItem(Gv)
				endif
			endloop
		endif
	endloop
	set Gv = null
endfunction
//符合条件执行g4[i]触发
function Lv takes nothing returns nothing
	local integer i = 0
	loop
		exitwhen i >= h4
		if g4[i] != null and IsTriggerEnabled(g4[i])and TriggerEvaluate(g4[i])then
			call TriggerExecute(g4[i])
		endif
		set i = i + 1
	endloop
endfunction
//单位没有蝗虫技能，则注册单位伤害信息
function Mv takes nothing returns boolean
	if GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') <= 0 then
		call TriggerRegisterUnitEvent(f4, GetFilterUnit(), EVENT_UNIT_DAMAGED)
	endif
	return false
endfunction
//任意单位受伤害事件
function Nv takes nothing returns nothing
	local trigger t = CreateTrigger()
	local region r = CreateRegion()
	local group g = CreateGroup()
	call RegionAddRect(r, GetWorldBounds())
	//新进入地图的单位受伤害
	call TriggerRegisterEnterRegion(t, r, Condition(function Mv))
	//地图上已有的单位受伤害
	call GroupEnumUnitsInRect(g, GetWorldBounds(), Condition(function Mv))
	call DestroyGroup(g)
	set r = null
	set t = null
	set g = null
endfunction
function Ov takes trigger Pv returns nothing
	if Pv == null then
		return
	endif
	if h4 == 0 then
		set f4 = CreateTrigger()
		call TriggerAddAction(f4, function Lv)
		call Nv()
	endif
	set g4[h4] = Pv
	set h4 = h4 + 1
endfunction
function Qv takes nothing returns nothing
	local integer i = 0
	if GetIssuedOrderId() >= $D0022 and GetIssuedOrderId() <= $D0027 then
		set i4 = GetOrderTargetItem()
		loop
			exitwhen i >= m4
			if k4[i] != null and IsTriggerEnabled(k4[i])and TriggerEvaluate(k4[i])then
				call TriggerExecute(k4[i])
			endif
			set i = i + 1
		endloop
	endif
endfunction
function TriggerAddRect takes trigger Sv, rect r returns event
	local region Tv = CreateRegion()
	call RegionAddRect(Tv, r)
	set nn4 = Tv
	set Tv = null
	return TriggerRegisterEnterRegion(Sv, nn4, null)
endfunction
function UnitHaveItem takes unit u, integer j returns boolean
	local integer i = 0
	if j != 0 then
		loop
			if GetItemTypeId(UnitItemInSlot(u, i)) == j then
				return true
			endif
			set i = i + 1
			exitwhen i >= 6
		endloop
	endif
	return false
endfunction

function UnitHasDenomWeapon takes unit u, integer id returns boolean
	return UnitHaveItem(u, id) or ateDenom[1 + GetPlayerId(GetOwningPlayer(u))] == 1
endfunction

function Vv takes player pv returns nothing
	local group g = CreateGroup()
	call GroupEnumUnitsOfPlayer(g, pv, null)
	call ForGroup(g, function WakePlayerUnitsEnum)
	call DestroyGroup(g)
	set g = null
endfunction
function CheckX takes real x returns real
	local real E2 = GetRectMinX(bj_mapInitialPlayableArea) + 50
	if(x < E2)then
		return E2
	endif
	set E2 = GetRectMaxX(bj_mapInitialPlayableArea) - 50
	if(x > E2)then
		return E2
	endif
	return x
endfunction
function CheckY takes real y returns real
	local real E2 = GetRectMinY(bj_mapInitialPlayableArea) + 50
	if(y < E2)then
		return E2
	endif
	set E2 = GetRectMaxY(bj_mapInitialPlayableArea) - 50
	if(y > E2)then
		return E2
	endif
	return y
	
endfunction
function Wv takes nothing returns nothing
	local integer d = 0
	local real x = .0
	local real y = .0
	local integer Xv = 0
	loop
		exitwhen(Xv == Ot)
		set d = Nt[Xv]
		if(Rt[d] > 0)and(GetUnitState(Pt[d], UNIT_STATE_LIFE) > 0)and(GetUnitState(Qt[d], UNIT_STATE_LIFE) > 0)then
			set Tt[d] = Tt[d] + .01
			if(Tt[d] >= St[d])then
				set Xt[d] = Xt[d] + Ut[d]
				set Yt[d] = Yt[d] + Vt[d]
				set Zt[d] = Zt[d] + Wt[d]
				set x = GetUnitX(Pt[d]) + Yt[d] * Cos(Xt[d])
				set y = GetUnitY(Pt[d]) + Yt[d] * Sin(Xt[d])
				set x = (RMinBJ(RMaxBJ(((x) * 1.), yd_MapMinX), yd_MapMaxX))
				set y = (RMinBJ(RMaxBJ(((y) * 1.), yd_MapMinY), yd_MapMaxY))
				call SetUnitX(Qt[d], CheckX(x))
				call SetUnitY(Qt[d], CheckY(y))
				call SetUnitFlyHeight(Qt[d], Zt[d], .0)
				set Tt[d] = .0
			endif
			set Rt[d] = Rt[d] - .01
		else
			set z = Pt[d]
			call Nu(Qt[d], $A)
			set Pt[d] = null
			set Qt[d] = null
			call Gu(d)
			set Ot = Ot - 1
			set Nt[Xv] = Nt[Ot]
			set Xv = Xv - 1
		endif
		set Xv = Xv + 1
	endloop
	if(Ot == 0)then
		call PauseTimer(o4)
	endif
endfunction
//转圈函数
function Yv takes unit Zv, unit dw, real ew, real fw, real gw, real hw, real iw returns nothing
	local integer d = Eu()
	local real x1 = GetUnitX(dw)
	local real y1 = GetUnitY(dw)
	local real x2 = GetUnitX(Zv)
	local real y2 = GetUnitY(Zv)
	set Pt[d] = dw
	set Qt[d] = Zv
	set Rt[d] = hw
	set St[d] = iw
	set Ut[d] = ew * (3.14159 / 180.)
	set Vt[d] = fw
	set Wt[d] = gw
	set Xt[d] = Atan2(y2 - y1, x2 - x1)
	set Yt[d] = SquareRoot((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1))
	set Zt[d] = GetUnitFlyHeight(Qt[d])
	set Nt[Ot] = (d)
	set Ot = Ot + 1
	if(Ot - 1 == 0)then
		call TimerStart(o4, .01, true, function Wv)
	endif
endfunction
function jw takes boolean kw returns nothing
	call SetPlayerState(Player(12), PLAYER_STATE_NO_CREEP_SLEEP, IntegerTertiaryOp(kw, 0, 1))
	if(not kw)then
		call Vv(Player(12))
	endif
endfunction
function vw takes unit ww returns nothing
	local integer tm = (LoadInteger(YDHT, StringHash((I2S((GetHandleId((ww)))))), StringHash(("Timer"))))
	call FlushChildHashtable(YDHT, StringHash((I2S((GetHandleId((ww)))))))
	call FlushChildHashtable(YDHT, StringHash((I2S(tm))))
	call DestroyTimer((LoadTimerHandle(YDHT, StringHash((I2S((GetHandleId((ww)))))), StringHash(("Timer")))))
endfunction
function xw takes nothing returns nothing
	local timer tm = GetExpiredTimer()
	local unit ww = ((LoadUnitHandle(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("Pet")))))
	local unit yw = ((LoadUnitHandle(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("Captain")))))
	local real x = GetUnitX(yw) - GetUnitX(ww)
	local real y = GetUnitY(yw) - GetUnitY(ww)
	local real d = x * x + y * y
	local real v
	local real a
	local effect e = null
	local real life = (LoadReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("Life"))))
	local integer p = (LoadInteger(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("Percent"))))
	set v = (LoadReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("GuardRanger"))))
	if GetUnitState(ww, UNIT_STATE_LIFE) > 0 and GetUnitState(yw, UNIT_STATE_LIFE) > 0 then
		if d < v * v then
			if(OrderId2String(GetUnitCurrentOrder((ww))) == null)and GetRandomInt(0, 100) < p then
				set x = GetUnitX(yw)
				set y = GetUnitY(yw)
				set d = GetRandomReal(0, v)
				set a = GetRandomReal(0, 360)
				call IssuePointOrderById(ww, $D0016, x + d * CosBJ(a), y + d * SinBJ(a))
			endif
		else
			set v = (LoadReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("ReturnRanger"))))
			if d < v * v then
				if(OrderId2String(GetUnitCurrentOrder((ww))) == null)then
					call IssuePointOrderById(ww, $D0016, GetUnitX(yw), GetUnitY(yw))
				endif
			else
				set v = (LoadReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("OutRanger"))))
				if d != 0 and d > v * v then
					call SetUnitPosition(ww, GetUnitX(yw), GetUnitY(yw))
					set e = AddSpecialEffectTargetEx("Abilities\\Spells\\Human\\MassTeleport\\MassTeleportTarget.mdl", yw, "chest")
					call DestroyEffectEx(e)
				else
					call IssuePointOrderById(ww, $D0012, GetUnitX(yw), GetUnitY(yw))
				endif
			endif
		endif
	else
		call IssuePointOrderById(ww, $D000F, GetUnitX(yw), GetUnitY(yw))
		call vw(ww)
	endif
	set tm = null
	set ww = null
	set yw = null
	set e = null
endfunction

// 单位ww跟随单位yw
function zw takes unit ww, unit yw, real hw, real Aw, real aw, real Bw, integer bw returns nothing
	local timer tm = CreateTimer()
	call SaveTimerHandle(YDHT, StringHash((I2S((GetHandleId((ww)))))), StringHash(("Timer")), (tm))
	call SaveUnitHandle(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("pet")), (ww))
	call SaveUnitHandle(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("Captain")), (yw))
	call SaveInteger(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("Percent")), (bw))
	call SaveReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("GuardRanger")), ((Aw) * 1.))
	call SaveReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("ReturnRanger")), ((aw) * 1.))
	call SaveReal(YDHT, StringHash((I2S((GetHandleId((tm)))))), StringHash(("OutRanger")), ((Bw) * 1.))
	call TimerStart(tm, hw, true, function xw)
	set tm = null
endfunction
function Cw takes nothing returns integer
	local integer h = s4
	if s4 < 0 then
		if t4 >= 8000 then
			return 8100
		else
			set t4 = t4 + 1
			return t4
		endif
	endif
	set s4 = u4[h]
	return h
endfunction
function cw takes integer cu returns nothing
	set u4[cu] = s4
	set s4 = cu
endfunction
function Dw takes real pw, trigger Ew returns integer
	local integer cu = Cw()
	local integer h = r4
	local integer t = R2I(100. * pw) + p4
	local integer p
	set x4[cu] = Ew
	set w4[cu] = t
	loop
		set p = v4[h]
		if p < 0 or w4[p] >= t then
			set v4[h] = cu
			set v4[cu] = p
			return cu
		endif
		set h = p
	endloop
	return cu
endfunction
function Fw takes nothing returns nothing
	call RemoveUnit(LoadUnitHandle(YDHT, c4, q4))
	call RemoveSavedHandle(YDHT, c4, q4)
endfunction
function Gw takes real pw, unit u returns nothing
	call SaveUnitHandle(YDHT, c4, Dw(pw, y4), u)
endfunction
function Hw takes nothing returns nothing
	call DestroyTimer(LoadTimerHandle(YDHT, c4, q4))
	call RemoveSavedHandle(YDHT, c4, q4)
endfunction
function Iw takes nothing returns nothing
	call RemoveItem(LoadItemHandle(YDHT, c4, q4))
	call RemoveSavedHandle(YDHT, c4, q4)
endfunction
function lw takes nothing returns nothing
	call DestroyEffectEx(LoadEffectHandle(YDHT, c4, q4))
	call RemoveSavedHandle(YDHT, c4, q4)
endfunction
function Jw takes real pw, effect e returns nothing
	call SaveEffectHandle(YDHT, c4, Dw(pw, a4), e)
endfunction
function Kw takes nothing returns nothing
	call DestroyLightning(LoadLightningHandle(YDHT, c4, q4))
	call RemoveSavedHandle(YDHT, c4, q4)
endfunction
function Lw takes real pw, lightning lt returns nothing
	local integer i = Dw(pw, B4)
	call SaveLightningHandle(YDHT, c4, i, lt)
endfunction
function Mw takes nothing returns nothing
	call TriggerExecute(LoadTriggerHandle(YDHT, c4, q4))
	call RemoveSavedHandle(YDHT, c4, q4)
endfunction
function Nw takes real pw, texttag tt returns nothing
	local integer N = 0
	local integer i = 0
	if pw <= 0 then
		set pw = .01
	endif
	call SetTextTagPermanent(tt, false)
	call SetTextTagLifespan(tt, pw)
	call SetTextTagFadepoint(tt, pw)
endfunction
function Ow takes nothing returns nothing
	local integer h = r4
	local integer p
	loop
		set q4 = v4[h]
		exitwhen q4 < 0 or p4 < w4[q4]
		call TriggerEvaluate(x4[q4])
		call cw(q4)
		set v4[h] = v4[q4]
	endloop
	set p4 = p4 + 1
endfunction
function Pw takes nothing returns nothing
	set C4 = CreateTimer()
	set c4 = GetHandleId(C4)
	set p4 = 0
	set r4 = 0
	set v4[0] =- 1
	set s4 = 1
	set t4 = 1
	set u4[1] =- 1
	set y4 = CreateTrigger()
	set z4 = CreateTrigger()
	set A4 = CreateTrigger()
	set a4 = CreateTrigger()
	set B4 = CreateTrigger()
	set b4 = CreateTrigger()
	call TriggerAddCondition(y4, Condition(function Fw))
	call TriggerAddCondition(z4, Condition(function Hw))
	call TriggerAddCondition(A4, Condition(function Iw))
	call TriggerAddCondition(a4, Condition(function lw))
	call TriggerAddCondition(B4, Condition(function Kw))
	call TriggerAddCondition(b4, Condition(function Mw))
	call TimerStart(C4, .01, true, function Ow)
endfunction
function Qw takes nothing returns nothing
	local integer Rw = GetHandleId(GetExpiredTimer())
	local trigger Pv = LoadTriggerHandle(YDHT, Rw, $D0001)
	call SaveInteger(YDHT, StringHash(I2S(GetHandleId(Pv))), StringHash("RunIndex"), LoadInteger(YDHT, Rw, $D0002))
	if TriggerEvaluate(Pv)then
		call TriggerExecute(Pv)
	endif
	set Pv = null
endfunction
function Sw takes nothing returns nothing
	local integer Rw = GetHandleId(GetExpiredTimer())
	local trigger Pv = LoadTriggerHandle(YDHT, Rw, $D0001)
	local integer Tw = LoadInteger(YDHT, Rw, $D0003)
	call SaveInteger(YDHT, StringHash(I2S(GetHandleId(Pv))), StringHash("RunIndex"), LoadInteger(YDHT, Rw, $D0002))
	if TriggerEvaluate(Pv)then
		call TriggerExecute(Pv)
	endif
	set Tw = Tw - 1
	if Tw > 0 then
		call SaveInteger(YDHT, Rw, $D0003, Tw)
	else
		call DestroyTimer(GetExpiredTimer())
		call FlushChildHashtable(YDHT, Rw)
	endif
	set Pv = null
endfunction
//0秒无敌，用来抵消伤害
function WuDiQingChu takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	call SetUnitInvulnerable( u, false )
	call PauseTimer(t)
	call DestroyTimer(t)
	set t = null
	set u = null
endfunction
function WuDi takes unit u returns nothing
	local timer t = CreateTimer()
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call SetUnitInvulnerable( u, true )
	call TimerStart(t, 0, false, function WuDiQingChu)
	set t = null
endfunction
//使单位晕眩 先天功、铁布衫
function SetUnitDizzyDoc takes nothing returns nothing
	local timer tm = GetExpiredTimer()
	local integer i = GetHandleId(tm)
	local unit Unit = LoadUnitHandle(YDHT, i, StringHash("unit"))
	local effect Eff = LoadEffectHandle(YDHT, i, StringHash("effect"))
	call DestroyEffectEx( Eff )
	call PauseUnit( Unit, false )
	call FlushChildHashtable(YDHT, i)
	call PauseTimer(tm)
	call DestroyTimer(tm)
	set tm = null
	set Unit = null
	set Eff = null
endfunction
function SetUnitDizzy takes unit Unit, real Size , string ExFile returns nothing
	local timer tm = CreateTimer()
	local integer i = GetHandleId(tm)
	local location loc = GetUnitLoc(Unit)
	//不无敌也不魔免
	if UnitHasBuffBJ(Unit, 'BHds') == false and IsUnitType(Unit, UNIT_TYPE_MAGIC_IMMUNE) == false then
		call SaveUnitHandle(YDHT, i, StringHash("unit"), Unit)
		call SaveEffectHandle(YDHT, i, StringHash("effect"), AddSpecialEffectTargetUnitBJEx( "overhead", Unit, ExFile ))
		call PauseUnit( Unit, true )
		call CreateTextTagLocBJ("封穴", loc, 0, 12., 65., 55., 42., 0)
		call Nw(Size, bj_lastCreatedTextTag)
		call SetTextTagVelocityBJ(bj_lastCreatedTextTag, 100., 90)
		call TimerStart(tm, Size, false, function SetUnitDizzyDoc)
	endif
	call RemoveLocation(loc)
	set loc = null
	set tm = null
endfunction

//===========================================================================
//绝学伤害系数
//@id:A06S 九阳真经散篇
//@id:A0DN 九阳神功
function jueXueXiShu takes integer i returns real
	return (1. + I2R(juexuelingwu[i])) * (1 + 0.4 * GetUnitAbilityLevel(udg_hero[i], 'A06S') * (1 + GetUnitAbilityLevel(udg_hero[i], 'A0DN')))
endfunction

/*
*  伤害公式
*/
function ShangHaiGongShi takes unit u, unit uc, real w1, real w2, real shxishu, integer id returns real
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local item it = null
	local integer j = 0
	local real shanghai
	local real attack //伤害因子
	local real target_def //敌方防御因子
	local real special_def // 特殊防御因子
	//local real critical //暴击因子
	local real dodge //闪避因子
	local real random //随机因子
	local real basic_damage //基础伤害
	local real str = I2R(GetHeroStatBJ(0, u, true)) // 招式伤害
	local real agi = I2R(GetHeroStatBJ(1, u, true)) // 内力
	local real int = I2R(GetHeroStatBJ(2, u, true)) // 真实伤害
	if UnitTypeNotNull(u, UNIT_TYPE_HERO) then
		// 神龙心法加成
		set attack = (1 + 0.3 * GetUnitAbilityLevel(u, 'A059')) \
		* 160 \
		* udg_lilianxishu[i] \
		* (w1 * (1 + str / 300) * (1 + agi / 300) + w2 * 0.02 * int) \
		* (1.5 + 0.5 * GetUnitAbilityLevel(u, id)) \
		* (udg_shanghaijiacheng[i] + 1.) \
		* shxishu
		
		// 养老模式
		if udg_yanglao then
			set attack = attack * 30
		endif
		// 9级技能伤害为原来的3倍
		if GetUnitAbilityLevel(u, id) == 9 then
			set attack = attack * 3
		endif
		// 携带十四天书神器，加强所有伤害2倍
		if UnitHaveItem(u, 'I0EE') or ateTianShu[i] == 1 then
			set attack = attack * 3
		endif
		
		//call BJDebugMsg(R2S(attack))
		set j = 1
		loop
			exitwhen j >= 7
			if(GetItemType(UnitItemInSlotBJ(u, j)) == ITEM_TYPE_ARTIFACT)then
				set it = UnitItemInSlotBJ(u, j)
			endif
			set j = j + 1
		endloop
		//君子剑、淑女剑
		if UnitHaveItem(u, 'I099') and (GetUnitTypeId(u) == 'O000' or GetUnitTypeId(u) == 'O001' or GetUnitTypeId(u) == 'O004' or GetUnitTypeId(u) == 'O02J') then
			set attack = attack * 1.5
		endif
		if UnitHaveItem(u, 'I09A') and (GetUnitTypeId(u) == 'O002' or GetUnitTypeId(u) == 'O003' or GetUnitTypeId(u) == 'O023' or GetUnitTypeId(u) == 'O02H' or GetUnitTypeId(u) == 'O02I') then
			set attack = attack * 1.5
		endif
	else
		if id == 'A0CH' then
			// 敌方用先天功不造成伤害
			set attack = 0
		else
			set attack = 750 * (w1 + w2) * (1. + GetUnitAbilityLevel(u, id)) * shxishu
		endif
		// 难6以上敌方用先天功加超多伤害
		// if udg_nandu>=5 and id == 1093682245 then
		// 	set attack = attack * 10
		// endif 
	endif
	
	
	if uc == null then
		set target_def = 1
	else
		// 敌方防御因子 = 1/(1+0.1*敌人等级)
		set target_def = 1 / (1 + 0.1 * GetUnitLevel(uc))
	endif
	
	// 特殊防御
	// 如果特攻大于等于42或者敌方虚弱
	if UnitHasBuffBJ(uc, 'B022') then
		set special_def = 1 + special_attack[i] * 0.06
	elseif special_attack[i] >= 6 * (1 + udg_nandu)  then
		// 特防 = 1+(特攻-42)*0.06，和1比取大值
		set special_def = RMaxBJ(1 + (special_attack[i] - 6 * (1 + udg_nandu)) * 0.06, 1)
	else
		// 特防 = 1/(1+0.06*(42 - 特攻))
		set special_def = 1 / (1 + 0.06 * ( (1 + udg_nandu) * 6 - special_attack[i])) 
	endif
	
	
	//set critical = udg_baojishanghai[1+GetPlayerId(GetOwningPlayer(u))]
	if uc == null then
		set dodge = 25
	else
		set dodge = RMinBJ(I2R(GetUnitLevel(uc)) / 5, 95.)
		if UnitHasBuffBJ(uc, 'Bslo') then
			set dodge = 0.
		endif
	endif
	// 随机因子 = 0.95到0.95+(b性格/20)取随机数
	set random = GetRandomReal(0.95, 0.95 + I2R(udg_xinggeB[i]) * 0.05)
	// 伤害 = 攻击因子 * 敌方防御因子 * 随机因子 * 特防
	set basic_damage = attack * target_def * random * special_def
	

	// 红怪
	if LoadInteger(YDHT, GetHandleId(uc), StringHash("color")) == 1 then
		set basic_damage = basic_damage / 100
	endif
	// 绿怪
	if LoadInteger(YDHT, GetHandleId(uc), StringHash("color")) == 2 then
		set basic_damage = basic_damage / 1000
	endif
	// 蓝怪
	if LoadInteger(YDHT, GetHandleId(uc), StringHash("color")) == 3 then
		set basic_damage = basic_damage / 10000
	endif

	// 无尽BOSS战模式第N个BOSS
	if uc == udg_boss[7] and tiaoZhanIndex == 3 then
		set basic_damage = basic_damage / Pow(10, endless_count)
	endif
	
	// 先天功不会miss
	if GetUnitAbilityLevel(u, 'A0CH') >= 1 then
		set dodge = 0
	endif
	
	if GetRandomReal(0, 100) < dodge then
		set shanghai = 0
	else
		set shanghai = basic_damage
	endif
	
	set p = null
	set it = null
	call SaveReal(YDHT, 1 + GetPlayerId(GetOwningPlayer(u)), id * 3, basic_damage)
	return shanghai
endfunction

function showDamageWithEffects takes integer i, unit u, real damage, boolean critical returns nothing
	local integer criticalInt = 2
	local location loc = GetUnitLoc(u)
	local string damageStr = ""
	local integer j = 1
	local effect eff = null
	local string effectStr = ""
	if critical then
		set criticalInt = 1
	endif
	if IsUnitEnemy(u, Player(0)) then
		// 显示伤害
		set damageStr = I2S(R2I(damage) + 1)
		loop
			exitwhen j > StringLength(damageStr)
			set effectStr = ""
			if showDamage[i] then
				set effectStr = "war3mapImported\\SHZT1" + I2S(criticalInt) + "-" + SubStringBJ(damageStr, j, j) + ".mdx"
			endif
			set eff = AddSpecialEffect(effectStr, GetUnitX(u) + 32 / 1.38 * (j - 1), GetUnitY(u))
			call EXSetEffectZ(eff, GetLocationZ(loc) + 80)
			call DestroyEffect(eff)
			set j = j + 1
		endloop
		if critical then
			set effectStr = ""
			if showDamage[i] then
				set effectStr = "war3mapImported\\SHZT11-10.mdx"
			endif
			set eff = AddSpecialEffect(effectStr, GetUnitX(u) - 37 / 1.38, GetUnitY(u))
			call EXSetEffectZ(eff, GetLocationZ(loc) + 80)
			call DestroyEffect(eff)
		endif
	endif	
	call RemoveLocation(loc)
	set loc = null
	set eff = null
endfunction

function WuGongShangHai takes unit u, unit uc, real shanghai returns nothing
	local effect eff = null
	local location loc = GetUnitLoc(uc)
	if shanghai == 0 then
		set eff = AddSpecialEffectEx("war3mapImported\\SHZT-MISS.mdx", GetUnitX(uc) - 64 / 1.38, GetUnitY(uc))
		// call EXSetEffectSize(eff, 1.38)
		call EXSetEffectZ(eff, GetLocationZ(loc) + 80)
		call DestroyEffectEx(eff)
		// call CreateTextTagUnitBJ("MISS",uc,0.,11.,255.,0.,0.,30.)
	else
		if GetRandomReal(0., 100.) <= 100. * udg_baojilv[1 + GetPlayerId(GetOwningPlayer(u))] then
			call UnitDamageTarget(u, uc, udg_baojishanghai[1 + GetPlayerId(GetOwningPlayer(u))] * shanghai, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
			call showDamageWithEffects(1 + GetPlayerId(GetOwningPlayer(u)), uc, udg_baojishanghai[1 + GetPlayerId(GetOwningPlayer(u))] * shanghai, true)
		else
			call UnitDamageTarget(u, uc, shanghai, true, false, ATTACK_TYPE_MAGIC, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
			call showDamageWithEffects(1 + GetPlayerId(GetOwningPlayer(u)), uc, shanghai, false)
		endif
	endif
	call SetTextTagVelocityBJ(bj_lastCreatedTextTag, 400., (GetRandomReal(80., 100.)))
	call Nw(.65, bj_lastCreatedTextTag)
	call RemoveLocation(loc)
	set loc = null
	set eff = null
endfunction


function createPartnerAndTownPortalDummy takes integer i, location loc returns nothing
	local player p = Player(i - 1)
	call CreateNUnitsAtLoc(1, 'nvul', p, loc, bj_UNIT_FACING)
	set P4[i] = bj_lastCreatedUnit
	call CreateNUnitsAtLoc(1, 'O02W', p, loc, bj_UNIT_FACING)
	call SuspendHeroXP(bj_lastCreatedUnit, true)
	call CreateNUnitsAtLoc(1, 'O02X', p, loc, bj_UNIT_FACING)
	call SuspendHeroXP(bj_lastCreatedUnit, true)
	call CreateNUnitsAtLoc(1, 'O02Y', p, loc, bj_UNIT_FACING)
	call SuspendHeroXP(bj_lastCreatedUnit, true)
	call SetPlayerMaxHeroesAllowed(0, p)
	set p = null
endfunction

/*
* 增加全属性
*/
function addAllAttrs takes integer i, integer num returns nothing
	set gengu[i] = gengu[i] + num
	set danpo[i] = danpo[i] + num
	set jingmai[i] = jingmai[i] + num
	set wuxing[i] = wuxing[i] + num
	set yishu[i] = yishu[i] + num
	set fuyuan[i] = fuyuan[i] + num
endfunction


/**	
* 重随机门派后调整属性点（原先的属性点加成去掉）
* @param i 玩家角标
* @param last_i 上一个门派的id
*/
function jianShuXingDian takes integer i, integer last_i returns nothing 
	if last_i == 11 then
		set udg_shuxing[i] = udg_shuxing[i] - 5
	elseif last_i == 14 then
		set wuxing[i] = (wuxing[i] - 3)
		set jingmai[i] = (jingmai[i] - 2)
		set fuyuan[i] = (fuyuan[i] - 2)
	elseif last_i == 16 then
		set gengu[i] = gengu[i] - 2
		set fuyuan[i] = fuyuan[i] - 2
		set danpo[i] = danpo[i] - 1
	elseif last_i == 17 then
		set gengu[i] = gengu[i] - 2
		set fuyuan[i] = fuyuan[i] - 2
		set danpo[i] = danpo[i] - 1
	elseif last_i == 18 then
		set gengu[i] = gengu[i] - 3
		set wuxing[i] = wuxing[i] - 1
		set yishu[i] = yishu[i] - 1
	elseif last_i == 12 then
		set danpo[i] = (danpo[i] - 2)
		set jingmai[i] = (jingmai[i] - 2)
		set fuyuan[i] = (fuyuan[i] - 1)
	elseif last_i == 13 then
		set udg_shuxing[i] = udg_shuxing[i] - 5
	elseif last_i == 1 then
		set gengu[i] = (gengu[i] - 3)
		set jingmai[i] = (jingmai[i] - 2)
	elseif last_i == 3 then
		set danpo[i] = (danpo[i] - 3)
		set jingmai[i] = (jingmai[i] - 2)
	elseif last_i == 4 then
		set wuxing[i] = (wuxing[i] - 3)
		set danpo[i] = (danpo[i] - 2)
	elseif last_i == 5 then
		set jingmai[i] = (jingmai[i] - 3)
		set fuyuan[i] = (fuyuan[i] - 2)
	elseif last_i == 6 then
		set gengu[i] = (gengu[i] - 2)
		set danpo[i] = (danpo[i] - 3)
	elseif last_i == 7 then
		set yishu[i] = (yishu[i] - 3)
		set fuyuan[i] = (fuyuan[i] - 2)
	elseif last_i == 8 then
		set yishu[i] = (yishu[i] - 1)
		set jingmai[i] = (jingmai[i] - 1)
		set fuyuan[i] = (fuyuan[i] - 3)
	elseif last_i == 10 then
		set danpo[i] = (danpo[i] - 2)
		set yishu[i] = (yishu[i] - 1)
		set jingmai[i] = (jingmai[i] - 2)
	elseif last_i == 9 then
		set gengu[i] = (gengu[i] - 1)
		set jingmai[i] = (jingmai[i] - 2)
		set fuyuan[i] = (fuyuan[i] - 2)
	elseif last_i == 2 then
		set wuxing[i] = (wuxing[i] - 2)
		set jingmai[i] = (jingmai[i] - 1)
		set fuyuan[i] = (fuyuan[i] - 2)
	elseif last_i == 15 then
		set wuxing[i] = (wuxing[i] - 3)
		set yishu[i] = (yishu[i] - 2)
	elseif last_i == 19 then
		set gengu[i] = gengu[i] - 3
		set danpo[i] = danpo[i] - 2
	elseif last_i == 20 then
		set wuxing[i] = wuxing[i] - 3
		set fuyuan[i] = fuyuan[i] - 2
	elseif last_i == 21 then
		call addAllAttrs(i, - 1)
	endif
endfunction


/**
* 随机或重选门派方法
* @param p 触发的玩家player
* @param status 1：输入- random，2：积分重随门派
*/
function randomMenpai takes player p, integer status returns nothing
	local integer i = GetPlayerId(p) + 1
	local integer last_i = 0
	// 保存上一个门派id
	set last_i = udg_runamen[i]
	
	//
	set udg_runamen[i] = GetRandomInt(1, DENOMINATION_NUMBER)
	if udg_runamen[i] == 11 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓自由门派〓|r")
		call SetPlayerName(p, "〓自由门派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call AdjustPlayerStateBJ(60, p, PLAYER_STATE_RESOURCE_LUMBER)
		set udg_shuxing[i] = udg_shuxing[i] + 5
	elseif udg_runamen[i] == 14 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓明教〓|r")
		call SetPlayerName(p, "〓明教〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set wuxing[i] = (wuxing[i] + 3)
		set jingmai[i] = (jingmai[i] + 2)
		set fuyuan[i] = (fuyuan[i] + 2)
	elseif udg_runamen[i] == 16 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓神龙教-英雄三招〓|r")
		call SetPlayerName(p, "〓神龙教〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set gengu[i] = gengu[i] + 2
		set fuyuan[i] = fuyuan[i] + 2
		set danpo[i] = danpo[i] + 1
	elseif udg_runamen[i] == 17 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓神龙教-美人三招〓|r")
		call SetPlayerName(p, "〓神龙教〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set gengu[i] = gengu[i] + 2
		set fuyuan[i] = fuyuan[i] + 2
		set danpo[i] = danpo[i] + 1
	elseif udg_runamen[i] == 18 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓泰山派〓|r")
		call SetPlayerName(p, "〓泰山派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set gengu[i] = gengu[i] + 3
		set wuxing[i] = wuxing[i] + 1
		set yishu[i] = yishu[i] + 1
	elseif udg_runamen[i] == 12 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓灵鹫宫〓|r")
		call SetPlayerName(p, "〓灵鹫宫〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set danpo[i] = (danpo[i] + 2)
		set jingmai[i] = (jingmai[i] + 2)
		set fuyuan[i] = (fuyuan[i] + 1)
	elseif udg_runamen[i] == 13 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓姑苏慕容〓|r")
		call SetPlayerName(p, "〓姑苏慕容〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set udg_shuxing[i] = udg_shuxing[i] + 5
	elseif udg_runamen[i] == 1 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓少林派〓|r")
		call SetPlayerName(p, "〓少林派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set gengu[i] = (gengu[i] + 3)
		set jingmai[i] = (jingmai[i] + 2)
	elseif udg_runamen[i] == 3 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓丐帮〓|r")
		call SetPlayerName(p, "〓丐帮〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set danpo[i] = (danpo[i] + 3)
		set jingmai[i] = (jingmai[i] + 2)
	elseif udg_runamen[i] == 4 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓华山派〓|r")
		call SetPlayerName(p, "〓华山派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set wuxing[i] = (wuxing[i] + 3)
		set danpo[i] = (danpo[i] + 2)
	elseif udg_runamen[i] == 5 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓全真教〓|r")
		call SetPlayerName(p, "〓全真教〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set jingmai[i] = (jingmai[i] + 3)
		set fuyuan[i] = (fuyuan[i] + 2)
	elseif udg_runamen[i] == 6 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓血刀门〓|r")
		call SetPlayerName(p, "〓血刀门〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set gengu[i] = (gengu[i] + 2)
		set danpo[i] = (danpo[i] + 3)
	elseif udg_runamen[i] == 7 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓恒山派〓|r")
		call SetPlayerName(p, "〓恒山派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set yishu[i] = (yishu[i] + 3)
		set fuyuan[i] = (fuyuan[i] + 2)
	elseif udg_runamen[i] == 8 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓峨眉派〓|r")
		call SetPlayerName(p, "〓峨眉派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set yishu[i] = (yishu[i] + 1)
		set jingmai[i] = (jingmai[i] + 1)
		set fuyuan[i] = (fuyuan[i] + 3)
	elseif udg_runamen[i] == 10 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓星宿派〓|r")
		call SetPlayerName(p, "〓星宿派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set danpo[i] = (danpo[i] + 2)
		set yishu[i] = (yishu[i] + 1)
		set jingmai[i] = (jingmai[i] + 2)
	elseif udg_runamen[i] == 9 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓武当派〓|r")
		call SetPlayerName(p, "〓武当派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set gengu[i] = (gengu[i] + 1)
		set jingmai[i] = (jingmai[i] + 2)
		set fuyuan[i] = (fuyuan[i] + 2)
	elseif udg_runamen[i] == 2 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓古墓派〓|r")
		call SetPlayerName(p, "〓古墓派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set wuxing[i] = (wuxing[i] + 2)
		set jingmai[i] = (jingmai[i] + 1)
		set fuyuan[i] = (fuyuan[i] + 2)
	elseif udg_runamen[i] == 15 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓衡山派〓|r")
		call SetPlayerName(p, "〓衡山派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set wuxing[i] = (wuxing[i] + 3)
		set yishu[i] = (yishu[i] + 2)
	elseif udg_runamen[i] == 19 then
		set gengu[i] = gengu[i] + 3
		set danpo[i] = danpo[i] + 2
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓铁掌帮〓|r")
		call SetPlayerName(p, "〓铁掌帮〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	elseif udg_runamen[i] == 20 then
		set wuxing[i] = wuxing[i] + 3
		set fuyuan[i] = fuyuan[i] + 2
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓唐门〓|r")
		call SetPlayerName(p, "〓唐门〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	elseif udg_runamen[i] == 21 then
		call addAllAttrs(i, 1)
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓五毒教〓|r")
		call SetPlayerName(p, "〓五毒教〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	elseif udg_runamen[i] == 22 then
		call addAllAttrs(i, 1)
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓桃花岛〓|r")
		call SetPlayerName(p, "〓桃花岛〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call SaveInteger(YDHT, GetHandleId(udg_hero[i]), BI_BO_POINT, 20)
		if Player(i - 1) == GetLocalPlayer() then
			call bibo_image.show()					
		endif
	elseif udg_runamen[i] == 23 then
		set danpo[i] = danpo[i] + 5
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓野螺派〓|r")
		call SetPlayerName(p, "〓野螺派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	elseif udg_runamen[i] == 24 then
		call addAllAttrs(i , 1)
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓雪山派〓|r")
		call SetPlayerName(p, "〓雪山派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	elseif udg_runamen[i] == 25 then
		call addAllAttrs(i , 1)
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓汝阳王府〓|r")
		call SetPlayerName(p, "〓汝阳王府〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	elseif udg_runamen[i] == 26 then
		set danpo[i] = danpo[i] + 3
		set jingmai[i] = jingmai[i] + 3
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "随机选择了〓嵩山派〓|r")
		call SetPlayerName(p, "〓嵩山派〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	endif
	if status == 1 then
		call DisplayTimedTextToPlayer(p, 0, 0, 15., "|CFF00FFFF提示：|r请在NPC|CFF00EE00郭靖|r处选择副职")
		call PingMinimapForPlayer(p, - 2075, - 312, 3)
		call UnitAddAbility(udg_hero[i], 'A05R')
		call AddCharacterABuff(udg_hero[i], udg_xinggeA[i])
		call AddCharacterBBuff(udg_hero[i], udg_xinggeB[i])
		if udg_vip[i] < 2 and udg_elevenvip[i] < 1 then
			call UnitAddAbility(udg_hero[i], 'A040')
			call UnitAddAbility(udg_hero[i], 'A041')
			call UnitAddAbility(udg_hero[i], 'A042')
		endif
		set I7[(((i - 1) * 20) + 8)] = 'A05R'
		call UnitRemoveAbility(udg_hero[i], 'Avul')
		set Q4 = GetRandomLocInRect(He)
		call SetUnitPositionLoc(udg_hero[i], Q4)
		call PanCameraToTimedLocForPlayer(p, Q4, 0)
		call createPartnerAndTownPortalDummy(i, Q4)
		call AdjustPlayerStateBJ(50, p, PLAYER_STATE_RESOURCE_LUMBER)
		call RemoveLocation(Q4)
		call UnitAddItemByIdSwapped(1227896394, udg_hero[i])
	endif
	// 扣除原来的属性
	if status == 2 then
		call jianShuXingDian(i, last_i)
	endif
endfunction


//击退系统
function knock_back_condition takes nothing returns boolean
	local unit u = LoadUnitHandle(YDHT, StringHash("击退"), 0)
	local real shanghai = LoadReal(YDHT, StringHash("击退"), 1)
	local unit uc = GetFilterUnit()
	if IsUnitEnemy(uc, GetOwningPlayer(u)) then
		//call DisplayTextToPlayer(GetOwningPlayer(u),0,0,R2S(shanghai))
		//call WuGongShangHai(u,uc,shanghai)
	endif
	set uc = null
	set u = null
	call FlushChildHashtable(YDHT, StringHash("击退"))
	return false
endfunction
function knock_back_on_timer takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local integer p = GetHandleId(t)
	local unit u = LoadUnitHandle(YDHT, p, 0)
	local integer step = LoadInteger(YDHT, p, 1) + 1
	local real shanghai = LoadReal(YDHT, p, 6)
	local group g = CreateGroup()
	//call  DisplayTextToPlayer(GetOwningPlayer(u),0,0,R2S(shanghai))
	call SaveInteger(YDHT, p, 1, step)
	if IsTerrainPathable( GetUnitX(u) + LoadReal(YDHT, p, 3), GetUnitY(u) + LoadReal(YDHT, p, 4), PATHING_TYPE_WALKABILITY) == false then
		call SetUnitX(u, CheckX(GetUnitX(u) + LoadReal(YDHT, p, 3)))
		call SetUnitY(u, CheckY(GetUnitY(u) + LoadReal(YDHT, p, 4)))
		call DestroyEffectEx(AddSpecialEffectEx(LoadStr(YDHT, p, 5), GetUnitX(u), GetUnitY(u)))
	endif
	call SaveUnitHandle(YDHT, StringHash("击退"), 0, u)
	call SaveReal(YDHT, StringHash("击退"), 1, shanghai)
	call GroupEnumUnitsInRange(g, CheckX(GetUnitX(u)), CheckY(GetUnitY(u)), 500, Condition(function knock_back_condition))
	if ( step >= LoadInteger(YDHT, p, 2) ) then
		call PauseTimer(t)
		call DestroyTimer(t)
		call FlushChildHashtable(YDHT, p)
	endif
	call GroupClear(g)
	call DestroyGroup(g)
	set g = null
	set u = null
	set t = null
endfunction
//击退函数
function knock_back takes unit u, real angle, real dist, real time, real period, string model, real shanghai returns nothing
	local timer t = CreateTimer()
	local integer p = GetHandleId(t)
	local integer m = R2I(time / period)
	set dist = dist / m //  单次位移距离
	call SaveUnitHandle(YDHT, p, 0, u) //  存储被击退单位
	call SaveInteger(YDHT, p, 1, 0) //  存储循环计数
	call SaveInteger(YDHT, p, 2, m) //  存储次数
	call SaveReal(YDHT, p, 3, dist * Cos(angle)) //  存储x轴速度分量
	call SaveReal(YDHT, p, 4, dist * Sin(angle)) //  存储y轴速度分量
	call SaveStr(YDHT, p, 5, model)
	call SaveReal(YDHT, p, 6, shanghai) //存储伤害
	call TimerStart(t, period, true, function knock_back_on_timer)
	set t = null
endfunction
function IsCertainWuGong takes unit u, unit uc, integer id returns boolean
	return (GetRandomReal(0., 100) < 15 + fuyuan[1 + GetPlayerId(GetOwningPlayer(u))] / 5) and (GetUnitAbilityLevel(u, id) >= 1) and (IsUnitEnemy(uc, GetOwningPlayer(u)))
endfunction
//BOSS AI放技能
function IsUnitBoss takes nothing returns boolean
	return ((GetUnitPointValue(GetTriggerUnit()) == 101))
endfunction
function BossFangJiNeng takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local unit uc = GetEventDamageSource()
	local real x = GetUnitX(uc)
	local real y = GetUnitY(uc)
	if GetRandomInt(1, 100) < 50 then
		if (GetUnitTypeId(GetTriggerUnit()) == u7[1]) then
			call IssuePointOrderById(u, $D0278, x, y)
		elseif (GetUnitTypeId(GetTriggerUnit()) == u7[2]) then
			if GetRandomInt(1, 3) == 1 then
				call IssueTargetOrderById(u, $D0278, uc)
			elseif GetRandomInt(1, 2) == 1 then
				call IssueImmediateOrderById(u, $D00D1)
			else
				call IssueImmediateOrderById(u, $D00D2)
			endif
		elseif (GetUnitTypeId(GetTriggerUnit()) == u7[3]) then
			call IssuePointOrderById(u, $D0278, x, y)
		elseif (GetUnitTypeId(GetTriggerUnit()) == u7[4]) then
			call IssuePointOrderById(u, $D0278, x, y)
		elseif (GetUnitTypeId(GetTriggerUnit()) == u7[5]) then
			call IssueTargetOrder(u, "chemicalrage", u)
		elseif (GetUnitTypeId(GetTriggerUnit()) == u7[6]) then
			call IssueTargetOrder(u, "devour", u)
		endif
	endif
	set u = null
	set uc = null
endfunction


//封装CreateTimerDialog方法并使对话框自动显示
function createTimerDialog takes timer t, string title returns timerdialog
	call CreateTimerDialogBJ(t, title)
	call TimerDialogDisplay(bj_lastCreatedTimerDialog, true)
	return bj_lastCreatedTimerDialog
endfunction

/*
* 马甲在目标单位所在处对单位释放技能
* @param owner 马甲所有者的英雄
* @param unitId 马甲单位id
* @param abilityId 马甲技能id
* @param orderId 马甲技能对应的命令ID
* @param target 马甲技能的施放目标
*/
function maJiaUseAbilityAtEnemysLoc takes unit owner, integer unitId, integer abilityId, integer orderId, unit target, real lifeTime returns nothing
	local location loc = GetUnitLoc(target)
	call CreateNUnitsAtLoc(1, unitId, GetOwningPlayer(owner), loc, bj_UNIT_FACING)
	call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, abilityId)
	call IssueTargetOrderById(bj_lastCreatedUnit, orderId, target)
	call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', lifeTime)
	call RemoveLocation(loc)
	set loc = null
endfunction

/*
* 马甲在目标单位所在处对单位释放技能
* @param owner 马甲所有者的英雄
* @param unitId 马甲单位id
* @param abilityId 马甲技能id
* @param orderId 马甲技能对应的命令ID
* @param target 马甲技能的施放目标
*/
function maJiaUseLeveldAbilityAtTargetLoc takes unit owner, integer unitId, integer abilityId, integer ablilityLevel, integer orderId, unit target, real lifeTime returns nothing
	local location loc = GetUnitLoc(target)
	call CreateNUnitsAtLoc(1, unitId, GetOwningPlayer(owner), loc, bj_UNIT_FACING)
	call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, abilityId)
	call SetUnitAbilityLevel(bj_lastCreatedUnit, abilityId, ablilityLevel)
	call IssueTargetOrderById(bj_lastCreatedUnit, orderId, target)
	call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', lifeTime)
	call RemoveLocation(loc)
	set loc = null
endfunction

/*
* 被动技能判断条件
*/
function PassiveWuGongCondition takes unit playerControllingUnit, unit enemy, integer abilityId returns boolean
	return GetUnitAbilityLevel(playerControllingUnit, abilityId) >= 1 and IsUnitEnemy(enemy, GetOwningPlayer(playerControllingUnit))
endfunction

/*
* 被动武功伤害对象的筛选条件：活着的敌人
*/
function DamageFilter takes unit playerControllingUnit, unit filtered returns boolean
	return IsUnitAliveBJ(filtered) and IsUnitEnemy(filtered, GetOwningPlayer(playerControllingUnit))
endfunction


// 是否为进攻者的敌人
function isAttackerEnemy takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetAttacker())) and IsUnitAliveBJ(GetFilterUnit())
endfunction

// 是否为触发单位的敌人
function isTriggerEnemy takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetTriggerUnit())) and IsUnitAliveBJ(GetFilterUnit())
endfunction

/*
* 武功搭配中技能加强伤害的系数
*/
function DamageCoefficientByAbility takes unit u, integer abilityId, real coefficient returns real
	if (GetUnitAbilityLevel(u, abilityId) >= 1) then
		return coefficient
	endif
	return 0.0
endfunction

/*
* 武功搭配中物品加强伤害的系数
*/
function DamageCoefficientByItem takes unit u, integer itemId, real coefficient returns real
	if (UnitHaveItem(u, itemId)) then
		return coefficient
	endif
	return 0.0
endfunction

/*
* 被动武功的特效和伤害
* @param w1:伤害公式中的第1个伤害因子
* @param w2:伤害公式中的第2个伤害因子
*/
function PassiveWuGongEffectAndDamage takes unit playerControllingUnit, unit enemy, string modelName, real w1, real w2, real damageCoefficient, integer abilityId returns nothing
	local location loc = GetUnitLoc(enemy)
	call DestroyEffectEx(AddSpecialEffectLocEx(modelName, loc))
	call WuGongShangHai(playerControllingUnit, enemy, ShangHaiGongShi(playerControllingUnit, enemy, w1, w2, damageCoefficient, abilityId))
	call RemoveLocation(loc)
	set loc = null
endfunction

/*
* 封装漂浮字方法
*/
function FontFloat takes string s, location loc, real zoffset, real size, real red, real green, real blue, real transparency, real time returns nothing
	call CreateTextTagLocBJ(s, loc, zoffset, size, red, green, blue, transparency)
	call Nw(time, bj_lastCreatedTextTag)
	call SetTextTagVelocityBJ(bj_lastCreatedTextTag, 100., 90)
endfunction

/*
* 关闭timer并清空timer储存信息
*/
function clearTimer takes timer tm returns nothing
	call FlushChildHashtable(YDHT, GetHandleId(tm))
	call PauseTimer(tm)
	call DestroyTimer(tm)
endfunction



// mod 1-增加 2-设置
// ch 增加数量
// id 生命值修改的技能
function LifeChange takes unit u, integer mod, integer ch, integer id returns nothing
	local integer a
	local integer b
	local integer c
	local integer d
	local integer aid = id
	
	if mod == 1 then
		set ch =- ch
	elseif mod == 2 then
		set ch = ch - R2I(GetUnitState(u, UNIT_STATE_MAX_LIFE))
	endif
	//set YDWEADDBONUS_LIFE=YDWEADDBONUS_LIFE+ch
	if ch > 999999999 then
		set ch = 999999999
	endif
	if ch <- 999999999 then
		set ch =- 999999999
	endif
	if ch < 0 then
		set a = 2
		set ch =- ch
	else
		set a = 12
	endif
	set b = 0
	loop
		exitwhen b == 10
		set c = ch - ch / 10 * 10
		set d = 0
		loop
			exitwhen d == c
			call UnitAddAbility(u, aid)
			call SetUnitAbilityLevel(u, aid, a)
			call UnitRemoveAbility(u, aid)
			set d = d + 1
		endloop
		set ch = ch / 10
		set a = a + 1
		set b = b + 1
	endloop
	
endfunction

// 百分比伤害
function percentDamage takes unit uc, real percent, boolean max returns nothing
	// 无尽BOSS模式下，百分比伤害失效
	if uc == udg_boss[7] and tiaoZhanIndex == 3 then
		return
	endif
	set percent = percent / 2
	if max then
		if GetUnitState(uc, UNIT_STATE_LIFE) <= percent / 100 * GetUnitState(uc, UNIT_STATE_MAX_LIFE)then
			call WuDi(uc)
			call SetWidgetLife(uc, 1.)
		else
			call SetWidgetLife(uc, GetUnitState(uc, UNIT_STATE_LIFE) - percent / 100 * GetUnitState(uc, UNIT_STATE_MAX_LIFE))
		endif
	else
		call SetWidgetLife(uc, GetWidgetLife(uc) * (100 - percent) / 100)
	endif
endfunction


function isPlayersEnemy takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(), Player(5)) and IsUnitAliveBJ(GetFilterUnit())
endfunction

// 动态调整难度
function dynamicDifficultyAdjustment takes integer experience returns nothing
	// 查看玩家1到玩家5的历练值，是否当前为唯一的最高值，如果是，则调整难度
	local integer count = 0
	local integer whichPlayer = 0
	local integer i = 1
	loop
		exitwhen i > 5
		if xiuxing[i] > experience then
			return
		endif
		if xiuxing[i] == experience then
			set count = count + 1
			set whichPlayer = i
		endif
		set i = i + 1
	endloop
	if count == 1 and udg_boshu <= 4 * experience then
		// 如果当前难度为0或2，则科技+1
		if udg_nandu <= 2 then
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "由于玩家" + I2S(whichPlayer) + "完成了历练" + I2S(experience) + "，难度动态调整，怪物科技上升")
			call SetPlayerTechResearched(Player(12), 1378889777, GetPlayerTechCount(Player(12), 1378889777, true) + 1)
			call SetPlayerTechResearched(Player(6), 1378889777, GetPlayerTechCount(Player(6), 1378889777, true) + 1)
			call SetPlayerTechResearched(Player(15), 1378889777, GetPlayerTechCount(Player(15), 1378889777, true) + 1)
		endif
	endif
endfunction

function isKungfuFull takes integer i returns boolean
	local integer j = 1
	loop
		exitwhen j > wugongshu[i]
		// call BJDebugMsg(I2S(I7[20 * ( i - 1 ) + j]))
		if I7[20 * ( i - 1 ) + j] == 1095067243 then
			return false
		endif
		set j = j + 1
	endloop
	call DisplayTextToPlayer(Player(i - 1), 0, 0, "|CFFFF0033学习技能已达上限，请先遗忘部分技能")
	return true
endfunction
#endif //CommonFuncIncluded
