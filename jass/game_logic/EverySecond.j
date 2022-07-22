globals
	integer passed_time = 0 // 游戏时间
	integer next_endless_time = 3600 // 下一次无尽BOSS进攻的时间
	integer endless_count = 0 // 已经成功挑战的无尽BOSS次数
	timer endless_timer
endglobals



function EverySecond_Conditions takes nothing returns boolean
	local integer i = 1
	local string s = ""
	local timer t 
	local timerdialog tg
	set passed_time = passed_time + 1
	if passed_time == 40 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,20,"|cfffff000欢迎来到|cffff00de决战江湖|r")
		// 获取服务器全局存档，信息提示
		set info = DzAPI_Map_GetMapConfig("info")
		if info != "无" then
			call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,20,"|CFF00FFFF公告：|r|cffff00de"+info+"|r")
			call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,20,"|CFF00FFFF公告：|r|cffff00de"+info+"|r")
			call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS,20,"|CFF00FFFF公告：|r|cffff00de"+info+"|r")
		endif
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r按|CFF00EE00F9|r进入任务面板可查看游戏各个系统|r")
	elseif passed_time == 60 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r选择人物后直接回城（hg）可以选择自由门派|r")
	elseif passed_time == 80 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r基地右侧的NPC|CFF00EE00新手教官|r处查看游戏中的特殊玩法|r")
		call PingMinimapForForce(bj_FORCE_ALL_PLAYERS, 398, -689, 5)
	elseif passed_time == 120 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r游戏开始2分钟内输入|CFF00EE00sw|r可激活试玩模式，一小时内不刷进攻怪|r")
	elseif passed_time == 160 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r历练是游戏中的主线任务，想快点提升伤害，请抓紧时间历练哦|r")
	elseif passed_time == 180 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r声望是影响历练进度最重要的属性，可以通过号令天下令刷练功房提高声望获取速度|r")
	elseif passed_time == 200 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r前期做|CFF00EE00辽国第一先锋|r任务、击杀|CFF00EE00林朝英|r和|CFF00EE00扫地神僧|r可以获得不错的声望|r")
	elseif passed_time == 220 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r|CFF00EE004个门派技能|r升级到|CFF00EE006重|r后可以获得掌门（唐门六合经为1重，明教乾坤大挪移为4重）|r")
	elseif passed_time == 240 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r搭配某些武功到达特定重数可以获得称号，游戏中有多达|CFF00EE0060多种|r称号（|CFF00EE00新手教官|r处查看）|r")
	elseif passed_time == 280 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r|CFF00EE00称号|r可以大幅提升属性，部分称号还可以使特定武功变强|r")
	elseif passed_time == 320 then
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r历练5后可以到NPC|CFF00EE00游坦之|r处自创武功")
		call PingMinimapForForce(bj_FORCE_ALL_PLAYERS, -9000, -13169, 5)
		if tiaoZhanIndex == 3 then
			set udg_boshu = 28
			call SetPlayerTechResearched(Player(12),'R001',50)
			call SetPlayerTechResearched(Player(6),'R001',50)
			call SetPlayerTechResearched(Player(15),'R001',50)
			call setDifficultyAndExpRate(6)	
			call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 20, "|CFF00FFFF提示：|r已自动提升至最高难度")
		endif
	endif
	// 每秒为最终boss清除一次负面状态
	if ModuloInteger(passed_time, 1) == 0 and udg_boss[7] != null then
		call UnitRemoveBuffs( udg_boss[7], true, true )
	endif
	
	if tiaoZhanIndex == 3 and passed_time == next_endless_time then
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS,"|CFFFF0033无尽BOSS即将发起进攻，请作好防守准备")
		call CreateNUnitsAtLocFacingLocBJ(1,u7[8],Player(6),v7[6],v7[4])
		set udg_boss[7] = bj_lastCreatedUnit
		set t = CreateTimer()
		call TimerStart(t,20,true,function BOSSChengZhang)
		set endless_timer = CreateTimer()
		set tg = CreateTimerDialogBJ(endless_timer, "|CFF00FFFF无尽BOSS时间：")
		call TimerDialogDisplay(tg, true)
		call SaveInteger(YDHT, GetHandleId(endless_timer), 0, endless_count)
		call SaveTimerDialogHandle(YDHT, GetHandleId(endless_timer), 1, tg)
		call TimerStart(endless_timer, 300, false, function endlessFail)
		
		call GroupAddUnit(w7, bj_lastCreatedUnit)
		call IssuePointOrderByIdLoc(bj_lastCreatedUnit, $D000F, v7[4])
		set next_endless_time = passed_time + 600
	endif
	
	loop
	exitwhen i > 5
		// 宠物技能 账号信息
		if P4[i] != null and IsUnitAliveBJ(P4[i]) then
			call SetUnitAbilityLevel(P4[i], 'A0EO', i)
			set s = "地图等级：|cff00ff00"+ I2S(DzAPI_Map_GetMapLevel(Player(i - 1))) +"|r"
			set s = s + "｜排名：|cff00ff00"+ I2S(DzAPI_Map_GetMapLevelRank(Player(i-1))) + "|r|n"
			set s = s + "单通门派：|cff00ff00" + I2S(LoadInteger(YDHT, i, StringHash("单通门派数量"))) + "|r"
			set s = s + "｜多通门派：|cff00ff00" + I2S(LoadInteger(YDHT, i, StringHash("多通门派数量"))) + "|r|n"
			set s = s + "最大无尽BOSS数：|cff00ff00" + I2S(decryptInt(DzAPI_Map_GetStoredString(Player(i - 1),"endless"), Player(i - 1))) + "|r"
			call YDWESetUnitAbilityDataString( P4[i], 'A0EO', i, 218, s )
		endif
		
		// 碧波心经点数
		if Player(i - 1) == GetLocalPlayer() then
			call bibo_text.setText(I2S(LoadInteger(YDHT, GetHandleId(udg_hero[i]), BI_BO_POINT)))
		endif
		// 每隔30秒切换一次潮起潮落的状态
		if ModuloInteger(passed_time, 30) == 0 then
			set tide_rising[i] = not tide_rising[i]
		endif
		if GetUnitAbilityLevel(udg_hero[i], BI_BO_XIN_JING) >= 1 then
			set s = "|cffffff00桃花岛心法|r|n"
			set s = s + "黄药师纪念亡妻所创的碧海潮生曲谱中演变而来,“大海浩淼,万里无波,洪涛汹涌,白浪连山,极尽变幻,隐伏凶险”。|n"
			set s = s + "每隔30秒切换一次潮起和潮落状态：潮起时使用，消耗5点心经点数，永久增加招式伤害、内力和真实伤害，潮落时使用，消耗3点心经点数，暂时提升攻速和移速。（剩余点数见小地图左上角）|n"
			set s = s + "每击杀N个敌人获得1点心经点数，N等于当前心经点数（最小为10）|n|n"
			if tide_rising[i] then
				set s = s + "当前状态：|cffdddd00潮起|r|n"
			else
				set s = s + "当前状态：|cff00dd00潮落|r|n"
			endif
			set s = s + "|cff808080|n|r|cffadff2f服用九花玉露丸：|r心经点数+10|n|cffadff2f+奇门术数：|r击杀敌人获得心经点数翻倍|n|cffadff2f+打狗棒法：|rCD减半|n"
			call YDWESetUnitAbilityDataString( udg_hero[i], BI_BO_XIN_JING, 1, 218, s )
		endif
		set i = i + 1
	endloop
	set t = null
	return false
endfunction




function EverySecond takes nothing returns nothing
	local trigger t = CreateTrigger()
	
	call TriggerRegisterTimerEventPeriodic(t, 1.)
	call TriggerAddCondition(t,Condition(function EverySecond_Conditions))
	set t = null
endfunction
