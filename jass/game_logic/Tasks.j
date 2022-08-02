//--------------------------
//游戏中的任务
//--------------------------

//店小二新手任务
function IJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 'I025'))
endfunction
function lJ takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = null
	if((O7[i] == 0))then
		if((GetRandomInt(1, 100) <= 35))then
			set loc = GetRectCenter(Pe)
			set O7[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC我这有一壶上等女儿红专程送给襄阳城郭靖的，你能帮我跑一趟吗|r\n|cFFFFCC00提示：|r |cFF99FFCC前往正派武林主城的|cFFADFF2F郭靖|r\n")
			call PingMinimapLocForForce(ov(p), loc, 5.)
			call RemoveLocation(loc)
		elseif((GetRandomInt(1, 70) <= 35))then
			set loc = GetRectCenter(Qe)
			set O7[i] = 2
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC旁边树林里的野狼经常来袭击村民，你能帮助我们吗|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F6只野狼|r\n")
			call PingMinimapLocForForce(ov(p), loc, 5.)
			call RemoveLocation(loc)
		else
			set O7[i] = 3
			set loc = GetRectCenter(Re)
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC听说少林寺的练功房升级特别快，为何不去看看呢|r\n|cFFFFCC00提示：|r |cFF99FFCC前往少林寺的|cFFADFF2F练功房|r，可以通过主城传送\n")
			call PingMinimapLocForForce(ov(p), loc, 5.)
			call RemoveLocation(loc)
		endif
	elseif((O7[i] == 1))then
		set loc = GetRectCenter(Pe)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC你怎么还不出发啊？|r\n|cFFFFCC00提示：|r |cFF99FFCC前往正派武林主城的|cFFADFF2F郭靖|r\n")
		call PingMinimapLocForForce(ov(p), loc, 5.)
		call RemoveLocation(loc)
	elseif((O7[i] == 2))then
		set loc = GetRectCenter(Qe)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC请帮助我们杀死野狼吧|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F6只野狼|r\n")
		call PingMinimapLocForForce(ov(p), loc, 5.)
		call RemoveLocation(loc)
	elseif((O7[i] == 3))then
		set loc = GetRectCenter(Re)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC听说少林寺的练功房升级特别快，为何不去看看呢|r\n|cFFFFCC00提示：|r |cFF99FFCC前往少林寺的|cFFADFF2F练功房|r，可以通过主城传送")
		call PingMinimapLocForForce(ov(p), loc, 5.)
		call RemoveLocation(loc)
	elseif((O7[i] == 4))then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC你已经完成新手任务了")
	endif
	set u = null
	set p = null
	set loc = null
endfunction
//郭靖——环戒
function KJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(O7[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 1))
endfunction
function LJ takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if GetRandomInt(1, 100) <= 60 then
		call unitadditembyidswapped('I024', GetTriggerUnit())
	else
		call unitadditembyidswapped('I0CH', GetTriggerUnit())
	endif
	call AddHeroXP(u, 100, true)
	set shengwang[i] = shengwang[i] + $A
	call PlaySoundOnUnitBJ(Hh, 100, u)
	call DisplayTextToPlayer(p, 0, 0, ("|CFF34FF00完成任务获得经验+100、江湖声望+10和" + GetItemName(bj_lastCreatedItem)))
	set O7[i] = 4
	set u = null
	set p = null
endfunction
// 狼皮任务

//杀狼任务——青铜刀
function TI takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 'nwlt')) // 狼死触发
endfunction
function UI takes nothing returns nothing
	local unit u = GetKillingUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if((O7[i] == 2))then
		set P7[i] = (P7[i] + 1)
		if((P7[i] >= 6))then
			set P7[i] = 0
			set O7[i] = 4
			if GetRandomInt(1, 100) <= 60 then
				call unitadditembyidswapped('I020', GetTriggerUnit())
			else
				call unitadditembyidswapped('I0CI', GetTriggerUnit())
			endif
			call AddHeroXP(GetKillingUnit(), 100, true)
			set shengwang[i] = shengwang[i] + 50
			call PlaySoundOnUnitBJ(Hh, 100, GetKillingUnit())
			call DisplayTextToPlayer(p, 0, 0, ("|CFF34FF00完成任务获得经验+100、江湖声望+50和" + GetItemName(bj_lastCreatedItem)))
		else
			call DisplayTextToPlayer(p, 0, 0, ("野狼：" + (I2S(P7[i]) + " / 6")))
		endif
	endif
	set wolfSkinCount[i] = (wolfSkinCount[i] + 1)
	call DisplayTextToPlayer(p, 0, 0, ("狼皮数量：" + (I2S(wolfSkinCount[i]) + " /10")))
	set u = null
	set p = null
endfunction
// 完成狼皮任务，靠近店小二提交任务
function isFinishWolfSkin takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER))
endfunction
function finishWolfSkin takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer count = 0 // 狼皮组，10个为一组
	local integer xp = 0 // 获得经验
	local integer gold = 0 // 获得金钱
	local integer sw = 0 // 获得声望
	if wolfSkinCount[i] >= 10 then
		set count = wolfSkinCount[i] / 10 // 取整
		set xp = 1000 * count
		set gold = 2000 * count
		set sw = 50 * count
		call AddHeroXP(u, xp, true) // 奖励经验
		call AdjustPlayerStateBJ(gold, p, PLAYER_STATE_RESOURCE_GOLD) // 奖励金钱
		set shengwang[i] = shengwang[i] + sw // 奖励声望
		call PlaySoundOnUnitBJ(Hh, 100, u)
		call DisplayTextToPlayer(p, 0, 0, ("|CFF34FF00完成任务获得经验+" + I2S(xp) + "、金钱" + I2S(gold) + "、江湖声望" + I2S(sw)))
		set wolfSkinCount[i] = wolfSkinCount[i] - count * 10
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00店小二：|r |cFF99FFCC即将入冬，请大侠帮忙收集一些狼皮|r\n|cFFFFCC00提示：|r |cFF99FFCC可以杀多点一次性交任务|r\n")
	endif
	set u = null
	set p = null
endfunction
//少林练功房——养精蓄锐令/乔峰草鞋
function NJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(O7[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 3))
endfunction
function OJ takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if GetRandomInt(1, 100) <= 60 then
		call unitadditembyidswapped('I06H', GetTriggerUnit())
	else
		call unitadditembyidswapped('I0DO', GetTriggerUnit())
	endif
	call AddHeroXP(u, 100, true)
	set shengwang[i] = shengwang[i] + $A
	call PlaySoundOnUnitBJ(Hh, 100, u)
	call DisplayTextToPlayer(p, 0, 0, ("|CFF34FF00完成任务获得经验+100、江湖声望+10和" + GetItemName(bj_lastCreatedItem)))
	set O7[i] = 4
	set u = null
	set p = null
endfunction
//寻找物品
globals
	integer array xunwu
	integer array yangshou
	integer array udg_yangshou
endglobals
function IsWuPin takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0BB'
endfunction
function LookForWuPin takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer id = LoadInteger(YDHT, GetHandleId(p), StringHash("item"))
	local string s
	if (xunwu[i] == 0)then
		if xiuxing[i] <= 2 then
			if GetRandomInt(1, 2) == 1 then
				// 6烈火衣去掉
				set id = ZhuangBei[GetRandomInt(1, 5)]
			else
				// 12是霓云去掉，有点坑
				if GetRandomInt(1, 18) < 12 then
					set id = ShiPin[GetRandomInt(1, 11)]
				else
					set id = ShiPin[GetRandomInt(13, 18)]
				endif
				
			endif
		elseif xiuxing[i] <= 4 then
			if GetRandomInt(1, 2) == 1 then
				set id = ZhuangBei[GetRandomInt(7, 9)]
			else
				set id = ShiPin[GetRandomInt(9, 33)]
			endif
		else
			if GetRandomInt(1, 3) == 1 then
				set id = ZhuangBei[GetRandomInt(10, 14)]
			else
				set id = ShiPin[GetRandomInt(34, 44)]
			endif
		endif
		set xunwu[i] = 1
		call SaveInteger(YDHT, GetHandleId(p), StringHash("item"), id)
		set s = GetObjectName(id)
		call PlaySoundOnUnitBJ(bh, 100, u)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC我需要" + s + "，你能帮我找来么|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助游骐寻找|cFFADFF2F" + s + "|r\n")
	else
		set s = GetObjectName(id)
		call PlaySoundOnUnitBJ(bh, 100, u)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC帮我找到" + s + "了吗|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助游骐寻找|cFFADFF2F" + s + "|r\n")
	endif
	set u = null
	set p = null
endfunction
function IsFangQiWuPin takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0BC'
endfunction
function FangQiWuPin takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if (xunwu[i] == 0)then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC当前没有接任务哦|r\n")
	else
		set shengwang[i] = shengwang[i] - 100
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC堂堂大侠，居然找不到小女子需要的东西吗|r\n")
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00放弃任务，声望减少100|r\n")
		call PlaySoundOnUnitBJ(Gh, 100, u)
		set xunwu[i] = 0
	endif
	set u = null
	set p = null
endfunction
function IsWanChengWuPin takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0BD'
endfunction
function WanChengWuPin takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer id = LoadInteger(YDHT, GetHandleId(p), StringHash("item"))
	if xunwu[i] == 1 and UnitHaveItem(u, id) and id != 0 then
		call RemoveItem(FetchUnitItem(u, id))
		set shengwang[i] = shengwang[i] + 40 * (xiuxing[i] + 1)
		call AddHeroXP(udg_hero[i], 15 * GetHeroLevel(udg_hero[i]) * GetHeroLevel(udg_hero[i]) * (xiuxing[i] + 1), true)
		set xunwu[i] = 0
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC谢谢你的帮助|r\n")
		if GetRandomInt(1, 10) <= xiuxing[i] + 1 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00完成任务，奖励声望" + I2S(40 * (xiuxing[i] + 1)) + "点，经验" + I2S(15 * GetHeroLevel(udg_hero[i]) * GetHeroLevel(udg_hero[i]) * (xiuxing[i] + 1)) + "点|r\n")
		else
			call unitadditembyidswapped('I04T', udg_hero[i])
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00完成任务，奖励声望" + I2S(40 * (xiuxing[i] + 1)) + "点，经验" + I2S(15 * GetHeroLevel(udg_hero[i]) * GetHeroLevel(udg_hero[i]) * (xiuxing[i] + 1)) + "点，九阳丹一颗|r\n")
		endif
		if Deputy_isDeputy(i, XUN_BAO) then
			if udg_xbds[i] < 3 then
				set udg_xbds[i] = udg_xbds[i] + 1
				call DisplayTextToPlayer(p, 0, 0, "|CFF66FF00恭喜您完成了" + I2S(udg_xbds[i]) + "次寻宝任务，完成4次可获得寻宝大师哦")
			else
				if not Deputy_isMaster(i, XUN_BAO) then
					call Deputy_setMaster(i, XUN_BAO)
					// call SaveStr(YDHT, GetHandleId(p), GetHandleId(p),"〓寻宝大师〓"+LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
					call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15, "|CFF66FF00恭喜" + GetPlayerName(p) + "获得寻宝大师")
					call SetPlayerName(p, "〓寻宝大师〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
				endif
			endif
		endif
	elseif xunwu[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC还没有找到小女子需要的东西吗|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骐：|r |cFF99FFCC当前没有接任务哦|r\n")
	endif
	set u = null
	set p = null
endfunction


// 随机兑换武功秘籍
function isBuyWuGongBook takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 'I0AI' or GetItemTypeId(GetManipulatedItem()) == 'I0AH' or GetItemTypeId(GetManipulatedItem()) == 'I0AJ'))
endfunction
function buyWuGongBook takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	if GetItemTypeId(GetManipulatedItem()) == 'I0AI' then
		call DisplayTimedTextToPlayer(p, 0, 0, 15, "|CFF00FF00这本江湖秘籍送给你了")
		call unitadditembyidswapped(udg_jianghu[GetRandomInt(1, 18)], u)
	elseif GetItemTypeId(GetManipulatedItem()) == 'I0AH' then
		call DisplayTimedTextToPlayer(p, 0, 0, 15, "|CFF00FF00这本绝学秘籍送给你了")
		call unitadditembyidswapped(udg_juexue[GetRandomInt(1, 10)], u)
	elseif GetItemTypeId(GetManipulatedItem()) == 'I0AJ' then
		call DisplayTimedTextToPlayer(p, 0, 0, 15, "|CFF00FF00这本绝内秘籍送给你了")
		call unitadditembyidswapped(udg_juenei[GetRandomInt(1, 8)], u)
	endif
	set u = null
	set p = null
endfunction

// 速战速决任务，奖励加速出怪物品
function IsQuickFight takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 'I0D1'))
endfunction
function QuickFight takes nothing returns nothing
	// local location loc = GetUnitLoc(GetTriggerUnit())
	local unit u = GetTriggerUnit()
	call unitadditembyidswapped('I0D2', u)
	// call createitemloc('I0D2',loc)
	set u = null
endfunction
// 加速出怪物品使用
function IsJiaSuChuGuai takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 'I0D2'))
endfunction
function JiaSuChuGuai takes nothing returns nothing
	local location loc = GetUnitLoc(GetTriggerUnit())
	// 判断是否15波之后、是否特殊模式
	if udg_boshu > 15 and udg_boshu <= 26 and udg_teshushijian then
		set udg_sutong = true
		set udg_boshu = 26
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF0033已经跳到26波，请大家注意防守")
	else
		call createitemloc('I0D2', loc)
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF0033特殊模式下超过15波、不超过26波才能跳")
	endif
	set loc = null
endfunction

// 猪年杀猪任务
// function IsKillYang takes nothing returns boolean
// 	return(GetUnitTypeId(GetTriggerUnit())=='nshf')
// endfunction
// function KillYang takes nothing returns nothing
// 	local unit u=GetKillingUnit()
// 	local integer i=GetRandomInt(1,15)
// 	if i==6 then
// 		call unitadditembyidswapped('I0A8',udg_hero[1+GetPlayerId(GetOwningPlayer(u))])
// 		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"|cfffff000有玩家打掉了小猪，获得了珍稀物品【新年】")
// 	elseif i==4 then
// 		call unitadditembyidswapped('I0A9',udg_hero[1+GetPlayerId(GetOwningPlayer(u))])
// 		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"|cfffff000有玩家打掉了小猪，获得了珍稀物品【快乐】")
// 	else
// 		call AdjustPlayerStateBJ(88,GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
// 		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"|cfffff000有玩家打掉了小猪，获得了88个珍稀币")
// 	endif
// 	set u=null
// endfunction

// ==============等级福利商店=====================//
/**
3级养精蓄锐I06H（必得），额外琥珀项链I01X、纱绒护腕I01U
5级大雁I02T（必得），额外七星戒指I01P、蛇皮裘I01G、精钢护腕I01M
8级蓝魔I01A、梦蝶I01C、北斗I01B
10级白虎符I019(必得)、追月I00Z、云海I010、鸳鸯刀I00X、七情束I00Y
11级续命I06Z（续命）、传功I071、乾坤丹I02K、通犀I070
12级神木王鼎I0AM、天璇I01D、 七绝I01J
14级5W钱、25木、小侠印记I0E9
*/

function IsLevelReward takes nothing returns boolean
	return GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0DG' 
endfunction
function LevelReward takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = GetPlayerId(p)
	// 获取玩家对应的地图等级
	local integer level = DzAPI_Map_GetMapLevel(Player(i))

	if (level < 3 and level_award[i + 1] != 1) or map_award_status[i + 1] == 1 then
		call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|CFFFE890D可能你不符合条件或者已经领取过了哦！")
		return
	endif

	set map_award_status[i + 1] = 1 
	if (level >= 3 or level_award[i + 1] == 1)  then
		call unitadditembyidswapped(mapLevelReward[1] , u) // 养精蓄锐令牌
	endif
	if (level >= 5 or level_award[i + 1] == 1) then
		call unitadditembyidswapped('I02T' , u) // 大雁
	endif
	if (level >= 8 or level_award[i + 1] == 1) then
		call unitadditembyidswapped(mapLevelReward[GetRandomInt(8, 10)] , u) 
	endif
	if  (level >= 10 or level_award[i + 1] == 1)  then
		call unitadditembyidswapped('I019' , u) // 白虎符
	endif
	if (level >= 11 or level_award[i + 1] == 1) then
		call unitadditembyidswapped('I06Z' , u) // 续命
	endif
	if  (level >= 14 or level_award[i + 1] == 1) then
		if GetRandomInt(1, 2) == 1 then
			call AdjustPlayerStateBJ(50000, p, PLAYER_STATE_RESOURCE_GOLD) // 奖励5w金钱
		else
			call AdjustPlayerStateBJ(25, p, PLAYER_STATE_RESOURCE_LUMBER) // 奖励25木头
		endif
	endif
	if  (level >= 25 or level_award[i + 1] == 1) then
		call unitadditembyidswapped('I070' , u) // 通犀地龙丸
	endif

	set u = null
	set p = null
endfunction

// 扣除积分并存档方法
function jfChange takes integer i, integer jf returns nothing 
	// 累加本局可用积分
	set jf_useMax[i] = jf_useMax[i] + jf
	// 扣除对应的积分
	set udg_jf[i] = udg_jf[i] - jf
	// 保存到服务器
	call DzAPI_Map_StoreInteger(Player(i), "jf", udg_jf[i])
endfunction

globals
	integer array bigTalent
endglobals

//============积分商店=============//
// 随机一个AB性格加一:5积分；明教一局：20积分；精钢剑：4积分；随机一本奇武：4积分；桃花岛传送符（永久版）：4积分；重置门派称号：14积分；号令天下：10积分
function isJfShop takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and (GetItemTypeId(GetManipulatedItem()) == 'I0DC' or GetItemTypeId(GetManipulatedItem()) == 'I0DD' or GetItemTypeId(GetManipulatedItem()) == 'I0DE' or GetItemTypeId(GetManipulatedItem()) == 'I0DF' or GetItemTypeId(GetManipulatedItem()) == 'I0DH' or GetItemTypeId(GetManipulatedItem()) == 'I0EL'))
endfunction
function jfShop takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = GetPlayerId(p)
	// 精钢剑4积分、随机性格5积分、随机奇武4积分、桃花岛传送4积分、重置门派称号14积分、号令天下10积分、加强天赋15积分
	local integer jf1 = 4
	local integer jf2 = 5
	local integer jf3 = 4
	local integer jf4 = 4
	local integer jf5 = 14
	local integer jf6 = 10
	local integer jf7 = 15
	
	if ((GetItemTypeId(GetManipulatedItem()) == 'I0DC')) and udg_jf[i] >= jf1 and (jf_useMax[i] + jf1) <= jf_max then
		call unitadditembyidswapped('I01L', u) // 创建精钢剑给玩家
		call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00获取精钢剑，扣除4积分")
		call jfChange(i, jf1)
	elseif ((GetItemTypeId(GetManipulatedItem()) == 'I0EL')) and udg_jf[i] >= jf7 and (jf_useMax[i] + jf7) <= jf_max then
		if bigTalent[i + 1] != 1 and talent_flag[i + 1] == 1 then
			set bigTalent[i + 1] = 1
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00激活加强天赋系统")
			call jfChange(i, jf7)
		else
			if talent_flag[i + 1] != 1 then
				call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00激活失败，尚未解锁天赋系统")
			else
				call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00已经激活，不能重复激活")
			endif
		endif
	elseif ((GetItemTypeId(GetManipulatedItem()) == 'I0DD')) and udg_jf[i] >= jf2 and (jf_useMax[i] + jf2) <= jf_max then
		if udg_xinggeA[i + 1] == 5 and udg_xinggeB[i + 1] == 5 then
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00AB性格已经满级，不扣除积分")
		else
			// 随机一个AB性格加1
			if GetRandomInt(1, 2) == 1 then
				if udg_xinggeA[i + 1] < 5 then
					set udg_xinggeA[i + 1] = udg_xinggeA[i + 1] + 1
					call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00A性格+1，扣除5积分")
				else
					if udg_xinggeB[i + 1] < 5 then
						set udg_xinggeB[i + 1] = udg_xinggeB[i + 1] + 1
						call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00B性格+1，扣除5积分")
					endif
				endif
			else
				if udg_xinggeB[i + 1] < 5 then
					set udg_xinggeB[i + 1] = udg_xinggeB[i + 1] + 1
					call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00B性格+1，扣除5积分")
				else
					if udg_xinggeA[i + 1] < 5 then
						set udg_xinggeA[i + 1] = udg_xinggeA[i + 1] + 1
						call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00A性格+1，扣除5积分")
					endif
				endif
			endif
			// 重置英雄性格buff
			call AddCharacterABuff(udg_hero[i + 1], udg_xinggeA[i + 1])
			call AddCharacterBBuff(udg_hero[i + 1], udg_xinggeB[i + 1])
			// 积分变更
			call jfChange(i, jf2)
		endif
	elseif ((GetItemTypeId(GetManipulatedItem()) == 'I0DE')) and udg_jf[i] >= jf3 and (jf_useMax[i] + jf3) <= jf_max then
		if not udg_fpgz then
			if jfQiWu[i] >= jfQiWuLimit[i] then
				call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|CFFFE890D一局游戏只能兑换3本奇武，单通11个门派额外兑换1本！")
			else
				// 随机一本奇武，去掉珍珑棋局49
				if GetRandomInt(42, 56) < 49 then
					call unitadditembyidswapped(LoadInteger(YDHT, StringHash("武学") + GetRandomInt(42, 48), 1), u)
				else
					call unitadditembyidswapped(LoadInteger(YDHT, StringHash("武学") + GetRandomInt(50, 56), 1), u)
				endif
				call jfChange(i, jf3)
				call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00B随机获取一本奇武，扣除4积分")
			endif
			set jfQiWu[i] = jfQiWu[i] + 1
		else
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00返璞归真模式下无法兑换奇武")
		endif
	elseif ((GetItemTypeId(GetManipulatedItem()) == 'I0DF')) and udg_jf[i] >= jf4 and (jf_useMax[i] + jf4) <= jf_max then
		// 桃花岛传送符，不限次数
		call unitadditembyidswapped('I0DI', u) 
		call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00获取桃花岛传送符，扣除4积分")
		call jfChange(i, jf4)
	elseif ((GetItemTypeId(GetManipulatedItem()) == 'I0DH')) and udg_jf[i] >= jf6 and (jf_useMax[i] + jf6) <= jf_max then
		// 号令
		// call unitadditembyidswapped('I06F',u) 
		if GetUnitLevel(udg_hero[i + 1]) <= 2 then
			call randomMenpai(p, 2)
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00重选随机门派，扣除10积分")
			call jfChange(i, jf6)
		else
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC003级以下才能重新随机门派")
		endif
		
	else
		call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|CFFFE890D不好意思你的积分不够了哦，或者已经或者已经达到本局使用上限50！")
	endif
	
	set u = null
	set p = null
endfunction
/**	
* 积分兑换永久奖励
*/
function isJfShop2 takes nothing returns boolean
	return((GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and (GetItemTypeId(GetManipulatedItem()) == 'I0EG' ))
endfunction
function jfShop2 takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = GetPlayerId(p)
	local integer jf7 = 200 // 200积分永久加10%武功加成和爆伤，上限30%
	call BJDebugMsg("兑换奖励：" + R2S(bonus_wugong[i]))
	/**
	*	永久奖励
	*/
	if ((GetItemTypeId(GetManipulatedItem()) == 'I0EG')) and udg_jf[i] >= jf7 then
		if bonus_wugong[i] >= 0.3 then
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00伤害兑换已达上限")
		else
			// 每次购买加10%武功加成和10%爆伤
			set bonus_wugong[i] = bonus_wugong[i] + .1
			set bonus_baoshang[i] = bonus_baoshang[i] + .1
			// 加上购买伤害，这里只记录当局兑换的永久加成，初始化记录存档的加成
			set udg_shanghaijiacheng[i + 1] = udg_shanghaijiacheng[i + 1] + .1
			set udg_baojishanghai[i + 1] = udg_baojishanghai[i + 1] + .1
			// 伤害加成存档
			call DzAPI_Map_StoreReal(Player(i), "wugong", bonus_wugong[i])
			call DzAPI_Map_StoreReal(Player(i), "baoshang", bonus_baoshang[i])
			call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00武功伤害加10%，暴击伤害加10%")
			// 扣除对应的积分
			set udg_jf[i] = udg_jf[i] - jf7
			// 保存到服务器
			call DzAPI_Map_StoreInteger(Player(i), "jf", udg_jf[i])
		endif
	else
		call DisplayTimedTextToPlayer(Player(i), 0, 0, 5, "|cFF66CC00积分不足")
	endif
	set u = null
	set p = null
endfunction

/**
* 门派专属任务
1.灵鹫：玉扳指I0DT，天山童姥10 %爆，八荒加属性概率增加
2.武当：真武剑I0DK，挑战场跳转张三丰, 太极拳主动使用永久加1绝学领悟，被动使用概率加绝学领悟
3.全真：七星道袍I0DP，90级找丘处机接任务，加金雁攻速，三花聚顶弹射次数+ 50
4.恒山：拂尘I0DU，教训田伯光，加2级拂尘范围（300, 400, 500, 600共4级范围）
5.衡山：镇岳尚方I0DY，令狐冲接任务，江南水乡解决费彬，剑加青龙光环
6.泰山：东灵铁剑I0E2，令狐冲接任务，雁门关解决玉玑子，永久触发泰山十八盘
7.慕容：燕国玉玺I0DS，慕容复发布任务，慕容龙城称号和等级超过100级可以获取专属，袖中指加属性概率增加
8.华山：养吾剑I0EO，令狐冲处接任务挑战令狐冲（副本6令狐冲移除瞬杀技能的强度），剑附带破防效果（防御减400）
9.神龙：毒龙鞭I0DZ，副本1韦小宝（神龙教）触发任务杀死洪安通，接任务后洪安通出现在桃花岛上
10.明教：屠龙刀I00D，副本6
*/

globals
	integer array yitianflag // 倚天任务是否进行中，1-进行中，2-完成任务
	integer array quanZhenFlag // 是否已完成全真专属任务，1：进行中；2：已完成
	integer array muRongOnlyFlag // 是否已完成慕容专属任务，0：未完成；1：已完成
	integer array hengShanOnlyFlag // 是否已完成恒山专属任务，0：未完成；1：已接受任务，2：完成
	integer array huaShanOnlyFlag // 是否已完成华山专属任务，0：未完成；1：进行中；2：已完成
	integer array hengshan2OnlyFlag // 是否已完成衡山专属任务，0：未完成；1：进行中；2：已完成
	integer array taiShanOnlyFlag // 是否已完成衡山专属任务，0：未完成；1：进行中；2：已完成
	integer array shenLongOnlyFlag // 是否已完成神龙专属任务，0：未完成；1：已完成
endglobals
// 倚天剑任务，教训张无忌emtg，出现张无忌加强版e01G
function IsYiTian takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0CZ'
endfunction
function YiTian takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	if yitianflag[i] == 0  then
		if udg_runamen[i] == 8 then
			set yitianflag[i] = 1
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00灭绝师太：|r |cFF99FFCC帮我教训一下张无忌|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助灭绝师太解决|cFFADFF2F张无忌（副本3神秘怪物）|r\n")
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00灭绝师太：|r |cFF99FFCC你不是峨眉派中人，无法接此任务|r\n")
		endif
	elseif yitianflag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00灭绝师太：|r |cFF99FFCC还没教训张无忌吗？|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助灭绝师太解决|cFFADFF2F张无忌（副本3神秘怪物）|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00灭绝师太：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set u = null
	set p = null
endfunction
function IsWanChengYiTian takes nothing returns boolean
	return (GetUnitTypeId(GetTriggerUnit()) == 'emtg') or (GetUnitTypeId(GetTriggerUnit()) == 'e01G')
endfunction
function WanChengYiTian takes nothing returns nothing
	local player p = GetOwningPlayer(GetKillingUnit())
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(GetTriggerUnit())
	if GetUnitTypeId(GetTriggerUnit()) == 'emtg' then
		if yitianflag[i] == 1 then
			set yitianflag[i] = 2
			call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00张无忌：小子，刚才我只用了三分力")
			call CreateNUnitsAtLoc(1, 'e01G', Player(12), loc, bj_UNIT_FACING)
		endif
	elseif GetUnitTypeId(GetTriggerUnit()) == 'e01G' then
		call createitemloc('I00B', loc)
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00教训张无忌完成，奖励|cFFFF00CC倚天剑|r")
	endif
	set p = null
	set loc = null
endfunction
// 全真专属任务，杀林朝英ndqs
function isQuanZhenOnly takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0E4'
endfunction
function quanZhenOnly takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	if quanZhenFlag[i] == 0  then
		if udg_runamen[i] == 5 then
			if GetUnitLevel(udg_hero[i]) >= 90 then
				set quanZhenFlag[i] = 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00丘处机：|r |cFF99FFCC古墓深处，林朝英女侠可以为你解惑|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F林朝英（古墓Boss）|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00丘处机：|r |cFF99FFCC等你90级再来|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00丘处机：|r |cFF99FFCC你不是全真派中人，无法接此任务|r\n")
		endif
	elseif quanZhenFlag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00丘处机：|r |cFF99FFCC你已接受任务|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F林朝英（古墓Boss）|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00丘处机：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set u = null
	set p = null
endfunction
// 林朝英和王重阳死亡事件
function isLcyAndWcy takes nothing returns boolean
	return (GetUnitTypeId(GetTriggerUnit()) == 'ndqs') or (GetUnitTypeId(GetTriggerUnit()) == 'o02Q')
endfunction
function lcyAndWcy takes nothing returns nothing
	local player p = GetOwningPlayer(GetKillingUnit())
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(GetTriggerUnit())
	if GetUnitTypeId(GetTriggerUnit()) == 'ndqs' then
		if quanZhenFlag[i] == 1 then
			set quanZhenFlag[i] = 2
			call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00王重阳：何方鼠辈，竟敢偷袭朝英！！")
			call CreateNUnitsAtLoc(1, 'o02Q', Player(12), loc, bj_UNIT_FACING)
		endif
	elseif GetUnitTypeId(GetTriggerUnit()) == 'o02Q' then
		call createitemloc('I0DP', loc)
		
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00你的实力得到王重阳认可，获得|cFFFF00CC七星道袍|r")
	endif
	set p = null
	set loc = null
endfunction
// 慕容专属任务I0DR
function isMuRongOnly takes nothing returns boolean 
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0DR'
	// return((GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem())=='I0DR'))
endfunction
function muRongOnly takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	if muRongOnlyFlag[i] == 0 then
		if udg_runamen[i] == 13 then
			if isTitle(i, 26) and GetHeroLevel(udg_hero[i]) > 100 then
				set muRongOnlyFlag[i] = 1 // 慕容任务标记已完成
				call unitadditembyidswapped('I0DS', u)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00慕容复：|r |cFF99FFCC你小子没让我失望，这是你的奖励！|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00慕容复：|r |cFF99FFCC你还没有慕容龙城的实力或者等级未超过100级，请继续努力！|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00慕容复：|r |cFF99FFCC你不是慕容世家中人，无法接此任务|r\n")
		endif
	else
		call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00慕容复：|r |cFF99FFCC你已完成任务|r\n")
	endif
	set u = null
	set p = null
endfunction

// 恒山拂尘I0DU专属，教训田伯光o02U
function isHengShanOnly takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0DW'
endfunction
function hengShanOnly takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	local location loc = Location(0, 0)
	local integer rn = 0
	if hengShanOnlyFlag[i] == 0  then
		// 必须是恒山派
		if udg_runamen[i] == 7 then
			// GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD) >= 200000 
			if GetHeroLevel(udg_hero[i]) >= 90 then
				set hengShanOnlyFlag[i] = 1
				// 田伯光随机出现在黄蓉、林朝英、灭绝师太附近
				set rn = GetRandomInt(1, 3)
				if rn == 1 then
					set loc = Location(- 3500, 121) // 黄蓉附近
				elseif rn == 2 then
					set loc = Location(- 1165, 11193) // 灭绝附近
				else
					set loc = Location(- 9373, - 2769) // 林朝英附近
				endif
				call CreateNUnitsAtLoc(1, 'o02U', Player(12), loc, bj_UNIT_FACING)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC田伯光竟敢欺负仪琳小师妹，帮忙教训一顿。|r\n|cFFFFCC00提示：|r |cFF99FFCC教训|cFFADFF2F田伯光（随机出现在黄蓉、林朝英、灭绝师太附近）|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你的等级未达到90级|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你不是恒山派中人，无法接此任务|r\n")
		endif
	elseif hengShanOnlyFlag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC田伯光竟敢欺负仪琳小师妹，帮忙教训一顿。|r\n|cFFFFCC00提示：|r |cFF99FFCC教训|cFFADFF2F田伯光（随机出现在黄蓉、林朝英、灭绝师太附近）|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set u = null
	set p = null
	set loc = null
endfunction

// 华山：养吾剑I0EO，等级大于90级挑战令狐冲
function isHuaShanOnly takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0DV'
	// return((GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem())=='I0DV'))
endfunction
function huaShanOnly takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	local location loc = Location(1252, - 10800)
	if huaShanOnlyFlag[i] == 0  then
		// 必须是华山派
		if udg_runamen[i] == 4 then
			if GetUnitLevel(udg_hero[i]) >= 90 then 
				set huaShanOnlyFlag[i] = 1
				call CreateNUnitsAtLoc(1, 'h00N', Player(12), loc, bj_UNIT_FACING)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC请开始你的历练|r\n|cFFFFCC00提示：|r |cFF99FFCC打败|cFFADFF2F令狐冲|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你的等级没到90级|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你不是华山派中人，无法接此任务|r\n")
		endif
	elseif huaShanOnlyFlag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC请开始你的历练|r\n|cFFFFCC00提示：|r |cFF99FFCC打败|cFFADFF2F令狐冲|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set loc = null
	set u = null
	set p = null
endfunction

//衡山：镇岳尚方I0DY，令狐冲接任务，江南水乡解决费彬n00S，剑加青龙光环
function isHengShan2Only takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0E5'
endfunction
function hengShan2Only takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	local location loc = Location(- 4022, - 5210)
	if hengshan2OnlyFlag[i] == 0  then
		// 必须是衡山派
		if udg_runamen[i] == 15 then
			if GetUnitLevel(udg_hero[i]) >= 90 then 
				set hengshan2OnlyFlag[i] = 1
				call CreateNUnitsAtLoc(1, 'n00S', Player(12), loc, bj_UNIT_FACING)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC大嵩阳手费彬出现在江南水乡，帮忙解决他|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F费彬|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你的等级没到90级|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你不是衡山派中人，无法接此任务|r\n")
		endif
	elseif hengshan2OnlyFlag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC大嵩阳手费彬出现在江南水乡，帮忙解决他|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F费彬|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set loc = null
	set u = null
	set p = null
endfunction

//泰山：东灵铁剑I0E2，令狐冲接任务，雁门关解决玉玑子n00T，永久触发泰山十八盘
function isTaiShanOnly takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0E6'
endfunction
function taiShanOnly takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	local location loc = Location(- 5280, 50)
	if taiShanOnlyFlag[i] == 0  then
		// 必须是泰山派
		if udg_runamen[i] == 18 then
			if GetUnitLevel(udg_hero[i]) >= 90 then 
				set taiShanOnlyFlag[i] = 1
				call CreateNUnitsAtLoc(1, 'n00T', Player(12), loc, bj_UNIT_FACING)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC玉玑子出现在雁门关，帮忙抢回掌门铁剑|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F玉玑子|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你的等级没到90级|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你不是泰山派中人，无法接此任务|r\n")
		endif
	elseif taiShanOnlyFlag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC玉玑子出现在雁门关，帮忙抢回掌门铁剑|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F玉玑子|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00令狐冲：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set loc = null
	set u = null
	set p = null
endfunction
// 令狐冲、田伯光、洪安通、费彬死亡掉落
function isLingHuChongDeath takes nothing returns boolean
	return (GetUnitTypeId(GetTriggerUnit()) == 'h00N') or (GetUnitTypeId(GetTriggerUnit()) == 'o02U') or (GetUnitTypeId(GetTriggerUnit()) == 'n00R') or (GetUnitTypeId(GetTriggerUnit()) == 'n00S') or (GetUnitTypeId(GetTriggerUnit()) == 'n00T')
endfunction
function lingHuChongDeath takes nothing returns nothing
	local unit u = GetKillingUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(GetTriggerUnit())
	if GetUnitTypeId(GetTriggerUnit()) == 'h00N' then
		set huaShanOnlyFlag[i] = 2 // 华山历练完成
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00令狐冲：恭喜你通过历练，奖励|cFFFF00CC养吾剑|r一把")
		call unitadditembyidswapped('I0E0', u)
	elseif GetUnitTypeId(GetTriggerUnit()) == 'o02U' then
		set hengShanOnlyFlag[i] = 2
		call unitadditembyidswapped('I0DU', u)
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00令狐冲：你已经教训了田伯光，奖励|cFFFF00CC拂尘|r一把")
	elseif GetUnitTypeId(GetTriggerUnit()) == 'n00R' then
		set shenLongOnlyFlag[i] = 2
		call unitadditembyidswapped('I0DZ', u)
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00韦小宝：感谢你赶跑了洪安通，奖励|cFFFF00CC毒龙鞭|r一把")
	elseif GetUnitTypeId(GetTriggerUnit()) == 'n00S' then
		set hengshan2OnlyFlag[i] = 2
		call unitadditembyidswapped('I0DY', u)
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00令狐冲：多谢少侠为帮忙杀了费彬，奖励|cFFFF00CC镇岳尚方|r一把")
	elseif GetUnitTypeId(GetTriggerUnit()) == 'n00T' then
		set taiShanOnlyFlag[i] = 2
		call unitadditembyidswapped('I0E2', u)
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00令狐冲：多谢少侠为帮忙抢回掌门铁剑，奖励|cFFFF00CC东灵铁剑|r一把")
	endif
	set u = null
	set p = null
	set loc = null
endfunction
// 	神龙：毒龙鞭I0DZ，韦小宝卖，金钱20w，木头300
function isShenLongOnly takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0E3'
	// return((GetPlayerController(GetOwningPlayer(GetTriggerUnit()))==MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem())=='I0E3'))
endfunction
function shenLongOnly takes nothing returns nothing
	local unit u = GetTriggerUnit() // 触发单位
	local player p = GetOwningPlayer(u) // 单位所有者
	local integer i = 1 + GetPlayerId(p)
	local location loc = Location(10524, 324)
	if shenLongOnlyFlag[i] == 0  then
		// 必须是神龙教
		if udg_runamen[i] == 16 or udg_runamen[i] == 17 then
			if GetUnitLevel(udg_hero[i]) >= 40 then 
				set shenLongOnlyFlag[i] = 1
				// 桃花岛出现洪安通
				call CreateNUnitsAtLoc(1, 'n00R', Player(12), loc, bj_UNIT_FACING)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00韦小宝：|r |cFF99FFCC洪安通要来找我麻烦，求大侠帮忙打发走，据说他从神龙岛偷渡到桃花岛了。|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F洪安通（桃花岛）|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00韦小宝：|r |cFF99FFCC你的等级不足40级|r\n")	
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00韦小宝：|r |cFF99FFCC你不是神龙教中人，无法接此任务|r\n")
		endif
	elseif shenLongOnlyFlag[i] == 1 then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00韦小宝：|r |cFF99FFCC洪安通要来找我麻烦，求大侠帮忙打发走，据说他从神龙岛偷渡到桃花岛了。|r\n|cFFFFCC00提示：|r |cFF99FFCC解决|cFFADFF2F洪安通（桃花岛）|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00韦小宝：|r |cFF99FFCC你已经完成任务了|r\n")
	endif
	set u = null
	set p = null
	set loc = null
endfunction

//杀人系统
function IsYangShou takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0BF'
endfunction
function KillYangShou takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer id = LoadInteger(YDHT, GetHandleId(p), StringHash("life"))
	local integer j = GetRandomInt(1, xiuxing[i] * 3 + 3)
	local string s
	if (yangshou[i] == 0)then
		set id = udg_yangshou[j]
		set yangshou[i] = 1
		call SaveInteger(YDHT, GetHandleId(p), StringHash("life"), id)
		call SaveInteger(YDHT, GetHandleId(p), StringHash("life") * 2, (j - 1) / 3)
		set s = GetObjectName(id)
		call PlaySoundOnUnitBJ(bh, 100, u)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骏：|r |cFF99FFCC老夫夜观天象，" + s + "阳寿已尽，速去与老夫解决他|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助游骏解决|cFFADFF2F" + s + "|r\n")
	else
		set s = GetObjectName(id)
		call PlaySoundOnUnitBJ(bh, 100, u)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骏：|r |cFF99FFCC解决" + s + "了吗|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助游骏解决|cFFADFF2F" + s + "|r\n")
	endif
	set u = null
	set p = null
endfunction
function IsFangQiYangShou takes nothing returns boolean
	return UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER and GetItemTypeId(GetManipulatedItem()) == 'I0BE'
endfunction
function FangQiYangShou takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if (yangshou[i] == 0)then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骏：|r |cFF99FFCC当前没有接任务|r\n")
	else
		set shengwang[i] = shengwang[i] - 100
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00游骏：|r |cFF99FFCC堂堂大侠，竟解决不了一个小喽啰|r\n")
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00放弃任务，声望减少100|r\n")
		call PlaySoundOnUnitBJ(Gh,100,u)
		set yangshou[i] = 0
	endif
	set u = null
	set p = null
endfunction
function IsWanChengYangShou takes nothing returns boolean
	return GetUnitTypeId(GetTriggerUnit()) == LoadInteger(YDHT, GetHandleId(GetOwningPlayer(GetKillingUnit())), StringHash("life")) and yangshou[1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))] == 1
endfunction
function WanChengYangShou takes nothing returns nothing
	local unit u = GetKillingUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer id = LoadInteger(YDHT, GetHandleId(p), StringHash("life"))
	local integer j = GetRandomInt(40, 60)
	local integer l = LoadInteger(YDHT, GetHandleId(p), StringHash("life") * 2)
	set shengwang[i] = shengwang[i] + j * (l + 1)
	call AdjustPlayerStateBJ(5000 * (l + 1), p, PLAYER_STATE_RESOURCE_GOLD)
	call AdjustPlayerStateBJ(10 * (l + 1), p, PLAYER_STATE_RESOURCE_LUMBER)
	//call AddHeroXP(udg_hero[i],200*GetHeroLevel(udg_hero[i])*GetHeroLevel(udg_hero[i])*(xiuxing[i]+1),true)
	
	set yangshou[i] = 0
	if GetRandomInt(1, 10) <= l + 1 then
		call unitadditembyidswapped('I04T', udg_hero[i])
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00完成任务，奖励声望" + I2S(j * (l + 1)) + "点，金钱" + I2S(5000 * (l + 1)) + "，珍稀币" + I2S(10 * (l + 1)) + "，九阳丹一颗|r\n")
	else
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00完成任务，奖励声望" + I2S(j * (l + 1)) + "点，金钱" + I2S(5000 * (l + 1)) + "，珍稀币" + I2S(10 * (l + 1)))
	endif
	set u = null
	set p = null
endfunction
//帮郭靖求婚任务、偷玉箫任务、寻找杨过
function IsQiuHun takes nothing returns boolean
	return(UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 'I09T' or GetItemTypeId(GetManipulatedItem()) == 'I09U' or GetItemTypeId(GetManipulatedItem()) == 'I09L' or GetItemTypeId(GetManipulatedItem()) == 'I09M' or GetItemTypeId(GetManipulatedItem()) == 'I0AW' or GetItemTypeId(GetManipulatedItem()) == 'I0AT' or GetItemTypeId(GetManipulatedItem()) == 'I0AV' or GetItemTypeId(GetManipulatedItem()) == 'I0EK')
endfunction
function QiuHun_Action takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if GetItemTypeId(GetManipulatedItem()) == 'I09T' then
		if(qiuhun[i] == 0)then
			set qiuhun[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC我要教郭靖兄弟九阴真经帮助他向蓉儿求婚，可是九阴真经突然找不到了|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助周伯通寻找|cFFADFF2F九阴真经上下卷（九阴真经和九阴白骨爪）|r\n")
		else
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC帮我找到经书了吗|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助周伯通寻找|cFFADFF2F九阴真经上下卷（九阴真经和九阴白骨爪）|r\n")
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I0EK' then
		if(xidujuexue[i] == 0)then
			set xidujuexue[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC我听说老毒物把他的绝学西毒棍法和蛤蟆功整理成书了，你能帮我找来么？|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助周伯通寻找|cFFADFF2F蛤蟆功和西毒棍法|r\n")
		else
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC我听说老毒物把他的绝学西毒棍法和蛤蟆功整理成书了，你能帮我找来么？|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助周伯通寻找|cFFADFF2FcFFADFF2F蛤蟆功和西毒棍法|r\n")
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I0AT' and udg_runamen[i] == 2 then
		if(zhaoyangguo[i] == 0)then
			set zhaoyangguo[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00小龙女：|r |cFF99FFCC少侠如果见到过儿，把玉蜂交给他，他就知道我没有死了|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助小龙女找到|cFFADFF2F杨过|r\n")
			call unitadditembyidswapped('I0AU', u)
		elseif(zhaoyangguo[i] == 1)then
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00小龙女：|r |cFF99FFCC见到过儿了吗|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助小龙女找到|cFFADFF2F杨过|r\n")
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00小龙女：|r |cFF99FFCC感谢少侠相助，帮我找到了过儿|r\n")
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I0AV' and udg_runamen[i] == 2 then
		if(zhaoyangguo[i] == 0)then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00你还没有到小龙女处接任务|r\n")
		elseif(zhaoyangguo[i] == 1)then
			if UnitHaveItem(u, 'I0AU') then
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00杨过：|r |cFF99FFCC太好了，姑姑没有死！谢谢少侠，这本残章送给你了|r\n")
				call RemoveItem(FetchUnitItem(u, 'I0AU'))
				call unitadditembyidswapped('I065', u)
				set zhaoyangguo[i] = 2
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00杨过：|r |cFF99FFCC姑姑已经死去多年，哪里来的狂小子在胡言乱语|r\n")
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00杨过：|r |cFF99FFCC感谢少侠相助，帮我找到了姑姑|r\n")
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I09U' then
		if(touxiao[i] == 0)then
			set touxiao[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC黄老邪把我关在这好久，天天吹箫烦死了，你能帮我把他的玉箫偷来吗？|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助周伯通偷到|cFFADFF2F玉箫|r\n")
		else
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC帮我偷到玉箫了吗|r\n|cFFFFCC00提示：|r |cFF99FFCC帮助周伯通偷到|cFFADFF2F玉箫|r\n")
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I09L' then
		if GetUnitAbilityLevel(u, 'A0D1') >= 1 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC小子，你已经掌握此武功了")
		else
			if UnitHaveItem(u, 'I03I') and GetUnitAbilityLevel(u, 'A07S') >= 1 and wuxing[i] >= 35 then
				call RemoveItem(FetchUnitItem(u, 'I03I'))
				call unitadditembyidswapped('I09J', u)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC看你资质不错，书的这几页就是摧坚神抓的修习法门|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC小子，你的条件不足|r\n")
			endif
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I0AW' and linganran[i] == 0 then
		if GetUnitAbilityLevel(u, 'A07G') >= 1 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00杨过：|r |cFF99FFCC少侠，你已经掌握此武功了")
		else
			if fuyuan[i] >= 25 and wuxing[i] >= 25 then
				call unitadditembyidswapped('I039', u)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00杨过：|r |cFF99FFCC看你资质不错，这本黯然销魂掌的秘籍就给你了|r\n")
				set linganran[i] = 1
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00杨过：|r |cFF99FFCC少侠，你的条件不足|r\n")
			endif
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I09M' then
		if GetUnitAbilityLevel(u, 'A0D4') >= 1 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00洪七公：|r |cFF99FFCC年轻人，你已经掌握此武功了")
		else
			if UnitHaveItem(u, 'I02X') and yishu[i] >= 35 then
				call RemoveItem(FetchUnitItem(u, 'I02X'))
				call unitadditembyidswapped('I09H', u)
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00洪七公：|r |cFF99FFCC看你资质不错，书的这几页就是医疗篇的修习法门|r\n")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00洪七公：|r |cFF99FFCC年轻人，你的条件不足|r\n")
			endif
		endif
		call ShowUnitHide(gg_unit_n00E_0066)
	endif
	set u = null
	set p = null
endfunction
function IsQiuHunWan takes nothing returns boolean
	return(UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER) and ((qiuhun[1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 1 and UnitHaveItem(GetTriggerUnit(), 'I02X') and UnitHaveItem(GetTriggerUnit(), 'I03I'))or (touxiao[1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 1 and UnitHaveItem(GetTriggerUnit(), 'I0A1'))or (xidujuexue[1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 1 and UnitHaveItem(GetTriggerUnit(), 'I03C') and UnitHaveItem(GetTriggerUnit(), 'I03O')))
endfunction
function QiuHunWanCheng takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	//call BJDebugMsg("有没有？")
	if qiuhun[i] == 1 and UnitHaveItem(u, 'I02X') and UnitHaveItem(u, 'I03I') then
		set L7[i] = 1
		loop
			exitwhen L7[i] > wugongshu[i]
			if (I7[(i - 1) * 20 + L7[i]] != 'AEfk')then
				if L7[i] == wugongshu[i] then
					call RemoveItem(FetchUnitItem(u, 'I02X'))
					call RemoveItem(FetchUnitItem(u, 'I03I'))
					call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC不错小子，居然被你找到了，不能让你白跑，我把这遗忘技能的法门传给你，今后你遗忘技能就不需要遗忘之石了|r\n")
					set udg_yiwang[i] = true
					set qiuhun[i] = 0
					exitwhen true
				endif
			else
				call UnitAddAbility(u, 'A017')
				set I7[(((i - 1) * 20) + L7[i])] = 'A017'
				call RemoveItem(FetchUnitItem(u, 'I02X'))
				call RemoveItem(FetchUnitItem(u, 'I03I'))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC不错小子，居然被你找到了，不能让你白跑，我这七十二路空明拳传给你了|r\n")
				call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF0033恭喜" + GetPlayerName(p) + "习得空明拳")
				set qiuhun[i] = 0
				exitwhen true
			endif
			set L7[i] = L7[i] + 1
		endloop
	elseif xidujuexue[i] == 1 and UnitHaveItem(u, 'I03C') and UnitHaveItem(u, 'I03O') then
		set xidujuexue[i] = 0
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC不错小子，居然被找到了|r\n")
		call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC这个铁掌令是我上次和裘千仞老儿过招的时候得到的，就送给你了吧|r\n")
		call unitadditembyidswapped('I0EJ', u)
		call RemoveItem(FetchUnitItem(u , 'I03O'))
		call RemoveItem(FetchUnitItem(u , 'I03C'))
	elseif touxiao[i] == 1 and UnitHaveItem(u, 'I0A1') then
		set L7[i] = 1
		loop
			exitwhen L7[i] > wugongshu[i]
			if (I7[(i - 1) * 20 + L7[i]] != 'AEfk')then
				if L7[i] == wugongshu[i] then
					call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC小子，你学的武功太多了，遗忘一些再过来找我吧|r\n")
					exitwhen true
				endif
			else
				call UnitAddAbility(u, 'A018')
				set I7[(((i - 1) * 20) + L7[i])] = 'A018'
				call RemoveItem(FetchUnitItem(u, 'I0A1'))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC不错小子，居然被你偷到了，不能让你白跑，我把从黄老邪那偷学的碧海潮生曲传给你|r\n")
				call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|CFFFF0033恭喜" + GetPlayerName(p) + "习得碧海潮生曲")
				call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC这把玉箫其实是一把难得的神器，就送给你了吧|r\n")
				call unitadditembyidswapped('I09D', u)
				set touxiao[i] = 0
				exitwhen true
			endif
			set L7[i] = L7[i] + 1
		endloop
	endif
	set u = null
	set p = null
endfunction
//---------帮郭靖求婚结束

//-------任务系统-------
//鲁有脚送信任务
function QJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227895898))
endfunction
function RJ takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= 3))then
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFF0000你无法再接取此任务了")
	else
		if((jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 0))then
			if((GetRandomInt(1, 100) <= 35))then
				call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Bg))
				set jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 1
				call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00鲁有脚：|r |cFF99FFCC丐帮乃江湖第一大帮派，负责传送各种情报|r\n|cFFFFCC00提示：|r |cFF99FFCC送信给|cFFADFF2F黄蓉|r\n")
				call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
				call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
			else
				if((GetRandomInt(1, 70) <= 35))then
					call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Xe))
					set jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 2
					call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
					call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00鲁有脚：|r |cFF99FFCC丐帮乃江湖第一大帮派，负责传送各种情报|r\n|cFFFFCC00提示：|r |cFF99FFCC送信给|cFFADFF2F达摩祖师|r\n")
					call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
					call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
				else
					set jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 3
					call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Pe))
					call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
					call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00鲁有脚：|r |cFF99FFCC丐帮乃江湖第一大帮派，负责传送各种情报|r\n|cFFFFCC00提示：|r |cFF99FFCC送信给|cFFADFF2F郭靖\n")
					call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
					call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
				endif
			endif
		else
			if((jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
				call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Bg))
				call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00鲁有脚：|r |cFF99FFCC丐帮乃江湖第一大帮派，负责传送各种情报|r\n|cFFFFCC00提示：|r |cFF99FFCC送信给|cFFADFF2F黄蓉|r\n")
				call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
				call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
			else
				if((jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 2))then
					call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Xe))
					call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
					call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00鲁有脚：|r |cFF99FFCC丐帮乃江湖第一大帮派，负责传送各种情报|r\n|cFFFFCC00提示：|r |cFF99FFCC送信给|cFFADFF2F达摩祖师|r\n")
					call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
					call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
				else
					if((jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 3))then
						call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Pe))
						call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
						call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00鲁有脚：|r |cFF99FFCC丐帮乃江湖第一大帮派，负责传送各种情报|r\n|cFFFFCC00提示：|r |cFF99FFCC送信给|cFFADFF2F郭靖\n")
						call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
						call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
					endif
				endif
			endif
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function TJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(jd[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 1))
endfunction
function UJ takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((GetRandomInt(1, 50) <= 25))then
		call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 0, 0, 500)
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、生命+500\n")
	else
		if((GetRandomInt(1, 50) <= 25))then
			call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 3, 0, $C8)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、攻击+200")
		else
			call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 2, 0, 30)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、防御+30\n")
		endif
	endif
	if((GetRandomInt(1, 50) <= 40))then
		call unitadditembyidswapped(YaoCao[5], GetTriggerUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00意外获得了一个锦灯笼")
	endif
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	set jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 60)
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function WJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(jd[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 2))
endfunction
function XJ takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((GetRandomInt(1, 50) <= 25))then
		call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 0, 0, 500)
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、生命+500\n")
	else
		if((GetRandomInt(1, 50) <= 25))then
			call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 3, 0, $C8)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、攻击+200")
		else
			call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 2, 0, 30)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、防御+30\n")
		endif
	endif
	if((GetRandomInt(1, 50) <= 40))then
		call unitadditembyidswapped(YaoCao[5], GetTriggerUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00意外获得了一个锦灯笼")
	endif
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	set jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 60)
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function ZJ takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(jd[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 3))
endfunction
function dK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((GetRandomInt(1, 50) <= 25))then
		call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 0, 0, 500)
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、生命+500\n")
	else
		if((GetRandomInt(1, 50) <= 25))then
			call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 3, 0, $C8)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、攻击+200")
		else
			call YDWEGeneralBounsSystemUnitSetBonus(GetTriggerUnit(), 2, 0, 30)
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得经验+3000、江湖声望+60、防御+30\n")
		endif
	endif
	if((GetRandomInt(1, 50) <= 40))then
		call unitadditembyidswapped(YaoCao[5], GetTriggerUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00意外获得了一个锦灯笼")
	endif
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	set jd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (kd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 60)
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function fK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227895352))
endfunction
//击杀野猪首领
function gK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((e8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 0))then
		call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Se))
		set e8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 1
		call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00耶律齐：|r |cFF99FFCC我一生酷爱打猎，平时有时间就会出来试试身手，你愿意一同前往吗|r\n|cFFFFCC00提示：|r |cFF99FFCC击杀山林中的|cFFADFF2F野猪首领|r\n")
		call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
	else
		if((e8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
			call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Se))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00你已经接下任务了\n|cFFFFCC00提示：|r |cFF99FFCC击杀山林中的|cFFADFF2F野猪首领|r\n")
			call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function iK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227895353))
endfunction
//林远图押镖任务
function jK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 0))then
		if((GetRandomInt(1, 70) <= $A))then
			call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Te))
			set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 1
			call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给全真教的丘掌门吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往全真教的|cFFADFF2F丘处机|r\n")
			call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		else
			if((GetRandomInt(1, 60) <= $A))then
				call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Ue))
				set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 2
				call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC全真教山下附近的豺狼经常出没攻击镖车，你能前往消灭他们吗|r\n|cFFFFCC00提示：|r |cFF99FFCC前往全真教山下的杀死10只|cFFADFF2F豺狼|r\n")
				call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
				call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
			else
				if((GetRandomInt(1, 50) <= $A))then
					call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Ve))
					set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 3
					call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
					call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给燕子坞的慕容复吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往燕子坞的|cFFADFF2F慕容复|r\n")
					call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
					call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
				else
					if((GetRandomInt(1, 40) <= $A))then
						call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(We))
						set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 4
						call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
						call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC燕子坞的蝎子王经常出没攻击镖车，你能前往消灭他们吗|r\n|cFFFFCC00提示：|r |cFF99FFCC前往燕子坞的杀死3只|cFFADFF2F蝎子王|r\n")
						call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
						call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
					else
						if((GetRandomInt(1, 30) <= $A))then
							call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Xe))
							set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 5
							call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
							call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给少林寺的达摩祖师吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往少林寺的|cFFADFF2F达摩祖师|r\n")
							call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
							call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
						else
							if((GetRandomInt(1, 20) <= $A))then
								call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Ye))
								set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 6
								call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
								call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给雁门关的乔峰吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往雁门关的|cFFADFF2F乔峰|r\n")
								call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
								call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
							else
								set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 7
								call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Je))
								call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
								call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC西域邪教持续骚扰我中原武林，是时候给他们一点颜色了|r\n|cFFFFCC00提示：|r |cFF99FFCC守住武林正派，杀死10只|cFFADFF2F进攻的西域教徒|r\n")
								call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
								call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
							endif
						endif
					endif
				endif
			endif
		endif
	else
		if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
			call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Te))
			call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给全真教的邱掌门吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往全真教的|cFFADFF2F丘处机|r\n")
			call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		else
			if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 2))then
				call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Ue))
				call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC全真教山下附近的豺狼经常出没攻击镖车，你能前往消灭他们吗|r\n|cFFFFCC00提示：|r |cFF99FFCC前往全真教山下的杀死10只|cFFADFF2F豺狼|r\n")
				call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
				call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
			else
				if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 3))then
					call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Ve))
					call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
					call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给燕子坞的慕容复吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往燕子坞的|cFFADFF2F慕容复|r\n")
					call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
					call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
				else
					if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 4))then
						call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(We))
						call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
						call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC燕子坞的蝎子王经常出没攻击镖车，你能前往消灭他们吗|r\n|cFFFFCC00提示：|r |cFF99FFCC前往燕子坞的杀死5只|cFFADFF2F蝎子王|r\n")
						call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
						call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
					else
						if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 5))then
							call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Xe))
							call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
							call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给少林寺的达摩祖师吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往少林寺的|cFFADFF2F达摩祖师|r\n")
							call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
							call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
						else
							if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 6))then
								call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Ye))
								call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
								call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC我这有一封信，你帮我送给雁门关的乔峰吧|r\n|cFFFFCC00提示：|r |cFF99FFCC前往雁门关的|cFFADFF2F乔峰|r\n")
								call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
								call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
							else
								if((g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 7))then
									call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Je))
									call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
									call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC西域邪教持续骚扰我中原武林，是时候给他们一点颜色了|r\n|cFFFFCC00提示：|r |cFF99FFCC守住武林正派，杀死10只|cFFADFF2F进攻的西域教徒|r\n")
									call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
									call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
								endif
							endif
						endif
					endif
				endif
			endif
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function mK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(g8[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 1))
endfunction
function nK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
	set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
		call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function pK takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 'ngns')and(g8[(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())))] == 2))
endfunction
function qK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetKillingUnit())
	set h8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (h8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((h8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= $A))then
		set h8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		call PlaySoundOnUnitBJ(Hh, 100, GetKillingUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
		set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
		call AddHeroXP(GetKillingUnit(), 3000, true)
		set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
		if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
			call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
		endif
	else
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("豺狼：" + (I2S(h8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)]) + " / 10")))
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function sK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(g8[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 3))
endfunction
function tK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
	set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
		call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function vK takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 'nanb')and(g8[(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())))] == 4))
endfunction
function wK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	set i8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (i8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((i8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= 3))then
		set i8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		call PlaySoundOnUnitBJ(Hh, 100, GetKillingUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
		set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
		set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
		call AddHeroXP(GetKillingUnit(), 3000, true)
		if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
			call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
		endif
	else
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("蝎子王：" + (I2S(i8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)]) + " / 3")))
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function yK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(g8[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 5))
endfunction
function zK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
	set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
		call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function aK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(g8[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 6))
endfunction
function BK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
	set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
	call AddHeroXP(LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0), 3000, true)
	set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
		call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function CK takes nothing returns boolean
	return GetKillingUnit() != null and ((g8[(1 + GetPlayerId(GetOwningPlayer(GetKillingUnit())))] == 7))
endfunction
function cK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetKillingUnit()))))
	set j8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (j8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((j8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= $A))then
		set j8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		call PlaySoundOnUnitBJ(Hh, 100, GetKillingUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+50，经验值+3000")
		set g8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
		set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 50)
		call AddHeroXP(GetKillingUnit(), 3000, true)
		set qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
		if((GetRandomInt(1, 35) <= (fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] - 5)))then
			call unitadditembyidswapped(gudong[GetRandomInt(1, 3)], LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00你的运气（与福缘有关）太好了，竟然意外获得了一个古董")
		endif
	else
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("西域邪教：" + (I2S(j8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)]) + " / 10")))
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function EK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227895364))
endfunction
function FK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((qd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= 3))then
		if((o8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == false))then
			if((GetRandomInt(1, 100) <= 25))then
				call unitadditembyidswapped('I01U', GetTriggerUnit())
				set o8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = true
				call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00获得" + GetItemName(bj_lastCreatedItem)))
			else
				if((GetRandomInt(1, 60) <= 20))then
					call unitadditembyidswapped('I01Z', GetTriggerUnit())
					set o8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = true
					call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
					call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00获得" + GetItemName(bj_lastCreatedItem)))
				else
					if((GetRandomInt(1, 60) <= 30))then
						call unitadditembyidswapped(1227895124, GetTriggerUnit())
						set o8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = true
						call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
						call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00获得" + GetItemName(bj_lastCreatedItem)))
					else
						call unitadditembyidswapped(1227895109, GetTriggerUnit())
						set o8[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = true
						call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
						call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00获得" + GetItemName(bj_lastCreatedItem)))
					endif
				endif
			endif
			call SaveLocationHandle(YDHT, id * cx, $1769D332, GetUnitLoc(GetTriggerUnit()))
			if((GetRandomInt(1, $B4) <= $A))then
				call createitemloc(1227895627, LoadLocationHandle(YDHT, id * cx, $1769D332))
			else
				if((GetRandomInt(1, $AA) <= $A))then
					call createitemloc(1227895385, LoadLocationHandle(YDHT, id * cx, $1769D332))
				else
					if((GetRandomInt(1, $A0) <= $A))then
						call createitemloc('I03D', LoadLocationHandle(YDHT, id * cx, $1769D332))
					else
						if((GetRandomInt(1, $96) <= $A))then
							call createitemloc(1227895382, LoadLocationHandle(YDHT, id * cx, $1769D332))
						else
							if((GetRandomInt(1, $8C) <= $A))then
								call createitemloc(1227895624, LoadLocationHandle(YDHT, id * cx, $1769D332))
							else
								if((GetRandomInt(1, $82) <= $A))then
									call createitemloc(1227895621, LoadLocationHandle(YDHT, id * cx, $1769D332))
								else
									if((GetRandomInt(1, 120) <= $A))then
										call createitemloc(1227895603, LoadLocationHandle(YDHT, id * cx, $1769D332))
									else
										if((GetRandomInt(1, 110) <= $A))then
											call createitemloc('I02W', LoadLocationHandle(YDHT, id * cx, $1769D332))
										else
											if((GetRandomInt(1, 100) <= $A))then
												call createitemloc(1227895601, LoadLocationHandle(YDHT, id * cx, $1769D332))
											else
												if((GetRandomInt(1, 90) <= $A))then
													call createitemloc('I03G', LoadLocationHandle(YDHT, id * cx, $1769D332))
												else
													if((GetRandomInt(1, 80) <= $A))then
														call createitemloc('I02U', LoadLocationHandle(YDHT, id * cx, $1769D332))
													else
														if((GetRandomInt(1, 70) <= $A))then
															call createitemloc(1227895626, LoadLocationHandle(YDHT, id * cx, $1769D332))
														else
															if((GetRandomInt(1, 60) <= $A))then
																call createitemloc('I030', LoadLocationHandle(YDHT, id * cx, $1769D332))
															else
																if((GetRandomInt(1, 50) <= $A))then
																	call createitemloc('I02X', LoadLocationHandle(YDHT, id * cx, $1769D332))
																else
																	if((GetRandomInt(1, 40) <= $A))then
																		call createitemloc('I03I', LoadLocationHandle(YDHT, id * cx, $1769D332))
																	else
																		if((GetRandomInt(1, 30) <= $A))then
																			call createitemloc('I02Z', LoadLocationHandle(YDHT, id * cx, $1769D332))
																		else
																			if((GetRandomInt(1, 20) <= $A))then
																				call createitemloc('I03L', LoadLocationHandle(YDHT, id * cx, $1769D332))
																			else
																				call createitemloc('I03F', LoadLocationHandle(YDHT, id * cx, $1769D332))
																			endif
																		endif
																	endif
																endif
															endif
														endif
													endif
												endif
											endif
										endif
									endif
								endif
							endif
						endif
					endif
				endif
			endif
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00获得" + GetItemName(bj_lastCreatedItem)))
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $1769D332))
		else
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC你已经领过奖励了\n")
		endif
	else
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00林远图：|r |cFF99FFCC需要完成至少3次押镖任务才可以领取奖励哦")
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//接杀熊、桃花岛哑仆的任务
function HK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227896132 or GetItemTypeId(GetManipulatedItem()) == 'I09W'))
endfunction
function IK takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = null
	if GetItemTypeId(GetManipulatedItem()) == 1227896132 then
		if((rd[i] == 0))then
			set loc = GetRectCenter(Nf)
			set rd[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00胡斐：|r |cFF99FFCC这一代时常有熊出没，能搞点熊皮来的话应该可以卖个好价钱|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F30只熊|r\n")
			call PingMinimapLocForForce(ov(p), loc, 5.)
			call RemoveLocation(loc)
		elseif((rd[i] == 1))then
			set loc = GetRectCenter(Nf)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00胡斐：|r |cFF99FFCC这一代时常有熊出没，能搞点熊皮来的话应该可以卖个好价钱|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F30只熊|r\n")
			call PingMinimapLocForForce(ov(p), loc, 5.)
			call RemoveLocation(loc)
		elseif((rd[i] == 2))then
			call DisplayTextToPlayer(p, 0, 0, "|cFfff0000这个任务你已经完成过了")
		endif
	elseif GetItemTypeId(GetManipulatedItem()) == 'I09W' then
		if((LoadInteger(YDHT, StringHash("哑仆任务"), i) == 0))then
			call SaveInteger(YDHT, StringHash("哑仆任务"), i, 1)
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC黄老邪把我腿打断的时候，桃花岛上的哑仆一直欺负我，你能帮我杀掉十个哑仆吗|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F十个哑仆|r\n")
		elseif((LoadInteger(YDHT, StringHash("哑仆任务"), i) == 1))then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFCC00周伯通：|r |cFF99FFCC杀掉十个哑仆了吗|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F十个哑仆|r\n")
		endif
	endif
	set u = null
	set p = null
	set loc = null
endfunction

//升10级自动奖励丹药
function PK takes nothing returns boolean
	return (GetTriggerUnit() == udg_hero[1] or GetTriggerUnit() == udg_hero[2] or GetTriggerUnit() == udg_hero[3] or GetTriggerUnit() == udg_hero[4] or GetTriggerUnit() == udg_hero[5])and GetUnitLevel(GetTriggerUnit()) == 10 and GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER
endfunction
function QK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	if((GetRandomInt(1, 60) <= $A))then
		call unitadditembyidswapped(1227895375, GetTriggerUnit())
	else
		if((GetRandomInt(1, 50) <= $A))then
			call unitadditembyidswapped(1227895370, GetTriggerUnit())
		else
			if((GetRandomInt(1, 40) <= $A))then
				call unitadditembyidswapped(1227895363, GetTriggerUnit())
			else
				if((GetRandomInt(1, 30) <= $A))then
					call unitadditembyidswapped(1227895368, GetTriggerUnit())
				else
					if((GetRandomInt(1, 60) <= 30))then
						call unitadditembyidswapped(1227895369, GetTriggerUnit())
					else
						call unitadditembyidswapped(1227895365, GetTriggerUnit())
					endif
				endif
			endif
		endif
	endif
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00恭喜升到10级，获得" + GetItemName(bj_lastCreatedItem)))
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//采集断肠草
function SK takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227895890))
endfunction
function TK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((z9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 0))then
		call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Gg))
		set z9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 1
		call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00公孙绿萼：|r |cFF99FFCC杨过中了情花剧毒，你能替我想想办法救救他吗|r\n|cFFFFCC00提示：|r |cFF99FFCC采集绝情谷副本中的|cFFADFF2F断肠草|r\n")
		call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
	else
		if((z9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
			call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(Gg))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00你已经接下任务了\n|cFFFFCC00提示：|r |cFF99FFCC采集绝情谷副本的|cFFADFF2F断肠草|r\n")
			call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//采集到断肠草
function VK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	if((GetItemTypeId(GetEnumItem()) == 'I04S'))then
		call SaveInteger(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $5E9EB4B3, (LoadInteger(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $5E9EB4B3) + 1))
		set a9[LoadInteger(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $5E9EB4B3)] = GetEnumItem()
		set B9[LoadInteger(YDHT, id * LoadInteger(YDHT, id, - $1317DA19), - $5E9EB4B3)] = GetItemLoc(GetEnumItem())
	endif
endfunction
function WK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, 0)
	call EnumItemsInRectBJ(Gg, function VK)
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//断肠草
function YK takes nothing returns boolean
	return((GetItemTypeId(GetManipulatedItem()) == 'I04S'))
endfunction
function ZK takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call SaveItemHandle(YDHT, id * cx, $1769D332, GetManipulatedItem())
	if((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) == false))then
		set bj_forLoopAIndex = 1
		set bj_forLoopAIndexEnd = 12
		loop
			exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
			if((GetManipulatedItem() == a9[bj_forLoopAIndex]))then
				call createitemloc('I04S', B9[bj_forLoopAIndex])
				set a9[bj_forLoopAIndex] = bj_lastCreatedItem
				call DisplayTimedTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, 15., "|CFFFF0000只能由主角来采集")
			endif
			set bj_forLoopAIndex = bj_forLoopAIndex + 1
		endloop
	else
		if((z9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
			set A9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (A9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
			if((A9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] >= $A))then
				set z9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 2
				set A9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务请前往公孙绿萼换取奖励")
			else
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("断肠草：" + (I2S(A9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)]) + " / 10")))
			endif
			call CreateNUnitsAtLoc(1, 1752196449, Player(15), v7[1], bj_UNIT_FACING)
			call ShowUnitHide(bj_lastCreatedUnit)
			call UnitApplyTimedLife(bj_lastCreatedUnit, 'BHwe', GetRandomReal(20., 25.))
			set bj_forLoopAIndex = 1
			set bj_forLoopAIndexEnd = 12
			loop
				exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
				if((LoadItemHandle(YDHT, id * cx, $1769D332) == a9[bj_forLoopAIndex]))then
					set b9[bj_forLoopAIndex] = bj_lastCreatedUnit
				endif
				set bj_forLoopAIndex = bj_forLoopAIndex + 1
			endloop
		else
			set bj_forLoopAIndex = 1
			set bj_forLoopAIndexEnd = 12
			loop
				exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
				if((LoadItemHandle(YDHT, id * cx, $1769D332) == a9[bj_forLoopAIndex]))then
					call createitemloc('I04S', B9[bj_forLoopAIndex])
					set a9[bj_forLoopAIndex] = bj_lastCreatedItem
					call DisplayTimedTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, 15., "|CFFFF0000身上没有该任务或已经完成了")
				endif
				set bj_forLoopAIndex = bj_forLoopAIndex + 1
			endloop
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//完成断肠草任务
function eL takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(z9[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 2))
endfunction
function fL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call PlaySoundOnUnitBJ(Hh, 100, GetTriggerUnit())
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	set z9[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 100)
	if((GetRandomInt(1, 40) <= 20))then
		call unitadditembyidswapped('I00X', GetTriggerUnit())
	else
		call unitadditembyidswapped('I00Y', GetTriggerUnit())
	endif
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00完成任务江湖声望+100，并获得" + GetItemName(bj_lastCreatedItem)))
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function hL takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 1752196449))
endfunction
function iL takes nothing returns nothing
	set bj_forLoopAIndex = 1
	set bj_forLoopAIndexEnd = 12
	loop
		exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
		if((GetTriggerUnit() == b9[bj_forLoopAIndex]))then
			call createitemloc('I04S', B9[bj_forLoopAIndex])
			set a9[bj_forLoopAIndex] = bj_lastCreatedItem
		endif
		set bj_forLoopAIndex = bj_forLoopAIndex + 1
	endloop
endfunction
//护送耶律楚材
function kL takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227896387))
endfunction
function mL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((Sd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 0))then
		call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(gh))
		set Sd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 1
		call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00完颜萍：|r |cFF99FFCC耶律楚材受伤了，你能帮个忙啊|r\n|cFFFFCC00提示：|r |cFF99FFCC护送耶律楚材回|cFFADFF2F大辽国|r\n")
		call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
		call SaveLocationHandle(YDHT, id * cx, 1231311908, GetRectCenter(hh))
		call CreateNUnitsAtLoc(1, 1853254706, GetOwningPlayer(GetTriggerUnit()), LoadLocationHandle(YDHT, id * cx, 1231311908), bj_UNIT_FACING)
		call IssuePointOrderByIdLoc(bj_lastCreatedUnit, $D0012, LoadLocationHandle(YDHT, id * cx, $5E83114F))
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, 1231311908))
	else
		if((Sd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
			call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(gh))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00你已经接下任务了\n|cFFFFCC00提示：|r |cFF99FFCC护送耶律楚材回|cFFADFF2F大辽国|r\n")
			call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		else
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00你已经完成了这个任务了（不可重复接取）")
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function oL takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 1853254706))
endfunction
function pL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetTriggerPlayer())))
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFF0000任务失败了")
	set Sd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	call PlaySoundOnUnitBJ(Gh, 100, udg_hero[LoadInteger(YDHT, id * cx, - $5E9EB4B3)])
	call FlushChildHashtable(YDHT, id * cx)
endfunction
function rL takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 1853254706))
endfunction
function sL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call PlaySoundOnUnitBJ(Hh, 100, udg_hero[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))])
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	set Sd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 2
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + $96)
	set juexuelingwu[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (juexuelingwu[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 1)
	call RemoveUnit(GetTriggerUnit())
	call AdjustPlayerStateBJ($7530, GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_GOLD)
	call AdjustPlayerStateBJ(20, GetOwningPlayer(GetTriggerUnit()), PLAYER_STATE_RESOURCE_LUMBER)
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务江湖声望+150，并获得金钱+30000、稀有币+20、绝学领悟力+1")
	call ShowUnitShow(gg_unit_nvl2_0005)
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//高昌迷宫任务
function uL takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227896388))
endfunction
function vL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	if((Td[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 0))then
		call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(xg))
		set Td[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 1
		call PlaySoundOnUnitBJ(bh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00苗人凤：|r |cFF99FFCC很多武林恶势力犯事之后都躲到了高昌迷宫里|r\n|cFFFFCC00提示：|r |cFF99FFCC分别杀死|cFFADFF2F10个门派叛徒和武林恶徒|r\n")
		call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
	else
		if((Td[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 1))then
			call SaveLocationHandle(YDHT, id * cx, $5E83114F, GetRectCenter(xg))
			call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFFFFCC00苗人凤：|r |cFF99FFCC很多武林恶势力犯事之后都躲到了高昌迷宫里|r\n|cFFFFCC00提示：|r |cFF99FFCC分别杀死|cFFADFF2F10个门派叛徒和武林恶徒|r\n")
			call PingMinimapLocForForce(ov(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3)))), LoadLocationHandle(YDHT, id * cx, $5E83114F), 5.)
			call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $5E83114F))
		else
			if((Td[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] == 2))then
				call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|cFfff0000这个任务你无法再接取了")
			endif
		endif
	endif
	call FlushChildHashtable(YDHT, id * cx)
endfunction
// 完成高昌迷宫任务
function xL takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(Td[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 1)and(Vd[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == $A)and(Ud[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == $A))
endfunction
function yL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	// 号令初始爆率
	local integer gailv = 18
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	// 自由号令爆率提高
	if udg_runamen[1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] == 11 then
		set gailv = gailv + 20
	endif
	if GetRandomInt(1, 100) <= gailv + fuyuan[1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
		// 号令I06F
		call unitadditembyidswapped(1227896390, GetTriggerUnit())
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00运气不错，送你一个号令天下令牌\n")
	endif
	if((GetRandomInt(1, 50) <= fuyuan[LoadInteger(YDHT, id * cx, - $5E9EB4B3)]))then
		call SaveLocationHandle(YDHT, id * cx, $1769D332, GetUnitLoc(GetTriggerUnit()))
		if((GetRandomInt(1, 100) <= $A))then
			call createitemloc(1227896370, LoadLocationHandle(YDHT, id * cx, $1769D332))
		else
			if((GetRandomInt(1, 90) <= $A))then
				call createitemloc(1227896371, LoadLocationHandle(YDHT, id * cx, $1769D332))
			else
				if((GetRandomInt(1, 80) <= $A))then
					call createitemloc(1227896369, LoadLocationHandle(YDHT, id * cx, $1769D332))
				else
					if((GetRandomInt(1, 70) <= $A))then
						call createitemloc(1227896374, LoadLocationHandle(YDHT, id * cx, $1769D332))
					else
						if((GetRandomInt(1, 60) <= $A))then
							call createitemloc(1227896372, LoadLocationHandle(YDHT, id * cx, $1769D332))
						else
							if((GetRandomInt(1, 50) <= $A))then
								call createitemloc(1227896368, LoadLocationHandle(YDHT, id * cx, $1769D332))
							else
								if((GetRandomInt(1, 40) <= $A))then
									call createitemloc(1227896377, LoadLocationHandle(YDHT, id * cx, $1769D332))
								else
									if((GetRandomInt(1, 30) <= $A))then
										call createitemloc(1227896376, LoadLocationHandle(YDHT, id * cx, $1769D332))
									else
										if((GetRandomInt(1, 20) <= $A))then
											call createitemloc(1227896375, LoadLocationHandle(YDHT, id * cx, $1769D332))
										else
											call createitemloc('I065', LoadLocationHandle(YDHT, id * cx, $1769D332))
										endif
									endif
								endif
							endif
						endif
					endif
				endif
			endif
		endif
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $1769D332))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+200和绝学隐藏招式残章一本\n")
		set Td[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	else
		call SaveLocationHandle(YDHT, id * cx, $1769D332, GetUnitLoc(GetTriggerUnit()))
		call createitemloc(gudong[GetRandomInt(4, 9)], LoadLocationHandle(YDHT, id * cx, $1769D332))
		call RemoveLocation(LoadLocationHandle(YDHT, id * cx, $1769D332))
		call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, "|CFF34FF00完成任务获得江湖声望+200和古董一个")
		set Td[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	endif
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + $C8)
	set Vd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	set Ud[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	call FlushChildHashtable(YDHT, id * cx)
endfunction
//辽国第一先锋任务+拯救阿紫任务
function AL takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(GetItemTypeId(GetManipulatedItem()) == 1227896389 or GetItemTypeId(GetManipulatedItem()) == 'I0AN'))
endfunction
function aL takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	local location loc = GetRectCenter(mh)
	if (GetItemTypeId(GetManipulatedItem()) == 1227896389) then
		if (Wd[i] == 0) then
			set Wd[i] = 1
			call PlaySoundOnUnitBJ(bh, 100, u)
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00乔峰：|r |cFF99FFCC最近辽国养兵蓄锐，似乎对大宋有所企图，若能擒住辽国第一先锋，百姓才能避免战祸|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F辽国第一先锋|r\n")
			call PingMinimapLocForForce(bj_FORCE_ALL_PLAYERS, loc, 5.)
			call RemoveLocation(loc)
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00乔峰：|r |cFF99FFCC最近辽国养兵蓄锐，似乎对大宋有所企图，若能擒住辽国第一先锋，百姓才能避免战祸|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F辽国第一先锋|r\n")
			call PingMinimapLocForForce(bj_FORCE_ALL_PLAYERS, loc, 5.)
			call RemoveLocation(loc)
		endif
	else
		if jiuazi[i] == 0  then
			if udg_runamen[i] == 10 then
				set jiuazi[i] = 1
				call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00乔峰：|r |cFF99FFCC阿紫被丁老头抓走了，请英雄帮我击败丁春秋，救出阿紫|r\n|cFFFFCC00提示：|r |cFF99FFCC杀死|cFFADFF2F丁春秋|r\n")
			else
				call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00乔峰：|r |cFF99FFCC你不是星宿派中人，无法接此任务|r\n")
			endif
		else
			call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "|cFFFFCC00乔峰：|r |cFF99FFCC你已完成任务|r\n")
		endif
	endif
	set u = null
	set loc = null
endfunction
function bL takes nothing returns boolean
	return((GetUnitTypeId(GetTriggerUnit()) == 1751543663) or (GetUnitTypeId(GetTriggerUnit()) == 'odkt') or (GetUnitTypeId(GetTriggerUnit()) == 'h00J'))
endfunction
function CL takes nothing returns nothing
	local player p = GetOwningPlayer(GetKillingUnit())
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(GetTriggerUnit())
	if GetUnitTypeId(GetTriggerUnit()) == 1751543663 and GetOwningPlayer(GetTriggerUnit()) == Player(12) then
		if((Wd[i] == 1))then
			set Wd[i] = 2
			call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00恭喜击破辽国第一先锋，你可以回去领奖励了")
		elseif((Wd[i] == 2))then
			call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00你已经杀过这个怪了，还是先回去交任务把")
		endif
	elseif GetUnitTypeId(GetTriggerUnit()) == 'odkt' then
		if jiuazi[i] == 1 then
			set jiuazi[i] = 2
			call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00击败丁春秋，阿紫现身")
			call CreateNUnitsAtLoc(1, 'h00J', Player(12), loc, bj_UNIT_FACING)
		endif
	elseif GetUnitTypeId(GetTriggerUnit()) == 'h00J' then
		call createitemloc('I0AM', loc)
		call SetItemUserData(bj_lastCreatedItem, GetRandomInt(1, 5) * $989680 + GetRandomInt(1, 5) * $F4240 + GetRandomInt(1, 5) * $186A0 + GetRandomInt(1, 5) * $2710)
		call DisplayTextToPlayer(p, 0, 0, "|CFF34FF00击败阿紫，获得神木王鼎")
	endif
	call RemoveLocation(loc)
	set p = null
	set loc = null
endfunction

// 完成辽国军心任务
function DL takes nothing returns boolean
	return((UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO))and(GetPlayerController(GetOwningPlayer(GetTriggerUnit())) == MAP_CONTROL_USER)and(Wd[(1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit())))] == 2))
endfunction
function EL takes nothing returns nothing
	local integer id = GetHandleId(GetTriggeringTrigger())
	local integer cx = LoadInteger(YDHT, id, - $3021938A)
	set cx = cx + 3
	call SaveInteger(YDHT, id, - $3021938A, cx)
	call SaveInteger(YDHT, id, - $1317DA19, cx)
	call SaveInteger(YDHT, id * cx, - $5E9EB4B3, (1 + GetPlayerId(GetOwningPlayer(GetTriggerUnit()))))
	call SaveUnitHandle(YDHT, id * cx, - $2EC5CBA0, GetTriggerUnit())
	call PlaySoundOnUnitBJ(Hh, 100, LoadUnitHandle(YDHT, id * cx, - $2EC5CBA0))
	call unitadditembyidswapped(YaoCao[4], GetTriggerUnit())
	if((GetRandomInt(1, 75) <= 25))then
		//遗忘石
		call unitadditembyidswapped('I06K', GetTriggerUnit())
	else
		if((GetRandomInt(1, 50) <= 25))then
			//打孔符
			call unitadditembyidswapped('I06N', GetTriggerUnit())
		else
			//神偷令
			call unitadditembyidswapped('I06I', GetTriggerUnit())
		endif
	endif
	//三分之一概率双倍掉落
	if (GetRandomInt(1, 3) == 1)then
		if((GetRandomInt(1, 75) <= 25))then
			//遗忘石
			call unitadditembyidswapped('I06K', GetTriggerUnit())
		else
			if((GetRandomInt(1, 50) <= 25))then
				//打孔符
				call unitadditembyidswapped('I06N', GetTriggerUnit())
			else
				//神偷令
				call unitadditembyidswapped('I06I', GetTriggerUnit())
			endif
		endif
	endif
	set shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = (shengwang[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] + 250)
	set Wd[LoadInteger(YDHT, id * cx, - $5E9EB4B3)] = 0
	call DisplayTextToPlayer(Player(- 1 + (LoadInteger(YDHT, id * cx, - $5E9EB4B3))), 0, 0, ("|CFF34FF00完成任务获得江湖声望+250，金银花一个和" + GetItemName(bj_lastCreatedItem)))
	call FlushChildHashtable(YDHT, id * cx)
endfunction

function Tasks_Trigger takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	
	set bigTalent[1] = 0
	set bigTalent[2] = 0
	set bigTalent[3] = 0
	set bigTalent[4] = 0
	set bigTalent[5] = 0
	
	set Fo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Fo, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Fo, Condition(function IJ))
	call TriggerAddAction(Fo, function lJ)
	set Go = CreateTrigger()
	call TriggerAddRect(Go, Pe)
	call TriggerAddCondition(Go, Condition(function KJ))
	call TriggerAddAction(Go, function LJ)
	set Jn = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Jn, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(Jn, Condition(function TI))
	call TriggerAddAction(Jn, function UI)
	set Ho = CreateTrigger()
	call TriggerAddRect(Ho, Re)
	call TriggerAddRect(Ho, Ie)
	call TriggerAddRect(Ho, le)
	call TriggerAddCondition(Ho, Condition(function NJ))
	call TriggerAddAction(Ho, function OJ)
	
	// 武功秘籍兑换
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isBuyWuGongBook))
	call TriggerAddAction(t, function buyWuGongBook)
	
	// 速战速决任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsQuickFight))
	call TriggerAddAction(t, function QuickFight)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_USE_ITEM )
	call TriggerAddCondition(t, Condition(function IsJiaSuChuGuai))
	call TriggerAddAction(t, function JiaSuChuGuai)
	set t = CreateTrigger()
	// 猪年杀猪任务
	// call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_DEATH)
	// call TriggerAddCondition(t,Condition(function IsKillYang))
	// call TriggerAddAction(t,function KillYang)
	// 等级福利
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsLevelReward))
	call TriggerAddAction(t, function LevelReward)
	// 积分商店
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isJfShop))
	call TriggerAddAction(t, function jfShop)
	// 积分商店2
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isJfShop2))
	call TriggerAddAction(t, function jfShop2)
	// 杀人系统
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsWuPin))
	call TriggerAddAction(t, function LookForWuPin)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsFangQiWuPin))
	call TriggerAddAction(t, function FangQiWuPin)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsWanChengWuPin))
	call TriggerAddAction(t, function WanChengWuPin)
	// 寻宝系统
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsYangShou))
	call TriggerAddAction(t, function KillYangShou)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsFangQiYangShou))
	call TriggerAddAction(t, function FangQiYangShou)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_DEATH )
	call TriggerAddCondition(t, Condition(function IsWanChengYangShou))
	call TriggerAddAction(t, function WanChengYangShou)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(t, Condition(function IsQiuHun))
	call TriggerAddAction(t, function QiuHun_Action)
	set t = CreateTrigger()
	call TriggerAddRect(t, botong)
	call TriggerAddCondition(t, Condition(function IsQiuHunWan))
	call TriggerAddAction(t, function QiuHunWanCheng)
	set Io = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Io, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Io, Condition(function QJ))
	call TriggerAddAction(Io, function RJ)
	set lo = CreateTrigger()
	call TriggerAddRect(lo, Bg)
	call TriggerAddCondition(lo, Condition(function TJ))
	call TriggerAddAction(lo, function UJ)
	set Jo = CreateTrigger()
	call TriggerAddRect(Jo, Xe)
	call TriggerAddCondition(Jo, Condition(function WJ))
	call TriggerAddAction(Jo, function XJ)
	set Ko = CreateTrigger()
	call TriggerAddRect(Ko, Pe)
	call TriggerAddCondition(Ko, Condition(function ZJ))
	call TriggerAddAction(Ko, function dK)
	set Lo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Lo, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Lo, Condition(function fK))
	call TriggerAddAction(Lo, function gK)
	set Mo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Mo, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Mo, Condition(function iK))
	call TriggerAddAction(Mo, function jK)
	set No = CreateTrigger()
	call TriggerAddRect(No, Te)
	call TriggerAddCondition(No, Condition(function mK))
	call TriggerAddAction(No, function nK)
	set Oo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Oo, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(Oo, Condition(function pK))
	call TriggerAddAction(Oo, function qK)
	set Po = CreateTrigger()
	call TriggerAddRect(Po, Ve)
	call TriggerAddCondition(Po, Condition(function sK))
	call TriggerAddAction(Po, function tK)
	set Qo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Qo, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(Qo, Condition(function vK))
	call TriggerAddAction(Qo, function wK)
	set Ro = CreateTrigger()
	call TriggerAddRect(Ro, Xe)
	call TriggerAddCondition(Ro, Condition(function yK))
	call TriggerAddAction(Ro, function zK)
	set So = CreateTrigger()
	call TriggerAddRect(So, Ye)
	call TriggerAddCondition(So, Condition(function aK))
	call TriggerAddAction(So, function BK)
	// 杀10个西域邪教单位
	set To = CreateTrigger()
	call TriggerRegisterPlayerUnitEventSimple(To, Player(6), EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(To, Condition(function CK))
	call TriggerAddAction(To, function cK)
	// 押镖三次奖励
	set Uo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Uo, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Uo, Condition(function EK))
	call TriggerAddAction(Uo, function FK)
	//接杀熊、桃花岛哑仆的任务
	set Vo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Vo, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Vo, Condition(function HK))
	call TriggerAddAction(Vo, function IK)
	
	//升10级自动奖励丹药
	set Yo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Yo, EVENT_PLAYER_HERO_LEVEL)
	call TriggerAddCondition(Yo, Condition(function PK))
	call TriggerAddAction(Yo, function QK)
	// 接断肠草任务
	set Zo = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(Zo, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(Zo, Condition(function SK))
	call TriggerAddAction(Zo, function TK)
	// 生成断肠草
	set dp = CreateTrigger()
	call TriggerRegisterTimerEventSingle(dp, 1.)
	call TriggerAddAction(dp, function WK)
	// 采集到断肠草
	set ep = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(ep, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(ep, Condition(function YK))
	call TriggerAddAction(ep, function ZK)
	// 完成断肠草任务
	set fp = CreateTrigger()
	call TriggerAddRect(fp, lg)
	call TriggerAddCondition(fp, Condition(function eL))
	call TriggerAddAction(fp, function fL)
	// 重新生成断肠草
	set gp = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(gp, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(gp, Condition(function hL))
	call TriggerAddAction(gp, function iL)
	// 护送耶律楚材任务
	set hp = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(hp, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(hp, Condition(function kL))
	call TriggerAddAction(hp, function mL)
	// 护送耶律楚材任务失败
	set jp = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(jp, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(jp, Condition(function oL))
	call TriggerAddAction(jp, function pL)
	// 完成护送耶律楚材任务
	set kp = CreateTrigger()
	call TriggerAddRect(kp, gh)
	call TriggerAddCondition(kp, Condition(function rL))
	call TriggerAddAction(kp, function sL)
	// 高昌迷宫任务
	set mp = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(mp, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(mp, Condition(function uL))
	call TriggerAddAction(mp, function vL)
	// 完成高昌迷宫任务
	set np = CreateTrigger()
	call TriggerAddRect(np, kh)
	call TriggerAddCondition(np, Condition(function xL))
	call TriggerAddAction(np, function yL)
	//辽国第一先锋任务+拯救阿紫任务
	set op = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(op, EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(op, Condition(function AL))
	call TriggerAddAction(op, function aL)
	// 击败辽国第一先锋、丁春秋、阿紫
	set pp = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(pp, EVENT_PLAYER_UNIT_DEATH)
	call TriggerAddCondition(pp, Condition(function bL))
	call TriggerAddAction(pp, function CL)
	// 完成辽国军心任务
	set qp = CreateTrigger()
	call TriggerAddRect(qp, Ye)
	call TriggerAddCondition(qp, Condition(function DL))
	call TriggerAddAction(qp, function EL)
	
	// 狼皮任务
	
	// 完成狼皮任务
	set t = CreateTrigger()
	// -4885,424
	// 1939,-2738
	call TriggerAddRect(t, Rect(1768., - 2500., 2088., - 2826.))
	// call TriggerAddRect(t,Rect(-5056.,192.,-4736.,512.))
	call TriggerAddCondition(t, Condition(function isFinishWolfSkin))
	call TriggerAddAction(t, function finishWolfSkin)
	
	// 倚天剑任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function IsYiTian))
	call TriggerAddAction(t, function YiTian)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_DEATH )
	call TriggerAddCondition(t, Condition(function IsWanChengYiTian))
	call TriggerAddAction(t, function WanChengYiTian)
	
	// 全真专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isQuanZhenOnly))
	call TriggerAddAction(t, function quanZhenOnly)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_DEATH )
	call TriggerAddCondition(t, Condition(function isLcyAndWcy))
	call TriggerAddAction(t, function lcyAndWcy)
	
	// 慕容专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isMuRongOnly))
	call TriggerAddAction(t, function muRongOnly)
	
	// 恒山专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isHengShanOnly))
	call TriggerAddAction(t, function hengShanOnly)
	
	// 华山专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isHuaShanOnly))
	call TriggerAddAction(t, function huaShanOnly)
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_DEATH )
	call TriggerAddCondition(t, Condition(function isLingHuChongDeath))
	call TriggerAddAction(t, function lingHuChongDeath)
	
	// 神龙教专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isShenLongOnly))
	call TriggerAddAction(t, function shenLongOnly)
	
	// 衡山派专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isHengShan2Only))
	call TriggerAddAction(t, function hengShan2Only)
	
	// 泰山派专属任务
	set t = CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_PICKUP_ITEM )
	call TriggerAddCondition(t, Condition(function isTaiShanOnly))
	call TriggerAddAction(t, function taiShanOnly)
	
	set t = null
endfunction
