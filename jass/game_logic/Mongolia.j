/*
* 蒙古大营
*/

globals
    integer array openDenoms
    integer array openDenomIds
    dialog array openDenomDialog
    constant integer openDenomButtonKey = $86556
    integer array dahanTask
    integer array nimoxingTask
endglobals

// 本局开放五个门派作为中原武学散篇的随机范围
// 从1到DENOMINATION_NUMBER之间选择5个不重复的数字，不包含数字11
function generateOpenDenoms takes nothing returns nothing
    local integer j = 1
    local integer k = 1
    local integer temp = 1
    loop
        exitwhen j > DENOMINATION_NUMBER
        if j != 11 then
            set openDenoms[k] = j
            set k = k + 1
        endif
        set j = j + 1
    endloop

    set j = 1
    set k = 1
    loop
        exitwhen j >= DENOMINATION_NUMBER - 1
        set k = GetRandomInt(j + 1, DENOMINATION_NUMBER - 1)
        set temp = openDenoms[j]
        set openDenoms[j] = openDenoms[k]
        set openDenoms[k] = temp
        set j = j + 1
    endloop
endfunction
// 查看当前开放的五个门派
function checkOpenDenoms takes player p returns nothing
    local integer j = 1
    call DisplayTextToPlayer(p, 0, 0, "本局开放门派为：")
    loop
        exitwhen j > 5
        call DisplayTextToPlayer(p, 0, 0, udg_menpainame[openDenoms[j]])
        set j = j + 1
    endloop
endfunction

// 使用中原武学散篇学习门派武功
function learnOpenDenoms takes unit u returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    local integer rand = openDenoms[GetRandomInt(1, 5)]
    local integer j = 1
    if isKungfuFull(i) then
        call UnitAddItemById(u, 'I0F2')
        return
    endif
    set openDenomIds[1] = denomFirst[rand]
    set openDenomIds[2] = denomSecond[rand]
    set openDenomIds[3] = denomThird[rand]
    set openDenomIds[4] = denomFourth[rand]
    set openDenomIds[5] = denomFifth[rand]
    call DialogSetMessage(openDenomDialog[i], "|CFF00FFFF请选择要学习的武功!")
    set j = 1
    loop
        exitwhen j > 5
        call SaveButtonHandle(YDHT, openDenomButtonKey + i, j, DialogAddButtonBJ(openDenomDialog[i], GetObjectName(openDenomIds[j])))
        call SaveInteger(YDHT, openDenomButtonKey + i, j, openDenomIds[j])
        set j = j + 1
    endloop
    call SaveButtonHandle(YDHT, openDenomButtonKey + i, 6, DialogAddButtonBJ(openDenomDialog[i], "|CFF00FFFF取消"))
    call DialogDisplay(GetOwningPlayer(u), openDenomDialog[i], true)
endfunction

function openDenomDialogHandler takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local integer i = 1 + GetPlayerId(p)
    local integer k = 1
    local integer j = 1
    local integer id = 0
    local integer level = 1
    local integer l__kk = 1
    loop
        exitwhen k > 6
        if GetClickedButton() == LoadButtonHandle(YDHT, openDenomButtonKey + i, k) then
            set id = LoadInteger(YDHT, openDenomButtonKey + i, k)
            if GetUnitAbilityLevel(udg_hero[i], id) > 0 then
                call DisplayTextToPlayer(p, 0, 0, "|CFFFF0033你已经拥有此武功了")
                call FlushChildHashtable(YDHT, openDenomButtonKey + i)
                call DialogClear(openDenomDialog[i])
                return
            endif
            call UnitAddAbility(udg_hero[i], id)
            call UnitMakeAbilityPermanent(udg_hero[i], true, id)
            call SetUnitAbilityLevel(udg_hero[i], id, IMaxBJ(level, LoadInteger(YDHT, GetHandleId(p), id * 5)))
            
            if id == 'A03Q' then
                // 百胜神拳
				call AddPlayerTechResearched(p, 'Rhri', 1)
            else
                set j = 1
                loop
                    exitwhen j > wugongshu[i]
                    if I7[20 * ( i - 1 ) + j] == 1095067243 then
                        set I7[20 * ( i - 1 ) + j] = id
                        exitwhen true
                    endif
                    set j = j + 1
                endloop
            endif
            call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF0033恭喜" + GetPlayerName(p) + "习得" + GetObjectName(id) + "|r")

            if id == 'A0EL' then
                call qimen_widget.show()
            elseif id == 'A0EK' then
                call bibo_image.show()
            endif

            set l__kk = 1
            loop
                exitwhen l__kk > 20
                if id == MM9[l__kk] then
                    set udg_shanghaijiacheng[i] = udg_shanghaijiacheng[i] + udg_jueneishjc[l__kk]
                    call ModifyHeroStat(1, udg_hero[i], 0, udg_jueneiminjie[l__kk])
                    set udg_baojilv[i] = udg_baojilv[i] + udg_jueneibaojilv[l__kk]
                    set juexuelingwu[i] = juexuelingwu[i] + udg_jueneijxlw[l__kk]
                    set udg_shanghaixishou[i] = udg_shanghaixishou[i] + udg_jueneishxs[l__kk]
                endif
                set l__kk = l__kk + 1
            endloop
            call FlushChildHashtable(YDHT, openDenomButtonKey + i)
            call DialogClear(openDenomDialog[i])
            return
        endif
        set k = k + 1
    endloop
    set p = null
endfunction
    
function initOpenDenom takes nothing returns nothing
    local integer i = 1
    local trigger t = CreateTrigger()
    call generateOpenDenoms()
    set i = 1
    loop
        exitwhen i > 5
        set openDenomDialog[i] = DialogCreate()
        set dahanTask[i] = 0
        set nimoxingTask[i] = 0
        call TriggerRegisterDialogEvent(t, openDenomDialog[i])
        set i = i + 1
    endloop
    call TriggerAddAction(t, function openDenomDialogHandler)
    set t = null
endfunction