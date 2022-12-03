globals
	integer itemScore = 0
	integer antiqueIndex = 0
	constant integer antiqueKey = $98988
endglobals


function isDAntique takes integer id returns boolean
	return id == 'I053' or id == 'I054' or id == 'I055'
endfunction

function isCAntique takes integer id returns boolean
	return id == 'I056' or id == 'I057' or id == 'I058'
endfunction

function isBAntique takes integer id returns boolean
	return id == 'I059' or id == 'I05A' or id == 'I05B'
endfunction

function isAAntique takes integer id returns boolean
	return id == 'I05C'
endfunction


function doExchangeBooks takes nothing returns nothing
	local integer id = GetItemTypeId(GetEnumItem())
	local integer dSuit = 0
	local item itemD1 = null
	local item itemD2 = null
	local item itemD3 = null
	local item itemC1 = null
	local item itemC2 = null
	local item itemC3 = null
	local item itemB1 = null
	local item itemB2 = null
	local item itemB3 = null
	local item itemA1 = null
	local item itemA2 = null
	local integer cSuit = 0
	local integer bSuit = 0
	local integer aSuit = 0
	local integer i = 1
	local real x = GetItemX(GetEnumItem())
	local real y = GetItemY(GetEnumItem())

	set antiqueIndex = antiqueIndex + 1
	call SaveItemHandle(YDHT, antiqueKey, antiqueIndex, GetEnumItem())
	if isDAntique(id) then
		loop
			exitwhen i > antiqueIndex
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I053' then
				set dSuit = YDWEBitwise_OR(dSuit, 1)
				set itemD1 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I054' then
				set dSuit = YDWEBitwise_OR(dSuit, 2)
				set itemD2 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I055' then
				set dSuit = YDWEBitwise_OR(dSuit, 4)
				set itemD3 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			set i = i + 1
		endloop
		if dSuit == 7 then
			call RemoveItem(itemD1)
			call RemoveItem(itemD2)
			call RemoveItem(itemD3)
			call CreateItem( udg_jianghu[GetRandomInt(1, 18)], x, y)
			set itemScore = itemScore + 2
		endif
	endif
	if isCAntique(id) then
		loop
			exitwhen i > antiqueIndex
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I056' then
				set cSuit = YDWEBitwise_OR(cSuit, 1)
				set itemC1 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I057' then
				set cSuit = YDWEBitwise_OR(cSuit, 2)
				set itemC2 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I058' then
				set cSuit = YDWEBitwise_OR(cSuit, 4)
				set itemC3 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			set i = i + 1
		endloop
		if cSuit == 7 then
			call RemoveItem(itemC1)
			call RemoveItem(itemC2)
			call RemoveItem(itemC3)
			call CreateItem( udg_juexue[GetRandomInt(1, 10)], x, y)
			set itemScore = itemScore + 4
		endif
	endif
	if isBAntique(id) then
		loop
			exitwhen i > antiqueIndex
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I059' then
				set bSuit = YDWEBitwise_OR(bSuit, 1)
				set itemB1 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I05A' then
				set bSuit = YDWEBitwise_OR(bSuit, 2)
				set itemB2 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I05B' then
				set bSuit = YDWEBitwise_OR(bSuit, 4)
				set itemB3 = LoadItemHandle(YDHT, antiqueKey, i)
			endif
			set i = i + 1
		endloop
		if bSuit == 7 then
			call RemoveItem(itemB1)
			call RemoveItem(itemB2)
			call RemoveItem(itemB3)
			call CreateItem( udg_juenei[GetRandomInt(1, 8)], x, y)
			set itemScore = itemScore + 6
		endif
	endif
	if isAAntique(id) then
		loop
			exitwhen i > antiqueIndex
			if GetItemTypeId(LoadItemHandle(YDHT, antiqueKey, i)) == 'I05C' then
				if itemA1 == null then
					set aSuit = YDWEBitwise_OR(aSuit, 1)
					set itemA1 = LoadItemHandle(YDHT, antiqueKey, i)
				else
					set aSuit = YDWEBitwise_OR(aSuit, 2)
					set itemA2 = LoadItemHandle(YDHT, antiqueKey, i)
				endif
			endif
			set i = i + 1
		endloop
		if aSuit == 3 then
			call RemoveItem(itemA1)
			call RemoveItem(itemA2)
			call CreateItem( udg_canzhang[GetRandomInt(1, 10)], x, y)
			set itemScore = itemScore + 10
		endif
	endif
	set itemD1 = null
	set itemD2 = null
	set itemD3 = null
	set itemC1 = null
	set itemC2 = null
	set itemC3 = null
	set itemB1 = null
	set itemB2 = null
	set itemB3 = null
	set itemA1 = null
	set itemA2 = null
endfunction

function piLiangJianDing takes unit u, real x, real y returns nothing
	local rect r = Rect(x - 300, y - 300, x + 300, y + 300)
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)

	set antiqueIndex = 0
	set itemScore = 0
	call EnumItemsInRect(r, null, function doExchangeBooks)

	call FlushChildHashtable(YDHT, antiqueKey)
	set udg_jdds[i] = udg_jdds[i] + itemScore
	if udg_jdds[i] <= 10 and not (Deputy_isMaster(i, JIAN_DING)) and Deputy_isDeputy(i, JIAN_DING) then
		call DisplayTextToPlayer(p, 0, 0, "|CFF66FF00您的鉴定师已经得了" + I2S(udg_jdds[i]) + "分，得到10分可获得鉴定大师哦")
	endif
	if udg_jdds[i] >= 10 and not (Deputy_isMaster(i, JIAN_DING)) and Deputy_isDeputy(i, JIAN_DING) then
		set wuxing[i] = wuxing[i] + 10 // 悟性加10
		call Deputy_setMaster(i, JIAN_DING)
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFF66FF00恭喜" + GetPlayerName(p) + "获得鉴定大师")
		call SetPlayerName(p, "〓鉴定大师〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
	endif

endfunction

function shortenAbilityCd takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local integer id = LoadInteger(YDHT, GetHandleId(t), 1)

	// CD变为0.5倍
	call EXSetAbilityState(EXGetUnitAbility(u, id), 1, EXGetAbilityState(EXGetUnitAbility(u, id), 1) * 0.5)
	call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "岚葵发动了|CFF66FF00岚葵的祝福|r，" + GetObjectName(id) + "的冷却时间缩短了")

	call FlushChildHashtable(YDHT, GetHandleId(t))
	call DestroyTimer(t)
	set t = null
	set u = null

endfunction

//使用技能系统
function UseAbility_Conditions takes nothing returns boolean
	local integer id = GetSpellAbilityId()
	local unit u = GetTriggerUnit()
	local unit ut = GetSpellTargetUnit()
	local unit last = null
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local timer t = null
	local real r = 0
	local integer j = 0
	local real range = 500
	local real rand = 0
	local integer randInt = 0
	local group g = null
	local integer life = 0
	local real x = GetSpellTargetX()
	local real y = GetSpellTargetY()
	
	// 岚葵皮肤效果岚葵的禅定——使用技能时，有一定几率CD减少为原来的0.67倍
	if (GetUnitTypeId(P4[i]) == 'n018' and GetRandomInt(1, 100) <= 30) and id != 'A00C' and IsUnitType(u, UNIT_TYPE_HERO) then
		set t = CreateTimer()
		call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
		call SaveInteger(YDHT, GetHandleId(t), 1, id)
		call TimerStart(t, 0.2, false, function shortenAbilityCd)
	endif

	// 五毒教：五毒笛咒
	if id == WU_DU_ZHOU then
		call wuDuZhou()
	endif
	
	// 五毒教：补天心经
	if id == BU_TIAN_JING then
		call buTianJing()
	endif
	
	// 五毒教：万蜍噬心
	if id == WAN_CHU_SHI_XIN then
		call wanChuShiXin()
	endif
	
	// 桃花岛：落英神剑掌 
	if id == LUO_YING_ZHANG then
		call luoYingZhang(u)
	endif
	// 桃花岛：碧波心经 
	if id == BI_BO_XIN_JING then
		call biBoXinJing(u)
	endif
	
	// 桃花岛：奇门术数 
	if id == QI_MEN_SHU_SHU then
		call qiMenShuShu(u)
	endif

	// 野螺派：反手牵猪
	if id == FAN_SHOU_QIAN_ZHU then
		call fanShouQianZhu(u, ut)
	endif

	// 野螺派：乾坤一掷
	if id == QIAN_KUN_YI_ZHI then
		call qianKunYiZhi(u)
	endif

	// 汝阳王府：嫁衣神功
	if id == JIA_YI_SHEN_GONG then
		call jiaYiShenGong(u)
	endif

	// 汝阳王府：偷看偷学
	if id == TOU_KAN_TOU_XUE then
		call touKanTouXue(u)
	endif

	// 宠物：批量鉴定
	if id == 'A08O' then
		call piLiangJianDing(u, GetSpellTargetX(), GetSpellTargetY())
	endif

	// 雪山：风沙莽莽
	if id == FENG_SHA_MANG_MANG then
		call fengShaMangMang(u)
	endif

	// 雪山：雪花六出
	if id == XUE_HUA_LIU_CHU or (id == 'A07A' and GetUnitAbilityLevel(u, XUE_HUA_LIU_CHU) > 0)  then
		call xueHuaLiuChu(u)
	endif

	// 雪山：无妄神功
	if id == WU_WANG_SHEN_GONG then
		call wuWangShenGong(u)
	endif

	// 嵩山：子午十二剑
	if id == ZI_WU_SHI_ER_JIAN then
		call ziWuShiErJian(u)
	endif

	// 嵩山：寒冰神掌
	if id == HAN_BING_SHEN_ZHANG then
		call hanBingShenZhang(u)
	endif

	// 嵩山：无名内功
	if id == WU_MING_NEI_GONG then
		call wuMingNeiGong(u)
	endif

	// 嵩山：大嵩阳神掌
	if id == DA_SONG_YANG_SHEN_ZHANG then
		call daSongYangShenZhang(u, ut)
	endif

	// 光明教：天魔拳
	if id == TIAN_MO_QUAN then
		call tianMoQuan(u)
	endif

	// 光明教：吸星神掌
	if id == XI_XING_SHEN_ZHANG then
		call xiXingShenZhang(u, x, y)
	endif

	// 光明教：葵花心法
	if id == KUI_HUA_XIN_FA then
		call kuiHuaXinFa(u)
	endif
 
	set u = null
	set ut = null
	set p = null
	set g = null
	set last = null
	set t = null
	return false
endfunction

//单位使用技能系统
function UseAbility takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t, Condition(function UseAbility_Conditions))
	set t = null
endfunction
