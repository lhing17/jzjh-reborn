//金刚伏魔圈
function IsJinGangFuMo takes nothing returns boolean
	return GetSpellAbilityId()=='A039'
endfunction
function IsFuMoEnemy takes nothing returns boolean
	return(IsUnitEnemy(GetFilterUnit(), Player(0)) and UnitHasBuffBJ(GetFilterUnit(),'BHds')==false and GetUnitAbilityLevel(GetFilterUnit(), 'Avul')<1)
endfunction
//--渡劫鞭法
function JinGang_DuJie takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local integer i = LoadInteger(YDHT, GetHandleId(t), 2)
	local location loc = LoadLocationHandle(YDHT, GetHandleId(t), 3)
	local unit ut = null
	local group g = CreateGroup()
	call GroupEnumUnitsInRangeOfLoc(g, loc, 325, Condition(function IsFuMoEnemy))
	set ut = GroupPickRandomUnit(g)
	if i-i/3*3==0 then
		call ShowUnitShow(u)
		call IssueTargetOrderById(u, $D0200, ut)
		call AddSpecialEffectLocBJ(GetUnitLoc(ut),"war3mapImported\\ChaosExplosion.mdl")
	else
		call ShowUnitHide(u)
	endif
	call SaveInteger(YDHT, GetHandleId(t), 2, i+1)
	if i>15 then
		call PauseTimer(t)
		call DestroyTimer(t)
		call FlushChildHashtable(YDHT, GetHandleId(t))
		call RemoveLocation(loc)
	endif
	call DestroyGroup(g)
	set u = null
	set t = null
	set ut = null
	set loc = null
	set g = null
endfunction
//--渡厄鞭法
function JinGang_DuE takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local integer i = LoadInteger(YDHT, GetHandleId(t), 2)
	local location loc = LoadLocationHandle(YDHT, GetHandleId(t), 3)
	local unit ut = null
	local group g = CreateGroup()
	call GroupEnumUnitsInRangeOfLoc(g, loc, 325, Condition(function IsFuMoEnemy))
	set ut = GroupPickRandomUnit(g)
	if i-i/3*3==1 then
		call ShowUnitShow(u)
		call IssueTargetOrderById(u, $D0200, ut)
		call AddSpecialEffectLocBJ(GetUnitLoc(ut),"war3mapImported\\FireStomp.mdx")
	else
		call ShowUnitHide(u)
	endif
	call SaveInteger(YDHT, GetHandleId(t), 2, i+1)
	if i>15 then
		call PauseTimer(t)
		call DestroyTimer(t)
		call FlushChildHashtable(YDHT, GetHandleId(t))
		call RemoveLocation(loc)
	endif
	call DestroyGroup(g)
	set u = null
	set t = null
	set ut = null
	set loc = null
	set g = null
endfunction
//--渡难鞭法
function JinGang_DuNan takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local integer i = LoadInteger(YDHT, GetHandleId(t), 2)
	local location loc = LoadLocationHandle(YDHT, GetHandleId(t), 3)
	local unit ut = null
	local group g = CreateGroup()
	call GroupEnumUnitsInRangeOfLoc(g, loc, 350, Condition(function IsFuMoEnemy))
	set ut = GroupPickRandomUnit(g)
	if i-i/3*3==2 then
		call ShowUnitShow(u)
		call IssueTargetOrderById(u, $D0200, ut)
		call AddSpecialEffectLocBJ(GetUnitLoc(ut),"war3mapImported\\FireStomp.mdx")
	else
		call ShowUnitHide(u)
	endif
	call SaveInteger(YDHT, GetHandleId(t), 2, i+1)
	if i>15 then
		call PauseTimer(t)
		call DestroyTimer(t)
		call FlushChildHashtable(YDHT, GetHandleId(t))
		call RemoveLocation(loc)
	endif
	call DestroyGroup(g)
	set u = null
	set t = null
	set ut = null
	set loc = null
	set g = null
endfunction
//不能出伏魔圈
function FuMoBuNengChu takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local location loc = LoadLocationHandle(YDHT, GetHandleId(t), 1)
	local integer i = LoadInteger(YDHT, GetHandleId(t), 2)
	local location loc2 = GetUnitLoc(u)
	if i < 500 then
		if DistanceBetweenPoints(loc2, loc)>250 then
			call SetUnitX(u, GetLocationX(loc)+GetRandomReal(-250., 250.)*CosBJ(AngleBetweenPoints(loc, loc2)))
			call SetUnitY(u, GetLocationY(loc)+GetRandomReal(-250., 250.)*SinBJ(AngleBetweenPoints(loc, loc2)))
			if (ModuloInteger(GetUnitPointValue(u),100)==0) then
				call percentDamage(GetEnumUnit(), 50, false)
			else
				call percentDamage(GetEnumUnit(), 15, false)
			endif
		endif
		call SaveInteger(YDHT, GetHandleId(t), 2, i+1)
	else
		call RemoveLocation(loc)
		call PauseTimer(t)
		call DestroyTimer(t)
		call FlushChildHashtable(YDHT, GetHandleId(t))
	endif
	set t = null
	set  u = null
	set loc = null
	set loc2 = null
endfunction
function FuMoQuan takes nothing returns nothing
	local unit ut = GetEnumUnit()
	local unit u = GetTriggerUnit()
	local location loc = LoadLocationHandle(YDHT, GetHandleId(u) , StringHash("伏魔"))
	local timer t = CreateTimer()
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, ut)
	call SaveLocationHandle(YDHT, GetHandleId(t), 1, loc)
	call TimerStart(t, 0.03, true, function FuMoBuNengChu)
	set t = null
	set u = null
	set ut = null
	set loc = null
endfunction
function FuMoTeXiao takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local location loc = LoadLocationHandle(YDHT, GetHandleId(t), 0)
	call YDWETimerDestroyEffect( 15., AddSpecialEffectLoc("war3mapImported\\kineticfield_fx_stand.mdx", loc))
	set t = null
	set loc = null
endfunction
function JinGangFuMo takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local unit uc = GetSpellTargetUnit()
	local location loc = GetUnitLoc(uc)
	local location loc1 = pu(loc, 325, 90)
	local location loc2 = pu(loc, 325, 210)
	local location loc3 = pu(loc, 325, 330)
	local group g = CreateGroup()
	local timer tt1 = CreateTimer()
	local timer tt2 = CreateTimer()
	local timer tt3 = CreateTimer()
	local timer tt4 = CreateTimer()
	//伏魔圈
	call GroupEnumUnitsInRangeOfLoc(g, loc, 325, Condition(function IsFuMoEnemy))
	call SaveLocationHandle(YDHT, GetHandleId(u), StringHash("伏魔"), loc)
	call YDWETimerDestroyEffect( 1.2, AddSpecialEffectLoc("war3mapImported\\kineticfield_fx_start.mdx", loc))
	call SaveLocationHandle(YDHT, GetHandleId(tt4), 0, loc)
	call TimerStart(tt4, 1.2, false, function FuMoTeXiao)
	call ForGroupBJ(g, function FuMoQuan)
	//渡劫
	call CreateNUnitsAtLoc(1,'e017',GetOwningPlayer(u),loc1,bj_UNIT_FACING)
	call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03A')
	call SaveUnitHandle(YDHT, GetHandleId(tt1), 0, bj_lastCreatedUnit)
	call SaveUnitHandle(YDHT, GetHandleId(tt1), 1, uc)
	call SaveLocationHandle(YDHT, GetHandleId(tt1), 3, loc)
	call TimerStart(tt1, 1, true, function JinGang_DuJie)
    call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',15.)
	//渡厄
    call CreateNUnitsAtLoc(1,'e016',GetOwningPlayer(u),loc2,bj_UNIT_FACING)
    call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03B')
	call SaveUnitHandle(YDHT, GetHandleId(tt2), 0, bj_lastCreatedUnit)
	call SaveUnitHandle(YDHT, GetHandleId(tt2), 1, uc)
	call SaveLocationHandle(YDHT, GetHandleId(tt2), 3, loc)
	call TimerStart(tt2, 1, true, function JinGang_DuE)
    call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',15.)
	//渡难
    call CreateNUnitsAtLoc(1,'e018',GetOwningPlayer(u),loc3,bj_UNIT_FACING)
    call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03C')
	call SaveUnitHandle(YDHT, GetHandleId(tt3), 0, bj_lastCreatedUnit)
	call SaveUnitHandle(YDHT, GetHandleId(tt3), 1, uc)
	call SaveLocationHandle(YDHT, GetHandleId(tt3), 3, loc)
	call TimerStart(tt3, 1, true, function JinGang_DuNan)
    call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',15.)
    call RemoveLocation(loc1)
    call RemoveLocation(loc2)
    call RemoveLocation(loc3)
    set u = null
    set uc = null
    set loc = null
    set loc1 = null
    set loc2 = null
    set loc3 = null
    set tt1 = null
    set tt2 = null
    set tt3 = null
    set tt4 = null
    set g = null
endfunction
//伏魔圈伤害
function IsFuMoShangHai takes nothing returns boolean
	return GetUnitTypeId(GetEventDamageSource())=='e017' or GetUnitTypeId(GetEventDamageSource())=='e016' or GetUnitTypeId(GetEventDamageSource())=='e018'
endfunction
function FuMoShangHai takes nothing returns nothing
	local unit uc = GetTriggerUnit()
	call percentDamage(uc, 10, true)
	
    set uc = null
endfunction

// 唐门：九宫八卦阵
function IsJiuGongBaGua takes nothing returns boolean
	return GetSpellAbilityId()=='A0B3'
endfunction
function JiuGongBaGua_Condition takes nothing returns boolean
    return IsUnitEnemy(GetFilterUnit(), Player(0)) and GetUnitAbilityLevel(GetFilterUnit(),'Avul')==0 and IsUnitAliveBJ(GetFilterUnit())
endfunction

function JiuGongBaGua_Action takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local real x = LoadReal(YDHT, GetHandleId(t), 0)
    local real y = LoadReal(YDHT, GetHandleId(t), 1)
    local real range = LoadReal(YDHT, GetHandleId(t), 2)
    local integer j = LoadInteger(YDHT, GetHandleId(t), 3)
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 4)
    local unit dummy = null
    local unit target = null
    local group g = null
    local integer i = 1
    local integer jmax = 50
    if j > jmax then
        call clearTimer(t)
    else
        call SaveInteger(YDHT, GetHandleId(t), 3, j + 1)
        loop
            exitwhen i > 8
            set dummy = CreateUnit(GetOwningPlayer(u), 'e000',x + range * CosBJ(45 * i), y + range * SinBJ(45 * i), 270 + 45 * i)
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, GetUnitX(dummy), GetUnitY(dummy), range + 200, Condition(function JiuGongBaGua_Condition))
            set target = GroupPickRandomUnit(g)
            call ShowUnitHide(dummy)
            call UnitAddAbility(dummy, 'A09B')
            call IssueTargetOrderById( dummy, $D007F, target )
            call UnitApplyTimedLife(dummy,'BHwe', 3)
            call DestroyGroup(g)
            set i = i + 1
        endloop
    endif
    set g = null
    set u = null
    set dummy = null
    set t = null
    set target = null
endfunction

function attackPeriodicly takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
    if GetUnitState(u, UNIT_STATE_LIFE) > 0 then
        call SetUnitAnimation(u,"attack")
    else
        call clearTimer(t)
    endif
    set t = null
    set u = null
endfunction

function JiuGongBaGua takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local unit dummy = null
    local integer id = 0
    local integer i = 1
    local real range = GetRandomReal(500, 800)
    local timer t = CreateTimer()
    local timer tt = null
    if((GetUnitTypeId(u)=='O004'))then
        set id = 1747988533
    elseif((GetUnitTypeId(u)=='O001'))then
        set id = 1747988535
    elseif((GetUnitTypeId(u)=='O002'))then
        set id = 1747988536
    elseif((GetUnitTypeId(u)=='O003'))then
        set id = 1747988537
    elseif((GetUnitTypeId(u)=='O000'))then
        set id = 1747988534
    elseif((GetUnitTypeId(u)=='O023' or GetUnitTypeId(u)=='O02H' or GetUnitTypeId(u)=='O02I'))then
        set id = 'h00I'
    elseif((GetUnitTypeId(u)=='O02J'))then
        set id = 'h00K'
    endif
    loop
        exitwhen i > 8
        set dummy = CreateUnit(GetOwningPlayer(u), id, GetUnitX(u) + range * CosBJ(45 * i), GetUnitY(u) + range * SinBJ(45 * i), 45 * i)
        call YDWETimerDestroyLightning(15., AddLightning("MFPB", true, GetUnitX(u) + range * CosBJ(45 * i), GetUnitY(u) + range * SinBJ(45 * i), GetUnitX(u) + range * CosBJ(45 * i + 45), GetUnitY(u) + range * SinBJ(45 * i + 45)))
        call SetUnitMoveSpeed(dummy, 0)
        set tt = CreateTimer()
        call SaveUnitHandle(YDHT, GetHandleId(tt), 0, dummy)
        call TimerStart(tt, 1, true, function attackPeriodicly)
        call SetUnitVertexColorBJ(dummy,GetRandomReal(20.,80.),GetRandomReal(20.,80.),GetRandomReal(20.,80.),GetRandomReal(20.,60.))
        call UnitAddAbility(dummy,'Aloc')
        call UnitApplyTimedLife(dummy, 1112045413, 15.)
        set i = i + 1
    endloop
    call SaveReal(YDHT, GetHandleId(t), 0, GetUnitX(u))
    call SaveReal(YDHT, GetHandleId(t), 1, GetUnitY(u))
    call SaveReal(YDHT, GetHandleId(t), 2, range)
    call SaveInteger(YDHT, GetHandleId(t), 3, 0)
    call SaveUnitHandle(YDHT, GetHandleId(t), 4, u)
    call TimerStart(t, 0.3, true, function JiuGongBaGua_Action)
    set dummy = null
    set u = null
    set t = null
    set tt = null
endfunction

//十八罗汉阵
//真武七截阵
function IsZhenWuQiJie takes nothing returns boolean
	return GetSpellAbilityId()=='A03J'
endfunction
function ZhenWuQiJieZhen takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local location tianji = GetUnitLoc(u)
	local location tianxuan = Location(GetUnitX(u)-500, GetUnitY(u)-100)
	local location tianshu = Location(GetUnitX(u)+500, GetUnitY(u)+100)
	local location tianquan = Location(GetUnitX(u), GetUnitY(u)+300)
	local location yuheng = Location(GetUnitX(u), GetUnitY(u)-500)
	local location kaiyang = Location(GetUnitX(u)+500, GetUnitY(u)-500)
	local location yaoguang = Location(GetUnitX(u)+500, GetUnitY(u)-300)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, tianji, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, tianxuan, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, tianshu, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, tianquan, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, yuheng, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, kaiyang, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02G', p, yaoguang, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03K')
	call Gw(10.,bj_lastCreatedUnit)
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", kaiyang, yaoguang))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", yuheng, kaiyang))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianji, yuheng))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianquan, tianji))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianxuan, tianji))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianji, tianshu))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", tianji))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", tianxuan))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", tianquan))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", tianshu))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", yuheng))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", kaiyang))
	call YDWETimerDestroyEffect( 7., AddSpecialEffectLoc("war3mapImported\\divinering.mdx", yaoguang))
	call RemoveLocation(tianji)
	call RemoveLocation(tianxuan)
	call RemoveLocation(tianquan)
	call RemoveLocation(tianshu)
	call RemoveLocation(yuheng)
	call RemoveLocation(kaiyang)
	call RemoveLocation(yaoguang)
	set u = null
	set p = null
	set tianji = null
	set tianxuan = null
	set tianshu = null
	set tianquan = null
	set yuheng = null
	set kaiyang = null
	set yaoguang = null
endfunction
function IsZhenWuShangHai takes nothing returns boolean
	return GetUnitTypeId(GetEventDamageSource())=='o02G'
endfunction
function ZhenWuShangHai takes nothing returns nothing
	local integer i=1+GetPlayerId(GetOwningPlayer(GetEventDamageSource()))
	local unit u=udg_hero[i]
    local unit uc=GetTriggerUnit()
    local real shxishu=1.+I2R(juexuelingwu[i])
    local real shanghai=0.
    set shanghai=ShangHaiGongShi(u,uc,3000.,3000.,shxishu,'A03J')
    call WuGongShangHai(u,uc,shanghai)
    set u=null
    set uc=null
endfunction


//天罡北斗阵
function IsTianGangBeiDou takes nothing returns boolean
	return GetSpellAbilityId()=='A03G'
endfunction
function TianGangBeiDouZhen takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local location tianji = GetUnitLoc(u)
	local location tianxuan = Location(GetUnitX(u)+300, GetUnitY(u)-50)
	local location tianshu = Location(GetUnitX(u)+500, GetUnitY(u)+250)
	local location tianquan = Location(GetUnitX(u)-50, GetUnitY(u)+300)
	local location yuheng = Location(GetUnitX(u)-300, GetUnitY(u)+500)
	local location kaiyang = Location(GetUnitX(u)-500, GetUnitY(u)+700)
	local location yaoguang = Location(GetUnitX(u)-800, GetUnitY(u)+700)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, tianji, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, tianxuan, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, tianshu, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, tianquan, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, yuheng, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, kaiyang, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call CreateNUnitsAtLocFacingLocBJ(1, 'o02F', p, yaoguang, tianji)
	call UnitAddAbility(bj_lastCreatedUnit, 'A03I')
	call Gw(10.,bj_lastCreatedUnit)
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", yaoguang, kaiyang))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", kaiyang, yuheng))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", yuheng, tianquan))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianquan, tianji))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianji, tianxuan))
	call YDWETimerDestroyLightning(10., AddLightningLoc("SPLK", tianxuan, tianshu))
	call RemoveLocation(tianji)
	call RemoveLocation(tianxuan)
	call RemoveLocation(tianquan)
	call RemoveLocation(tianshu)
	call RemoveLocation(yuheng)
	call RemoveLocation(kaiyang)
	call RemoveLocation(yaoguang)
	set u = null
	set p = null
	set tianji = null
	set tianxuan = null
	set tianshu = null
	set tianquan = null
	set yuheng = null
	set kaiyang = null
	set yaoguang = null
endfunction
function TianGangEnemy takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GetAttacker())) and IsUnitAliveBJ(GetFilterUnit())
endfunction
function TianGangSha takes nothing returns nothing
	local unit u = GetAttacker()
	local location loc = GetUnitLoc(u)
	local group g = CreateGroup()
	local group gg2 = CreateGroup()
	local unit ut = null
	local integer i = 1
	local integer imax = 0
	call GroupEnumUnitsInRangeOfLoc(g, loc, 600, Condition(function TianGangEnemy))
	set imax = CountUnitsInGroup(g)
	if imax>=1 then
		set i = 1
		loop
			exitwhen i > imax
			set ut = FirstOfGroup(g)
			if GetUnitAbilityLevel(ut, 'A03I')!=0 then
				call GroupAddUnit(gg2, ut)
			endif
			call GroupRemoveUnit(g, ut)
			set i = i + 1
		endloop
	endif
	set imax = CountUnitsInGroup(gg2)
	if imax>=1 then
		set i = 1
		loop
			exitwhen i > imax
			set ut = FirstOfGroup(gg2)
			call IssueTargetOrderById(ut, $D0097, u)
			call GroupRemoveUnit(gg2, ut)
			set i = i + 1
		endloop
	endif
	call RemoveLocation(loc)
	call DestroyGroup(g)
	call DestroyGroup(gg2)
	set u = null
	set ut = null
	set loc = null
	set g = null
	set gg2 = null
endfunction
function IsTianGangShangHai takes nothing returns boolean
	return GetUnitTypeId(GetEventDamageSource())=='o02F'
endfunction
function TianGangShangHai takes nothing returns nothing
	local integer i=1+GetPlayerId(GetOwningPlayer(GetEventDamageSource()))
	local unit u=udg_hero[i]
    local unit uc=GetTriggerUnit()
    local real shxishu=1.+I2R(juexuelingwu[i])
    local real shanghai=0.
    set shanghai=ShangHaiGongShi(u,uc,3000.,3000.,shxishu,'A03G')
    call WuGongShangHai(u,uc,shanghai)
    set u=null
    set uc=null
endfunction
//打狗阵
//杀狗阵
//二十八星宿阵
//六脉剑阵
//天罗地网阵
//修习阵法
function IsXueZhenFa takes nothing returns boolean
	return GetItemTypeId(GetManipulatedItem())=='I0BY' or GetItemTypeId(GetManipulatedItem())=='I0BZ' or GetItemTypeId(GetManipulatedItem())=='I0C0' or GetItemTypeId(GetManipulatedItem())=='I0C1' or GetItemTypeId(GetManipulatedItem())=='I0ER'
endfunction
function XueZhenFa takes nothing returns nothing
	local integer id = GetItemTypeId(GetManipulatedItem())
	local unit u = GetTriggerUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local integer j = 0
	if UnitTypeNotNull(u,UNIT_TYPE_HERO)==false then
		call DisplayTextToPlayer(p, 0, 0, "|cff00FF66侠侣不能修行阵法")
	else
		if id == 'I0C1' then
			if GetUnitAbilityLevel(u, 'A03J')!=0 then
				call DisplayTextToPlayer(p, 0, 0, "|cff00FF66您已经修行过该阵法")
			else
				if isChief(i, 9) and GetUnitAbilityLevel(u, 'A08R')==9 then
					set j=1
		        	loop
		        	exitwhen j>wugongshu[i]
		        	    if (I7[(i-1)*20+j])!='AEfk' then
			    	        if j==wugongshu[i] then
		        	        	call DisplayTextToPlayer(p,0,0,"|CFF34FF00学习技能已达上限，请先遗忘部分技能")
		        	    	endif
		        	    else
			    	        call UnitAddAbility(u,'A03J')
    	    				call DisplayTextToPlayer(p,0,0, "|cff00FF66恭喜领悟技能："+GetObjectName('A03J'))
    	    				set L7[i]=1
    	    				loop
    	    				    exitwhen L7[i]>wugongshu[i]
    	    				    if((I7[(((i-1)*20)+L7[i])]!='AEfk'))then
    	    				    else
    	    				        set I7[(((i-1)*20)+L7[i])]='A03J'
    	    				        exitwhen true
    	    				    endif
    	    				    set L7[i]=L7[i]+1
    	    				endloop
    	    				exitwhen true
	    				endif

	    				set j = j + 1

	    			endloop
	    		else
	    			call DisplayTextToPlayer(p,0,0, "|cff00FF66条件不足，无法修行此阵法")
    			endif
    		endif
    	elseif id == 'I0BZ' then
			if GetUnitAbilityLevel(u, 'A039')!=0 then
				call DisplayTextToPlayer(p, 0, 0, "|cff00FF66您已经修行过该阵法")
			else
				if isChief(i, 1) and GetUnitAbilityLevel(u, 'A05K')==9 then
					set j=1
		        	loop
		        	exitwhen j>wugongshu[i]
		        	    if (I7[(i-1)*20+j])!='AEfk' then
			    	        if j==wugongshu[i] then
		        	        	call DisplayTextToPlayer(p,0,0,"|CFF34FF00学习技能已达上限，请先遗忘部分技能")
		        	    	endif
		        	    else
			    	        call UnitAddAbility(u,'A039')
    	    				call DisplayTextToPlayer(p,0,0, "|cff00FF66恭喜领悟技能："+GetObjectName('A039'))
    	    				set L7[i]=1
    	    				loop
    	    				    exitwhen L7[i]>wugongshu[i]
    	    				    if((I7[(((i-1)*20)+L7[i])]!='AEfk'))then
    	    				    else
    	    				        set I7[(((i-1)*20)+L7[i])]='A039'
    	    				        exitwhen true
    	    				    endif
    	    				    set L7[i]=L7[i]+1
    	    				endloop
    	    				exitwhen true
	    				endif

	    				set j = j + 1
	    			endloop
	    		else
	    			call DisplayTextToPlayer(p,0,0, "|cff00FF66条件不足，无法修行此阵法")
    			endif
    		endif
    	elseif id == 'I0C0' then
			if GetUnitAbilityLevel(u, 'A03F')!=0 then
				call DisplayTextToPlayer(p, 0, 0, "|cff00FF66您已经修行过该阵法")
			else
				if isChief(i, 2) and GetUnitAbilityLevel(u, 'A09M')==9 then
					set j=1
		        	loop
		        	exitwhen j>wugongshu[i]
		        	    if (I7[(i-1)*20+j])!='AEfk' then
			    	        if j==wugongshu[i] then
		        	        	call DisplayTextToPlayer(p,0,0,"|CFF34FF00学习技能已达上限，请先遗忘部分技能")
		        	    	endif
		        	    else
			    	        call UnitAddAbility(u,'A03F')
    	    				call DisplayTextToPlayer(p,0,0, "|cff00FF66恭喜领悟技能："+GetObjectName('A03F'))
    	    				set L7[i]=1
    	    				loop
    	    				    exitwhen L7[i]>wugongshu[i]
    	    				    if((I7[(((i-1)*20)+L7[i])]!='AEfk'))then
    	    				    else
    	    				        set I7[(((i-1)*20)+L7[i])]='A03F'
    	    				        exitwhen true
    	    				    endif
    	    				    set L7[i]=L7[i]+1
    	    				endloop
    	    				exitwhen true
	    				endif

	    				set j = j + 1
	    			endloop
	    		else
	    			call DisplayTextToPlayer(p,0,0, "|cff00FF66条件不足，无法修行此阵法")
    			endif
    		endif
    	elseif id == 'I0BY' then
			if GetUnitAbilityLevel(u, 'A03G')!=0 then
				call DisplayTextToPlayer(p, 0, 0, "|cff00FF66您已经修行过该阵法")
			else
				if isChief(i, 5) and GetUnitAbilityLevel(u, 'A0CM')==9 then
					set j=1
		        	loop
		        	exitwhen j>wugongshu[i]
		        	    if (I7[(i-1)*20+j])!='AEfk' then
			    	        if j==wugongshu[i] then
		        	        	call DisplayTextToPlayer(p,0,0,"|CFF34FF00学习技能已达上限，请先遗忘部分技能")
		        	    	endif
		        	    else
			    	        call UnitAddAbility(u,'A03G')
    	    				call DisplayTextToPlayer(p,0,0, "|cff00FF66恭喜领悟技能："+GetObjectName('A03G'))
    	    				set L7[i]=1
    	    				loop
    	    				    exitwhen L7[i]>wugongshu[i]
    	    				    if((I7[(((i-1)*20)+L7[i])]!='AEfk'))then
    	    				    else
    	    				        set I7[(((i-1)*20)+L7[i])]='A03G'
    	    				        exitwhen true
    	    				    endif
    	    				    set L7[i]=L7[i]+1
    	    				endloop
    	    				exitwhen true
	    				endif

	    				set j = j + 1
	    			endloop
	    		else
	    			call DisplayTextToPlayer(p,0,0, "|cff00FF66条件不足，无法修行此阵法")
    			endif
    		endif
    	elseif id == 'I0ER' then
            if GetUnitAbilityLevel(u, 'A03G')!=0 then
                call DisplayTextToPlayer(p, 0, 0, "|cff00FF66您已经修行过该阵法")
            else
                if isChief(i, 20) and GetUnitAbilityLevel(u, 'A09A')==9 then // 唐门门主、漫天飞花达到9级
                    set j=1
                    loop
                    exitwhen j>wugongshu[i]
                        if (I7[(i-1)*20+j])!='AEfk' then
                            if j==wugongshu[i] then
                                call DisplayTextToPlayer(p,0,0,"|CFF34FF00学习技能已达上限，请先遗忘部分技能")
                            endif
                        else
                            call UnitAddAbility(u,'A0B3')
                            call DisplayTextToPlayer(p,0,0, "|cff00FF66恭喜领悟技能："+GetObjectName('A0B3'))
                            set L7[i]=1
                            loop
                                exitwhen L7[i]>wugongshu[i]
                                if((I7[(((i-1)*20)+L7[i])]!='AEfk'))then
                                else
                                    set I7[(((i-1)*20)+L7[i])]='A0B3'
                                    exitwhen true
                                endif
                                set L7[i]=L7[i]+1
                            endloop
                            exitwhen true
                        endif

                        set j = j + 1
                    endloop
                else
                    call DisplayTextToPlayer(p,0,0, "|cff00FF66条件不足，无法修行此阵法")
                endif
            endif
		endif
	endif
	set u = null
	set p = null
endfunction
//事件
function ZhenFa_Trigger takes nothing returns nothing
	local trigger t=CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t,Condition(function IsJinGangFuMo))
    call TriggerAddAction(t,function JinGangFuMo)
    set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddCondition(t, Condition(function IsFuMoShangHai))
    call TriggerAddAction(t, function FuMoShangHai)
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t,Condition(function IsTianGangBeiDou))
    call TriggerAddAction(t,function TianGangBeiDouZhen)
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_ATTACKED)
	//call TriggerAddCondition(t,Condition(function HaveTianGang))
	call TriggerAddAction(t,function TianGangSha)
	set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddCondition(t, Condition(function IsTianGangShangHai))
    call TriggerAddAction(t, function TianGangShangHai)
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
	call TriggerAddCondition(t,Condition(function IsZhenWuQiJie))
    call TriggerAddAction(t,function ZhenWuQiJieZhen)
    set t = CreateTrigger()
    call YDWESyStemAnyUnitDamagedRegistTrigger( t )
    call TriggerAddCondition(t, Condition(function IsZhenWuShangHai))
    call TriggerAddAction(t, function ZhenWuShangHai)
    // 唐门：九宫八卦阵
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t,Condition(function IsJiuGongBaGua))
    call TriggerAddAction(t,function JiuGongBaGua)
    set t=CreateTrigger()
	call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_PICKUP_ITEM)
	call TriggerAddCondition(t,Condition(function IsXueZhenFa))
	call TriggerAddAction(t,function XueZhenFa)


    set t =null
endfunction
