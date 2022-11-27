
//========================================================================
//键盘输入系统
//========================================================================


function getDeputyString takes integer i, integer deputy, string deputyStr returns string
	if Deputy_isMaster(i, deputy) then
		return deputyStr
	endif
	return ""
endfunction

function getChiefString takes integer i, integer denomination, string chiefStr returns string
	if isChief(i, denomination) then
		return chiefStr
	endif
	return ""
endfunction

function getTitleString takes integer i, integer title, string titleStr returns string
	if isTitle(i, title) then
		return titleStr
	endif
	return ""
endfunction

function KeyInput takes nothing returns nothing
	local string s = GetEventPlayerChatString()
	local item it = null
	local player p = GetTriggerPlayer()
	local integer i = GetPlayerId(p) + 1
	local integer j = 0
	local location loc = null
	local string str = null
	local real array shanghai
	local integer pId = GetPlayerId(p)
	local string spilt = ""
	local string tgs_menpai = "" // 单通门派显示字符串
	local string tgm_menpai = "" // 多通门派显示字符串
	local integer count = 0
	if s == "+" then
		call SetCameraFieldForPlayer(p, CAMERA_FIELD_TARGET_DISTANCE, (GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) + 200.00), 1.00)
	endif
	if s == "-" then
		call SetCameraFieldForPlayer(p, CAMERA_FIELD_TARGET_DISTANCE, (GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) - 200.00), 1.00)
	endif
	if s == "hg" or s == "HG" or s == "hc" or s == "HC" then
		call SetUnitPosition(udg_hero[i], - 1174, - 678)
		call PanCameraToTimedForPlayer(GetTriggerPlayer(), - 1174, - 678, 0)
	endif
	if s == "q" then
		call SetUnitPosition(udg_hero[i], - 869, 796)
		call PanCameraToTimedForPlayer(GetTriggerPlayer(), - 869, 796, 0)
	endif
	if s == "3" then
		call SetUnitPosition(udg_hero[i], - 869, - 2000)
		call PanCameraToTimedForPlayer(GetTriggerPlayer(), - 869, - 2000, 0)
	endif
	if s == "4" then
		call SetUnitPosition(udg_hero[i], 10692, - 14847)
		call PanCameraToTimedForPlayer(GetTriggerPlayer(), 10692, - 14847, 0)
	endif

	if SubStringBJ(s, 1, 2) == "wq" then
		if UnitHaveItem(udg_hero[i], 'I0BH') == false then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000当前未装备自制武器")
		else
			set it = FetchUnitItem(udg_hero[i], 'I0BH')
			call SaveStr(YDHT, GetHandleId(it), StringHash("武器名称"), SubStringBJ(s, 3, 40))
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000自制武器已更名为" + SubStringBJ(s, 3, 40))
		endif
	endif
	//if s == "randreal" then
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//	call BJDebugMsg(R2S(GetGeoNormRandomReal(1., 3.)))
	//endif
	if SubStringBJ(s, 1, 2) == "tx" then
		if S2I(SubStringBJ(s, 3, 4)) >= 1 and S2I(SubStringBJ(s, 3, 4)) <= 10 then
			set zizhiwugong[i].texiao = S2I(SubStringBJ(s, 3, 4))
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000自创武功已更改为第" + SubStringBJ(s, 3, 40) + "种特效")
		endif
	endif
	if SubStringBJ(s, 1, 4) == "wing" then
		if S2I(SubStringBJ(s, 5, 5)) == 0 then
			call DestroyEffect(vd[i])
			set vd[i] = null
		endif
		if S2I(SubStringBJ(s, 5, 5)) == 1 then
			if wing1Flag[i] == 1 then
				call DestroyEffect(vd[i])
				call AddSpecialEffectTargetUnitBJ("chest", udg_hero[i], "wing_red_no6.mdx")
				set vd[i] = bj_lastCreatedEffect
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000未激活该翅膀")
			endif
		endif
		if S2I(SubStringBJ(s, 5, 5)) == 2 then
			if wing2Flag[i] == 1 then
				call DestroyEffect(vd[i])
				call AddSpecialEffectTargetUnitBJ("chest", udg_hero[i], "wing_bluewhite_no1.mdx")
				set vd[i] = bj_lastCreatedEffect
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000未激活该翅膀")
			endif
		endif
	endif
	if SubStringBJ(s, 1, 2) == "wg" then
		if GetUnitAbilityLevel(udg_hero[i], 'A036') == 0 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000当前无自创武功")
		else
			set zizhiwugong[i].name = SubStringBJ(s, 3, 40)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000自创武功已更名为" + SubStringBJ(s, 3, 40))
		endif
	endif
	// 查看称号
	if s == "ckch" or s == "CKCH" then
		set s = ""
		set s = s + getDeputyString(i, LIAN_DAN, "炼丹大师 ")
		set s = s + getDeputyString(i, DUAN_ZAO, "锻造大师 ")
		set s = s + getDeputyString(i, BING_QI, "兵器大师 ")
		set s = s + getDeputyString(i, JIAN_DING, "鉴定大师 ")
		set s = s + getDeputyString(i, LIAN_QI, "练气大师 ")
		set s = s + getDeputyString(i, XUN_BAO, "寻宝大师 ")
		set s = s + getDeputyString(i, YA_HUAN, "郡主 ")
		set s = s + getDeputyString(i, JING_WU, "精武宗师 ")
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000当前已获得副职宗师：" + s)

		set s = ""
		set s = s + getChiefString(i, 1, "少林方丈 ")
		set s = s + getChiefString(i, 2, "古墓掌门 ")
		set s = s + getChiefString(i, 3, "丐帮帮主 ")
		set s = s + getChiefString(i, 4, "华山掌门 ")
		set s = s + getChiefString(i, 5, "全真掌教 ")
		set s = s + getChiefString(i, 6, "血刀掌门 ")
		set s = s + getChiefString(i, 7, "恒山掌门 ")
		set s = s + getChiefString(i, 8, "峨眉掌门 ")
		set s = s + getChiefString(i, 9, "武当掌门 ")
		set s = s + getChiefString(i, 10, "星宿掌门 ")
		set s = s + getChiefString(i, 12, "灵鹫宫主 ")
		set s = s + getChiefString(i, 13, "慕容家主 ")
		set s = s + getChiefString(i, 14, "明教教主 ")
		set s = s + getChiefString(i, 15, "衡山掌门 ")
		set s = s + getChiefString(i, 16, "男神龙 ")
		set s = s + getChiefString(i, 17, "女神龙 ")
		set s = s + getChiefString(i, 18, "泰山掌门 ")
		set s = s + getChiefString(i, 19, "铁掌帮主 ")
		set s = s + getChiefString(i, 20, "唐门门主 ")
		set s = s + getChiefString(i, 21, "五毒教主 ")
		set s = s + getChiefString(i, 22, "桃花岛主 ")
		set s = s + getChiefString(i, 23, "野螺掌派 ")
		set s = s + getChiefString(i, 24, "雪山掌门 ")
		set s = s + getChiefString(i, 25, "汝阳王 ")
		set s = s + getChiefString(i, 26, "嵩山掌门 ")
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00当前已获得掌门：" + s)

		set s = ""
		set s = s + getTitleString(i, 1, "扫地神僧 ")
		set s = s + getTitleString(i, 2, "达摩祖师 ")
		set s = s + getTitleString(i, 3, "大轮明王 ")
		set s = s + getTitleString(i, 4, "金轮法王 ")
		set s = s + getTitleString(i, 5, "神雕侠 ")
		set s = s + getTitleString(i, 6, "小龙女 ")
		set s = s + getTitleString(i, 7, "神雕侠侣 ")
		set s = s + getTitleString(i, 8, "赤炼仙子 ")
		set s = s + getTitleString(i, 9, "北丐 ")
		set s = s + getTitleString(i, 10, "北乔峰 ")
		set s = s + getTitleString(i, 11, "君子剑 ")
		set s = s + getTitleString(i, 12, "风清扬 ")
		set s = s + getTitleString(i, 13, "老顽童 ")
		set s = s + getTitleString(i, 14, "中神通 ")
		set s = s + getTitleString(i, 15, "血刀老祖 ")
		set s = s + getTitleString(i, 16, "空心菜 ")
		set s = s + getTitleString(i, 17, "仪琳 ")
		set s = s + getTitleString(i, 18, "笑傲江湖 ")
		set s = s + getTitleString(i, 19, "芷若 ")
		set s = s + getTitleString(i, 20, "小东邪 ")
		set s = s + getTitleString(i, 21, "邋遢仙人 ")
		set s = s + getTitleString(i, 22, "张三丰 ")
		set s = s + getTitleString(i, 23, "星宿老仙 ")
		set s = s + getTitleString(i, 24, "天山童姥 ")
		set s = s + getTitleString(i, 25, "虚竹子 ")
		set s = s + getTitleString(i, 26, "慕容龙城 ")
		set s = s + getTitleString(i, 27, "白眉鹰王 ")
		set s = s + getTitleString(i, 28, "青翼蝠王 ")
		set s = s + getTitleString(i, 29, "金毛狮王 ")
		set s = s + getTitleString(i, 30, "无忌 ")
		set s = s + getTitleString(i, 31, "莫大先生 ")
		set s = s + getTitleString(i, 32, "神龙教主 ")
		set s = s + getTitleString(i, 33, "教主夫人 ")
		set s = s + getTitleString(i, 34, "天门道长 ")
		set s = s + getTitleString(i, 35, "铁掌水上漂 ")
		set s = s + getTitleString(i, 36, "搜魂侠 ")
		set s = s + getTitleString(i, 37, "九阴真人 ")
		set s = s + getTitleString(i, 38, "西毒 ")
		set s = s + getTitleString(i, 39, "东邪 ")
		set s = s + getTitleString(i, 40, "南帝 ")
		set s = s + getTitleString(i, 41, "瑶琴 ")
		set s = s + getTitleString(i, 42, "小虾米 ")
		set s = s + getTitleString(i, 43, "郭大侠 ")
		set s = s + getTitleString(i, 44, "神仙姐姐 ")
		set s = s + getTitleString(i, 45, "婆婆姊姊 ")
		set s = s + getTitleString(i, 46, "女中诸葛 ")
		set s = s + getTitleString(i, 47, "爵爷 ")
		set s = s + getTitleString(i, 48, "石破天惊")
		set s = s + getTitleString(i, 49, "绍敏郡主 ")
		set s = s + getTitleString(i, 50, "左盟主")
		set s = s + getTitleString(i, 51, "五岳盟主")
		set s = s + getTitleString(i, 52, "威德先生")
		set s = s + getTitleString(i, 53, "白龙使")
		set s = s + getTitleString(i, 54, "铁丑")

		call DisplayTextToPlayer(p, 0, 0, "|cFFFFFF00当前已获得称号：" + s)
	endif
	if s == "ckwg" or s == "CKWG" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000剩余自创武功点：" + I2S(wuxuedian[i]))
		if GetUnitAbilityLevel(udg_hero[i], 'A036') == 0 then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000当前无自创武功")
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000武功：" + zizhiwugong[i].name)
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000伤害范围：" + I2S(R2I(400. + 100. * I2R(zizhiwugong[i].range))))
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000伤害系数：" + R2S(1. + 0.5 * I2R(zizhiwugong[i].xishu)))
			set j = 1
			loop
				exitwhen j > zizhiwugong[i].dapeishu
				call DisplayTextToPlayer(p, 0, 0, dapei[20 * i + j].XiaoGuoShuoMing())
				set j = j + 1
			endloop
		endif
	endif
	if s == "ckwq" or s == "CKWQ" then
		if UnitHaveItem(udg_hero[i], 'I0BH') == false then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000当前未装备自制武器")
		else
			set it = FetchUnitItem(udg_hero[i], 'I0BH')
			if LoadStr(YDHT, GetHandleId(it), StringHash("武器名称")) == "" then
				call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00武器名称：尚未输入")
			else
				call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00武器名称：" + LoadStr(YDHT, GetHandleId(it), StringHash("武器名称")))
			endif
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF6600升级概率：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("升级概率")))) + "%")
			call DisplayTextToPlayer(p, 0, 0, "|cFFE500AF招式伤害：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("招式伤害")))) + " 内力：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("内力")))) + " 真实伤害：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("真实伤害")))))
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0033暴击伤害：" + I2S(R2I(100 * LoadReal(YDHT, GetHandleId(it), StringHash("暴击伤害")))) + "% 暴击率：" + I2S(R2I(100 * LoadReal(YDHT, GetHandleId(it), StringHash("暴击率")))) + "% 绝学领悟：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("绝学领悟")))))
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFFF33根骨：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("根骨")))) + " 胆魄：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("胆魄")))) + " 悟性：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("悟性")))))
			call DisplayTextToPlayer(p, 0, 0, "|cFFFFFF33医术：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("医术")))) + " 经脉：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("经脉")))) + " 福缘：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("福缘")))))
			call DisplayTextToPlayer(p, 0, 0, "|cFF9933FF伤害回复：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("伤害回复")))) + " 杀怪回复：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("杀怪回复")))) + " 生命回复：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("生命回复")))) + " 法力回复：" + I2S(R2I(LoadReal(YDHT, GetHandleId(it), StringHash("法力回复")))))
		endif
	endif
	
	if s == "ckjn" or s == "CKJN" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000人物性格：你学武资质" + XingGeA(udg_xinggeA[i]) + "，态度" + XingGeB(udg_xinggeB[i]))
		call DisplayTextToPlayer(p, 0, 0, "|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
		set j = 1
		loop
			exitwhen j > wugongshu[i]
			if I7[(i - 1) * 20 + j] != 'AEfk' then
				call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(I7[(i - 1) * 20 + j]) + "第" + I2S(GetUnitAbilityLevel(udg_hero[i], I7[(i - 1) * 20 + j])) + "重，升级进度：" + LoadStr(YDHT, GetHandleId(p), I7[(i - 1) * 20 + j] * 2))
			endif
			set j = j + 1
		endloop

		set j = 1
		loop
			exitwhen j > alreadyInternalizedCount[i]
			// 内化武功的升重进度
			if LoadInteger(YDHT, interAbilityKey + i, j) != 'AEfk' then
				call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(LoadInteger(YDHT, interAbilityKey + i, j)) + "第" + I2S(GetUnitAbilityLevel(udg_hero[i], LoadInteger(YDHT, interAbilityKey + i, j))) + "重，升级进度：" + LoadStr(YDHT, GetHandleId(p), LoadInteger(YDHT, interAbilityKey + i, j) * 2))
			endif
			set j = j + 1
		endloop
		call DisplayTextToPlayer(p, 0, 0, "|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
	endif
	if s == "ckhf" or s == "CKHF" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF杀怪回复：" + I2S(R2I(shaguaihufui[i])))
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF伤害回复：" + I2S(R2I(shanghaihuifu[i])))
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF生命回复：" + I2S(R2I(shengminghuifu[i])))
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF法力回复：" + I2S(R2I(falihuifu[i])))
		call DisplayTextToPlayer(p, 0, 0, "|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
	endif

	// 查看专属
	if s == "ckzs" or s == "ckmp" then
		
		call DisplayTextToPlayer(p, 0, 0, "|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF当前所选门派：" + udg_menpainame[udg_runamen[i]])
		if udg_runamen[i] == 1 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00少林专属：袈裟，90级去挑战场打达摩")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号扫地神僧：掌门+金钟罩+医术32点")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号达摩祖师：掌门+易筋经或洗髓经")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号大轮明王：掌门+小无相功或无相劫指+悟性31点")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号金轮法王：掌门+龙象般若功+根骨31点")
		elseif udg_runamen[i] == 2 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00古墓专属：双剑，副本4君子、淑女剑合成")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号神雕侠：掌门+黯然销魂掌+君子剑")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号小龙女：掌门+双手互搏+淑女剑")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号神雕侠侣：掌门+黯然销魂掌+双手互搏+双剑合璧")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号赤炼仙子：掌门+冰魄银针6重")
		elseif udg_runamen[i] == 3 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00丐帮专属：打狗棒，桃花岛洪七公，90级杀他才爆")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号北丐：掌门+降龙十八掌+打狗棒法+打狗棒（武器）")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号北乔峰：掌门+降龙十八掌3重+擒龙控鹤+打狗棒（武器）")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号铁丑：丐帮帮主或星宿掌门+冰蚕毒掌")
		elseif udg_runamen[i] == 4 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00华山专属：养吾剑，90级令狐冲处接任务挑战令狐冲，剑附带破防效果")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号君子剑：掌门+葵花宝典+辟邪剑法")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号风清扬：掌门+独孤九剑5重")
		elseif udg_runamen[i] == 5 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00全真专属：七星道袍，90级找丘处机接任务，加金雁攻速，三花聚顶弹射次数+50")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号老顽童：掌门+空明拳+双手互搏+九阴真经·摧坚神抓")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号中神通：掌门+一阳指+九阴真经·内功+先天功")
		elseif udg_runamen[i] == 6 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00血刀专属：血刀，90级挑战场挑战血刀老祖")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号血刀老祖：掌门+血刀（武器）")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号空心菜：掌门+真·神照经+连城剑法+唐诗剑法")
		elseif udg_runamen[i] == 7 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00恒山专属：拂尘，90级令狐冲接任务，教训田伯光，加2级拂尘范围")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号仪林：掌门+门派前三个武功7重")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号笑傲江湖：掌门+独孤九剑+真·易筋经+吸星大法+冲灵剑法（华山门派武功，需要用传功丹）")
		elseif udg_runamen[i] == 8 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00峨眉专属：倚天剑，灭绝师太接任务，打死副本3张无忌；或者副本6东方不败爆")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号芷若：掌门+九阴真经·九阴白骨爪+倚天剑（武器）")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号小东邪：掌门+峨眉九阳功+玉箫（武器）")
		elseif udg_runamen[i] == 9 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00武当专属：真武剑，90级去挑战场挑战张三丰,太极拳主动使用永久加1绝学领悟，被动使用概率加绝学领悟")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号邋遢仙人：掌门+九阳神功+真·易筋经")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号张三丰：掌门+太极拳9重+真武剑（武器）")
		elseif udg_runamen[i] == 10 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00星宿专属：神木王鼎，乔峰接任务，副本1杀丁春秋杀阿紫")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号星宿老仙：掌门+化功大法+小无相功")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号铁丑：丐帮帮主或星宿掌门+冰蚕毒掌")
		elseif udg_runamen[i] == 11 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00自由专属：十四天书，具体合成请看基地右边NPC随风")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号小虾米：虾米神拳（自创武功改名）+野球拳5重")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号郭大侠：降龙十八掌5重+空明拳5重+九阴真经·内功+双手互搏")
		elseif udg_runamen[i] == 12 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00灵鹫专属：玉扳指，天山童姥20%爆，八荒加属性概率增加")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号天山童姥：掌门+八荒六合唯我独尊功6重+冰魄银针+北冥神功")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号虚竹子：掌门+北冥神功+冰魄银针+罗汉伏魔功+玉扳指（饰品）")
		elseif udg_runamen[i] == 13 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00慕容专属：燕国玉玺，慕容复发布任务，慕容龙城称号和等级超过100级可以获取专属，袖中指加属性概率增加")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号慕容龙城：掌门+斗转星移")
		elseif udg_runamen[i] == 14 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00明教专属：屠龙刀，副本6东方不败爆")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号白眉鹰王：掌门+鹰爪功9重")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号青翼蝠王：掌门+蝠翼纵9重")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号金毛狮王：掌门+狮子吼9重")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号无忌：掌门+乾坤大挪移6重+九阳神功+太极拳4重（武当门派武功）")
		elseif udg_runamen[i] == 15 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00衡山专属：镇岳尚方，90级令狐冲接任务，江南水乡解决费彬，剑加青龙光环")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号莫大先生：掌门+门派前三个武功7重")
		elseif udg_runamen[i] == 16 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00神龙专属：毒龙鞭，副本1韦小宝（神龙教）触发任务杀死洪安通，接任务后洪安通出现在桃花岛上")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号神龙教主：掌门+九阳神功+龙象般若功")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号白龙使：掌门+神行百变")
		elseif udg_runamen[i] == 17 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00神龙专属：毒龙鞭，副本1韦小宝（神龙教）触发任务杀死洪安通，接任务后洪安通出现在桃花岛上")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号教主夫人：掌门+九阴真经·内功+小无相功")
		elseif udg_runamen[i] == 18 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00泰山专属：东灵铁剑，90级令狐冲接任务，雁门关解决玉玑子，永久触发泰山十八盘")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号天门道长：掌门+小无相功")
		elseif udg_runamen[i] == 19 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00铁掌专属：铁掌令，周伯通处任务")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号铁掌水上漂：掌门+乾坤大挪移+双手互搏+铁掌令（武器）")
		elseif udg_runamen[i] == 20 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00唐门专属：子午砂，副本2唐文亮几率掉落；观音泪，副本4南海神尼几率掉落")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号搜魂侠：掌门+小无相功+冰魄银针")
		elseif udg_runamen[i] == 21 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00五毒专属：选择门派时赠送")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号婆婆姊姊：掌门+龙象般若功+葵花宝典")
		elseif udg_runamen[i] == 22 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00桃花岛专属：桃花岛玉箫任务")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号女中诸葛：掌门+九阴真经·内功+打狗棒法")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号东邪：掌门+弹指神通3重+碧海潮生曲3重+玉箫（武器）")
		elseif udg_runamen[i] == 23 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00野螺专属：技能几率偷取")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号爵爷：掌门+神行百变+金钱60万")
		elseif udg_runamen[i] == 24 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00雪山专属：贼哥处购买")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号石破天惊：掌门+罗汉伏魔功+真·太玄经")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号威德先生：掌门，雪山剑法8重以上，遗忘金乌刀法")
		elseif udg_runamen[i] == 25 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00汝阳王府专属：倚天剑，灭绝师太接任务，打死副本3张无忌；或者副本6东方不败爆")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号绍敏郡主：掌门+使用10次偷看偷学")
		elseif udg_runamen[i] == 26 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FF00嵩山专属：贼哥处购买")
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF称号左盟主：掌门+寒冰真气+寒魄剑")
		endif
		call DisplayTextToPlayer(p, 0, 0, "|cFF389C83称号五岳盟主：同时获得五岳门派的掌门")
		call DisplayTextToPlayer(p, 0, 0, "|cFF389C83称号九阴真人：九阴真经·内功+逆九阴真经·内功+九阴真经·易筋锻骨篇+九阴真经·医疗篇+九阴真经·九阴白骨爪+九阴真经·摧坚神抓4重+九阴真经·摧心掌4重")
		call DisplayTextToPlayer(p, 0, 0, "|cFF004096称号西毒：西毒杖法5重+真·蛤蟆功+蛇杖（武器）")
		call DisplayTextToPlayer(p, 0, 0, "|cFF006083称号南帝：一阳指5重+先天功3重（全真门派武功）+非全真门派")
		call DisplayTextToPlayer(p, 0, 0, "|cFF326859称号瑶琴：九阴真经·九阴白骨爪5重+九阴真经·摧坚神抓5重+九阴真经·摧心掌5重+黯然销魂掌3重")
		call DisplayTextToPlayer(p, 0, 0, "|cFF754298称号神仙姐姐：九阴真经·内功+九阳神功+罗汉伏魔功+吸星大法+葵花宝典+斗转星移+乾坤大挪移+双手互搏")
		call DisplayTextToPlayer(p, 0, 0, "|cFF754298理论上也可以获得其他门派的称号，不在此处描述，请自行尝试")
		call DisplayTextToPlayer(p, 0, 0, "|cFFcc99ff〓〓〓〓〓〓〓〓〓〓〓")
	endif

	// 手动整理物品
	if s == "sort" or s == "-sort" then
		call EnumItemsInRectBJ(bj_mapInitialPlayableArea, function SO)
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF整理物品完成")
	endif

	if s == "ver" then
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF决战江湖1.6.74版本")
	endif

	if s == "hd" then
		set showDamage[i] = false
	endif

	if s == "sd" then
		set showDamage[i] = true
	endif

	if s == "cx" or s == "CX" then
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|cFFFF00CC" + "查询玩家:" + "|r" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "战斗力：" + I2S(udg_zdl[pId]))
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "积分：" + I2S(udg_jf[pId]))
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "每局可用积分剩余：" + I2S(jf_max - jf_useMax[pId]))
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "通关次数：" + I2S(udg_success[pId]))
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "伤害兑换：" + R2S(bonus_wugong[pId] * 100) + "%")
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "最高伤害：" + R2S(max_damage[pId]))
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "累计评分：" + I2S(decryptInt(DzAPI_Map_GetStoredString(Player(pId), "totalPoint"), Player(pId))))
		// 全门派通关查询
		// call BJDebugMsg("原始单通数据："+singleSuccess[pId])
		// call BJDebugMsg("原始多通数据："+manySuccess[pId])
		set j = 0
		loop
			exitwhen j >= DENOMINATION_NUMBER
			// body
			set spilt = SubString(singleSuccess[pId], j, j + 1)
			// 已通关门派
			if spilt == "1" then
				set tgs_menpai = tgs_menpai + "||" + "|CffFF0000" + udg_menpainame[j + 1] + "|r"
			else 
				set tgs_menpai = tgs_menpai + "||" + udg_menpainame[j + 1]
			endif
			set j = j + 1
		endloop
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "单通挑战速通难7门派（白色未通关）|r：" + tgs_menpai)
		set j = 0
		loop
			exitwhen j >= DENOMINATION_NUMBER
			// body
			set spilt = SubString(manySuccess[pId], j, j + 1)
			// 已通关门派
			if spilt == "1" then
				set tgm_menpai = tgm_menpai + "||" + "|CffFF0000" + udg_menpainame[j + 1] + "|r"
			else 
				set tgm_menpai = tgm_menpai + "||" + udg_menpainame[j + 1]
			endif
			set j = j + 1
		endloop
		call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9系统提示：|r" + "|CFFFE890D" + "多通挑战速通难7门派（白色未通关）|r：" + tgm_menpai)
	endif

	if s == "cxs" or s == "CXS" then
		loop
			exitwhen j > 4
			call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|cFFFF00CC" + "查询玩家:" + "|r" + GetPlayerName(Player(j)))
			call DisplayTimedTextToPlayer(Player(pId), 0, 0, 10, "|CFF1CE6B9战斗力：|r" + I2S(udg_zdl[j]) + ",|CFF1CE6B9积分：|r" + I2S(udg_jf[j]) + ",|CFF1CE6B9每局积分：|r" + I2S(jf_max - jf_useMax[j]) + ",|r|CFF1CE6B9通关次数：" + I2S(udg_success[j]) + ",|r|CFF1CE6B9伤害加成：" + R2S(bonus_wugong[j]) + ",|r|CFF1CE6B9最高伤害：" + R2S(max_damage[j]))
			set j = j + 1
		endloop
	endif

	// if s == "save" and is_victory and not saveFlag[pId] then
	// 	call DisplayTextToPlayer(p,0,0,"|CFF99CC00获得战斗力和积分："+I2S(get_zdl))
	// 	// 保存战斗力到服务器
	// 	set udg_zdl[pId] = udg_zdl[pId] + get_zdl
	// 	set udg_jf[pId] = udg_jf[pId] + get_zdl
	// 	call DzAPI_Map_StoreInteger(Player(pId),"zdl",udg_zdl[pId])
	// 	call DzAPI_Map_StoreInteger(Player(pId),"jf",udg_zdl[pId])
	// 	if GetPlayerServerValueSuccess(Player(pId)) then
	// 		call DisplayTextToPlayer(p,0,0,"|CFFFE890D"+GetPlayerName(Player(pId))+"|CFF99CC00数据保存成功")
	// 		set saveFlag[pId] = true
	// 	else
	// 		call DisplayTextToPlayer(p,0,0,"|CFFFE890D"+GetPlayerName(Player(pId))+"|CFFFF0303数据保存失败")
	// 		set saveFlag[pId] = false
	// 	endif
	// endif

	//if s=="碧海潮生" then
	//	call UnitAddAbility(udg_hero[i],'A018')
	//endif
	//if s=="空明" then
	//	call UnitAddAbility(udg_hero[i],'A017')
	//endif
	if s == "ck" or s == "cksh" then
		set j = 1
		set count = 0
		loop
			exitwhen j > wugongshu[i]
			set shanghai[j] = LoadReal(YDHT, 1 + GetPlayerId(p), I7[(i - 1) * 20 + j] * 3)
			if I7[(i - 1) * 20 + j] == 'A034' then
				set shanghai[j] = LoadReal(YDHT, 1 + GetPlayerId(p), 'A035' * 3)
			endif
			if I7[(i - 1) * 20 + j] != 'AEfk' and shanghai[j] > 0 then
				set count = count + 1
				if shanghai[j] < 10000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(I7[(i - 1) * 20 + j]) + "伤害：" + R2S(shanghai[j]))
				elseif shanghai[j] < 100000000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(I7[(i - 1) * 20 + j]) + "伤害：" + R2S(shanghai[j] / 10000.) + "万")
				elseif shanghai[j] / 10000. < 100000000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(I7[(i - 1) * 20 + j]) + "伤害：" + R2S(shanghai[j] / 100000000.) + "亿")
				elseif shanghai[j] / 100000000. < 100000000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(I7[(i - 1) * 20 + j]) + "伤害：" + R2S(shanghai[j] / 100000000. / 10000.) + "万亿")
				else
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(I7[(i - 1) * 20 + j]) + "伤害：" + R2S(shanghai[j] / 100000000. / 100000000.) + "亿亿")
				endif
			endif
			set j = j + 1
		endloop
		set j = 1
		loop
			exitwhen j > alreadyInternalizedCount[i]
			// 内化武功的伤害
			set shanghai[j] = LoadReal(YDHT, 1 + GetPlayerId(p), LoadInteger(YDHT, interAbilityKey + i, j) * 3)
			if LoadInteger(YDHT, interAbilityKey + i, j) != 'AEfk' and shanghai[j] > 0 then
				set count = count + 1
				if shanghai[j] < 10000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(LoadInteger(YDHT, interAbilityKey + i, j)) + "伤害：" + R2S(shanghai[j]))
				elseif shanghai[j] < 100000000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(LoadInteger(YDHT, interAbilityKey + i, j)) + "伤害：" + R2S(shanghai[j] / 10000.) + "万")
				elseif shanghai[j] / 10000. < 100000000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(LoadInteger(YDHT, interAbilityKey + i, j)) + "伤害：" + R2S(shanghai[j] / 100000000.) + "亿")
				elseif shanghai[j] / 100000000. < 100000000. then
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(LoadInteger(YDHT, interAbilityKey + i, j)) + "伤害：" + R2S(shanghai[j] / 100000000. / 10000.) + "万亿")
				else
					call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF" + GetAbilityName(LoadInteger(YDHT, interAbilityKey + i, j)) + "伤害：" + R2S(shanghai[j] / 100000000. / 100000000.) + "亿亿")
				endif
			endif
			set j = j + 1
		endloop
		if count == 0 then
			call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF暂时没有有伤害的武功")
		endif
	endif
	if s == "1" and GetUnitAbilityLevel(udg_hero[i], 'A07W') > 0 and IsUnitAliveBJ(udg_hero[i]) then
		if qiankunCd[i] then
			call DisplayTextToPlayer(p, 0, 0, "目前CD中，不能创建飞行点")
		else
			if RectContainsUnit(lh_r, udg_hero[i]) then
				call DisplayTextToPlayer(p, 0, 0, "桃花岛不能创建飞行点")
			else
				call RemoveUnit(J9[i])
				set loc = GetUnitLoc(udg_hero[i])
				call CreateNUnitsAtLoc(1, 'e00J', p, loc, bj_UNIT_FACING)
				set J9[i] = bj_lastCreatedUnit
				call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "创建飞行点")
				call RemoveLocation(loc)
				set loc = null
			endif
		endif
	endif
	if s == "2" and GetUnitAbilityLevel(udg_hero[i], 'A07W') > 0 and IsUnitAliveBJ(udg_hero[i]) then
		if J9[i] == null then
			call DisplayTextToPlayer(p, 0, 0, "你还没有设置飞行点，请输入聊天信息“1”来设置")
		else
			set loc = GetUnitLoc(J9[i])
			call SetUnitPositionLoc(udg_hero[i], loc)
			call PanCameraToTimedLocForPlayer(p, loc, 0)
			call RemoveLocation(loc)
			set loc = null
		endif
	endif
	if s == "11" and GetUnitAbilityLevel(udg_hero[i], 'A07W') > 3 and IsUnitAliveBJ(udg_hero[i]) then
		if RectContainsUnit(lh_r, udg_hero[i]) then
			call DisplayTextToPlayer(p, 0, 0, "桃花岛不能创建飞行点")
		else
			call RemoveUnit(qiankun2hao[i])
			set loc = GetUnitLoc(udg_hero[i])
			call CreateNUnitsAtLoc(1, 'e00J', p, loc, bj_UNIT_FACING)
			set qiankun2hao[i] = bj_lastCreatedUnit
			call DisplayTextToPlayer(GetTriggerPlayer(), 0, 0, "创建飞行点")
			call RemoveLocation(loc)
			set loc = null
		endif
	endif
	if s == "22" and GetUnitAbilityLevel(udg_hero[i], 'A07W') > 3 and IsUnitAliveBJ(udg_hero[i]) then
		if qiankun2hao[i] == null then
			call DisplayTextToPlayer(p, 0, 0, "你还没有设置飞行点，请输入聊天信息“11”来设置")
		else
			set loc = GetUnitLoc(qiankun2hao[i])
			call SetUnitPositionLoc(udg_hero[i], loc)
			call PanCameraToTimedLocForPlayer(p, loc, 0)
			call RemoveLocation(loc)
			set loc = null
		endif
	endif

	if s == "-ms" then
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF您当前的移动速度为" + I2S(R2I(GetUnitMoveSpeedEx(udg_hero[i]))))
	endif
	if s == "-random" and udg_runamen[i] == 0 and udg_hero[i] != null then
		call randomMenpai(p, 1)
	endif
	if s == "www.juezhanjianghu.com" and udg_runamen[i] == 0 and udg_hero[i] != null then
		call DisplayTextToPlayer(p, 0, 0, "|cFF00FFFF灵鹫宫已加入积分兑换，请输入hg选择自由门派后去基地左下方兑换")
	endif

	if s == "jzjh.uuu9.com" and udg_runamen[i] == 0 and udg_hero[i] != null then
		set udg_runamen[i] = 13
		call DisplayTimedTextToForce(bj_FORCE_ALL_PLAYERS, 15., "|CFFff9933玩家" + GetPlayerName(p) + "选择了隐藏门派〓姑苏慕容〓|r")
		call SetPlayerName(p, "〓姑苏慕容〓" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)))
		set udg_shuxing[i] = udg_shuxing[i] + 5
		call DisplayTimedTextToPlayer(p, 0, 0, 15., "|CFFff9933获得武功：凌波微步，你可以在主城和传送石之间任意传送了")
		call UnitAddAbility(udg_hero[i], 'A05R')
		call AddCharacterABuff(udg_hero[i], udg_xinggeA[i])
		call AddCharacterBBuff(udg_hero[i], udg_xinggeB[i])
		if udg_vip[i] < 2 and udg_elevenvip[i] < 1 then
			call UnitAddAbility(udg_hero[i], 'A040')
			call UnitAddAbility(udg_hero[i], 'A041')
			call UnitAddAbility(udg_hero[i], 'A042')
		endif
		set I7[(((i - 1) * 20) + 8)] = 'A05R'
		call UnitRemoveAbility(udg_hero[i], 'Avul')
		set Q4 = GetRandomLocInRect(He)
		call SetUnitPositionLoc(udg_hero[i], Q4)
		call PanCameraToTimedLocForPlayer(p, Q4, 0)
		call createPartnerAndTownPortalDummy(i, Q4)
		call RemoveLocation(Q4)
		call UnitAddItemByIdSwapped(1227896394, udg_hero[i])
	endif
	//if s=="jiafuyuan" then
	//	set fuyuan[i]=fuyuan[i]+20
	//	call DisplayTextToPlayer(p,0,0,"|cFFFF0000福缘+20")
	//endif
	if s == "cksx" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000剩余属性点：" + I2S(udg_shuxing[i]))
	endif
	if s == "testMall" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000天赋道具ID为：" + PROPERTY_TALENT)
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000门派道具ID为：" + PROPERTY_TIEZHANG)
		if DzAPI_Map_HasMallItem(p, PROPERTY_TALENT) then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000拥有天赋道具")
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000未拥有天赋道具")
		endif
		if DzAPI_Map_HasMallItem(p, PROPERTY_TIEZHANG) then
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000拥有门派道具")
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000未拥有门派道具")
		endif
	endif
	if s == "ckjf" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000剩余守家积分：" + I2S(shoujiajf[i]))
	endif
	if s == "累积积分" then
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000累积游戏积分：" + I2S(udg_MeiJuJiFen[i]))
	endif
	if SubStringBJ(s, 1, 5) == "zy500" and udg_MeiJuJiFen[i] >= 500 then
		set udg_MeiJuJiFen[S2I(SubStringBJ(s, 6, 6))] = udg_MeiJuJiFen[S2I(SubStringBJ(s, 6, 6))] + 500
		set udg_MeiJuJiFen[i] = udg_MeiJuJiFen[i] - 500
		call DisplayTextToForce(bj_FORCE_ALL_PLAYERS, "|cFFFF0000" + LoadStr(YDHT, GetHandleId(p), GetHandleId(p)) + "已向" + LoadStr(YDHT, GetHandleId(Player(S2I(SubStringBJ(s, 6, 6)) - 1)), GetHandleId(Player(S2I(SubStringBJ(s, 6, 6)) - 1))) + "转移500点积分")
	endif
	if s == "+ys" or s == "+YS" then
		call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, (GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) + 200.00), 1.00)
	endif
	if s == "+js" or s == "+JS" then
		call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, (GetCameraField(CAMERA_FIELD_TARGET_DISTANCE) - 200.00), 1.00)
	endif
	if s == "sj" then
		call SetCameraFieldForPlayer(GetTriggerPlayer(), CAMERA_FIELD_TARGET_DISTANCE, 1800., 0)
	endif
	if s == "fb" then
		call FBdaojishi()
	endif
	if s == "bl" then
		call BanLvShuXing()
	endif
	if s == "yx" then
		call YaoXing()
	endif
	if s == "jy" then
		call TransferJY()
	endif
	//自由属性点系统
	if SubStringBJ(s, 1, 2) == "wx" or SubStringBJ(s, 1, 2) == "WX" then
		if udg_shuxing[i] >= 1 then
			if S2I(SubStringBJ(s, 3, 5)) <= 0 or S2I(SubStringBJ(s, 3, 5)) > udg_shuxing[i] then
				set wuxing[i] = wuxing[i] + 1
				set udg_shuxing[i] = udg_shuxing[i] - 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配1点悟性，剩余属性点：" + I2S(udg_shuxing[i]))
			else
				set wuxing[i] = wuxing[i] + S2I(SubStringBJ(s, 3, 5))
				set udg_shuxing[i] = udg_shuxing[i] - S2I(SubStringBJ(s, 3, 5))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配" + SubStringBJ(s, 3, 5) + "点悟性，剩余属性点：" + I2S(udg_shuxing[i]))
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000属性点已用完")
		endif
	elseif SubStringBJ(s, 1, 2) == "fy" or SubStringBJ(s, 1, 2) == "FY" then
		if udg_shuxing[i] >= 1 then
			if S2I(SubStringBJ(s, 3, 5)) <= 0 or S2I(SubStringBJ(s, 3, 5)) > udg_shuxing[i] then
				set fuyuan[i] = fuyuan[i] + 1
				set udg_shuxing[i] = udg_shuxing[i] - 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配1点福缘，剩余属性点：" + I2S(udg_shuxing[i]))
			else
				set fuyuan[i] = fuyuan[i] + S2I(SubStringBJ(s, 3, 5))
				set udg_shuxing[i] = udg_shuxing[i] - S2I(SubStringBJ(s, 3, 5))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配" + SubStringBJ(s, 3, 5) + "点福缘，剩余属性点：" + I2S(udg_shuxing[i]))
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000属性点已用完")
		endif
	elseif SubStringBJ(s, 1, 2) == "gg" or SubStringBJ(s, 1, 2) == "GG" then
		if udg_shuxing[i] >= 1 then
			if S2I(SubStringBJ(s, 3, 5)) <= 0 or S2I(SubStringBJ(s, 3, 5)) > udg_shuxing[i] then
				set gengu[i] = gengu[i] + 1
				set udg_shuxing[i] = udg_shuxing[i] - 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配1点根骨，剩余属性点：" + I2S(udg_shuxing[i]))
			else
				set gengu[i] = gengu[i] + S2I(SubStringBJ(s, 3, 5))
				set udg_shuxing[i] = udg_shuxing[i] - S2I(SubStringBJ(s, 3, 5))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配" + SubStringBJ(s, 3, 5) + "点根骨，剩余属性点：" + I2S(udg_shuxing[i]))
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000属性点已用完")
		endif
	elseif SubStringBJ(s, 1, 2) == "dp" or SubStringBJ(s, 1, 2) == "DP" then
		if udg_shuxing[i] >= 1 then
			if S2I(SubStringBJ(s, 3, 5)) <= 0 or S2I(SubStringBJ(s, 3, 5)) > udg_shuxing[i] then
				set danpo[i] = danpo[i] + 1
				set udg_shuxing[i] = udg_shuxing[i] - 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配1点胆魄，剩余属性点：" + I2S(udg_shuxing[i]))
			else
				set danpo[i] = danpo[i] + S2I(SubStringBJ(s, 3, 5))
				set udg_shuxing[i] = udg_shuxing[i] - S2I(SubStringBJ(s, 3, 5))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配" + SubStringBJ(s, 3, 5) + "点胆魄，剩余属性点：" + I2S(udg_shuxing[i]))
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000属性点已用完")
		endif
	elseif SubStringBJ(s, 1, 2) == "ys" or SubStringBJ(s, 1, 2) == "YS" then
		if udg_shuxing[i] >= 1 then
			if S2I(SubStringBJ(s, 3, 5)) <= 0 or S2I(SubStringBJ(s, 3, 5)) > udg_shuxing[i] then
				set yishu[i] = yishu[i] + 1
				set udg_shuxing[i] = udg_shuxing[i] - 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配1点医术，剩余属性点：" + I2S(udg_shuxing[i]))
			else
				set yishu[i] = yishu[i] + S2I(SubStringBJ(s, 3, 5))
				set udg_shuxing[i] = udg_shuxing[i] - S2I(SubStringBJ(s, 3, 5))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配" + SubStringBJ(s, 3, 5) + "点医术，剩余属性点：" + I2S(udg_shuxing[i]))
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000属性点已用完")
		endif
	elseif SubStringBJ(s, 1, 2) == "jm" or SubStringBJ(s, 1, 2) == "JM" then
		if udg_shuxing[i] >= 1 then
			if S2I(SubStringBJ(s, 3, 5)) <= 0 or S2I(SubStringBJ(s, 3, 5)) > udg_shuxing[i] then
				set jingmai[i] = jingmai[i] + 1
				set udg_shuxing[i] = udg_shuxing[i] - 1
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配1点经脉，剩余属性点：" + I2S(udg_shuxing[i]))
			else
				set jingmai[i] = jingmai[i] + S2I(SubStringBJ(s, 3, 5))
				set udg_shuxing[i] = udg_shuxing[i] - S2I(SubStringBJ(s, 3, 5))
				call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000分配" + SubStringBJ(s, 3, 5) + "点经脉，剩余属性点：" + I2S(udg_shuxing[i]))
			endif
		else
			call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000属性点已用完")
		endif
	endif
	
	//测试码
	if s == "代码不乱用吧" and udg_isTest[GetPlayerId(p)] then
		call SetHeroLevel(udg_hero[i], GetHeroLevel(udg_hero[i]) + 5, true)
		set wuxuedian[i] = wuxuedian[i] + 5
		call unitadditembyidswapped(1227895642, udg_hero[i])
		call unitadditembyidswapped('I053', udg_hero[i])
		call unitadditembyidswapped('I054', udg_hero[i])
		call unitadditembyidswapped('I055', udg_hero[i])
		call unitadditembyidswapped('I04E', udg_hero[i])
		call unitadditembyidswapped('I02S', udg_hero[i])
		//call CreateNUnitsAtLoc(1,'o01U',GetTriggerPlayer(),GetUnitLoc(udg_hero[i]),bj_UNIT_FACING)
		set shengwang[i] = shengwang[i] + 5000
		set xiuxing[i] = 5
		set udg_lilianxishu[i] = udg_lilianxishu[i] + 3
		set udg_shuxing[i] = udg_shuxing[i] + 3000
		set shoujiajf[i] = shoujiajf[i] + 1000
	endif
	if s == "ts" and udg_isTest[GetPlayerId(p)] then
		call unitadditembyidswapped('I0CI', udg_hero[i])
		call unitadditembyidswapped('I0CH', udg_hero[i])
		call unitadditembyidswapped('I0DO', udg_hero[i])
		call unitadditembyidswapped('I01X', udg_hero[i])
		call unitadditembyidswapped('I01P', udg_hero[i])
		call unitadditembyidswapped('I01C', udg_hero[i])
		call unitadditembyidswapped('I010', udg_hero[i])
		call unitadditembyidswapped('I00W', udg_hero[i])
		call unitadditembyidswapped('I06F', udg_hero[i])
		call unitadditembyidswapped('I03A', udg_hero[i])
		call unitadditembyidswapped('I00L', udg_hero[i])
		call unitadditembyidswapped('I08W', udg_hero[i])
	endif
	if s == "九阴真人" and udg_isTest[GetPlayerId(p)] then
		call unitadditembyidswapped('I02X', udg_hero[i])
		call unitadditembyidswapped('I03I', udg_hero[i])
		call unitadditembyidswapped('I09H', udg_hero[i])
		call unitadditembyidswapped('I09I', udg_hero[i])
		call unitadditembyidswapped('I09G', udg_hero[i])
		call unitadditembyidswapped('I09J', udg_hero[i])
		call unitadditembyidswapped('I09K', udg_hero[i])
	endif
	if s == "fff" and udg_isTest[GetPlayerId(p)] then
		call SetPlayerAbilityAvailable(p, 'A07M', false)
	endif
	if (s == "贼哥牛逼" or s == "zgnb") and udg_isTest[GetPlayerId(p)] then
		if UnitTypeNotNull(GetTriggerUnit(), UNIT_TYPE_HERO) then
			call ModifyHeroStat(0, GetTriggerUnit(), 0, 100000)
			call ModifyHeroStat(1, GetTriggerUnit(), 0, 100000)
			call ModifyHeroStat(2, GetTriggerUnit(), 0, 100000)
		endif
		call commonAddGold( p, 1000000) // 奖励金钱
		call commonAddLumber( p, 1000000) // 木头
		call SetHeroLevel(udg_hero[i], GetHeroLevel(udg_hero[i]) + 5, true)
		set wuxuedian[i] = wuxuedian[i] + 500
		call unitadditembyidswapped(1227895642, udg_hero[i])
		call unitadditembyidswapped('I08V', udg_hero[i])
		call unitadditembyidswapped('I08W', udg_hero[i])
		call unitadditembyidswapped('I08X', udg_hero[i])
		call unitadditembyidswapped('I08Y', udg_hero[i])
		call unitadditembyidswapped('I08Z', udg_hero[i])
		call unitadditembyidswapped('I090', udg_hero[i])
		set shengwang[i] = shengwang[i] + 50000
		set xiuxing[i] = 6
		set udg_lilianxishu[i] = udg_lilianxishu[i] + 3
		set udg_shuxing[i] = udg_shuxing[i] + 30000
		set shoujiajf[i] = shoujiajf[i] + 10000
		set udg_shanghaixishou[i] = udg_shanghaixishou[i] + 1
		set heroKillCounter[i] = 9990

		set Jd[i] = 1
		set Id[i] = 1
		set Qd[i] = 1
		set ld[i] = 1
		set Od[i] = 1
		set Pd[i] = 1
		set Kd[i] = 1
		set Ld[i] = 1
		set Nd[i] = 1
		set Md[i] = 1
	endif
	if s == "next" and udg_isTest[GetPlayerId(p)] then
		set udg_boshu = udg_boshu + 1
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000已跳转至下一波")
	endif
	if s == "next15" and udg_isTest[GetPlayerId(p)] then
		set udg_boshu = 15
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000已跳转至15波")
	endif
	if s == "next28" and udg_isTest[GetPlayerId(p)] then
		set udg_boshu = 28
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000已跳转至28波")
	endif
	if s == "n7" then
		call setDifficultyAndExpRate(6)
		call SetPlayerTechResearched(Player(12), 'R001', 5)
		call SetPlayerTechResearched(Player(6), 'R001', 5)
		call SetPlayerTechResearched(Player(15), 'R001', 5)
	endif
	if s == "n8" then
		call setDifficultyAndExpRate(8)
		call SetPlayerTechResearched(Player(12), 'R001', 7)
		call SetPlayerTechResearched(Player(6), 'R001', 7)
		call SetPlayerTechResearched(Player(15), 'R001', 7)
	endif
	if s == "title" and udg_isTest[GetPlayerId(p)] then
		call AddSpecialEffectTargetEx("jinmengxiaoyao.mdx", udg_hero[1], "overhead")
	endif
	if (s == "撸下一波" or s == "lxyb") and udg_isTest[GetPlayerId(p)] then
		set udg_boshu = udg_boshu + 1
		call DisplayTextToPlayer(p, 0, 0, "|cFFFF0000已跳转至下一波")
	endif
	if s == "撸Boss8" or s == "lboss8" and udg_isTest[GetPlayerId(p)] then 
		call CreateNUnitsAtLocFacingLocBJ(1, u7[8], Player(6), v7[6], v7[4])
	endif
	if s == "addCoin" and udg_isTest[GetPlayerId(p)] then 
		call setCoin(passportCoin[i] + 100, i)
	endif
	// if s == "撸Boss" or s=="撸boss" and udg_isTest[GetPlayerId(p)] then 
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[5],Player(6),v7[6],v7[4])
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[1],Player(6),v7[6],v7[4])
	// endif
	// if s=="撸Boss1" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[1],Player(6),v7[6],v7[4])
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[1],Player(0),v7[6],v7[4])
	// elseif s=="撸Boss2" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[2],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss3" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[3],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss4" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[4],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss5" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[5],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss6" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[6],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss7" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[7],Player(6),v7[6],v7[4])
	// elseif s=="撸Boss8" and udg_vip[i]>1 then
	// 	call CreateNUnitsAtLocFacingLocBJ(1,u7[8],Player(6),v7[6],v7[4])
	// elseif s=="撸LiaoGuo" and udg_vip[i]>1 then
	// 	call LiaoGuoJinGong()
	// elseif s=="撸LingJiu" and udg_vip[i]>1 then
	// 	call LingJiuGongJinGong()
	// endif
	set p = null
	set it = null
endfunction

function KeyInputSystem takes nothing returns nothing
	local trigger t = CreateTrigger()
	local integer i = 0
	loop
		exitwhen i > 6
		call TriggerRegisterPlayerChatEvent(t, Player(i), "", true)
		set i = i + 1
	endloop
	call TriggerAddAction(t, function KeyInput)
	set t = null
endfunction
