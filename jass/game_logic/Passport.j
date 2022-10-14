// 通行证系统
globals
    // S1通行证经验
    integer array passportExpS1
    // S1通行证等级
    integer array passportLevelS1
    // S1通行证1-10级开关（二进制）
    integer array passportSwitchS1

    // 决战币
    integer array passportCoin

    // 蜜蜂皮肤
    integer array beeSkinFlag
    // 1号翅膀
    integer array wing1Flag
    // 2号翅膀
    integer array wing2Flag
    // 3号翅膀
    integer array wing3Flag
    // 魁岚皮肤-宠物
    integer array kuiLanSkinFlag
    // 空瑶皮肤-英雄
    integer array kongYaoSkinFlag
    // 启萧皮肤-英雄
    integer array qiXiaoSkinFlag



    constant string PASSPORT_EXP_S1 = "passportExpS1"
    constant string COIN = "coin"
    constant string PASSPORT_SWITCH_S1 = "passportSwitchS1"
endglobals

// 判断是否领取了某一等级的奖励
function isRewardS1 takes integer passportSwitch, integer level returns boolean
    return YDWEBitwise_AND(passportSwitch, YDWEBitwise_LShift(1, level - 1)) != 0
endfunction

// 设置领取了某一等级的奖励
function setRewardS1 takes integer level, integer i returns nothing
    set passportSwitchS1[i] = YDWEBitwise_OR(passportSwitchS1[i], YDWEBitwise_LShift(1, level - 1))
    call DzAPI_Map_StoreString(Player(i - 1),PASSPORT_SWITCH_S1,  newEncryptInt(passportSwitchS1[i]))
endfunction

// 增加通行证经验
function addPassportExpS1 takes integer i, integer exp returns nothing
    set passportExpS1[i] = passportExpS1[i] + exp
    // 1000为满经验
    if passportExpS1[i] > 800 then
        set passportExpS1[i] = 800
    endif
    call DzAPI_Map_StoreString(Player(i - 1), PASSPORT_EXP_S1, newEncryptInt(passportExpS1[i]))
endfunction

// 设置决战币
function setCoin takes integer coin, integer i returns nothing
    set passportCoin[i] = coin
    call DzAPI_Map_StoreString(Player(i - 1), COIN, newEncryptInt(passportCoin[i]))
endfunction

// 领取S1通行证奖励
function rewardS1 takes integer level, integer i returns nothing
    // 普通 
    // 一级 十个决战币
    // 二级 宠物皮肤蜜蜂 金币获得率加10%
    // 三级 十个决战币
    // 四级 翅膀 暴击率+2%
    // 五级 十个决战币
    // 六级 十个决战币
    // 七级 十个决战币
    // 八级 英雄皮肤 初始攻击速度+10%
    if level == 1 or level == 3 or level == 5 or level == 6 or level == 7 then
        call setCoin(passportCoin[i] + 10, i)
    endif


    // 精英
    // 一级 宠物皮肤魁岚
    // 二级 十个决战币
    // 三级 十个决战币
    // 四级 十个决战币
    // 五级 翅膀 六围+1
    // 六级 十个决战币
    // 七级 十个决战币
    // 八级 英雄皮肤 初始攻击范围+300
    if DzAPI_Map_HasMallItem(Player(i - 1), PROPERTY_PASSPORT_S1) or udg_isTest[i - 1] then
        if level == 2 or level == 3 or level == 4 or level == 6 or level == 7 then
            call setCoin(passportCoin[i] + 10, i)
        endif
    endif

endfunction

function rewardS1Permanent takes integer level, integer i returns nothing
    if level == 2 then
        set beeSkinFlag[i] = 1
    elseif level == 4 then
        set wing1Flag[i] = 1
    elseif level == 8 then
        set kongYaoSkinFlag[i] = 1
    endif

    if DzAPI_Map_HasMallItem(Player(i - 1), PROPERTY_PASSPORT_S1) or udg_isTest[i - 1] then
        if level == 1 then
            set kuiLanSkinFlag[i] = 1
        elseif level == 5 then
            set wing2Flag[i] = 1
        elseif level == 8 then
            set qiXiaoSkinFlag[i] = 1
        endif
    endif
endfunction

// 设置六进制数的第n位
function setSixNum takes integer num, integer n, integer value returns integer
    // 先获取原来的值
    local integer i = 1
    local integer j = 0
    local integer k = 1
    local integer numCopy = num

    loop
        exitwhen i > n
        set j = ModuloInteger(numCopy, 6)
        set numCopy = numCopy / 6
        set k = k * 6
        set i = i + 1
    endloop
    set k = k / 6

    // 再设置新的值
    return num - j * k + value * k

endfunction


// 天赋树加点
function addPointInTalentTree takes integer i, integer treeNum, integer level returns nothing
    local integer talentPoint = MAX_INT / 2 - DzAPI_Map_GetStoredInteger(Player(i - 1), TALENT_SAVE)
    local integer newSave = 0
    // 左侧 攻击天赋 三围->暴击->特攻
    // 特攻 2 4 6 8 10
    // 暴击倍数 0.1 0.2 0.3 0.4 0.5
    // 三围 20 50 100 200 300
    // 
    // 中间 防御天赋 护甲->回血->伤害吸收上限
    // 护甲 5 10 15 20 30
    // 伤害吸收上限 2 4 6 8 10
    // 回血 0.5% 1% 1.5% 2% 2.5%
    // 
    // 右侧 资源天赋 金币->声望->木材/六围
    // 金币获得率 20 40 60 80 100
    // 珍惜币获得率 20 40 60 80 100
    // 六围 悟性2 根骨2 经脉2 胆魄2 医术2
    // 声望获得率 10 20 30 40 50
    if passportCoin[i] < 5 then
        call DisplayTextToPlayer(Player(i - 1), 0, 0, "|CFFFF0000决战币不足|r")
        return
    endif
    if talentPoint == MAX_INT / 2 then
        set talentPoint = 0
    endif

    if treeNum == 1 then
        if level == 1 then
            set talent_three_attribute[i] = talent_three_attribute[i] + 1
            set newSave = setSixNum(talentPoint, 1, talent_three_attribute[i])
        elseif level == 2 then
            set talent_critical_attack[i] = talent_critical_attack[i] + 1
            set newSave = setSixNum(talentPoint, 2, talent_critical_attack[i])
        elseif level == 3 then
            set talent_special_attack[i] = talent_special_attack[i] + 1
            set newSave = setSixNum(talentPoint, 3, talent_special_attack[i])
        endif
    elseif treeNum == 2 then
        if level == 1 then
            set talent_armor[i] = talent_armor[i] + 1
            set newSave = setSixNum(talentPoint, 4, talent_armor[i])
        elseif level == 2 then
            set talent_recover_hp[i] = talent_recover_hp[i] + 1
            set newSave = setSixNum(talentPoint, 5, talent_recover_hp[i])
        elseif level == 3 then
            set talent_damage_absorption[i] = talent_damage_absorption[i] + 1
            set newSave = setSixNum(talentPoint, 6, talent_damage_absorption[i])
        endif
    elseif treeNum == 3 then
        if level == 1 then
            set talent_gold[i] = talent_gold[i] + 1
            set newSave = setSixNum(talentPoint, 7, talent_gold[i])
        elseif level == 2 then
            set talent_reputation[i] = talent_reputation[i] + 1
            set newSave = setSixNum(talentPoint, 8, talent_reputation[i])
        elseif level == 3 then
            set talent_lumber[i] = talent_lumber[i] + 1
            set newSave = setSixNum(talentPoint, 9, talent_lumber[i])
        elseif level == 4 then
            set talent_six_attribute[i] = talent_six_attribute[i] + 1
            set newSave = setSixNum(talentPoint, 10, talent_six_attribute[i])
        endif
    endif
    // 决战币减少5
    call setCoin(passportCoin[i] - 5, i)
    call DzAPI_Map_StoreInteger(Player(i - 1), TALENT_SAVE, MAX_INT / 2 - newSave)

endfunction

function killGreenDragon takes nothing returns nothing
    local integer i = 1
    local integer point = 0
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "有玩家击碎了|cffffcc00青龙石|r，所有玩家获得通行证积分（每天上限100分，到达上限后不再获得）")
    // if udg_nandu >= 8 then
    //     set point = 50
    // elseif udg_nandu >= 6 then
    //     set point = 40
    // elseif udg_nandu >= 2 then
    //     set point = 30
    // else
    //     set point = 20
    // endif
    set point = 100
    loop
        exitwhen i > 5
        call addPassportExpS1(i, point)
        set i = i + 1
    endloop

endfunction

// 刷青龙
function spawnGreenDragon takes nothing returns nothing
    call CreateUnit(Player(PLAYER_NEUTRAL_AGGRESSIVE), 'n019', 2200, - 14000, bj_UNIT_FACING)
    call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFF00FF00青龙石出现在了地图上")
    call PingMinimapForForce(bj_FORCE_ALL_PLAYERS, 2200, - 14000, 5)
    call DestroyTimer(GetExpiredTimer())
endfunction

// 初始化S1通行证
function initS1Passport takes nothing returns nothing
    local integer i = 1
    local integer j = 1
    local timer t = CreateTimer()
    loop
        exitwhen i > 5
        if GetPlayerController(Player(i - 1)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(i - 1)) == PLAYER_SLOT_STATE_PLAYING then
            set passportExpS1[i] = newDecryptInt(DzAPI_Map_GetStoredString(Player(i - 1), PASSPORT_EXP_S1))
            set passportLevelS1[i] = passportExpS1[i] / 100
            set passportSwitchS1[i] = newDecryptInt(DzAPI_Map_GetStoredString(Player(i - 1), PASSPORT_SWITCH_S1))
            set passportCoin[i] = newDecryptInt(DzAPI_Map_GetStoredString(Player(i - 1), COIN))

            if ModuloInteger(passportCoin[i], 5) != 0 then
                set passportCoin[i] = 0
            endif

            // 领取通行证奖励
            set j = 1
            loop
                exitwhen j > 8
                // call BJDebugMsg("i: " + I2S(i) + " j: " + I2S(j))
                if not isRewardS1(passportSwitchS1[i], j) and passportLevelS1[i] >= j then
                    // 领取一次性奖励
                    call rewardS1(j, i)
                    call setRewardS1(j, i)
                endif
                if passportLevelS1[i] >= j then
                    // 领取永久奖励
                    call rewardS1Permanent(j, i)
                endif
                set j = j + 1
            endloop
        endif
        set i = i + 1
    endloop
    call TimerStart(t, 1800, false, function spawnGreenDragon)
    set t = null
endfunction


// 初始化通行证系统
function initPassport takes nothing returns nothing
    call initS1Passport()
endfunction


