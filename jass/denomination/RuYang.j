globals
    integer array touKanCounter
    integer array touKanIds
    integer array xuanMingCounter
    dialog array ruyangDialog
    constant integer ruyangButtonKey = $66556
endglobals

//---------------------------------------------------
// 汝阳一技能 偷看偷学
// 效果：
// 第一次使用在所有门派一技能中随机出五个进行选择
// 第二次使用在所有门派二技能中随机出五个进行选择
// 第三次使用在所有门派三技能中随机出五个进行选择
// 第四次使用在所有门派毕业技中随机出五个进行选择
// 第五次开始在所有技能中随机五个进行选择
//
// + 乾坤大挪移 学习武功等级+1
// + “郡主”称号 学习武功等级+1
// + 龙象般若功 学习武功等级+1
// + 自创武学 学习武功等级+2
//---------------------------------------------------
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

function closeTouKanDialog takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = LoadInteger(YDHT, GetHandleId(t), 0)
	call FlushChildHashtable(YDHT, ruyangButtonKey + i)
    call DialogClear(ruyangDialog[i])
    call DialogDisplay(Player(i - 1), ruyangDialog[i], false)
    call FlushChildHashtable(YDHT, GetHandleId(t))
	call PauseTimer(t)
	call DestroyTimer(t)
	set t = null
endfunction

function touKanTouXue takes unit u returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    local integer array randList
    local integer j = 1
    local integer k = 1
    local integer temp = 0
    local timer t = null
    set touKanCounter[i] = touKanCounter[i] + 1
    if isKungfuFull(i) then
        return
    endif
    loop
        exitwhen j > DENOMINATION_NUMBER
        set randList[j] = j
        set j = j + 1
    endloop

    set j = 1
    loop
        exitwhen j > DENOMINATION_NUMBER
        set k = GetRandomInt(1, DENOMINATION_NUMBER)
        set temp = randList[j]
        set randList[j] = randList[k]
        set randList[k] = temp
        set j = j + 1
    endloop
    if touKanCounter[i] == 1 then
        set touKanIds[1] = denomFirst[randList[1]]
        set touKanIds[2] = denomFirst[randList[2]]
        set touKanIds[3] = denomFirst[randList[3]]
        set touKanIds[4] = denomFirst[randList[4]]
        set touKanIds[5] = denomFirst[randList[5]]
    endif
    if touKanCounter[i] == 3 then
        set touKanIds[1] = denomSecond[randList[1]]
        set touKanIds[2] = denomSecond[randList[2]]
        set touKanIds[3] = denomSecond[randList[3]]
        set touKanIds[4] = denomSecond[randList[4]]
        set touKanIds[5] = denomSecond[randList[5]]
    endif
    if touKanCounter[i] == 2 then
        set touKanIds[1] = denomThird[randList[1]]
        set touKanIds[2] = denomThird[randList[2]]
        set touKanIds[3] = denomThird[randList[3]]
        set touKanIds[4] = denomThird[randList[4]]
        set touKanIds[5] = denomThird[randList[5]]
    endif
    if touKanCounter[i] == 4 then
        if GetRandomInt(1, 2) == 1 then
            set touKanIds[1] = denomFourth[randList[1]]
            set touKanIds[2] = denomFourth[randList[2]]
            set touKanIds[3] = denomFourth[randList[3]]
            set touKanIds[4] = denomFourth[randList[4]]
            set touKanIds[5] = denomFourth[randList[5]]
        else
            set touKanIds[1] = denomFifth[randList[1]]
            set touKanIds[2] = denomFifth[randList[2]]
            set touKanIds[3] = denomFifth[randList[3]]
            set touKanIds[4] = denomFifth[randList[4]]
            set touKanIds[5] = denomFifth[randList[5]]
        endif
    endif
    if touKanCounter[i] >= 5 then
        set touKanIds[1] = denomFirst[randList[1]]
        set touKanIds[2] = denomSecond[randList[2]]
        set touKanIds[3] = denomThird[randList[3]]
        set touKanIds[4] = denomFourth[randList[4]]
        set touKanIds[5] = denomFifth[randList[5]]
        set touKanIds[6] = LoadInteger(YDHT, StringHash("武学") + GetRandomInt(1, MAX_WU_GONG_NUM), 2)
    endif

    call DialogSetMessage(ruyangDialog[i], "|CFF00FFFF请选择要偷学的武功!")
    set k = 1
    set j = 1
    loop
        exitwhen k > 6
        if touKanIds[k] != 1095067243 and touKanIds[k] != 0 then
            call SaveButtonHandle(YDHT, ruyangButtonKey + i, j, DialogAddButtonBJ(ruyangDialog[i], GetObjectName(touKanIds[k])))
            call SaveInteger(YDHT, ruyangButtonKey + i, j, touKanIds[k])
            set j = j + 1
        endif
        set k = k + 1
    endloop
    call DialogDisplay(GetOwningPlayer(u), ruyangDialog[i], true)
    // 20秒后自动关闭对话框
    set t = CreateTimer()
    call SaveInteger(YDHT, GetHandleId(t), 0, i)
    call TimerStart(t, 20, false, function closeTouKanDialog)
    set t = null
endfunction
function touKanAction takes nothing returns nothing
    local player p = GetTriggerPlayer()
    local integer i = 1 + GetPlayerId(p)
    local integer k = 1
    local integer j = 1
    local integer id = 0
    local integer level = 1
    local integer l__kk = 1
    loop
        exitwhen k > 6
        if GetClickedButton() == LoadButtonHandle(YDHT, ruyangButtonKey + i, k) then
            set id = LoadInteger(YDHT, ruyangButtonKey + i, k)
            if GetUnitAbilityLevel(udg_hero[i], id) > 0 then
                call DisplayTextToPlayer(p, 0, 0, "|CFFFF0033你已经拥有此武功了")
                call FlushChildHashtable(YDHT, ruyangButtonKey + i)
                call DialogClear(ruyangDialog[i])
                return
            endif
            if GetUnitAbilityLevel(udg_hero[i], QIAN_KUN) > 0 then
                set level = level + 1
            endif
            if Deputy_isMaster(i, YA_HUAN) then 
                set level = level + 1
            endif
            if GetUnitAbilityLevel(udg_hero[i], LONG_XIANG) > 0 then
                set level = level + 1
            endif
            if GetUnitAbilityLevel(udg_hero[i], ZI_CHUANG_WU_XUE) > 0 then
                set level = level + 2
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
            call FlushChildHashtable(YDHT, ruyangButtonKey + i)
            call DialogClear(ruyangDialog[i])
            return
        endif
        set k = k + 1
    endloop
    set p = null
endfunction
//---------------------------------------------------
// 汝阳毕业技能一 玄冥神掌
// 效果：攻击时造成伤害并几率使敌人深度中毒
// + 九阴真经·内功 每杀100个敌人加1点特攻
// + 乾坤大挪移 几率使敌人虚弱
// + 九阳神功 该武功失去效果
// + 七伤拳 伤害+100%
// + 龙象般若功 伤害+150%
// 特攻：伤害范围
//---------------------------------------------------
function xuanMingAction takes unit u, unit enumUnit returns nothing
    local real coefficient = 1
    local real damage = 0
    if GetUnitAbilityLevel(u, QI_SHANG_QUAN) > 0 then
        set coefficient = coefficient + 1
    endif
    if GetUnitAbilityLevel(u, LONG_XIANG) > 0 then
        set coefficient = coefficient + 1.5
    endif
    if UnitHasDenomWeapon(u , 'I00B') then
        set coefficient = coefficient * 8
    endif
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Demon\\DarkPortal\\DarkPortalTarget.mdl", u, "overhead"))
    if GetRandomInt(1, 5) <= 2 then
        // 几率深度中毒
        call WanBuff(u , enumUnit , 14)
    endif
    if GetUnitAbilityLevel(u, QIAN_KUN) > 0 then
        // 几率使敌人虚弱
        call WanBuff(u , enumUnit , 16)
    endif
    set damage = ShangHaiGongShi(u , enumUnit , 100 , 120 , coefficient , XUAN_MING_SHEN_ZHANG)
    call WuGongShangHai(u , enumUnit , damage)
endfunction
function xuanMingShenZhang takes unit u returns nothing
    local player p = GetOwningPlayer(u)
    local integer i = 1 + GetPlayerId(p)
    local real range = 0
    local group g = null
    local real x = GetUnitX(u)
    local real y = GetUnitY(u)
    local unit enumUnit = null
    if GetRandomReal(0, 100) <= 15 + fuyuan[i] * 0.2 + wuxing[i] * 0.1 then
        call WuGongShengChong(u , XUAN_MING_SHEN_ZHANG , 360.0)
        set range = 400 + special_attack[i] * 10
        set g = CreateGroup()
        call GroupEnumUnitsInRange(g, x, y, range, null)
        loop
            set enumUnit = FirstOfGroup(g)
            exitwhen enumUnit == null
            if IsUnitEnemy(enumUnit, p) and IsUnitAliveBJ(enumUnit) then
                call xuanMingAction(u , enumUnit)
            endif
            call GroupRemoveUnit(g, enumUnit)
        endloop
        call DestroyGroup(g)
    endif
    set enumUnit = null
    set g = null
    set p = null
endfunction
// 玄冥神掌杀100个敌人加1点特殊攻击力
function xuanMingAddSpecialAttack takes unit u returns nothing
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    set xuanMingCounter[i] = xuanMingCounter[i] + 1
    if xuanMingCounter[i] >= 100 then
        set xuanMingCounter[i] = 0
        set special_attack[i] = special_attack[i] + 1
        call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|CFFFF0033你的特殊攻击力提升了")
    endif
endfunction
//----------------------------------------------------
//- 汝阳毕业技能二 嫁衣神功
//- 效果1：主动使用时，提升攻击速度和闪避率，持续(技能等级*2)秒
//- 效果2：遗忘武功时，增加三围
//- 效果3：有武功到达9重时，增加悟性和伤害倍数
//- 等级 增加值
//- “郡主”称号 增加值翻倍
//- “绍敏郡主”称号 增加值翻倍
//----------------------------------------------------
function jiaYiShenGongRemoveAbilities takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
    call UnitRemoveAbility(u, 1093682242)
    call UnitRemoveAbility(u, 1093682242)
    call FlushChildHashtable(YDHT, GetHandleId(t))
    call PauseTimer(t)
    call DestroyTimer(t)
    set u = null
    set t = null
endfunction
function jiaYiShenGong takes unit u returns nothing
    local real time = GetUnitAbilityLevel(u, JIA_YI_SHEN_GONG) * 2
    local timer t = CreateTimer()
    call UnitAddAbility(u, 1093682242)
    call SetUnitAbilityLevel(u, 1093682242, GetUnitAbilityLevel(u, JIA_YI_SHEN_GONG))
    call UnitAddAbility(u, 1098084450)
    call SetPlayerAbilityAvailableBJ(false, 1098084450, GetOwningPlayer(u))
    call SetUnitAbilityLevel(u, 1093682244, GetUnitAbilityLevel(u, JIA_YI_SHEN_GONG))
    call WuGongShengChong(u , JIA_YI_SHEN_GONG , 150)
    call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
    call TimerStart(t, time, false, function jiaYiShenGongRemoveAbilities)
    set t = null
endfunction
function initRuYang takes nothing returns nothing
    local integer i = 1
    local trigger t = CreateTrigger()
    loop
        exitwhen i > 5
        set touKanCounter[i] = 0
        set touKanIds[i] = 0
        set xuanMingCounter[i] = 0
        set ruyangDialog[i] = DialogCreate()
        set i = i + 1
    endloop
    set i = 1
    loop
        exitwhen i > 5
        call TriggerRegisterDialogEvent(t, ruyangDialog[i])
        set i = i + 1
    endloop
    call TriggerAddAction(t, function touKanAction)
    set t = null
endfunction