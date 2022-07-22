// 清除地图上的物品

globals
    boolean array readyToClear
endglobals

function isNotBook takes nothing returns boolean
    local integer id = GetItemTypeId(GetFilterItem())
    local integer j = 1
    loop
        exitwhen j > 18
        if id == udg_jianghu[j] then
            return false
        endif
        set j = j + 1
    endloop
    set j = 1
    loop
        exitwhen j > 10
        if id == udg_juexue[j] then
            return false
        endif
        set j = j + 1
    endloop
    set j = 1
    loop
        exitwhen j > 8
        if id == udg_juenei[j] then
            return false
        endif
        set j = j + 1
    endloop
    set j = 1
    loop
        exitwhen j > 11
        if id == udg_canzhang[j] then
            return false
        endif
        set j = j + 1
    endloop
    set j = 1
    loop
        exitwhen j > 11
        if id == udg_canzhang[j] then
            return false
        endif
        set j = j + 1
    endloop
    set j = 1
    loop
        exitwhen j > 15
        if id == udg_qiwu[j] then
            return false
        endif
        set j = j + 1
    endloop
    return true
endfunction

function doCleanItems takes nothing returns nothing
    call RemoveItem(GetEnumItem())
endfunction

function cleanItemActions takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local string s = GetEventPlayerChatString()
    local integer i = 1 + GetPlayerId(p)
    if s == "-clean" or s == "-clear" then
        if not readyToClear[i] then
            call DisplayTextToPlayer(p, 0, 0, "|cffff0000请确保地图上没有有用的物品(武功书不会被清理)，然后再次输入-clean或-clear")
            set readyToClear[i] = true
        else
            call EnumItemsInRect(bj_mapInitialPlayableArea, Condition(function isNotBook), function doCleanItems)
            set readyToClear[i] = false
        endif
    endif
    set p = null
endfunction


function cleanItems takes nothing returns nothing
	local trigger t = CreateTrigger()
	local integer i = 1
	loop
		exitwhen i > 6
        set readyToClear[i] = false
		call TriggerRegisterPlayerChatEvent(t,Player(i-1),"",true)
		set i = i + 1
	endloop
	call TriggerAddAction(t,function cleanItemActions)
	set t = null
endfunction