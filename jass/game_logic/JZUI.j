globals
	Frame array zwidget
	Frame array zbutton

	Frame array plusWidget
	Frame array plusButton
	
	Frame array checkboxWidget
	Frame array checkboxButton

	Frame avatar
	Frame avatarBack
	Frame closeBtn
	Frame heroDiscription
	Frame bibo_image
	Frame bibo_text
	
	Frame helpWidget // 帮助按钮图片
	Frame helpButton // 帮助按钮
	Frame helpAttrWidget // 帮助属性按钮图片
	Frame helpAttrButton // 帮助属性按钮
	Frame helpKungfuWidget // 帮助武功按钮图片
	Frame helpKungfuButton // 帮助武功按钮
	Frame helpCommandWidget // 帮助指令按钮图片
	Frame helpCommandButton // 帮助指令按钮
	Frame tutorial // 教程页面
	Frame attribute // 属性教程页面
	Frame command // 指令教程页面
	Frame closeTutorialWidget // 关闭教程按钮图片
	Frame closeTutorialButton // 关闭教程按钮
	Frame closeAttributeWidget // 关闭属性教程按钮图片
	Frame closeAttributeButton // 关闭属性教程按钮
	Frame closeCommandWidget // 关闭指令教程按钮图片
	Frame closeCommandButton // 关闭指令教程按钮

	Frame levelWidget // 等级按钮图片
	Frame levelButton // 等级按钮
	Frame closeLevelWidget // 关闭等级按钮图片
	Frame closeLevelButton // 关闭等级按钮
	Frame levelPopup // 等级弹出框


	Frame qimen_widget
	Frame qimen_button // 奇门术数按钮
	Frame qimen_text // 奇门术数按钮上的文字

	Frame interAbilityPanel // 内化技能面板
	Frame array interAbilityWidget // 内化的技能按钮图片
	Frame array interAbilityLock // 内化的技能按钮锁图片
	Frame array interAbilityButton // 内化的技能按钮
	Frame closeInterWidget // 关闭内化按钮图片
	Frame closeInterButton // 关闭内化按钮


	string array attrStr
	// UI设置对齐锚点的常量 DzFrameSetPoint achor定义，从0开始
	constant integer TOPLEFT = 0
	constant integer TOP = 1
	constant integer TOPRIGHT = 2
	constant integer LEFT = 3
	constant integer CENTER = 4
	constant integer RIGHT = 5
	constant integer BOTTOMLEFT = 6
	constant integer BOTTOM = 7
	constant integer BOTTOMRIGHT = 8
	
	//DzFrameSetScript  注册ui事件的事件ID
	constant integer NONE = 0
	constant integer FRAME_EVENT_PRESSED = 1
	constant integer FRAME_MOUSE_ENTER = 2
	constant integer FRAME_MOUSE_LEAVE = 3
	constant integer FRAME_MOUSE_UP = 4
	constant integer FRAME_MOUSE_DOWN = 5
	constant integer FRAME_MOUSE_WHEEL = 6
	constant integer FRAME_FOCUS_ENTER = FRAME_MOUSE_ENTER
	constant integer FRAME_FOCUS_LEAVE = FRAME_MOUSE_LEAVE
	constant integer FRAME_CHECKBOX_CHECKED = 7
	constant integer FRAME_CHECKBOX_UNCHECKED = 8
	constant integer FRAME_EDITBOX_TEXT_CHANGED = 9
	constant integer FRAME_POPUPMENU_ITEM_CHANGE_START = 10
	constant integer FRAME_POPUPMENU_ITEM_CHANGED = 11
	constant integer FRAME_MOUSE_DOUBLECLICK = 12
	constant integer FRAME_SPRITE_ANIM_UPDATE = 13

	// 最多允许的内化技能数量
	constant integer MAX_INTER_ABILITY_COUNT = 6
endglobals

function toggleFuncBoard takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[3].toggle()
	endif
endfunction

function toggleTutorial takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call tutorial.toggle()
	endif
endfunction

function toggleAttribute takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call attribute.toggle()
	endif
endfunction

function toggleCommand takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call command.toggle()
	endif
endfunction

function toggleAllHelpWidgets takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call helpAttrWidget.toggle()
		call helpKungfuWidget.toggle()
		call helpCommandWidget.toggle()
	endif
endfunction

function toggleHelpWidget takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call helpWidget.toggerHover("war3mapImported\\help.tga", "war3mapImported\\help_hover.tga")
	endif
endfunction

function toggleHelpAttrWidget takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call helpAttrWidget.toggerHover("war3mapImported\\help_attr.tga", "war3mapImported\\help_attr_hover.tga")
	endif
endfunction

function toggleHelpKungfuWidget takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call helpKungfuWidget.toggerHover("war3mapImported\\help_kungfu.tga", "war3mapImported\\help_kungfu_hover.tga")
	endif
endfunction

function toggleHelpCommandWidget takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call helpCommandWidget.toggerHover("war3mapImported\\help_command.tga", "war3mapImported\\help_command_hover.tga")
	endif
endfunction

function toggleLevelWidget takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call levelWidget.toggerHover("war3mapImported\\level.tga", "war3mapImported\\level_hover.tga")
	endif
endfunction

function toggleLevelPopup takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call levelPopup.toggle()
	endif
endfunction


function toggleAttrBoard takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[102].setText(I2S(IMinBJ(R2I((udg_baojilv[i] * 100.)), 100)) + "%")
		call zwidget[104].setText(I2S(R2I((udg_baojishanghai[i] * 100.))) + "%")
		call zwidget[106].setText(I2S(R2I((udg_shanghaijiacheng[i] * 100.))) + "%")
		call zwidget[108].setText(I2S(IMinBJ(R2I((udg_shanghaixishou[i] * 100.)), 80)) + "%")
		
		call zwidget[110].setText(I2S(gengu[i]))
		call zwidget[112].setText(I2S(wuxing[i]))
		call zwidget[114].setText(I2S(jingmai[i]))
		call zwidget[116].setText(I2S(fuyuan[i]))
		call zwidget[118].setText(I2S(danpo[i]))
		call zwidget[120].setText(I2S(yishu[i]))
		
		call zwidget[122].setText(I2S(juexuelingwu[i]))
		call zwidget[124].setText(I2S(xiuxing[i]))
		call zwidget[126].setText("第" + I2S(wugongxiuwei[i]) + "层")
		call zwidget[128].setText(I2S(shengwang[i]))
		call zwidget[130].setText(I2S(shoujiajf[i]))
		if not Deputy_isDeputy(i, LIAN_DAN) then
			call zwidget[132].setText(I2S(yongdanshu[i]) + " / 10")
		else
			call zwidget[132].setText(I2S(yongdanshu[i]) + " / 15")
		endif
		
		call zwidget[14].toggle()
	endif
endfunction

function toggleOpenButton takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[1].toggerHover("ReplaceableTextures\\CommandButtons\\BTNtab.blp", "ReplaceableTextures\\CommandButtons\\BTNtab.blp")
	endif
endfunction

function toggleWidget5 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[5].toggerHover("war3mapImported\\achievement01.tga", "war3mapImported\\achievement02.tga")
	endif
endfunction

function toggleWidget6 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[6].toggerHover("war3mapImported\\achievement01.tga", "war3mapImported\\achievement02.tga")
	endif
endfunction
function toggleWidget7 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[7].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
	endif
endfunction
function toggleWidget8 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[8].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
	endif
endfunction
function toggleWidget9 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[9].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
	endif
endfunction
function toggleWidget10 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[10].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
	endif
endfunction
function toggleWidget11 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[11].toggerHover("war3mapImported\\non_open01.tga", "war3mapImported\\non_open02.tga")
	endif
endfunction
function toggleWidget12 takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call zwidget[12].toggerHover("ReplaceableTextures\\CommandButtons\\BTNesc.blp", "ReplaceableTextures\\CommandButtons\\BTNesc.blp")
	endif
endfunction

function hideInterTip takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call interAbilityWidget[100].hide()
	endif
endfunction

function hideInterAbilityPanel takes nothing returns nothing
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call interAbilityPanel.hide()
		call DisplayTextToPlayer(GetLocalPlayer(), 0, 0, "|cffffcc00内化武功面板已关闭，你可以通过命令|r|cff00ff00showUI命令|r|cffffcc00再次打开内化武功面板|r")
	endif
endfunction

function showInterTip takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
	local integer j = 1
	local integer id = 0
	local string name = ""
	local string description = ""
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		loop
			exitwhen j > MAX_INTER_ABILITY_COUNT
			if DzGetTriggerUIEventFrame() == interAbilityButton[j].id then
				if j <= alreadyInternalizedCount[i] then
					set id = LoadInteger(YDHT, interAbilityKey + i, j)
					set name = YDWEGetUnitAbilityDataString(udg_hero[i], id, GetUnitAbilityLevel(udg_hero[i], id), 215)
					set description = YDWEGetUnitAbilityDataString(udg_hero[i], id, GetUnitAbilityLevel(udg_hero[i], id), 218)
					call interAbilityWidget[101].setText(name)
					call interAbilityWidget[102].setText(description)
					call interAbilityWidget[102].setPoint(BOTTOM, interAbilityWidget[j], TOP, 0, 0.03)
					call interAbilityWidget[101].setPoint(BOTTOM, interAbilityWidget[102], TOP, 0, 0.005)
					call interAbilityWidget[100].show()
				elseif j > interAbilityCount[i] then
					call interAbilityWidget[101].setText("|CFF00FFCD该功能需要解锁|r")
					call interAbilityWidget[102].setText("请到网易对战平台商城购买解锁")
					call interAbilityWidget[102].setPoint(BOTTOM, interAbilityWidget[j], TOP, 0, 0.03)
					call interAbilityWidget[101].setPoint(BOTTOM, interAbilityWidget[102], TOP, 0, 0.005)
					call interAbilityWidget[100].show()
				else
					call interAbilityWidget[101].setText("|CFF00FFCD可以内化被动武功|r")
					call interAbilityWidget[102].setText("使用侠侣身上的技能选择要内化的被动武功，内化后的武功不可遗忘")
					call interAbilityWidget[102].setPoint(BOTTOM, interAbilityWidget[j], TOP, 0, 0.03)
					call interAbilityWidget[101].setPoint(BOTTOM, interAbilityWidget[102], TOP, 0, 0.005)
					call interAbilityWidget[100].show()
				endif
			endif
			set j = j + 1
		endloop
	endif
endfunction

function doToggleQimenStatus takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set qimen_status[i] = qimen_status[i] + 1
	if qimen_status[i] == 3 then
		set qimen_status[i] = 0
	endif
	if Player(i - 1) == GetLocalPlayer() then
		if qimen_status[i] == 0 then
			// call qimen_button.setText("伤害")
			call qimen_widget.setTexture("war3mapImported\\qm_sh.tga")
		elseif qimen_status[i] == 1 then
			// call qimen_button.setText("六围")
			call qimen_widget.setTexture("war3mapImported\\qm_lw.tga")
		elseif qimen_status[i] == 2 then
			// call qimen_button.setText("护体")
			call qimen_widget.setTexture("war3mapImported\\qm_ht.tga")
		endif
	endif
endfunction

function toggleQimenStatus takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
	// call doToggleQimenStatus(i)
	call DzSyncData("qimen", I2S(i))
endfunction

function hideAddButtons takes integer i returns nothing
	call plusWidget[1].hide()
	call plusWidget[2].hide()
	call plusWidget[3].hide()
	call plusWidget[4].hide()
	call plusWidget[5].hide()
	call plusWidget[6].hide()
	call plusButton[1].hide()
	call plusButton[2].hide()
	call plusButton[3].hide()
	call plusButton[4].hide()
	call plusButton[5].hide()
	call plusButton[6].hide()
endfunction

function showAddButtons takes integer i returns nothing
	call plusWidget[1].show()
	call plusWidget[2].show()
	call plusWidget[3].show()
	call plusWidget[4].show()
	call plusWidget[5].show()
	call plusWidget[6].show()
	call plusButton[1].show()
	call plusButton[2].show()
	call plusButton[3].show()
	call plusButton[4].show()
	call plusButton[5].show()
	call plusButton[6].show()
endfunction

function addGengu takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set gengu[i] = gengu[i] + 1
	set udg_shuxing[i] = udg_shuxing[i] - 1
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
	endif
endfunction

function addWuxing takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set wuxing[i] = wuxing[i] + 1
	set udg_shuxing[i] = udg_shuxing[i] - 1
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
	endif
endfunction

function addJingmai takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set jingmai[i] = jingmai[i] + 1
	set udg_shuxing[i] = udg_shuxing[i] - 1
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
	endif
endfunction

function addFuyuan takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set fuyuan[i] = fuyuan[i] + 1
	set udg_shuxing[i] = udg_shuxing[i] - 1
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
	endif
endfunction

function addDanpo takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set danpo[i] = danpo[i] + 1
	set udg_shuxing[i] = udg_shuxing[i] - 1
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
	endif
endfunction

function addYishu takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set yishu[i] = yishu[i] + 1
	set udg_shuxing[i] = udg_shuxing[i] - 1
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
	endif
endfunction

function addAttr takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
	local integer frameId = DzGetTriggerUIEventFrame()
	if udg_shuxing[i] <= 0 and Player(i - 1) == GetLocalPlayer() then
		call hideAddButtons(i)
		return
	endif
	if frameId == plusButton[1].id then
		if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
			call zwidget[110].setText(I2S(gengu[i] + 1))
			call zwidget[136].setText(I2S(udg_shuxing[i] - 1))
		endif
		call DzSyncData("gengu", I2S(i))
	elseif frameId == plusButton[2].id then
		if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
			call zwidget[112].setText(I2S(wuxing[i] + 1))
			call zwidget[136].setText(I2S(udg_shuxing[i] - 1))
		endif
		call DzSyncData("wuxing", I2S(i))
	elseif frameId == plusButton[3].id then
		if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
			call zwidget[114].setText(I2S(jingmai[i] + 1))
			call zwidget[136].setText(I2S(udg_shuxing[i] - 1))
		endif
		call DzSyncData("jingmai", I2S(i))
	elseif frameId == plusButton[4].id then
		if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
			call zwidget[116].setText(I2S(fuyuan[i] + 1))
			call zwidget[136].setText(I2S(udg_shuxing[i] - 1))
		endif
		call DzSyncData("fuyuan", I2S(i))
	elseif frameId == plusButton[5].id then
		if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
			call zwidget[118].setText(I2S(danpo[i] + 1))
			call zwidget[136].setText(I2S(udg_shuxing[i] - 1))
		endif
		call DzSyncData("danpo", I2S(i))
	elseif frameId == plusButton[6].id then
		if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
			call zwidget[120].setText(I2S(yishu[i] + 1))
			call zwidget[136].setText(I2S(udg_shuxing[i] - 1))
		endif
		call DzSyncData("yishu", I2S(i))
	endif
endfunction



function pressEsc takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerKeyPlayer())
	if DzGetTriggerKeyPlayer() == GetLocalPlayer() then
		call zwidget[102].setText(I2S(IMinBJ(R2I((udg_baojilv[i] * 100.)), 100)) + "%")
		call zwidget[104].setText(I2S(R2I((udg_baojishanghai[i] * 100.))) + "%")
		call zwidget[106].setText(I2S(R2I((udg_shanghaijiacheng[i] * 100.))) + "%")
		call zwidget[108].setText(I2S(IMinBJ(R2I((udg_shanghaixishou[i] * 100.)), 80)) + "%")
		
		call zwidget[110].setText(I2S(gengu[i]))
		call zwidget[112].setText(I2S(wuxing[i]))
		call zwidget[114].setText(I2S(jingmai[i]))
		call zwidget[116].setText(I2S(fuyuan[i]))
		call zwidget[118].setText(I2S(danpo[i]))
		call zwidget[120].setText(I2S(yishu[i]))
		
		call zwidget[122].setText(I2S(juexuelingwu[i]))
		call zwidget[124].setText(I2S(xiuxing[i]))
		call zwidget[126].setText("第" + I2S(wugongxiuwei[i]) + "层")
		call zwidget[128].setText(I2S(shengwang[i]))
		call zwidget[130].setText(I2S(shoujiajf[i]))
		if not Deputy_isDeputy(i, LIAN_DAN) then
			call zwidget[132].setText(I2S(yongdanshu[i]) + " / 10")
		else
			call zwidget[132].setText(I2S(yongdanshu[i]) + " / 15")
		endif
		call zwidget[134].setText(I2S(special_attack[i]))
		call zwidget[136].setText(I2S(udg_shuxing[i]))
		
		call zwidget[14].toggle()

		if udg_shuxing[i] <= 0 then
			call hideAddButtons(i) 
		else
			call showAddButtons(i)
		endif
	endif
endfunction

function releaseEsc takes nothing returns nothing
	if DzGetTriggerKeyPlayer() == GetLocalPlayer() then
		call zwidget[14].hide()
	endif
endfunction

function pressTab takes nothing returns nothing
	if DzGetTriggerKeyPlayer() == GetLocalPlayer() then
		call zwidget[3].toggle()
	endif
endfunction

function toggleShowDamage takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call checkboxWidget[2].toggle()
		call DzSyncData("showDmg", I2S(i))
	endif
endfunction

function doToggleShowDamage takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	set showDamage[i] = not showDamage[i]
endfunction

function toggleShowAbilityEffect takes nothing returns nothing
	local integer i = 1 + GetPlayerId(DzGetTriggerUIEventPlayer())
	if DzGetTriggerUIEventPlayer() == GetLocalPlayer() then
		call checkboxWidget[4].toggle()
		call DzSyncData("showEffect", I2S(i))
	endif
endfunction

function doToggleShowEffect takes nothing returns nothing
	local integer i = S2I(DzGetTriggerSyncData())
	if IsPlayerInForce(Player(i - 1), showEffectForce) then
		call ForceRemovePlayer(showEffectForce, Player(i - 1))
	else
		call ForceAddPlayer(showEffectForce, Player(i - 1))
	endif
endfunction



function drawUI_Conditions takes nothing returns boolean
	local integer index = 100
	local integer ff0 = DzFrameGetHeroManaBar(0)
	local integer ff1 = DzFrameGetHeroBarButton(1)
	local integer ff2 = DzFrameGetHeroBarButton(2)
	local integer ff3 = DzFrameGetHeroBarButton(3)
	local integer fh1 = DzFrameGetHeroHPBar(1)
	local integer fh2 = DzFrameGetHeroHPBar(2)
	local integer fh3 = DzFrameGetHeroHPBar(3)
	local integer fm1 = DzFrameGetHeroManaBar(1)
	local integer fm2 = DzFrameGetHeroManaBar(2)
	local integer fm3 = DzFrameGetHeroManaBar(3)
	
	
	
	call DzFrameClearAllPoints(ff1)
	call DzFrameClearAllPoints(ff2)
	call DzFrameClearAllPoints(ff3)
	call DzFrameClearAllPoints(fh1)
	call DzFrameClearAllPoints(fh2)
	call DzFrameClearAllPoints(fh3)
	call DzFrameClearAllPoints(fm1)
	call DzFrameClearAllPoints(fm2)
	call DzFrameClearAllPoints(fm3)
	
	call DzFrameSetSize(ff1, 0.021, 0.028)
	call DzFrameSetSize(ff2, 0.021, 0.028)
	call DzFrameSetSize(ff3, 0.021, 0.028)
	call DzFrameSetSize(fh1, 0.01, 0.01)
	call DzFrameSetSize(fh2, 0.01, 0.01)
	call DzFrameSetSize(fh3, 0.01, 0.01)
	call DzFrameSetSize(fm1, 0.01, 0.01)
	call DzFrameSetSize(fm2, 0.01, 0.01)
	call DzFrameSetSize(fm3, 0.01, 0.01)
	
	call DzFrameSetPoint(ff1, LEFT, DzFrameGetMinimap(), TOPRIGHT, 0.008, - 0.001)
	call DzFrameSetPoint(ff2, 1, ff1, 7, 0, - 0.004)
	call DzFrameSetPoint(ff3, 1, ff2, 7, 0, - 0.004)
	call DzFrameSetPoint(fh1, 6, DzGetGameUI(), 8, .8, .6)
	call DzFrameSetPoint(fh2, 6, DzGetGameUI(), 8, .8, .6)
	call DzFrameSetPoint(fh3, 6, DzGetGameUI(), 8, .8, .6)
	call DzFrameSetPoint(fm1, 6, DzGetGameUI(), 8, .8, .6)
	call DzFrameSetPoint(fm2, 6, DzGetGameUI(), 8, .8, .6)
	call DzFrameSetPoint(fm3, 6, DzGetGameUI(), 8, .8, .6)
	
	call DzLoadToc("ui\\custom.toc")

	// 帮助按钮
	set helpWidget = Frame.newImage1(GUI, "war3mapImported\\help.tga", 0.032, 0.04)
	call helpWidget.setPoint(3, Frame.getFrame(DzFrameGetHeroBarButton(0)), 5, 0.05, - 0.005)
	
	set helpButton = Frame.newTextButton(helpWidget)
	call helpButton.setAllPoints(helpWidget)
	call helpButton.regEvent(FRAME_EVENT_PRESSED, function toggleAllHelpWidgets)
	call helpButton.regEvent(FRAME_MOUSE_ENTER, function toggleHelpWidget)
	call helpButton.regEvent(FRAME_MOUSE_LEAVE, function toggleHelpWidget)

	set helpAttrWidget = Frame.newImage1(GUI, "war3mapImported\\help_attr.tga", 0.032, 0.04)
	call helpAttrWidget.setPoint(CENTER, helpWidget, CENTER, - 0.032, - 0.04)
	call helpAttrWidget.hide()

	set helpAttrButton = Frame.newTextButton(helpAttrWidget)
	call helpAttrButton.setAllPoints(helpAttrWidget)
	call helpAttrButton.regEvent(FRAME_EVENT_PRESSED, function toggleAttribute)
	call helpAttrButton.regEvent(FRAME_MOUSE_ENTER, function toggleHelpAttrWidget)
	call helpAttrButton.regEvent(FRAME_MOUSE_LEAVE, function toggleHelpAttrWidget)

	set helpCommandWidget = Frame.newImage1(GUI, "war3mapImported\\help_command.tga", 0.032, 0.04)
	call helpCommandWidget.setPoint(CENTER, helpWidget, CENTER, 0.032, - 0.04)
	call helpCommandWidget.hide()

	set helpCommandButton = Frame.newTextButton(helpCommandWidget)
	call helpCommandButton.setAllPoints(helpCommandWidget)
	call helpCommandButton.regEvent(FRAME_EVENT_PRESSED, function toggleCommand)
	call helpCommandButton.regEvent(FRAME_MOUSE_ENTER, function toggleHelpCommandWidget)
	call helpCommandButton.regEvent(FRAME_MOUSE_LEAVE, function toggleHelpCommandWidget)

	set helpKungfuWidget = Frame.newImage1(GUI, "war3mapImported\\help_kungfu.tga", 0.032, 0.04)
	call helpKungfuWidget.setPoint(CENTER, helpWidget, CENTER, 0, - 0.04 * 1.414)
	call helpKungfuWidget.hide()

	set helpKungfuButton = Frame.newTextButton(helpKungfuWidget)
	call helpKungfuButton.setAllPoints(helpKungfuWidget)
	call helpKungfuButton.regEvent(FRAME_EVENT_PRESSED, function toggleTutorial)
	call helpKungfuButton.regEvent(FRAME_MOUSE_ENTER, function toggleHelpKungfuWidget)
	call helpKungfuButton.regEvent(FRAME_MOUSE_LEAVE, function toggleHelpKungfuWidget)

	set tutorial = Frame.newImage1(GUI, "war3mapImported\\tutorial.tga", 0.45, 0.4)
	call tutorial.setPoint(4, GUI, 4, 0.0, 0.0)
	call tutorial.hide()

	set closeTutorialWidget = Frame.newImage1(tutorial, "war3mapImported\\close0.tga", 0.018, 0.024)
	call closeTutorialWidget.setPoint(CENTER, tutorial, TOPRIGHT, 0, 0)

	set closeTutorialButton = Frame.newTextButton(closeTutorialWidget)
	call closeTutorialButton.setAllPoints(closeTutorialWidget)
	call closeTutorialButton.regEvent(FRAME_EVENT_PRESSED, function toggleTutorial)

	set command = Frame.newImage1(GUI, "war3mapImported\\command.tga", 0.45, 0.4)
	call command.setPoint(4, GUI, 4, 0.0, 0.0)
	call command.hide()

	set closeCommandWidget = Frame.newImage1(command, "war3mapImported\\close0.tga", 0.018, 0.024)
	call closeCommandWidget.setPoint(CENTER, command, TOPRIGHT, 0, 0)

	set closeCommandButton = Frame.newTextButton(closeCommandWidget)
	call closeCommandButton.setAllPoints(closeCommandWidget)
	call closeCommandButton.regEvent(FRAME_EVENT_PRESSED, function toggleCommand)

	set attribute = Frame.newImage1(GUI, "war3mapImported\\attribute.tga", 0.45, 0.4)
	call attribute.setPoint(4, GUI, 4, 0.0, 0.0)
	call attribute.hide()

	set closeAttributeWidget = Frame.newImage1(attribute, "war3mapImported\\close0.tga", 0.018, 0.024)
	call closeAttributeWidget.setPoint(CENTER, attribute, TOPRIGHT, 0, 0)

	set closeAttributeButton = Frame.newTextButton(closeAttributeWidget)
	call closeAttributeButton.setAllPoints(closeAttributeWidget)
	call closeAttributeButton.regEvent(FRAME_EVENT_PRESSED, function toggleAttribute)
	
	// 创建功能开启按钮背景
	//set zwidget[1] = Frame.newImage1(GUI, "ReplaceableTextures\\CommandButtons\\BTNtab.blp", 0.03, 0.04)
	//call zwidget[1].setPoint(1, Frame.getFrame(DzFrameGetHeroBarButton(3)), 7, 0.0, -0.012)
	//call zwidget[1].setAlpha(255)
	
	
	// 创建功能开启按钮
	//set zbutton[1] = Frame.newTextButton(zwidget[1])
	//call zbutton[1].setAllPoints(zwidget[1])
	//call zbutton[1].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	
	//call DzFrameSetScript(udg_UI_Gn_AN[1], 2, "Trig_GN_JiemianAActions", false)
	//call DzFrameSetScript(udg_UI_Gn_AN[1], 3, "Trig_GN_JiemianBActions", false)
	//call DzFrameSetScript(udg_UI_Gn_AN[1], 1, "Trig_GN_JiemianCActions", false)
	// 功能界面
	set zwidget[3] = Frame.newImage1(GUI, "war3mapImported\\jz01.tga", 0.3, 0.3)
	call zwidget[3].setPoint(4, GUI, 4, 0.0, 0.08)
	call zwidget[3].hide()
	
	// 关闭按钮贴图
	set zwidget[4] = Frame.newImage1(zwidget[3], "war3mapImported\\close.tga", 0.02, 0.02)
	call zwidget[4].setPoint(4, zwidget[3], 2, - 0.01, - 0.01)
	
	// 关闭按钮
	set zbutton[2] = Frame.newTextButton(zwidget[4])
	call zbutton[2].setAllPoints(zwidget[4])
	call zbutton[2].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	
	// 任务面板
	set zwidget[5] = Frame.newImage1(zwidget[3], "war3mapImported\\achievement01.tga", 0.04, 0.015)
	call zwidget[5].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.021)
	
	set zbutton[3] = Frame.newTextButton(zwidget[5])
	call zbutton[3].setAllPoints(zwidget[5])
	call zbutton[3].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[3].regEvent(FRAME_MOUSE_ENTER, function toggleWidget5)
	call zbutton[3].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget5)
	
	// 地图成就
	set zwidget[6] = Frame.newImage1(zwidget[3], "war3mapImported\\achievement01.tga", 0.04, 0.015)
	call zwidget[6].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.061)
	
	set zbutton[4] = Frame.newTextButton(zwidget[6])
	call zbutton[4].setAllPoints(zwidget[6])
	call zbutton[4].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[4].regEvent(FRAME_MOUSE_ENTER, function toggleWidget6)
	call zbutton[4].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget6)
	
	set zwidget[7] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
	call zwidget[7].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.101)
	
	set zbutton[5] = Frame.newTextButton(zwidget[7])
	call zbutton[5].setAllPoints(zwidget[7])
	call zbutton[5].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[5].regEvent(FRAME_MOUSE_ENTER, function toggleWidget7)
	call zbutton[5].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget7)
	
	set zwidget[8] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
	call zwidget[8].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.141)
	
	set zbutton[6] = Frame.newTextButton(zwidget[8])
	call zbutton[6].setAllPoints(zwidget[8])
	call zbutton[6].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[6].regEvent(FRAME_MOUSE_ENTER, function toggleWidget8)
	call zbutton[6].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget8)
	
	set zwidget[9] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
	call zwidget[9].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.181)
	
	set zbutton[7] = Frame.newTextButton(zwidget[9])
	call zbutton[7].setAllPoints(zwidget[9])
	call zbutton[7].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[7].regEvent(FRAME_MOUSE_ENTER, function toggleWidget9)
	call zbutton[7].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget9)
	
	set zwidget[10] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
	call zwidget[10].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.221)
	
	set zbutton[8] = Frame.newTextButton(zwidget[10])
	call zbutton[8].setAllPoints(zwidget[10])
	call zbutton[8].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[8].regEvent(FRAME_MOUSE_ENTER, function toggleWidget10)
	call zbutton[8].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget10)
	
	set zwidget[11] = Frame.newImage1(zwidget[3], "war3mapImported\\non_open01.tga", 0.04, 0.015)
	call zwidget[11].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.035, - 0.261)
	
	set zbutton[9] = Frame.newTextButton(zwidget[11])
	call zbutton[9].setAllPoints(zwidget[11])
	call zbutton[9].regEvent(FRAME_EVENT_PRESSED, function toggleFuncBoard)
	call zbutton[9].regEvent(FRAME_MOUSE_ENTER, function toggleWidget11)
	call zbutton[9].regEvent(FRAME_MOUSE_LEAVE, function toggleWidget11)
	
	// 创建属性开启按钮背景
	set zwidget[12] = Frame.newImage1(GUI, "ReplaceableTextures\\CommandButtons\\BTNesc.blp", 0.021, 0.028)
	call zwidget[12].setPoint(1, Frame.getFrame(DzFrameGetHeroBarButton(3)), 7, 0.0, - 0.004)
	call zwidget[12].setAlpha(255)
	
	// 创建属性介绍
	//set zwidget[13]= Frame.newText1(zwidget[12], "属性", "TXA10")
	//call zwidget[13].setPoint(4, zwidget[12], 4, 0, 0)
	
	
	// 内化武功面板
	set interAbilityPanel = Frame.newImage1(GUI, "war3mapImported\\inter.tga", 0.25, 0.09)
	call interAbilityPanel.setPoint(CENTER, GUI, CENTER, 0, - 0.12)

	set closeInterWidget = Frame.newImage1(interAbilityPanel, "war3mapImported\\close0.tga", 0.018, 0.024)
	call closeInterWidget.setPoint(CENTER, interAbilityPanel, TOPRIGHT, 0, -0.012)

	set closeInterButton = Frame.newTextButton(closeInterWidget)
	call closeInterButton.setAllPoints(closeInterWidget)
	call closeInterButton.regEvent(FRAME_EVENT_PRESSED, function hideInterAbilityPanel)

	// 内化武功图片
	set interAbilityWidget[1] = Frame.newImage1(interAbilityPanel, "war3mapImported\\lock.tga", 0.035, 0.047)
	call interAbilityWidget[1].setPoint(LEFT, interAbilityPanel, LEFT, 0.02, - 0.005)
	call interAbilityWidget[1].setAlpha(0)

	set interAbilityLock[1] = Frame.newImage1(interAbilityWidget[1], "war3mapImported\\lock.tga", 0.035, 0.047)
	call interAbilityLock[1].setAllPoints(interAbilityWidget[1])
	call interAbilityLock[1].setAlpha(150)

	set index = 2
	loop
		exitwhen index > MAX_INTER_ABILITY_COUNT
		set interAbilityWidget[index] = Frame.newImage1(interAbilityPanel, "war3mapImported\\lock.tga", 0.035, 0.047)
		call interAbilityWidget[index].setPoint(LEFT, interAbilityWidget[index - 1], RIGHT, 0.002, 0)
		call interAbilityWidget[index].setAlpha(0)

		set interAbilityLock[index] = Frame.newImage1(interAbilityWidget[index], "war3mapImported\\lock.tga", 0.035, 0.047)
		call interAbilityLock[index].setAllPoints(interAbilityWidget[index])
		call interAbilityLock[index].setAlpha(150)
		set index = index + 1
	endloop

	set index = 1
	loop
		exitwhen index > MAX_INTER_ABILITY_COUNT
		set interAbilityButton[index] = Frame.newTextButton(interAbilityWidget[index])
		call interAbilityButton[index].setAllPoints(interAbilityWidget[index])
		call interAbilityButton[index].regEvent(FRAME_MOUSE_ENTER, function showInterTip)
		call interAbilityButton[index].regEvent(FRAME_MOUSE_LEAVE, function hideInterTip)
		set index = index + 1
	endloop

	set index = 1
	loop
		exitwhen index > 5
		call refreshInterUI(index)
		set index = index + 1
	endloop

	// 内化武功的说明
	set interAbilityWidget[100] = Frame.newTips0(GUI, "tipbox")
	call interAbilityWidget[100].hide()
	
	set interAbilityWidget[101] = Frame.newText1(interAbilityWidget[100], "", "TXA14")
	call interAbilityWidget[101].setSize(0.16, 0)

	set interAbilityWidget[102] = Frame.newText1(interAbilityWidget[100], "", "TXA11")
	call interAbilityWidget[102].setSize(0.16, 0)

	call interAbilityWidget[100].setPoint(TOPLEFT, interAbilityWidget[101], TOPLEFT, - 0.005, 0.005)
	call interAbilityWidget[100].setPoint(BOTTOMRIGHT, interAbilityWidget[102], BOTTOMRIGHT, 0.005, - 0.005)
	call interAbilityWidget[102].setPoint(BOTTOM, interAbilityWidget[1], TOP, 0, 0.03)
	call interAbilityWidget[101].setPoint(BOTTOM, interAbilityWidget[102], TOP, 0, 0.005)
	
	// 属性界面
	set zwidget[14] = Frame.newImage1(GUI, "war3mapImported\\blackback.tga", 0.3, 0.4)
	call zwidget[14].setPoint(4, GUI, 4, 0.0, 0.03)
	call zwidget[14].hide()
	
	// 显示属性
	set attrStr[1] = "暴击率："
	set attrStr[2] = "0%"
	set attrStr[3] = "暴击伤害："
	set attrStr[4] = "0%"
	set attrStr[5] = "伤害加成："
	set attrStr[6] = "0%"
	set attrStr[7] = "伤害吸收："
	set attrStr[8] = "0%"
	set attrStr[9] = "根骨："
	set attrStr[10] = "0"
	set attrStr[11] = "悟性："
	set attrStr[12] = "0"
	set attrStr[13] = "经脉："
	set attrStr[14] = "0"
	set attrStr[15] = "福缘："
	set attrStr[16] = "0"
	set attrStr[17] = "胆魄："
	set attrStr[18] = "0"
	set attrStr[19] = "医术："
	set attrStr[20] = "0"
	set attrStr[21] = "绝学领悟："
	set attrStr[22] = "0"
	set attrStr[23] = "修行："
	set attrStr[24] = "0"
	set attrStr[25] = "武学修为："
	set attrStr[26] = "0"
	set attrStr[27] = "江湖声望："
	set attrStr[28] = "0"
	set attrStr[29] = "守家积分："
	set attrStr[30] = "0"
	set attrStr[31] = "用丹数量："
	set attrStr[32] = "0"
	set attrStr[33] = "特殊攻击"
	set attrStr[34] = "0"
	set attrStr[35] = "自由属性"
	set attrStr[36] = "0"
	
	set index = 101
	loop
		exitwhen index > 136
		// set avatarBack = Frame.newImage1(zwidget[14], null, 0.1, 0.09)
		// call avatarBack.setPoint(TOPLEFT, zwidget[14], TOPLEFT, 0.04, -0.02)

		// set avatar = Frame.newSprite(avatarBack, "war3mapImported\\lan10_hei.mdl")
		// call avatar.setAllPoints(avatarBack)
		set closeBtn = Frame.newCloseButton(zwidget[14])
		call closeBtn.setPoint(TOPRIGHT, zwidget[14], TOPRIGHT, - 0.01, - 0.01)

		set zwidget[index] = Frame.newText1(zwidget[14], attrStr[index - 100], "TXA12")
		if ModuloInteger(index, 2) == 0 then
			call zwidget[index].setPoint(TOPLEFT, zwidget[14], TOPLEFT, 0.05 + 0.06 * ModuloInteger(index - 101, 4) , - 0.097 + (index - 97) / 4 * (- 0.029))
		else
			call zwidget[index].setPoint(TOPLEFT, zwidget[14], TOPLEFT, 0.05 + 0.065 * ModuloInteger(index - 101, 4) , - 0.097 + (index - 97) / 4 * (- 0.029))
		endif
		if ModuloInteger(index, 2) == 0 then
			call zwidget[index].setColor255(55, 39, 14)
		else
			if index <= 108 then
				call zwidget[index].setColor255(0, 25, 200)
			elseif index <= 120 then
				call zwidget[index].setColor255(200, 25, 0)
			else
				call zwidget[index].setColor255(200, 0, 200)
			endif
		endif
		set index = index + 1
	endloop

	set index = 1
	loop
		exitwhen index > 6
		set plusWidget[index] = Frame.newImage1(zwidget[14], "war3mapImported\\plus.tga", 0.012, 0.016)
		set plusButton[index] = Frame.newTextButton(plusWidget[index])
		call plusWidget[index].setPoint(LEFT, zwidget[108 + index * 2], LEFT, 0.025, 0.0)
		call plusButton[index].setAllPoints(plusWidget[index])
		call plusButton[index].regEvent(FRAME_EVENT_PRESSED, function addAttr)

		set index = index + 1
	endloop
	
	
	// 创建属性开启按钮
	set zbutton[10] = Frame.newTextButton(zwidget[12])
	call zbutton[10].setAllPoints(zwidget[12])
	call zbutton[10].regEvent(FRAME_EVENT_PRESSED, function toggleAttrBoard)
	
	set zwidget[1000] = Frame.newText1(zwidget[3], "杀狼任务（5/6）", "TXA15")
	call zwidget[1000].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, - 0.035)
	call zwidget[1000].setColor255(0, 0, 0)
	
	set zwidget[1001] = Frame.newImage1(zwidget[3], "war3mapImported\\doing.tga", 0.044, 0.033)
	call zwidget[1001].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.235, - 0.027)
	
	set zwidget[1002] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
	call zwidget[1002].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, - 0.09)
	call zwidget[1002].setColor255(0, 0, 0)
	
	set zwidget[1003] = Frame.newImage1(zwidget[3], "war3mapImported\\done.tga", 0.044, 0.033)
	call zwidget[1003].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.235, - 0.082)
	
	set zwidget[1004] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
	call zwidget[1004].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, - 0.145)
	call zwidget[1004].setColor255(0, 0, 0)
	
	set zwidget[1006] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
	call zwidget[1006].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, - 0.2)
	call zwidget[1006].setColor255(0, 0, 0)
	
	set zwidget[1008] = Frame.newText1(zwidget[3], "狼皮任务（15/10）", "TXA15")
	call zwidget[1008].setPoint(TOPLEFT, zwidget[3], TOPLEFT, 0.11, - 0.255)
	call zwidget[1008].setColor255(0, 0, 0)
	
	set bibo_image = Frame.newImage1(GUI, "ReplaceableTextures\\CommandButtons\\PASBTNbibodian.blp", 0.02, 0.02)
	call bibo_image.setPoint(BOTTOMLEFT, Frame.getFrame(DzFrameGetMinimap()), TOPLEFT, 0.05, 0.02)
	call bibo_image.setAlpha(255)
	call bibo_image.hide()
	
	set bibo_text = Frame.newText1(bibo_image, "200", "TXA10")
	call bibo_text.setPoint(TOPRIGHT, bibo_image, TOPRIGHT, 0, 0)
	call bibo_text.setColor255(255, 255, 0)
	
	set qimen_widget = Frame.newImage1(GUI, "war3mapImported\\qm_sh.tga", 0.04, 0.02)
	call qimen_widget.setPoint(BOTTOMLEFT, Frame.getFrame(DzFrameGetMinimap()), TOPLEFT, 0.075, 0.02)
	call qimen_widget.hide()
	
	set qimen_button = Frame.newTextButton(qimen_widget)
	call qimen_button.setAllPoints(qimen_widget)
	call qimen_button.regEvent(FRAME_EVENT_PRESSED, function toggleQimenStatus)
	
	// set qimen_text = Frame.newText1(qimen_button, "伤害", "TXA12")
	// call qimen_text.setAllPoints(qimen_button)
	
	
	// 按ESC查看人物属性
	// 27 = ESC, 9 = TAB
	call DzTriggerRegisterKeyEventByCode(null, 27, 1, false, function pressEsc)
	//call DzTriggerRegisterKeyEventByCode(null, 27, 0, false, function releaseEsc)
	
	// 按TAB查看任务
	//call DzTriggerRegisterKeyEventByCode(null, 9, 1, false, function pressTab)

	// 右侧显示伤害和特效的复选框
	set checkboxWidget[1] = Frame.newImage1(GUI, "war3mapImported\\damage_number.tga", 0.09, 0.03)
	call checkboxWidget[1].setPoint(RIGHT, GUI, RIGHT, 0, 0.055)
	call checkboxWidget[1].setAlpha(200)
	
	set checkboxWidget[2] = Frame.newImage1(GUI, "war3mapImported\\right.tga", 0.018, 0.024) // 对号
	call checkboxWidget[2].setPoint(RIGHT, checkboxWidget[1], RIGHT, - 0.006, 0.004)

	set checkboxButton[1] = Frame.newTextButton(checkboxWidget[1])
	call checkboxButton[1].setAllPoints(checkboxWidget[1])
	call checkboxButton[1].regEvent(FRAME_EVENT_PRESSED, function toggleShowDamage)

	set checkboxWidget[3] = Frame.newImage1(GUI, "war3mapImported\\ability_effect.tga", 0.09, 0.03)
	call checkboxWidget[3].setPoint(RIGHT, GUI, RIGHT, 0, 0.02)
	call checkboxWidget[3].setAlpha(200)

	set checkboxWidget[4] = Frame.newImage1(GUI, "war3mapImported\\right.tga", 0.018, 0.024) // 对号
	call checkboxWidget[4].setPoint(RIGHT, checkboxWidget[3], RIGHT, - 0.006, 0.004)

	set checkboxButton[2] = Frame.newTextButton(checkboxWidget[3])
	call checkboxButton[2].setAllPoints(checkboxWidget[3])
	call checkboxButton[2].regEvent(FRAME_EVENT_PRESSED, function toggleShowAbilityEffect)

	call checkboxWidget[1].hide()
	call checkboxWidget[2].hide()
	call checkboxWidget[3].hide()
	call checkboxWidget[4].hide()

	// 显示等级
	set levelWidget = Frame.newImage1(GUI, "war3mapImported\\level.tga", 0.032, 0.04)
	call levelWidget.setPoint(LEFT, helpWidget, RIGHT, 0.005, 0)
	call levelWidget.hide()

	set levelButton = Frame.newTextButton(levelWidget)
	call levelButton.setAllPoints(levelWidget)
	call levelButton.regEvent(FRAME_EVENT_PRESSED, function toggleLevelPopup)
	call levelButton.regEvent(FRAME_MOUSE_ENTER, function toggleLevelWidget)
	call levelButton.regEvent(FRAME_MOUSE_LEAVE, function toggleLevelWidget)

	// 江湖等级的弹出框
	set levelPopup = Frame.newImage1(GUI, "war3mapImported\\level_popup.tga", 0.45, 0.4)
	call levelPopup.setPoint(CENTER, GUI, CENTER, 0, 0)
	call levelPopup.hide()

	set closeLevelWidget = Frame.newImage1(levelPopup, "war3mapImported\\close.tga", 0.018, 0.024)
	call closeLevelWidget.setPoint(CENTER, levelPopup, TOPRIGHT, 0, 0)

	set closeLevelButton = Frame.newTextButton(closeLevelWidget)
	call closeLevelButton.setAllPoints(closeLevelWidget)
	call closeLevelButton.regEvent(FRAME_EVENT_PRESSED, function toggleLevelPopup)


	
	return false
endfunction

function toggleUI takes nothing returns nothing
	local string s = GetEventPlayerChatString()
	local player p = GetTriggerPlayer()
	local integer i = GetPlayerId(p) + 1
	if s == "hideUI" and p == GetLocalPlayer() then
		call DzFrameShow(DzFrameGetHeroBarButton(1), false)
		call DzFrameShow(DzFrameGetHeroBarButton(2), false)
		call DzFrameShow(DzFrameGetHeroBarButton(3), false)
		call DzFrameShow(DzFrameGetHeroBarButton(1), true)
		call DzFrameShow(DzFrameGetHeroBarButton(2), true)
		call DzFrameShow(DzFrameGetHeroBarButton(3), true)
		call zwidget[12].hide()
		call helpWidget.hide()
		call interAbilityPanel.hide()
	endif
	if s == "showUI" and p == GetLocalPlayer() then
		call DzFrameShow(DzFrameGetHeroBarButton(1), false)
		call DzFrameShow(DzFrameGetHeroBarButton(2), false)
		call DzFrameShow(DzFrameGetHeroBarButton(3), false)
		call zwidget[12].show()
		call helpWidget.show()
		call interAbilityPanel.show()
	endif

	set p = null

endfunction


function initUI takes nothing returns nothing
	local trigger t = CreateTrigger()
	local integer i = 1
	local integer id = 0
	
	call TriggerRegisterTimerEventSingle(t, 1.)
	call TriggerAddCondition(t, Condition(function drawUI_Conditions))
	
	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "qimen", false)
	call TriggerAddAction(t, function doToggleQimenStatus)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "wuxing", false)
	call TriggerAddAction(t, function addWuxing)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "gengu", false)
	call TriggerAddAction(t, function addGengu)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "fuyuan", false)
	call TriggerAddAction(t, function addFuyuan)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "jingmai", false)
	call TriggerAddAction(t, function addJingmai)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "danpo", false)
	call TriggerAddAction(t, function addDanpo)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "yishu", false)
	call TriggerAddAction(t, function addYishu)

	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "showDmg", false)
	call TriggerAddAction(t, function doToggleShowDamage)

	
	set t = CreateTrigger()
	call DzTriggerRegisterSyncData(t, "showEffect", false)
	call TriggerAddAction(t, function doToggleShowEffect)

	set t = CreateTrigger()
	loop
		exitwhen i > 6
		call TriggerRegisterPlayerChatEvent(t, Player(i - 1), "", true)
		set i = i + 1
	endloop
	call TriggerAddAction(t, function toggleUI)


	// 去掉小地图旁边的按钮
	set i = 0
	loop
		exitwhen i > 4
		set id = DzFrameGetMinimapButton(i)
		call DzFrameClearAllPoints(id)
		call DzFrameSetPoint(id, CENTER, DzGetGameUI(), CENTER, 0.8, 0.6)
		set i = i + 1
	endloop
	

	set t = null
endfunction