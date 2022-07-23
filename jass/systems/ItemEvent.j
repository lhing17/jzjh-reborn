

// 购买物品
function BuyItem_Conditions takes nothing returns boolean
	local unit u = GetBuyingUnit()
	local unit ut = GetSellingUnit()
	local item it = GetSoldItem()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	
	// 八面玲珑
	if GetUnitAbilityLevel(udg_hero[i], BA_MIAN_LING_LONG) >= 1 then
		call baMianLingLong(udg_hero[i], it)
	endif
	
	set u = null
	set ut = null
	return false
endfunction

function getDenomExclusive takes integer i returns integer
	if i == 1 then
		return 'I0AL'
	elseif i == 2 then
		return 'I09C'
	elseif i == 3 then
		return 'I097'
	elseif i == 4 then
		return 'I0E0'
	elseif i == 5 then
		return 'I0DP'
	elseif i == 6 then
		return 'I098'
	elseif i == 7 then
		return 'I0DU'
	elseif i == 8 then
		return 'I00B'
	elseif i == 9 then
		return 'I0DK'
	elseif i == 10 then
		return 'I0AM'
	elseif i == 11 then
		return 'I0EE'
	elseif i == 12 then
		return 'I0DT'
	elseif i == 13 then
		return 'I0DS'
	elseif i == 14 then
		return 'I00D'
	elseif i == 15 then
		return 'I0DY'
	elseif i == 16 then
		return 'I0DZ'
	elseif i == 17 then
		return 'I0DZ'
	elseif i == 18 then
		return 'I0E2'
	elseif i == 19 then
		return 'I0EJ'
	elseif i == 20 then
		return 'I0EP'
	elseif i == 21 then
		return 'I0AE'
	elseif i == 22 then
		return 'I09D'
	elseif i == 23 then
		return 'I0EU'
	elseif i == 24 then
		return 'I0EZ'
	elseif i == 25 then
		return 'I00B'
	endif
	return 0
endfunction

function UseItem_Conditions takes nothing returns boolean
	local unit u = GetTriggerUnit()
	local item it = GetManipulatedItem()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local integer id = 0
	
	if GetItemTypeId(it) == ITEM_YE_LUO then
		call addAllAttrs(i, 2)
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15, "|CFFDDFF00有玩家食用了野螺，获得全属性+2")
	endif

	if GetItemTypeId(it) == 'I0EW' then
		if ateDenom[i] == 1 and ateTianShu[i] == 1 then
			call DisplayTextToPlayer(Player(i), 0, 0, "每局限使用两次哦（一次本门派专属和一次十四天书）")
			call UnitAddItemById(u, 'I0EW')
			return false
		endif
		if not IsUnitType(u, UNIT_TYPE_HERO) then
			call DisplayTextToPlayer(Player(i), 0, 0, "只有英雄才能使用哦")
			call UnitAddItemById(u, 'I0EW')
			return false
		endif
		if ateDenom[i] == 0 then
			if UnitHaveItem(u, getDenomExclusive(i)) then
				set id = getDenomExclusive(i)
			elseif udg_runamen[i] == 20 and UnitHaveItem(u, 'I0EQ') then
				set id = 'I0EQ'
			endif
			if id != 0 then
				call RemoveItem(FetchUnitItem(u, id))
				set ateDenom[i] = 1
				call DisplayTextToPlayer(Player(i), 0, 0, "|CFFDDFF00已将专属" + GetObjectName(id) + "内化")
				return false
			endif
		endif
		if ateTianShu[i] == 0 and UnitHaveItem(u, 'I0EE') then
			call RemoveItem(FetchUnitItem(u, 'I0EE'))
			set ateTianShu[i] = 1
			call DisplayTextToPlayer(Player(i), 0, 0, "|CFFDDFF00已将十四天书内化")
			return false
		endif
		call DisplayTextToPlayer(Player(i), 0, 0, "|CFFDDFF00身上没有专属或者已经内化过该专属了")
		call UnitAddItemById(u, 'I0EW')
	endif
	
	set u = null
	set it = null
	return false
endfunction

function PickupItem_Conditions takes nothing returns boolean
	local unit u = GetTriggerUnit()
	local item it = GetManipulatedItem()
	local item itt
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local integer point = GetItemCharges(it)
	local integer j = 0
	
	// 多个野螺合并次数
	if GetItemTypeId(it) == ITEM_YE_LUO then
		loop
			exitwhen j > 5
			set itt = UnitItemInSlot(u, j)
			if itt != it and GetItemTypeId(itt) == ITEM_YE_LUO then
				call RemoveItem(it)
				call SetItemCharges(itt, GetItemCharges(itt) + point)
				exitwhen true
			endif
		endloop
	endif
	
	set u = null
	set it = null
	set itt = null
	return false
endfunction

//任意单位购买物品系统
function ItemEvent takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SELL_ITEM)
	call TriggerAddCondition(t, Condition(function BuyItem_Conditions))
	
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_USE_ITEM)
	call TriggerAddCondition(t, Condition(function UseItem_Conditions))

	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(t, Condition(function PickupItem_Conditions))
	set t = null
endfunction



