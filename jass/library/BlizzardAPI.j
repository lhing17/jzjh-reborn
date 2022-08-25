//hardware


/*
DzFrameSetPoint achor定义，从0开始
enum class AnchorPoint
{
    TOPLEFT = 0,
    TOP = 1,
    TOPRIGHT = 2,
    LEFT = 3,
    CENTER = 4,
    RIGHT = 5,
    BOTTOMLEFT = 6,
    BOTTOM = 7,
    BOTTOMRIGHT = 8,
};

DzFrameSetScript  注册ui事件的事件ID
enum class CFrameEvents
{
    NONE = 0,
    FRAME_EVENT_PRESSED = 1,
    FRAME_MOUSE_ENTER = 2,
    FRAME_MOUSE_LEAVE = 3,
    FRAME_MOUSE_UP = 4,
    FRAME_MOUSE_DOWN = 5,
    FRAME_MOUSE_WHEEL = 6,
    FRAME_FOCUS_ENTER = FRAME_MOUSE_ENTER,
    FRAME_FOCUS_LEAVE = FRAME_MOUSE_LEAVE,
    FRAME_CHECKBOX_CHECKED = 7,
    FRAME_CHECKBOX_UNCHECKED = 8,
    FRAME_EDITBOX_TEXT_CHANGED = 9,
    FRAME_POPUPMENU_ITEM_CHANGE_START = 10,
    FRAME_POPUPMENU_ITEM_CHANGED = 11,
    FRAME_MOUSE_DOUBLECLICK = 12,
    FRAME_SPRITE_ANIM_UPDATE = 13,
};
*/


//获取鼠标在游戏内的坐标X
native DzGetMouseTerrainX takes nothing returns real

//获取鼠标在游戏内的坐标Y
native DzGetMouseTerrainY takes nothing returns real

//获取鼠标在游戏内的坐标Z
native DzGetMouseTerrainZ takes nothing returns real

//鼠标是否在游戏内
native DzIsMouseOverUI takes nothing returns boolean

//获取鼠标屏幕坐标X
native DzGetMouseX takes nothing returns integer

//获取鼠标屏幕坐标Y
native DzGetMouseY takes nothing returns integer

//获取鼠标游戏窗口坐标X
native DzGetMouseXRelative takes nothing returns integer

//获取鼠标游戏窗口坐标Y
native DzGetMouseYRelative takes nothing returns integer

//设置鼠标位置
native DzSetMousePos takes integer x, integer y returns nothing

//注册鼠标点击触发（sync为true时，调用TriggerExecute。为false时，直接运行action函数，可以异步不掉线，action里不要有同步操作）
native DzTriggerRegisterMouseEvent takes trigger trig, integer btn, integer status, boolean sync, string func returns nothing
native DzTriggerRegisterMouseEventByCode takes trigger trig, integer btn, integer status, boolean sync, code funcHandle returns nothing

//注册键盘点击触发
native DzTriggerRegisterKeyEvent takes trigger trig, integer key, integer status, boolean sync, string func returns nothing
native DzTriggerRegisterKeyEventByCode takes trigger trig, integer key, integer status, boolean sync, code funcHandle returns nothing

//注册鼠标滚轮触发
native DzTriggerRegisterMouseWheelEvent takes trigger trig, boolean sync, string func returns nothing
native DzTriggerRegisterMouseWheelEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing

//注册鼠标移动触发
native DzTriggerRegisterMouseMoveEvent takes trigger trig, boolean sync, string func returns nothing
native DzTriggerRegisterMouseMoveEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing

//获取触发器的按键码
native DzGetTriggerKey takes nothing returns integer

//获取滚轮delta
native DzGetWheelDelta takes nothing returns integer

//判断按键是否按下
native DzIsKeyDown takes integer iKey returns boolean

//获取触发key的玩家
native DzGetTriggerKeyPlayer takes nothing returns player

//获取war3窗口宽度
native DzGetWindowWidth takes nothing returns integer

//获取war3窗口高度
native DzGetWindowHeight takes nothing returns integer

//获取war3窗口X坐标
native DzGetWindowX takes nothing returns integer

//获取war3窗口Y坐标
native DzGetWindowY takes nothing returns integer

//注册war3窗口大小变化事件
native DzTriggerRegisterWindowResizeEvent takes trigger trig, boolean sync, string func returns nothing
native DzTriggerRegisterWindowResizeEventByCode takes trigger trig, boolean sync, code funcHandle returns nothing

//判断窗口是否激活
native DzIsWindowActive takes nothing returns boolean

//plus

//设置可摧毁物位置
native DzDestructablePosition takes destructable d, real x, real y returns nothing

//设置单位位置-本地调用
native DzSetUnitPosition takes unit whichUnit, real x, real y returns nothing

//异步执行函数
native DzExecuteFunc takes string funcName returns nothing

//取鼠标指向的unit
native DzGetUnitUnderMouse takes nothing returns unit

//设置unit的贴图
native DzSetUnitTexture takes unit whichUnit, string path, integer texId returns nothing

//设置内存数值
native DzSetMemory takes integer address, real value returns nothing

//设置单位ID
native DzSetUnitID takes unit whichUnit, integer id returns nothing

//设置单位模型
native DzSetUnitModel takes unit whichUnit, string path returns nothing

//设置小地图背景图片
native DzSetWar3MapMap takes string map returns nothing

native DzGetLocale takes nothing returns string
native DzGetUnitNeededXP takes unit whichUnit, integer level returns integer

//sync

//注册数据同步trigger
native DzTriggerRegisterSyncData takes trigger trig, string prefix, boolean server returns nothing

//同步游戏数据
native DzSyncData takes string prefix, string data returns nothing

//获取同步的数据
native DzGetTriggerSyncData takes nothing returns string

//获取同步数据的玩家
native DzGetTriggerSyncPlayer takes nothing returns player

//gui

/////////////////////////////// 原生UI修改
//隐藏界面元素
native DzFrameHideInterface takes nothing returns nothing

//修改游戏世界窗口位置
native DzFrameEditBlackBorders takes real upperHeight, real bottomHeight returns nothing

//头像
native DzFrameGetPortrait takes nothing returns integer

//小地图
native DzFrameGetMinimap takes nothing returns integer

//技能按钮
native DzFrameGetCommandBarButton takes integer row, integer column returns integer

//英雄按钮
native DzFrameGetHeroBarButton takes integer buttonId returns integer

//英雄血条
native DzFrameGetHeroHPBar takes integer buttonId returns integer

//英雄蓝条
native DzFrameGetHeroManaBar takes integer buttonId returns integer

//道具按钮
native DzFrameGetItemBarButton takes integer buttonId returns integer

//小地图按钮
native DzFrameGetMinimapButton takes integer buttonId returns integer

//左上菜单按钮
native DzFrameGetUpperButtonBarButton takes integer buttonId returns integer

//鼠标提示
native DzFrameGetTooltip takes nothing returns integer 

//聊天信息
native DzFrameGetChatMessage takes nothing returns integer 

//unit message
native DzFrameGetUnitMessage takes nothing returns integer 

//top message
native DzFrameGetTopMessage takes nothing returns integer 

///////////////////////////////
//取rgba色值
native DzGetColor takes integer r, integer g, integer b, integer a returns integer

//设置界面更新回调（非同步）
native DzFrameSetUpdateCallback takes string func returns nothing
native DzFrameSetUpdateCallbackByCode takes code funcHandle returns nothing

//显示/隐藏Frame
native DzFrameShow takes integer frame, boolean enable returns nothing

//创建frame
native DzCreateFrame takes string frame, integer parent, integer id returns integer

//创建SimpleFrame
native DzCreateSimpleFrame takes string frame, integer parent, integer id returns integer

//销毁frame
native DzDestroyFrame takes integer frame returns nothing

//加载toc
native DzLoadToc takes string fileName returns nothing

//设置frame相对位置
native DzFrameSetPoint takes integer frame, integer point, integer relativeFrame, integer relativePoint, real x, real y returns nothing

//设置frame绝对位置
native DzFrameSetAbsolutePoint takes integer frame, integer point, real x, real y returns nothing

//清空frame锚点
native DzFrameClearAllPoints takes integer frame returns nothing

//设置frame禁用/启用
native DzFrameSetEnable takes integer name, boolean enable returns nothing

//注册UI事件回调
native DzFrameSetScript takes integer frame, integer eventId, string func, boolean sync returns nothing
native DzFrameSetScriptByCode takes integer frame, integer eventId, code funcHandle, boolean sync returns nothing

//获取触发ui的玩家
native DzGetTriggerUIEventPlayer takes nothing returns player

//获取触发的Frame
native DzGetTriggerUIEventFrame takes nothing returns integer

//查找frame
native DzFrameFindByName takes string name, integer id returns integer

//查找SimpleFrame
native DzSimpleFrameFindByName takes string name, integer id returns integer

//查找String
native DzSimpleFontStringFindByName takes string name, integer id returns integer

//查找Texture
native DzSimpleTextureFindByName takes string name, integer id returns integer

//获取game ui
native DzGetGameUI takes nothing returns integer

//点击frame
native DzClickFrame takes integer frame returns nothing

//自定义屏幕比例
native DzSetCustomFovFix takes real value returns nothing

//使用宽屏模式
native DzEnableWideScreen takes boolean enable returns nothing

//设置文字（支持EditBox, TextFrame, TextArea, SimpleFontString、GlueEditBoxWar3、SlashChatBox、TimerTextFrame、TextButtonFrame、GlueTextButton）
native DzFrameSetText takes integer frame, string text returns nothing

//获取文字（支持EditBox, TextFrame, TextArea, SimpleFontString）
native DzFrameGetText takes integer frame returns string

//设置字数限制（支持EditBox）
native DzFrameSetTextSizeLimit takes integer frame, integer size returns nothing

//获取字数限制（支持EditBox）
native DzFrameGetTextSizeLimit takes integer frame returns integer

//设置文字颜色（支持TextFrame, EditBox）
native DzFrameSetTextColor takes integer frame, integer color returns nothing

//获取鼠标所在位置的ui控件指针
native DzGetMouseFocus takes nothing returns integer

//设置所有锚点到目标frame上
native DzFrameSetAllPoints takes integer frame, integer relativeFrame returns boolean

//设置焦点
native DzFrameSetFocus takes integer frame, boolean enable returns boolean

//设置模型（支持Sprite、Model、StatusBar）
native DzFrameSetModel takes integer frame, string modelFile, integer modelType, integer flag returns nothing

//获取控件是否启用
native DzFrameGetEnable takes integer frame returns boolean

//设置透明度（0-255）
native DzFrameSetAlpha takes integer frame, integer alpha returns nothing

//获取透明度
native DzFrameGetAlpha takes integer frame returns integer

//设置动画
native DzFrameSetAnimate takes integer frame, integer animId, boolean autocast returns nothing

//设置动画进度（autocast为false是可用）
native DzFrameSetAnimateOffset takes integer frame, real offset returns nothing

//设置texture（支持Backdrop、SimpleStatusBar）
native DzFrameSetTexture takes integer frame, string texture, integer flag returns nothing

//设置缩放
native DzFrameSetScale takes integer frame, real scale returns nothing

//设置tooltip
native DzFrameSetTooltip takes integer frame, integer tooltip returns nothing

//鼠标限制在ui内
native DzFrameCageMouse takes integer frame, boolean enable returns nothing

//获取当前值（支持Slider、SimpleStatusBar、StatusBar）
native DzFrameGetValue takes integer frame returns real

//设置最大最小值（支持Slider、SimpleStatusBar、StatusBar）
native DzFrameSetMinMaxValue takes integer frame, real minValue, real maxValue returns nothing

//设置Step值（支持Slider）
native DzFrameSetStepValue takes integer frame, real step returns nothing

//设置当前值（支持Slider、SimpleStatusBar、StatusBar）
native DzFrameSetValue takes integer frame, real value returns nothing

//设置frame大小
native DzFrameSetSize takes integer frame, real w, real h returns nothing

//根据tag创建frame
native DzCreateFrameByTagName takes string frameType, string name, integer parent, string template, integer id returns integer

//设置颜色（支持SimpleStatusBar）
native DzFrameSetVertexColor takes integer frame, integer color returns nothing

native DzOriginalUIAutoResetPoint takes boolean enable returns nothing
native DzFrameSetPriority takes integer frame, integer priority returns nothing
native DzFrameSetParent takes integer frame, integer parent returns nothing
native DzFrameGetHeight takes integer frame returns real
native DzFrameSetFont takes integer frame, string fileName, real height, integer flag returns nothing
native DzFrameGetParent takes integer frame returns integer
native DzFrameSetTextAlignment takes integer frame, integer align returns nothing
native DzFrameGetName takes integer frame returns string
native EXSetUnitArrayString takes integer uid, integer id,integer n,string name returns boolean
native EXSetUnitInteger takes integer uid, integer id,integer n returns boolean

function DzTriggerRegisterMouseEventTrg takes trigger trg, integer status, integer btn returns nothing
    if trg == null then
        return
    endif
    call DzTriggerRegisterMouseEvent(trg, btn, status, true, null)
endfunction

function DzTriggerRegisterKeyEventTrg takes trigger trg, integer status, integer btn returns nothing
    if trg == null then
        return
    endif
    call DzTriggerRegisterKeyEvent(trg, btn, status, true, null)
endfunction

function DzTriggerRegisterMouseMoveEventTrg takes trigger trg returns nothing
    if trg == null then
        return
    endif
    call DzTriggerRegisterMouseMoveEvent(trg, true, null)
endfunction

function DzTriggerRegisterMouseWheelEventTrg takes trigger trg returns nothing
    if trg == null then
        return
    endif
    call DzTriggerRegisterMouseWheelEvent(trg, true, null)
endfunction

function DzTriggerRegisterWindowResizeEventTrg takes trigger trg returns nothing
    if trg == null then
        return
    endif
    call DzTriggerRegisterWindowResizeEvent(trg, true, null)
endfunction

function DzF2I takes integer i returns integer
    return i
endfunction

function DzI2F takes integer i returns integer
    return i
endfunction

function DzK2I takes integer i returns integer
    return i
endfunction

function DzI2K takes integer i returns integer
    return i
endfunction

function DzTriggerRegisterMallItemSyncData takes trigger trig returns nothing
    call DzTriggerRegisterSyncData(trig, "DZMIA", true)
endfunction

function DzGetTriggerMallItemPlayer takes nothing returns player
    return DzGetTriggerSyncPlayer()
endfunction

function DzGetTriggerMallItem takes nothing returns string
    return DzGetTriggerSyncData()
endfunction

