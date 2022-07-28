// 武功升重系统
function isTitle takes integer i, integer title returns boolean
	if title <= 30 then
		return YDWEBitwise_AND(title0[i], YDWEBitwise_LShift(1, title - 1)) != 0
	else
		return YDWEBitwise_AND(title1[i], YDWEBitwise_LShift(1, title - 31)) != 0
	endif
endfunction

/*
* 设置称号
* 1 扫地神僧
* 2 达摩祖师
* 3 大轮明王
* 4 金轮法王
* 5 神雕侠
* 6 小龙女
* 7 神雕侠侣
* 8 赤炼仙子
* 9 北丐
* 10 北乔峰
* 11 君子剑
* 12 风清扬
* 13 老顽童
* 14 中神通
* 15 血刀老祖
* 16 空心菜
* 17 仪琳
* 18 笑傲江湖
* 19 芷若
* 20 小东邪
* 21 邋遢仙人
* 22 张三丰
* 23 星宿老仙
* 24 天山童姥
* 25 虚竹子
* 26 慕容龙城
* 27 白眉鹰王
* 28 青翼蝠王
* 29 金毛狮王
* 30 无忌
* 31 莫大先生
* 32 神龙教主
* 33 教主夫人
* 34 天门道长
* 35 铁掌水上漂
* 36 搜魂侠
* 37 九阴真人
* 38 西毒
* 39 东邪
* 40 南帝
* 41 瑶琴
* 42 小虾米
* 43 郭大侠
* 44 神仙姐姐
* 45 婆婆姊姊
* 46 女中诸葛
* 47 爵爷
* 48 石破天惊
* 49 绍敏郡主
*/
function setTitleNumber takes integer i, integer title returns nothing
	if title <= 30 then
		set title0[i] = YDWEBitwise_OR(title0[i], YDWEBitwise_LShift(1, title - 1))
	else
		set title1[i] = YDWEBitwise_OR(title1[i], YDWEBitwise_LShift(1, title - 31))
	endif
endfunction

function isChief takes integer i, integer denomination returns boolean
	return YDWEBitwise_AND(chief[i], YDWEBitwise_LShift(1, denomination - 1)) != 0
endfunction

/*
* 设置掌门
* 1 少林
* 2 古墓
* 3 丐帮
* 4 华山
* 5 全真
* 6 血刀
* 7 恒山
* 8 峨眉
* 9 武当
* 10 星宿
* 11 自由
* 12 灵鹫
* 13 慕容
* 14 明教
* 15 衡山
* 16 神龙
* 17 神龙（女）
* 18 泰山
* 19 铁掌
* 20 唐门
* 21 五毒
* 22 桃花岛
* 23 野螺派
* 24 雪山派
* 25 汝阳王府
*/
function setChiefNumber takes integer i, integer denomination returns nothing
	set chief[i] = YDWEBitwise_OR(chief[i], YDWEBitwise_LShift(1, denomination - 1))
endfunction

function QiJueCoefficient takes unit u returns integer
	// 是否激活九阳真经残卷
	local integer jyd = JYd[1 + GetPlayerId(GetOwningPlayer(u))]
	// 是否有王语嫣称号
	local boolean wyy = isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 44)
	
	// 九阳残卷、七绝、王语嫣400%升重
	if (UnitHaveItem(u, 'I01J') or UnitHaveItem(u, 'I0DB')) and jyd == 1 and wyy then
		return 8
	endif
	// 九阳残卷、王语嫣300%升重
	if jyd == 1 and wyy then
		return 6
	endif
	// 九阳残卷和七绝200%升重，王语嫣和七绝200%升重
	if (UnitHaveItem(u, 'I01J') or UnitHaveItem(u, 'I0DB')) and (jyd == 1 or wyy) then
		return 4
	endif
	// 九阳残卷100%升重，王语嫣100%升重
	if jyd == 1 or wyy then
		return 2
	endif
	// 七绝或新手神器50%升重
	if UnitHaveItem(u, 'I01J') or UnitHaveItem(u, 'I0DB') or jyd == 1 then
		return 1
	endif
	return 0
endfunction

function IncAbilityAndItemCharge takes unit u, integer id returns nothing
	local integer i = 0
	call IncUnitAbilityLevel(u, id)
	loop
		exitwhen i >= 6
		if GetItemTypeId(UnitItemInSlot(u, i)) == ITEM_HAN_SHA then
			call SetItemCharges(UnitItemInSlot(u, i), GetItemCharges(UnitItemInSlot(u, i)) + 1)
		endif
		set i = i + 1
	endloop
endfunction

function kungfuLevelUp takes unit u, integer id, real r returns nothing
	local integer level = GetUnitAbilityLevel(u, id)
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer needExp = level * level * R2I(r) / 6 // 升级所需经验
	local integer baseExp = (20 + udg_xinggeA[i] + wuxing[i] / 3) * 2 // 基础经验
	local real extraTimes = 1
	local integer realExp = 0
	local integer add = 0

	// 慕容家训
	if UnitHasBuffBJ(u, 'B010') then
		set extraTimes = extraTimes + 0.1 * GetUnitAbilityLevel(u, 'A02V')
	endif

	// 精武师九重武学影响
	set extraTimes = extraTimes + udg_jwjs[i] * 0.1

	// 天赋：天纵奇才 增加升重速度
	if UnitHasBuffBJ(u, 'B01O') then
		set extraTimes = extraTimes + 0.2 + 0.1 * bigTalent[i]
	endif 

	// 七绝护符或新手神器增加升重速度
	if UnitHaveItem(u, 'I01J') or UnitHaveItem(u, 'I0DB') then
		set extraTimes = extraTimes + 0.2
	endif

	// 激活九阳真经残卷
	if JYd[i] == 1 then
		set extraTimes = extraTimes + 0.4
	endif

	// 神仙姐姐称号增加升重速度
	if isTitle(i, 44) then
		set extraTimes = extraTimes + 0.4
	endif

	set realExp = R2I(baseExp * extraTimes)

	if level > 0 and level < 9 then
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id, LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id) + realExp)
		call SaveStr(YDHT, GetHandleId(GetOwningPlayer(u)), id * 2, I2S(LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id)) + "/" + I2S(needExp))
	endif

	if level > 0 and (level < 9 or  (id == 'A07W' and level < 7)) and LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id) >= needExp then
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id, LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id) - needExp)
		call IncAbilityAndItemCharge(u, id)
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), id * 5, GetUnitAbilityLevel(u, id))
		if GetPlayerController(p) == MAP_CONTROL_USER then
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "领悟了武功：" + GetObjectName(id) + "第" + I2S(level + 1) + "重")
		endif
				
		if id == 'A0DP' then // 归元吐纳功
			set fuyuan[i] = fuyuan[i] + 2
			set gengu[i] = gengu[i] + 2
			set wuxing[i] = wuxing[i] + 2
			set jingmai[i] = jingmai[i] + 2
			set danpo[i] = danpo[i] + 2
			set yishu[i] = yishu[i] + 2
		endif
		if level + 1 == 9 and Deputy_isDeputy(i, JING_WU) then
			set wuxuedian[i] = wuxuedian[i] + 2
			call DisplayTextToPlayer(p, 0, 0, "|cff66ff00精武师有技能升级到九重，获得两个自创武学点")
			if ( udg_jwjs[i] <= 2 ) and not Deputy_isMaster(i, JING_WU) then
				set udg_jwjs[i] = udg_jwjs[i] + 1
				call DisplayTextToPlayer(p, 0, 0, "|CFF66FF00恭喜您练成第" + I2S(udg_jwjs[i]) + "个九重武功，练成3个可获得宗师哦")
			endif
			if ( udg_jwjs[i] == 3 ) and not Deputy_isMaster(i, JING_WU) then
				call Deputy_setMaster(i, JING_WU)
				call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15, "|CFF66FF00恭喜" + GetPlayerName(p) + "获得精武宗师")
				call SetPlayerName(p, "〓精武宗师〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			endif
		endif

		// 嫁衣神功 增加悟性和伤害倍数
		if level + 1 == 9 and GetUnitAbilityLevel(u, JIA_YI_SHEN_GONG) > 0 then
			set add = (GetUnitAbilityLevel(u, JIA_YI_SHEN_GONG) + 3) / 2
			if isTitle(i, 49) then
				// 绍敏郡主称号 增加值翻倍
				set add = add * 2
			endif
			if Deputy_isMaster(i, YA_HUAN) then
				// 郡主称号 增加值翻倍
				set add = add * 2
			endif
			set wuxing[i] = wuxing[i] + add
			set udg_shanghaijiacheng[i] = udg_shanghaijiacheng[i] + add * 0.005
			call DisplayTextToPlayer(p, 0, 0, "|cffffcc00发动了嫁衣神功，悟性增加了" + I2S(add) + "点，伤害加成增加了" + R2S(add * 0.005) + "倍")
		endif
	endif

	set p = null
endfunction



// 成为掌门
function becomeChief takes unit u, integer denomination, string title, integer strAward, integer agiAward, integer intAward returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer special0 = 6
	local integer special1 = 6
	local string awardStr = ""
	if denomination == 14 then // 明教
		set special1 = 4
	elseif denomination == 20 then // 唐门
		set special0 = 1
	endif
	if strAward > 0 then
		set awardStr = awardStr + "|cffffcc00，招式伤害增加了" + I2S(strAward) + "点"
	endif
	if agiAward > 0 then
		set awardStr = awardStr + "|cffffcc00，内力增加了" + I2S(agiAward) + "点"
	endif
	if intAward > 0 then
		set awardStr = awardStr + "|cffffcc00，真实伤害增加了" + I2S(intAward) + "点"
	endif
	if denomination == 25 then // 汝阳王府
		if not isChief(i, 25) and (GetUnitAbilityLevel(u, denomFourth[25]) >= 6 or GetUnitAbilityLevel(u, denomFifth[25]) >= 6) then
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：" + title + awardStr)
			if strAward > 0 then
				call ModifyHeroStat(0, u, 0, strAward)
			endif
			if agiAward > 0 then
				call ModifyHeroStat(1, u, 0, agiAward)
			endif
			if intAward > 0 then
				call ModifyHeroStat(2, u, 0, intAward)
			endif
			call SetPlayerName(p, "〓" + title + "〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setChiefNumber(i, denomination)
		endif
		return
	endif
	if not isChief(i, denomination) and GetUnitAbilityLevel(u, denomFirst[denomination]) >= 6 and GetUnitAbilityLevel(u, denomThird[denomination]) >= 6 \
		and GetUnitAbilityLevel(u, denomSecond[denomination]) >= 6 \
		and ( GetUnitAbilityLevel(u, denomFourth[denomination]) >= special0 or GetUnitAbilityLevel(u, denomFifth[denomination]) >= special1 ) then
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：" + title + awardStr)
		if strAward > 0 then
			call ModifyHeroStat(0, u, 0, strAward)
		endif
		if agiAward > 0 then
			call ModifyHeroStat(1, u, 0, agiAward)
		endif
		if intAward > 0 then
			call ModifyHeroStat(2, u, 0, intAward)
		endif
		call SetPlayerName(p, "〓" + title + "〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call setChiefNumber(i, denomination)
	endif
	set p = null
endfunction

function determineShaoLinTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 1) then
		if GetUnitAbilityLevel(u, 'A05O') >= 1 and yishu[i] >= 32 and not isTitle(i, 1) then
			call ModifyHeroStat(1, u, 0, 720)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：扫地神僧，内力增加了720点")
			call SetPlayerName(p, "〓扫地神僧〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 1)
		endif
		// 拥有易筋A09D或洗髓A080，称号达摩，毕业技能到9级
		if GetUnitAbilityLevel(u, 'A09D') >= 1 or GetUnitAbilityLevel(u, 'A080') >= 1 and not isTitle(i, 2) then
			call SetPlayerName(p, "〓达摩祖师〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(1, u, 0, 220)
			call ModifyHeroStat(2, u, 0, 200)
			if ( GetUnitAbilityLevel(u, 'A05O') >= 6 ) then
				call SetUnitAbilityLevel(u, 'A05O', 9)
				call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：达摩祖师，招式伤害增加了200点，内力增加了220点，真实伤害增加了200点，武功" + GetObjectName('A05O') + "提升到9重")
			elseif ( GetUnitAbilityLevel(u, 'S000') >= 6 ) then
				call SetUnitAbilityLevel(u, 'S000', 9)
				call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：达摩祖师，招式伤害增加了200点，内力增加了220点，真实伤害增加了200点，武功" + GetObjectName('S000') + "提升到9重")
			endif
			call setTitleNumber(i, 2)
		endif
		// 小无相、无相劫指、悟性31以上
		if GetUnitAbilityLevel(u, 'A083') >= 1 or GetUnitAbilityLevel(u, 'A03P') >= 1 and wuxing[i] >= 31 and not isTitle(i, 3) then
			call SetPlayerName(p, "〓大轮明王〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 200)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：大轮明王，招式伤害增加了200点，内力增加了200点，真实伤害增加了200点")
			call setTitleNumber(i, 3)
		endif
		// 龙象，根骨31
		if GetUnitAbilityLevel(u, 'S002') >= 1 and gengu[i] >= 31 and not isTitle(i, 4) then
			call SetPlayerName(p, "〓金轮法王〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 200)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：金轮法王，招式伤害增加了200点，内力增加了200点，真实伤害增加了200点")
			call setTitleNumber(i, 4)
		endif
	endif
	set p = null
endfunction

function determineGuMuTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 2) then
		if GetUnitAbilityLevel(u, 'A07G') >= 1 and UnitHaveItem(u , 'I099') and not isTitle(i, 5) then
			call ModifyHeroStat(0, u, 0, 480)
			call SetUnitAbilityLevel(u, 'A07G', IMinBJ(GetUnitAbilityLevel(u, 'A07G') + 3, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：神雕侠，招式伤害增加了480点，武功" + GetObjectName('A07G') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07G') + 3, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07G' * 5, GetUnitAbilityLevel(u, 'A07G'))
			call SetPlayerName(p, "〓神雕侠〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 5)
		endif
		if GetUnitAbilityLevel(u, 'A07U') >= 1 and UnitHaveItem(u , 'I09A') and not isTitle(i, 6) then
			call ModifyHeroStat(2, u, 0, 600)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：小龙女，真实伤害增加了600点")
			call SetPlayerName(p, "〓小龙女〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 6)
		endif
		if GetUnitAbilityLevel(u, 'A07G') >= 1 and GetUnitAbilityLevel(u, 'A07U') >= 1 and UnitHaveItem(u, 'I09C') and not isTitle(i, 7) then
			call ModifyHeroStat(0, u, 0, 480)
			call ModifyHeroStat(2, u, 0, 600)
			call SetUnitAbilityLevel(u, 'A07G', IMinBJ(GetUnitAbilityLevel(u, 'A07G') + 6, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：神雕侠侣，招式伤害增加了480点，真实伤害增加了600点，武功" + GetObjectName('A07G') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07G') + 6, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07G' * 5, GetUnitAbilityLevel(u, 'A07G'))
			call SetPlayerName(p, "〓神雕侠侣〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			// 送神雕
			call unitadditembyidswapped('I04A' , u)
			call setTitleNumber(i, 7)
		endif
		if GetUnitAbilityLevel(u, 'A07A') >= 6 and not isTitle(i, 8) then
			call SetPlayerName(p, "〓赤炼仙子〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(1, u, 0, 400)
			call SetUnitAbilityLevel(u, 'A07A', 9)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：赤炼仙子，内力增加了400点，武功" + GetObjectName('A07A') + "提升到9重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07A' * 5, GetUnitAbilityLevel(u, 'A07A'))
			call setTitleNumber(i, 8)
		endif
	endif
	set p = null
endfunction

function determineGaiBangTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 3) then
		// 学降龙、打狗，带打狗棒
		if GetUnitAbilityLevel(u, 'A07L') >= 1 and GetUnitAbilityLevel(u, 'A07E') >= 1 and UnitHaveItem(u , 'I097') and not isTitle(i, 9) then
			call ModifyHeroStat(0, u, 0, 480)
			call SetUnitAbilityLevel(u, 'A07L', IMinBJ(GetUnitAbilityLevel(u, 'A07L') + 4, 9))
			call SetUnitAbilityLevel(u, 'A07E', IMinBJ(GetUnitAbilityLevel(u, 'A07E') + 4, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：北丐，招式伤害增加了480点，武功" + GetObjectName('A07L') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07L') + 4, 9)) + "重，" + GetObjectName('A07E') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07E') + 4, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07L' * 5, GetUnitAbilityLevel(u, 'A07L'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07E' * 5, GetUnitAbilityLevel(u, 'A07E'))
			call SetPlayerName(p, "〓北丐〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 9)
		endif
		// 降龙3级以上，拥有擒龙控鹤，带打狗棒
		if GetUnitAbilityLevel(u, 'A07E') >= 3 and GetUnitAbilityLevel(u, 'A03V') > 0 and UnitHaveItem(u , 'I097') and not isTitle(i, 10) then
			call ModifyHeroStat(0, u, 0, 500)
			call ModifyHeroStat(1, u, 0, 500)
			call ModifyHeroStat(2, u, 0, 500)
			// 降龙奖励到9级
			call SetUnitAbilityLevel(u, 'A07E', 9)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：北乔峰，招式伤害增加了500点，真实伤害增加了500点，武功" + GetObjectName('A07E') + "提升到9重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07L' * 5, GetUnitAbilityLevel(u, 'A07L'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07E' * 5, GetUnitAbilityLevel(u, 'A07E'))
			call SetPlayerName(p, "〓北乔峰〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 10)
		endif
	endif
	set p = null
endfunction

function determineHuaShanTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 4) then
		if GetUnitAbilityLevel(u, 'A07T') >= 1 and GetUnitAbilityLevel(u, 'A07J') >= 1 and not isTitle(i, 11) then
			call ModifyHeroStat(0, u, 0, 600)
			call SetUnitAbilityLevel(u, 'A07J', 9) // 辟邪剑法9级
			call unitadditembyidswapped('I069' , u) // 送辟邪残章
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：君子剑，招式伤害增加了600点，武功" + GetObjectName('A07J') + "提升到9重，获得辟邪剑法残章")
			call SetPlayerName(p, "〓君子剑〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 11)
		endif
		// 风清扬，学会5级独孤九剑
		if GetUnitAbilityLevel(u, 'A07F') >= 5 and not isTitle(i, 12) then
			call ModifyHeroStat(0, u, 0, 250)
			call ModifyHeroStat(1, u, 0, 250)
			call ModifyHeroStat(2, u, 0, 200)
			call SetUnitAbilityLevel(u, 'A07F', 9) // 独孤九剑9级
			call unitadditembyidswapped('I066' , u) // 送独孤残章
			// 送仙鹤
			call unitadditembyidswapped('I04B' , u)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：风清扬，招式伤害增加了250点，内力增加了250点，真实伤害增加了250点，武功" + GetObjectName('A07F') + "提升到9重，获得独孤九剑残章，获得伴侣仙鹤")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07F' * 5, GetUnitAbilityLevel(u, 'A07F'))
			call SetPlayerName(p, "〓风清扬〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 12)
		endif
	endif
	set p = null
endfunction

function determineQuanZhenTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 5) then
		if GetUnitAbilityLevel(u, 'A017') >= 1 and GetUnitAbilityLevel(u, 'A07U') >= 1 and GetUnitAbilityLevel(u, 'A0D1') >= 1 and not isTitle(i, 13) then
			call ModifyHeroStat(1, u, 0, 360)
			call SetUnitAbilityLevel(u, 'A017', 9)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：老顽童，内力增加了360点，武功" + GetObjectName('A017') + "提升到9重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A017' * 5, GetUnitAbilityLevel(u, 'A017'))
			call SetPlayerName(p, "〓老顽童〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 13)
		endif
		if GetUnitAbilityLevel(u, 'A06P') >= 1 and GetUnitAbilityLevel(u, 'A07S') >= 1 and GetUnitAbilityLevel(u, 'A0CH') >= 1 and not isTitle(i, 14) then
			call ModifyHeroStat(0, u, 0, 300)
			call ModifyHeroStat(1, u, 0, 300)
			call ModifyHeroStat(2, u, 0, 300)
			call SetUnitAbilityLevel(u, 'A0CH', 9)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：中神通，招式伤害增加了300点，内力增加了300点，真实伤害增加了300点，武功" + GetObjectName('A0CH') + "提升到9重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0CH' * 5, GetUnitAbilityLevel(u, 'A0CH'))
			call SetPlayerName(p, "〓中神通〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 14)
		endif
	endif
	set p = null
endfunction

function determineXueDaoTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 6) then
		if UnitHaveItem(u , 'I098') and not isTitle(i, 15) then
			call ModifyHeroStat(0, u, 0, 480)
			// 一刀绝空加2级
			call SetUnitAbilityLevel(u, 'A0DH', IMinBJ(GetUnitAbilityLevel(u, 'A0DH') + 2, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：血刀老祖，招式伤害增加了480点，武功" + GetObjectName('A0DH') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A0DH') + 2, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0DH' * 5, GetUnitAbilityLevel(u, 'A0DH'))
			call SetPlayerName(p, "〓血刀老祖〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 15)
		endif
		if GetUnitAbilityLevel(u, 'A07X') >= 1 and GetUnitAbilityLevel(u, 'A06J') >= 1 and GetUnitAbilityLevel(u, 'A071') >= 1 and not isTitle(i, 16) then
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 360)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：空心菜，招式伤害增加了200点，真实伤害增加了360点，内力增加了200点，暴击伤害增加500%")
			call SetPlayerName(p, "〓空心菜〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			// 爆伤+500%
			set	udg_baojishanghai[i] = udg_baojishanghai[i] + 5.0
			call setTitleNumber(i, 16)
		endif
	endif
	set p = null
endfunction

function determineHengShanTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 7) then
		// 前3个技能大于等于7级，获得仪琳称号
		if GetUnitAbilityLevel(u, 'A01Z') >= 7 and GetUnitAbilityLevel(u, 'A021') >= 7 and GetUnitAbilityLevel(u, 'A0CD') >= 7 and not isTitle(i, 17) then
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 200)
			// 拂尘到9级
			call SetUnitAbilityLevel(u, 'A01Z', 9)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：仪琳，内力增加了200点，真实伤害增加了200点，武功" + GetObjectName('A01Z') + "提升到9重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A01Z' * 5, GetUnitAbilityLevel(u, 'A01Z'))
			call SetPlayerName(p, "〓仪琳〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 17)
		endif
		if GetUnitAbilityLevel(u, 'A07F') >= 1 and GetUnitAbilityLevel(u, 'A09D') >= 1 and GetUnitAbilityLevel(u, 'A07R') >= 1 and GetUnitAbilityLevel(u, 'A08W') >= 1 and not isTitle(i, 18) then
			call SetPlayerName(p, "〓笑傲江湖〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(0, u, 0, 480)
			call ModifyHeroStat(1, u, 0, 500)
			call ModifyHeroStat(2, u, 0, 600)
			call SetUnitAbilityLevel(u, 'A07F', 9)
			call SetUnitAbilityLevel(u, 'A08W', IMinBJ(GetUnitAbilityLevel(u, 'A08W') + 5, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：笑傲江湖，招式伤害增加了480点，真实伤害增加了500点，内力增加了600点，武功" + GetObjectName('A07F') + "提升到9重，" + GetObjectName('A08W') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A08W') + 5, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07F' * 5, GetUnitAbilityLevel(u, 'A07F'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A08W' * 5, GetUnitAbilityLevel(u, 'A08W'))
			call setTitleNumber(i, 18)
		endif
	endif
	set p = null
endfunction

function determineEMeiTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 8) then
		if GetUnitAbilityLevel(u, 'A07N') >= 1 and UnitHaveItem(u , 'I00B') and not isTitle(i, 19) then
			call ModifyHeroStat(0, u, 0, 480)
			// 九阴白骨爪加2级
			call SetUnitAbilityLevel(u, 'A07N', IMinBJ(GetUnitAbilityLevel(u, 'A07N') + 2, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：芷若，招式伤害增加了480点，武功" + GetObjectName('A07N') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07N') + 2, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07N' * 5, GetUnitAbilityLevel(u, 'A07N'))
			call SetPlayerName(p, "〓芷若〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 19)
		endif
		if GetUnitAbilityLevel(u, 'A0C6') >= 1 and UnitHaveItem(u , 'I09D') and not isTitle(i, 20) then
			call ModifyHeroStat(1, u, 0, 360)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：小东邪，内力增加了360点")
			call SetPlayerName(p, "〓小东邪〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 20)
		endif
	endif
	set p = null
endfunction

function determineWuDangTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 9) then
		if GetUnitAbilityLevel(u, 'A0DN') >= 1 and GetUnitAbilityLevel(u, 'A09D') >= 1 and not isTitle(i, 21) then
			call ModifyHeroStat(1, u, 0, 420)
			// 蓝量加500
			call YDWEGeneralBounsSystemUnitSetBonus(u, 1, 0, 500)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：邋遢仙人，内力增加了420点，魔法上限增加了500点")
			call SetPlayerName(p, "〓邋遢仙人〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 21)
		endif
		// 太极拳9级，带真武剑
		if GetUnitAbilityLevel(u, 'A08R') >= 9 and UnitHaveItem(u , 'I0DK') and not isTitle(i, 22) then
			call ModifyHeroStat(0, u, 0, 300)
			call ModifyHeroStat(1, u, 0, 300)
			call ModifyHeroStat(2, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：张三丰，招式伤害增加了300点，真实伤害增加了300点，内力增加了300点")
			call SetPlayerName(p, "〓张三丰〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 22)
		endif
	endif
	set p = null
endfunction

function determineXingXiuTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 10) then
		if GetUnitAbilityLevel(u, 'A07P') >= 1 and GetUnitAbilityLevel(u, 'A083') >= 1 and not isTitle(i, 23) then
			call ModifyHeroStat(1, u, 0, 600)
			call ModifyHeroStat(2, u, 0, 300)
			if ( GetUnitAbilityLevel(u, 'A0BT') >= 6 ) then
				call SetUnitAbilityLevel(u, 'A0BT', 9)
				call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：星宿老仙，内力增加了600点，真实伤害增加了300点，武功" + GetObjectName('A0BT') + "提升到9重")
			elseif ( GetUnitAbilityLevel(u, 'A0BV') >= 6 ) then
				call SetUnitAbilityLevel(u, 'A0BV', 9)
				call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：星宿老仙，内力增加了600点，真实伤害增加了300点，武功" + GetObjectName('A0BV') + "提升到9重")
			endif
			call SetPlayerName(p, "〓星宿老仙〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 23)
		endif
	endif
	set p = null
endfunction

function determineLingJiuTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 12) then
		// 大招学八荒，同时学会生死符（冰魄加北冥）
		if GetUnitAbilityLevel(u, 'A02G') >= 6 and GetUnitAbilityLevel(u, 'A07A') >= 1 and GetUnitAbilityLevel(u, 'A082') >= 1 and not isTitle(i, 24) then
			call ModifyHeroStat(0, u, 0, 280)
			call ModifyHeroStat(1, u, 0, 280)
			call ModifyHeroStat(2, u, 0, 320)
			// 八荒奖励2级
			call SetUnitAbilityLevel(u, 'A02G', IMinBJ(GetUnitAbilityLevel(u, 'A02G') + 2, 9))
			// 如意加2级
			call SetUnitAbilityLevel(u, 'A02F', IMinBJ(GetUnitAbilityLevel(u, 'A02F') + 2, 9))
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：天山童姥，招式伤害增加了280点，内力增加了280点，真实伤害增加了320点，武功" + GetObjectName('A02G') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A02G') + 2, 9)) + "重，" + GetObjectName('A02F') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A02F') + 2, 9)) + "重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A02G' * 5, GetUnitAbilityLevel(u, 'A02G'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A02F' * 5, GetUnitAbilityLevel(u, 'A02F'))
			call SetPlayerName(p, "〓天山童姥〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 24)
		endif
		// 虚竹：北冥，冰魄，玉扳指，罗汉
		if GetUnitAbilityLevel(u, 'A07A') >= 1 and GetUnitAbilityLevel(u, 'A082') >= 1 and GetUnitAbilityLevel(u, 'A07O') >= 1 and UnitHaveItem(u, 'I0DT') and not isTitle(i, 25) then
			call ModifyHeroStat(0, u, 0, 100)
			call ModifyHeroStat(1, u, 0, 500)
			call ModifyHeroStat(2, u, 0, 100)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：虚竹子，招式伤害增加了100点，内力增加了500点，真实伤害增加了100点")
			call SetPlayerName(p, "〓虚竹子〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 25)
		endif
	endif
	set p = null
endfunction

function determineMuRongTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 13) then
		// 慕容龙城，搭配斗转
		if GetUnitAbilityLevel(u, 'A07Q') >= 1 and not isTitle(i, 26) then // +斗转星移
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(1, u, 0, 250)
			call ModifyHeroStat(2, u, 0, 200)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：慕容龙城，招式伤害增加了200点，内力增加了250点，真实伤害增加了200点")
			call SetPlayerName(p, "〓慕容龙城〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 26)
		endif
	endif
	set p = null
endfunction

function determineMingJiaoTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 14) then
		if GetUnitAbilityLevel(u, 'A030') >= 9 and not isTitle(i, 27) then
			call SetPlayerName(p, "〓白眉鹰王〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(2, u, 0, 500)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：白眉鹰王，真实伤害增加了500点")
			call setTitleNumber(i, 27)
		endif
		if GetUnitAbilityLevel(u, 'A032') >= 9 and not isTitle(i, 28) then
			call SetPlayerName(p, "〓青翼蝠王〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(1, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：青翼蝠王，内力增加了300点")
			call setTitleNumber(i, 28)
		endif
		if GetUnitAbilityLevel(u, 'A06R') >= 9 and GetUnitAbilityLevel(u, 'A07M') >= 3 and UnitHaveItem(u , 'I00D') and not isTitle(i, 29) then
			call SetPlayerName(p, "〓金毛狮王〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call SetUnitAbilityLevel(u, 'A07M', IMinBJ(GetUnitAbilityLevel(u, 'A07M') + 6, 9))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07M' * 5, GetUnitAbilityLevel(u, 'A07M'))
			call ModifyHeroStat(0, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：金毛狮王，招式伤害增加了300点，武功" + GetObjectName('A07M') + "提升到" + I2S(GetUnitAbilityLevel(u, 'A07M')) + "重")
			call setTitleNumber(i, 29)
		endif
		if GetUnitAbilityLevel(u, 'A07W') >= 6 and GetUnitAbilityLevel(u, 'A0DN') >= 1 and GetUnitAbilityLevel(u, 'A08R') >= 4 and not isTitle(i, 30) then
			call SetPlayerName(p, "〓无忌〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call SetUnitAbilityLevel(u, 'A08R', IMinBJ(GetUnitAbilityLevel(u, 'A08R') + 3, 9))
			call SetUnitAbilityLevel(u, 'A07W', 7)
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07W' * 5, GetUnitAbilityLevel(u, 'A07W'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A08R' * 5, GetUnitAbilityLevel(u, 'A08R'))
			call ModifyHeroStat(1, u, 0, 1000)
			call ModifyHeroStat(2, u, 0, 500)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：无忌，内力增加了1000点，真实伤害增加了500点，武功" + GetObjectName('A08R') + "提升到9重，" + GetObjectName('A07W') + "提升到7重，获得伴侣白猿")
			// 送白猿
			call unitadditembyidswapped('I0CS' , u)
			call setTitleNumber(i, 30)
		endif
	endif
	set p = null
endfunction

function determineHengShan2Title takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer idd = 0
	if isChief(i, 15) then
		if GetUnitAbilityLevel(u, 'A04M') >= 7 and GetUnitAbilityLevel(u, 'A04N') >= 7 and GetUnitAbilityLevel(u, 'A04P') >= 7 and not isTitle(i, 31) then
			call SetPlayerName(p, "〓莫大先生〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 31)
			set L7[i] = 1
			loop
				exitwhen L7[i] > wugongshu[i]
				if ( I7[20 * ( i - 1 ) + L7[i]] != 'AEfk' ) then
					if ( ( L7[i] == wugongshu[i] ) ) then
						call SetUnitAbilityLevel(u, 'A04M', 9)
						call SetUnitAbilityLevel(u, 'A04N', 9)
						call SetUnitAbilityLevel(u, 'A04P', 9)
						call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A04M' * 5, 9)
						call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A04N' * 5, 9)
						call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A04P' * 5, 9)
						call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：莫大先生，武功" + GetObjectName('A04M') + "提升到9重，" + GetObjectName('A04N') + "提升到9重，" + GetObjectName('A04P') + "提升到9重")
					endif
				else
					if GetUnitAbilityLevel(u, 'A026') >= 6 then
						set idd = 'A04R'
					else
						set idd = 'A026'
					endif
					call UnitAddAbility(u, idd)
					call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：莫大先生，学会武功" + GetObjectName(idd))
					call UnitMakeAbilityPermanent(u, true, idd)
					set I7[20 * ( i - 1 ) + L7[i]] = idd
					exitwhen true
				endif
				set L7[i] = L7[i] + 1
			endloop
		endif
	endif
	set p = null
endfunction

function determineShenLongTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 16) then
		// 学九阳+龙象，神龙教主
		if GetUnitAbilityLevel(u, 'A0DN') >= 1 and GetUnitAbilityLevel(u, 'S002') >= 1 and not isTitle(i, 32) then
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(1, u, 0, 400)
			call ModifyHeroStat(2, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：神龙教主，招式伤害增加了200点，内力增加了400点，真实伤害增加了300点")
			call SetPlayerName(p, "〓神龙教主〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 32)
		endif
	endif
	if isChief(i, 17) then
		// 学九阴+小无相，教主夫人
		if GetUnitAbilityLevel(u, 'A07S') >= 1 and GetUnitAbilityLevel(u, 'A083') >= 1 and not isTitle(i, 33) then
			call ModifyHeroStat(0, u, 0, 400)
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：教主夫人，招式伤害增加了400点，内力增加了200点，真实伤害增加了300点")
			call SetPlayerName(p, "〓教主夫人〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 33)
		endif
	endif
	set p = null
endfunction

function determineTaiShanTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 18) then
		// 天门道长，学会小无相
		if GetUnitAbilityLevel(u, 'A083') >= 1 and not isTitle(i, 34) then
			call ModifyHeroStat(0, u, 0, 300)
			call ModifyHeroStat(1, u, 0, 600)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：天门道长，招式伤害增加了300点，内力增加了600点")
			call SetPlayerName(p, "〓天门道长〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 34)
		endif
	endif
	set p = null
endfunction

function determineTieZhangTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 19) then
		// 学乾坤+双手+铁掌令，铁掌水上漂
		if GetUnitAbilityLevel(u, 'A07W') >= 1 and GetUnitAbilityLevel(u, 'A07U') >= 1 and UnitHaveItem(u , 'I0EJ')  and not isTitle(i, 35) then
			call ModifyHeroStat(0, u, 0, 300)
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 100)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：铁掌水上漂，招式伤害增加了300点，内力增加了200点，真实伤害增加了100点")
			call SetPlayerName(p, "〓铁掌水上漂〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 35)
		endif
	endif
	set p = null
endfunction

function determineTangMenTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 20) then
		// 学小无相+冰魄银针，搜魂侠
		if GetUnitAbilityLevel(u, 'A083') >= 1 and GetUnitAbilityLevel(u, 'A07A') >= 1 and not isTitle(i, 36) then
			call ModifyHeroStat(0, u, 0, 300)
			call ModifyHeroStat(1, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：搜魂侠，招式伤害增加了300点，内力增加了200点，真实伤害增加了300点")
			call SetPlayerName(p, "〓搜魂侠〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 36)
		endif
	endif
	set p = null
endfunction

function determineWuDuTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 21) then
		// 学龙象+葵花，婆婆姊姊
		if GetUnitAbilityLevel(u, LONG_XIANG) >= 1 and GetUnitAbilityLevel(u, KUI_HUA) >= 1 and not isTitle(i, 45) then
			call ModifyHeroStat(0, u, 0, 300)
			call ModifyHeroStat(1, u, 0, 300)
			call ModifyHeroStat(2, u, 0, 300)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：婆婆姊姊，招式伤害增加了300点，内力增加了300点，真实伤害增加了300点")
			call SetPlayerName(p, "〓婆婆姊姊〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 45)
		endif
	endif
	set p = null
endfunction

function determineTaoHuaDaoTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer idd
	if isChief(i, 22) then
		// 学九阴内功+打狗棒法，女中诸葛
		if GetUnitAbilityLevel(u, JIU_YIN) >= 1 and GetUnitAbilityLevel(u, DA_GOU) >= 1 and not isTitle(i, 46) then
			
			set wuxing[i] = wuxing[i] + 50
			set L7[i] = 1
			loop
				exitwhen L7[i] > wugongshu[i]
				if ( I7[20 * ( i - 1 ) + L7[i]] != 'AEfk' ) then
					if ( ( L7[i] == wugongshu[i] ) ) then
						call SetUnitAbilityLevel(u, 'A0EE', 9)
						call SetUnitAbilityLevel(u, 'A0EG', 9)
						call SetUnitAbilityLevel(u, 'A0EI', 9)
						call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0EE' * 5, 9)
						call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0EG' * 5, 9)
						call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0EI' * 5, 9)
						call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：女中诸葛，武功" + GetObjectName('A0EE') + "提升到9重，" + GetObjectName('A0EG') + "提升到9重，" + GetObjectName('A0EI') + "提升到9重")
					endif
				else
					if GetUnitAbilityLevel(u, 'A0EK') >= 6 then
						set idd = 'A0EL'
					else
						set idd = 'A0EK'
					endif
					call UnitAddAbility(u, idd)
					call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：女中诸葛，学会武功" + GetObjectName(idd))
					if Player(i - 1) == GetLocalPlayer() and idd == 'A0EL' then
						call qimen_widget.show()
					endif
					call UnitMakeAbilityPermanent(u, true, idd)
					set I7[20 * ( i - 1 ) + L7[i]] = idd
					exitwhen true
				endif
				set L7[i] = L7[i] + 1
			endloop
			call SetPlayerName(p, "〓女中诸葛〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 46)
		endif
		if GetUnitAbilityLevel(u, 'A06H') >= 3 and GetUnitAbilityLevel(u, 'A018') >= 3 and UnitHaveItem(u , 'I09D') and not isTitle(i, 39) then
			call SetPlayerName(p, "〓东邪〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call ModifyHeroStat(1, u, 0, 240)
			call ModifyHeroStat(2, u, 0, 300)
			call SetUnitAbilityLevel(u, 'A06H', 9)
			call SetUnitAbilityLevel(u, 'A018', 9)
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A06H' * 5, GetUnitAbilityLevel(u, 'A06H'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A018' * 5, GetUnitAbilityLevel(u, 'A018'))
			call unitadditembyidswapped('I04Q' , u)
			call unitadditembyidswapped('I04Q' , u)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：东邪，内力增加了240点，真实伤害增加了300点，武功" + GetObjectName('A06H') + "提升到9重，" + GetObjectName('A018') + "提升到9重，获得物品" + GetObjectName('I04Q') + "x2")
			call setTitleNumber(i, 39)
		endif
	endif
	set p = null
endfunction

function determineYeLuoTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 23) then
		// 学神行百变+60W金钱，爵爷
		if GetUnitAbilityLevel(u, SHEN_XING_BAI_BIAN) >= 1 and GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) >= 600000 and not isTitle(i, 47) then
			call ModifyHeroStat(0, u, 0, 400)
			call ModifyHeroStat(1, u, 0, 400)
			call ModifyHeroStat(2, u, 0, 200)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：爵爷，招式伤害增加了400点，内力增加了400点，真实伤害增加了200点")
			call SetPlayerName(p, "〓爵爷〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 47)
		endif
	endif
	set p = null
endfunction

function determineXueShanTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 24) then
		if GetUnitAbilityLevel(u, 'A07O') > 0 and GetUnitAbilityLevel(u, 'A0D8') > 0 and not isTitle(i, 48) then
			call ModifyHeroStat(0, u, 0, 400)
			call ModifyHeroStat(2, u, 0, 200)
			call SetUnitAbilityLevel(u, 'A0EZ', 9)
			call SetUnitAbilityLevel(u, 'A0EX', 9)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：石破天惊，招式伤害增加了400点，真实伤害增加了200点，武功" + GetObjectName('A0EZ') + "提升到9重，" + GetObjectName('A0EX') + "提升到9重")
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0EZ' * 5, GetUnitAbilityLevel(u, 'A0EZ'))
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0EX' * 5, GetUnitAbilityLevel(u, 'A0EX'))
			call SetPlayerName(p, "〓石破天惊〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 48)
		endif
	endif
	set p = null
endfunction

function determineRuYangTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if isChief(i, 25) then
		if touKanCounter[i] > 10 and not isTitle(i, 49) then
			call ModifyHeroStat(0, u, 0, 200)
			call ModifyHeroStat(2, u, 0, 400)
			call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：绍敏郡主，招式伤害增加了200点，真实伤害增加了400点")
			call SetPlayerName(p, "〓绍敏郡主〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
			call setTitleNumber(i, 49)
		endif
	endif
	set p = null
endfunction

function determineJiangHuTitle takes unit u returns nothing
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	if GetUnitAbilityLevel(u, 'A07S') >= 1 and GetUnitAbilityLevel(u, 'A0D2') >= 1 and GetUnitAbilityLevel(u, 'A0D6') >= 1 and GetUnitAbilityLevel(u, 'A0D4') >= 1 and GetUnitAbilityLevel(u, 'A07N') >= 4 and GetUnitAbilityLevel(u, 'A0D3') >= 4 and GetUnitAbilityLevel(u, 'A0D1') >= 4 and not isTitle(i, 37) then
		call SetPlayerName(p, "〓真·九阴真人〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(1, u, 0, 2900)
		call SetUnitAbilityLevel(u, 'A07N', 9)
		call SetUnitAbilityLevel(u, 'A0D3', 9)
		call SetUnitAbilityLevel(u, 'A0D1', 9)
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：真·九阴真人，内力增加了2900点，武功" + GetObjectName('A07N') + "提升到9重，" + GetObjectName('A0D3') + "提升到9重，" + GetObjectName('A0D1') + "提升到9重")
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07N' * 5, GetUnitAbilityLevel(u, 'A07N'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0D3' * 5, GetUnitAbilityLevel(u, 'A0D3'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0D1' * 5, GetUnitAbilityLevel(u, 'A0D1'))
		call setTitleNumber(i, 37)
	endif
	if GetUnitAbilityLevel(u, 'A089') >= 5 and GetUnitAbilityLevel(u, 'A084') >= 1 and UnitHaveItem(u , 'I09B') and not isTitle(i, 38) then
		call SetPlayerName(p, "〓西毒〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(0, u, 0, 600)
		call ModifyHeroStat(2, u, 0, 360)
		call unitadditembyidswapped('I070' , u)
		call SetUnitAbilityLevel(u, 'A089', IMinBJ(GetUnitAbilityLevel(u, 'A089') + 2, 9))
		// 奖励逆九阴
		call unitadditembyidswapped('I09G' , u)
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：西毒，招式伤害增加了600点，真实伤害增加了360点，武功" + GetObjectName('A089') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A089') + 2, 9)) + "重，获得物品：" + GetObjectName('I070') + ",获得物品：" + GetObjectName('I09G'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A089' * 5, GetUnitAbilityLevel(u, 'A089'))
		call setTitleNumber(i, 38)
	endif
	
	if GetUnitAbilityLevel(u, 'A06P') >= 5 and GetUnitAbilityLevel(u, 'A0CH') >= 3 and udg_runamen[i] != 5 and not isTitle(i, 40) then
		call SetPlayerName(p, "〓南帝〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(1, u, 0, 480)
		call ModifyHeroStat(2, u, 0, 600)
		call SetUnitAbilityLevel(u, 'A06P', 9)
		call SetUnitAbilityLevel(u, 'A0CH', 7)
		// 奖励医疗篇
		call unitadditembyidswapped('I09H' , u)
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：南帝，内力增加了480点，真实伤害增加了600点，武功" + GetObjectName('A06P') + "提升到9重，" + GetObjectName('A0CH') + "提升到7重，获得物品：" + GetObjectName('I09H'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A06P' * 5, GetUnitAbilityLevel(u, 'A06P'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0CH' * 5, GetUnitAbilityLevel(u, 'A0CH'))
		call setTitleNumber(i, 40)
	endif
	if GetUnitAbilityLevel(u, 'A07N') >= 5 and GetUnitAbilityLevel(u, 'A0D1') >= 5 and GetUnitAbilityLevel(u, 'A0D3') >= 5 and GetUnitAbilityLevel(u, 'A07G') >= 3 and ( GetUnitTypeId(u) == 'O023' or GetUnitTypeId(u) == 'O02H' or GetUnitTypeId(u) == 'O02I' or GetUnitTypeId(u) == 'O003' or GetUnitTypeId(u) == 'O002' ) and not isTitle(i, 41) then
		call SetPlayerName(p, "〓瑶琴〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(0, u, 0, 700)
		call ModifyHeroStat(1, u, 0, 200)
		call SetUnitAbilityLevel(u, 'A0D1', 9)
		call SetUnitAbilityLevel(u, 'A0D3', 7)
		// 九阴白骨爪加3级
		call SetUnitAbilityLevel(u, 'A07N', IMinBJ(GetUnitAbilityLevel(u, 'A07N') + 3, 9))
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：瑶琴，内力增加了200点，招式伤害增加了700点，武功" + GetObjectName('A0D1') + "提升到9重，" + GetObjectName('A0D3') + "提升到7重，武功" + GetObjectName('A07N') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07N') + 3, 9)) + "重")
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0D1' * 5, GetUnitAbilityLevel(u, 'A0D1'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A0D3' * 5, GetUnitAbilityLevel(u, 'A0D3'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07N' * 5, GetUnitAbilityLevel(u, 'A07N'))
		call setTitleNumber(i, 41)
	endif
	//自创武功命名为虾米神拳
	if s__ZiZhiWuGong_name[zizhiwugong[i]] == "虾米神拳" and GetUnitAbilityLevel(u, 'A036') >= 1 and GetUnitAbilityLevel(u, 'A07I') >= 5 and udg_runamen[i] == 11 and not isTitle(i, 42) then
		call SetPlayerName(p, "〓小虾米〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(0, u, 0, 1000)
		call ModifyHeroStat(1, u, 0, 1000)
		call ModifyHeroStat(2, u, 0, 1000)
		call SetUnitAbilityLevel(u, 'A07I', 9)
		// 奖励野球拳残章
		call unitadditembyidswapped('I068' , u)
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：小虾米，招式伤害增加了1000点，内力增加了1000点，真实伤害增加了1000点，武功" + GetObjectName('A07I') + "提升到9重，获得物品：" + GetObjectName('I068'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07I' * 5, GetUnitAbilityLevel(u, 'A07I'))
		call setTitleNumber(i, 42)
	endif
	if GetUnitAbilityLevel(u, 'A07E') >= 5 and GetUnitAbilityLevel(u, 'A017') >= 5 and GetUnitAbilityLevel(u, 'A07S') >= 1 and GetUnitAbilityLevel(u, 'A07U') >= 1 and udg_runamen[i] == 11 and not isTitle(i, 43) then
		// 不能是丐帮，降龙5级、空明拳5级、九阴真经、双手互博
		// 奖励招式300、内力500、真实300，降龙加3级，空明加3级
		call SetPlayerName(p, "〓郭大侠〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(0, u, 0, 300)
		call ModifyHeroStat(1, u, 0, 500)
		call ModifyHeroStat(2, u, 0, 300)
		call SetUnitAbilityLevel(u, 'A07E', IMinBJ(GetUnitAbilityLevel(u, 'A07E') + 3, 9))
		call SetUnitAbilityLevel(u, 'A017', IMinBJ(GetUnitAbilityLevel(u, 'A017') + 3, 9))
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：郭大侠，招式伤害增加了300点，内力增加了500点，真实伤害增加了300点，武功" + GetObjectName('A07E') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07E') + 3, 9)) + "重，" + GetObjectName('A017') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A017') + 3, 9)) + "重")
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07E' * 5, GetUnitAbilityLevel(u, 'A07E'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A017' * 5, GetUnitAbilityLevel(u, 'A017'))
		call setTitleNumber(i, 43)
	endif
	if GetUnitAbilityLevel(u, 'A07S') >= 1 and GetUnitAbilityLevel(u, 'A0DN') >= 1 and GetUnitAbilityLevel(u, 'A07O') >= 1 and GetUnitAbilityLevel(u, 'A07R') >= 1 and GetUnitAbilityLevel(u, 'A07T') >= 1  and GetUnitAbilityLevel(u, 'A07Q') >= 1 and GetUnitAbilityLevel(u, 'A07W') >= 1 and GetUnitAbilityLevel(u, 'A07U') >= 1 and not isTitle(i, 44) then
		// 王语嫣：九阴、九阳、罗汉、吸星、葵花、斗转、乾坤、双手
		call SetPlayerName(p, "〓神仙姐姐〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call ModifyHeroStat(0, u, 0, 300)
		call ModifyHeroStat(1, u, 0, 500)
		call ModifyHeroStat(2, u, 0, 300)
		call SetUnitAbilityLevel(u, 'A07E', IMinBJ(GetUnitAbilityLevel(u, 'A07E') + 3, 9))
		call SetUnitAbilityLevel(u, 'A017', IMinBJ(GetUnitAbilityLevel(u, 'A017') + 3, 9))
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cff66ff00恭喜玩家" + I2S(i) + "获得了称号：神仙姐姐，招式伤害增加了300点，内力增加了500点，真实伤害增加了300点，武功" + GetObjectName('A07E') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A07E') + 3, 9)) + "重，" + GetObjectName('A017') + "提升到" + I2S(IMinBJ(GetUnitAbilityLevel(u, 'A017') + 3, 9)) + "重")
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A07E' * 5, GetUnitAbilityLevel(u, 'A07E'))
		call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 'A017' * 5, GetUnitAbilityLevel(u, 'A017'))
		call setTitleNumber(i, 44)
	endif
	set p = null
endfunction

//武功升重及掌门称号系统
function WuGongShengChong takes unit u, integer id, real r returns nothing
	local integer level = GetUnitAbilityLevel(u, id)
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	
	// 武功升重
	call kungfuLevelUp(u, id, r)
	
	//掌门系统
	if (IsUnitType(u, UNIT_TYPE_HERO) != null)  then
		call becomeChief(u, 1, "少林方丈", 170, 190, 480)
		call becomeChief(u, 2, "古墓掌门", 240, 240, 0)
		call becomeChief(u, 3, "丐帮帮主", 480, 0, 0)
		call becomeChief(u, 4, "华山掌门", 0, 170, 290)
		call becomeChief(u, 5, "全真掌教", 0, 360, 0)
		call becomeChief(u, 6, "血刀掌门", 0, 0, 1200)
		call becomeChief(u, 7, "恒山掌门", 0, 460, 0)
		call becomeChief(u, 8, "峨眉掌门", 240, 170, 0)
		call becomeChief(u, 9, "武当掌门", 240, 0, 600)
		call becomeChief(u, 10, "星宿掌门", 0, 600, 300)
		call becomeChief(u, 12, "灵鹫宫主", 220, 220, 220)
		call becomeChief(u, 13, "慕容家主", 100, 280, 300)
		call becomeChief(u, 14, "明教教主", 210, 310, 160)
		call becomeChief(u, 15, "衡山掌门", 350, 260, 100)
		call becomeChief(u, 16, "男神龙", 350, 0, 200)
		call becomeChief(u, 17, "女神龙", 200, 350, 0)
		call becomeChief(u, 18, "泰山掌门", 320, 220, 120)
		call becomeChief(u, 19, "铁掌帮主", 300, 0, 225)
		call becomeChief(u, 20, "唐门门主", 0, 225, 300)
		call becomeChief(u, 21, "五毒教主", 300, 225, 0)
		call becomeChief(u, 22, "桃花岛主", 225, 0, 300)
		call becomeChief(u, 23, "野螺掌派", 225, 300, 0)
		call becomeChief(u, 24, "雪山掌门", 225, 0, 300)
		call becomeChief(u, 25, "汝阳王", 200, 200, 200)
		
		call determineShaoLinTitle(u)
		call determineGuMuTitle(u)
		call determineGaiBangTitle(u)
		call determineHuaShanTitle(u)
		call determineQuanZhenTitle(u)
		call determineXueDaoTitle(u)
		call determineHengShanTitle(u)
		call determineEMeiTitle(u)
		call determineWuDangTitle(u)
		call determineXingXiuTitle(u)
		call determineLingJiuTitle(u)
		call determineMuRongTitle(u)
		call determineMingJiaoTitle(u)
		call determineHengShan2Title(u)
		call determineShenLongTitle(u)
		call determineTaiShanTitle(u)
		call determineTieZhangTitle(u)
		call determineTangMenTitle(u)
		call determineWuDuTitle(u)
		call determineTaoHuaDaoTitle(u)
		call determineYeLuoTitle(u)
		call determineXueShanTitle(u)
		call determineRuYangTitle(u)
		call determineJiangHuTitle(u)
		
	endif
	
	set p = null
endfunction


/*
* 几率触发被动武功(AOE)
* @param filter 筛选伤害周围单位的条件，通常为活着、敌人
* @param callback 对筛选出的单位进行伤害的函数，包括物效
*/
function PassiveWuGongAction takes unit playerControllingUnit, unit enemy, real possibility, real range, boolexpr filter, code callback, integer abilityId, real upgradeSpeed returns nothing
	local location loc = GetUnitLoc(playerControllingUnit)
	local integer i = 1 + GetPlayerId(GetOwningPlayer(playerControllingUnit))
	if (GetRandomInt(1, 100) <= fuyuan[i] / 5 + possibility) then
		call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(range, loc, filter), callback)
		call WuGongShengChong(playerControllingUnit, abilityId, upgradeSpeed)
	endif
	call RemoveLocation(loc)
	set loc = null
endfunction

