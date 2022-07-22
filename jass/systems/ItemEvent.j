

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

function UseItem_Conditions takes nothing returns boolean
	local unit u = GetTriggerUnit()
	local item it = GetManipulatedItem()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	
	if GetItemTypeId(it) == ITEM_YE_LUO then
		call addAllAttrs(i, 2)
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15, "|CFFDDFF00有玩家食用了野螺，获得全属性+2")
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
	if GetItemTypeId(it) == ITEM_YE_LUO  then
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
	call TriggerAddCondition(t,Condition(function BuyItem_Conditions))
	
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_USE_ITEM)
	call TriggerAddCondition(t,Condition(function UseItem_Conditions))

	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(t,Condition(function PickupItem_Conditions))
	set t = null
endfunction



