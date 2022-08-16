//=================================================
//神龙教
//男性角色：子胥举鼎A04W、鲁达拔柳A04Z、狄青降龙A051
//女性角色：贵妃回眸A04X、飞燕回翔A054、小怜横陈A056
//内功：神龙八式A057、神龙心法A059
//=================================================

//子胥举鼎
function IsZiXuBeiDong takes nothing returns boolean
	return IsUnitEnemy(GetAttacker(),GetOwningPlayer(GetTriggerUnit())) and GetUnitAbilityLevel(GetTriggerUnit(), 'A04W')>=1
endfunction
function ZiXuBeiDong takes nothing returns nothing
	local integer i = GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1
	if GetRandomReal(1, 300) < 15 + fuyuan[i]/5 then
		call maJiaUseAbilityAtEnemysLoc(GetTriggerUnit(), 'e000', 'A04W', $D0102, GetAttacker(), 15.)
	endif
endfunction
function IsZiXuJuDing takes nothing returns boolean
	return((GetEventDamage()==.95))
endfunction
function ZiXuJuDing takes nothing returns nothing
	local unit u=udg_hero[(1+GetPlayerId(GetOwningPlayer(GetEventDamageSource())))]
    local unit uc=GetTriggerUnit()
    local real shxishu=1.
    local real shanghai=0.
    local location loc=GetUnitLoc(uc)
    if((GetUnitAbilityLevel(u,'A06L')!=0))then//加化骨绵掌
        set shxishu=shxishu+.6
    endif
    if((GetUnitAbilityLevel(u,'A03N')!=0))then//加神行百变
        set shxishu=shxishu+.7
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    set shanghai=ShangHaiGongShi(u,uc,24,40,shxishu,'A04W')
    call WuGongShangHai(u,uc,shanghai)
    if((GetUnitAbilityLevel(u,'A06J')!=0)and(GetRandomInt(1,100)<=30)and(UnitHasBuffBJ(uc,1111844210)==false))then //加连城走火入魔
        call WanBuff(u, uc, 2)
    endif
    if((GetUnitAbilityLevel(u,'A04V')!=0)and(GetRandomInt(1,100)<=30)and(UnitHasBuffBJ(uc,1110454323)==false))then //加夫妻神经错乱
         call WanBuff(u, uc, 10)
    endif
    if(GetUnitAbilityLevel(u,'S002')!=0)and(GetRandomInt(1,100)<=25) and IsUnitAliveBJ(uc) then //加龙象几率连环爆裂
	    call PolledWait(0.15)
	    call CreateNUnitsAtLoc(1,'e000',GetOwningPlayer(u),loc,bj_UNIT_FACING)
	    call ShowUnitHide(bj_lastCreatedUnit)
		call UnitAddAbility(bj_lastCreatedUnit, 'A04W')
		call IssueTargetOrderById(bj_lastCreatedUnit,$D0102, uc)
		call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',15.)

    endif
    call RemoveLocation(loc)
    call WuGongShengChong(u,'A04W',2400.)
    call WuGongShengChong(u,'A059',2500.)
    set u=null
    set uc=null
    set loc=null
endfunction
//小怜横陈
function IsXiaoLianHengChen takes nothing returns boolean
	return((GetUnitAbilityLevel(GetAttacker(),'A056')>=1)and(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))))
endfunction
function XiaoLian_Condition takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetAttacker()))and(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function XiaoLian_Action takes nothing returns nothing
	local unit uc=GetEnumUnit()
	local unit u=GetAttacker()
	local real x=GetUnitX(uc)
	local real y=GetUnitY(uc)
	local location loc = GetUnitLoc(uc)
	local real shxishu=1.
	local real shanghai=0.
    if((GetUnitAbilityLevel(u,'A07S')!=0))then//加九阴
        set shxishu=shxishu+.7
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    // 教主夫人加成
    if isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 33) then
        set shxishu = shxishu * 2
    endif
	call DestroyEffectEx(AddSpecialEffectEx("Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", x, y))
	set shanghai=ShangHaiGongShi(u,uc,8,11,shxishu,'A056')
	if GetUnitAbilityLevel(u, 'A059')!=0 and GetRandomReal(1, 100)<=30 then //加神龙心法
        // 封穴加变羊
        call WanBuff(u, uc, 11) //封穴
		call CreateNUnitsAtLoc(1,'e000',  GetOwningPlayer(u), loc, bj_UNIT_FACING)
	    call ShowUnitHide(bj_lastCreatedUnit)
		call UnitAddAbility(bj_lastCreatedUnit, 'A05A')
		call IssueTargetOrderById(bj_lastCreatedUnit,$D0216, uc)
		call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',15.)
	endif
	
	call WuGongShangHai(u,uc,shanghai)
	call RemoveLocation(loc)
	set loc = null
	set u=null
	set uc=null
endfunction
function XiaoLianHengChen takes nothing returns nothing
	local unit u=GetAttacker()
	local unit uc=GetTriggerUnit()
	local location loc1=GetUnitLoc(u)
	local location loc2=GetUnitLoc(uc)
	local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
	if (GetRandomReal(.0,100.) <= 30. + fuyuan[i]/3 + GetUnitAbilityLevel(u, 'A056')*4 )then
		//加爪子加范围
	    call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(800+100*(GetUnitAbilityLevel(u,'A07N')),loc1,Condition(function XiaoLian_Condition)),function XiaoLian_Action)
	    // call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(500+500*(GetUnitAbilityLevel(u,'A07U')),loc1,Condition(function XiaoLian_Condition)),function XiaoLian_Action)
	    call WuGongShengChong(u,'A056',900.)
	    call WuGongShengChong(u,'A059',2500.)
	    if((GetUnitAbilityLevel(u,'A07U')!=0))then//加双手回复20%内功
		    call SetUnitState(u, UNIT_STATE_MANA, (GetUnitState(u,UNIT_STATE_MANA)+(.2*GetUnitState(u,UNIT_STATE_MAX_MANA))))
		endif
	endif
	call RemoveLocation(loc1)
	call RemoveLocation(loc2)
	set u = null
	set uc = null
	set loc1 = null
	set loc2 = null
endfunction

//贵妃回眸
function IsGuiFeiHuiMou takes nothing returns boolean
	return GetSpellAbilityId()=='A04X'
endfunction
function XiaoLian_Condition_1 takes nothing returns boolean
	return IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEventDamageSource()))and(IsUnitAliveBJ(GetFilterUnit()))
endfunction
function XiaoLian_Action_1 takes nothing returns nothing
	local unit uc=GetEnumUnit()
	local unit u=udg_hero[(1+GetPlayerId(GetOwningPlayer(GetEventDamageSource())))]
	local real x=GetUnitX(uc)
	local real y=GetUnitY(uc)
	local location loc = GetUnitLoc(uc)
	local real shxishu=1.
	local real shanghai=0.
	call DestroyEffectEx(AddSpecialEffectEx("Abilities\\Spells\\Human\\Polymorph\\PolyMorphDoneGround.mdl", x, y))
    if((GetUnitAbilityLevel(u,'A07S')!=0))then//加九阴
        set shxishu=shxishu+.7
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    // 教主夫人加成
    if isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 33) then
        set shxishu = shxishu * 2
    endif
	set shanghai=ShangHaiGongShi(u,uc,8,11,shxishu,'A056')
	if GetUnitAbilityLevel(u, 'A059')!=0 and GetRandomReal(1, 100)<=30 then //加神龙心法
		call CreateNUnitsAtLoc(1,'e000' , GetOwningPlayer(u), loc, bj_UNIT_FACING)
	    call ShowUnitHide(bj_lastCreatedUnit)
		call UnitAddAbility(bj_lastCreatedUnit, 'A05A')
		call IssueTargetOrderById(bj_lastCreatedUnit,$D0216, uc)
		call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',15.)
	endif
	

	call WuGongShangHai(u,uc,shanghai)
	call RemoveLocation(loc)
	set loc = null
	set u=null
	set uc=null
endfunction
function GuiFeiHuiMou takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local unit ut = GetSpellTargetUnit()
	local player p = GetOwningPlayer(u)
	local location loc = GetUnitLoc(u)
	call CreateNUnitsAtLoc(1,'e000',p,loc,bj_UNIT_FACING)
    call ShowUnitHide(bj_lastCreatedUnit)
	call UnitAddAbility(bj_lastCreatedUnit, 'A04Y')
    call IssueTargetOrderById(bj_lastCreatedUnit, $D007F, ut)
    call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',10.)
    call RemoveLocation(loc)
    set loc = null
    set u = null
    set ut = null
    set p = null
endfunction
function IsGuiFeiHuiMouSH takes nothing returns boolean
	return((GetEventDamage()==.96))
endfunction
function GuiFeiHuiMouSH takes nothing returns nothing
	local unit u=udg_hero[(1+GetPlayerId(GetOwningPlayer(GetEventDamageSource())))]
    local unit uc=GetTriggerUnit()
    local location loc=GetUnitLoc(uc)
    local location loc2 = GetUnitLoc(u)
    local integer i = 1 + GetPlayerId(GetOwningPlayer(u))
    local real shxishu= RMinBJ(DistanceBetweenPoints(loc, loc2)/500, 4)
    local real shanghai=0.
    call WuGongShengChong(u,'A04X',500.)
    call WuGongShengChong(u,'A059',2500.)
    // 加弹指概率穴位全封
    if (GetUnitAbilityLevel(u,'A06H')!=0) and GetRandomInt(1,100) <= 40+ GetUnitAbilityLevel(u,'A07N')*4 then 
        call WanBuff(u, uc, 12)
    endif
    if (GetUnitAbilityLevel(u,'A03V')!=0) then //加擒龙
	    set shxishu= RMinBJ(DistanceBetweenPoints(loc, loc2)/300, 10)
    endif
    if (GetUnitAbilityLevel(u,'A07S')!=0) then //加九阴真经
	    set shxishu= shxishu + 1
    endif
    // if (GetUnitAbilityLevel(u,'A083')!=0) then //加小无相
	//     set shxishu= shxishu + 1.2
    // endif
	if (GetUnitAbilityLevel(u,'A056')!=0) and (GetRandomReal(.0,100.) <= 30. + fuyuan[i]/3 + GetUnitAbilityLevel(u, 'A04X')*5 ) then //加小怜横陈
	    call ForGroupBJ(YDWEGetUnitsInRangeOfLocMatchingNull(800+100*(GetUnitAbilityLevel(u,'A07N')),loc,Condition(function XiaoLian_Condition_1)),function XiaoLian_Action_1)
	    call WuGongShengChong(u,'A056',900.)
	    call WuGongShengChong(u,'A059',2500.)
	    if((GetUnitAbilityLevel(u,'A07N')!=0))then//加九爪
		    call SetUnitState(u, UNIT_STATE_MANA, (GetUnitState(u,UNIT_STATE_MANA)+(.2*GetUnitState(u,UNIT_STATE_MAX_MANA))))
		endif
	endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    set shanghai=ShangHaiGongShi(u,uc,80,90,shxishu,'A04X')
    call WuGongShangHai(u,uc,shanghai)
    call RemoveLocation(loc)
    call RemoveLocation(loc2)

    set u=null
    set uc=null
    set loc=null
	set loc2=null
endfunction
//鲁达拔柳
function IsLuDaBaLiu takes nothing returns boolean
	return UnitHasBuffBJ(GetAttacker(), 'B016') and IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))
endfunction
function LuDaBaLiuYun takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local unit ut = LoadUnitHandle(YDHT, GetHandleId(t), 1)
	if((GetUnitAbilityLevel(u,'A06L')!=0))then//加化骨穴位全封
		call WanBuff(u, ut, 12)
	else
		call WanBuff(u, ut, 11)
	endif
	call FlushChildHashtable(YDHT, GetHandleId(t))
	call DestroyTimer(t)
	set t = null
	set u = null
	set ut = null
endfunction
function LuDaBaLiu takes nothing returns nothing
	local unit u=GetAttacker()
	local unit ut=GetTriggerUnit()
	local timer t =CreateTimer()
	local real shxishu= 1
    local real shanghai=0.
    if((GetUnitAbilityLevel(u,'A057')!=0))then//加神龙八式
        set shxishu=shxishu+.6
    endif
    if((GetUnitAbilityLevel(u,'A0CE')!=0))then//加龟息功
        set shxishu=shxishu+1.
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    set shanghai=ShangHaiGongShi(u,ut,80,100,shxishu,'A04Z')
    call WuGongShangHai(u,ut,shanghai)
    call WuGongShengChong(u,'A04Z',200.)
    call WuGongShengChong(u,'A059',2500.)
    if GetUnitAbilityLevel(u, 'A082')>=1 or (GetUnitAbilityLevel(u, 'A06J')>=1 and GetRandomInt(1, 100)<=30) then //加北冥或连城几率，BUFF不消失
	else
		call UnitRemoveBuffBJ('B016', u)
	endif
	call YDWEJumpTimer( ut, 0, 0.00, 1.00, 0.01, 500.00 )
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call SaveUnitHandle(YDHT, GetHandleId(t), 1, ut)
	call TimerStart(t, 1., false, function LuDaBaLiuYun)
	set u = null
	set ut = null
	set t = null
endfunction
//狄青降龙
function IsDiQingXiangLong takes nothing returns boolean
	return GetSpellAbilityId()=='A051'
endfunction
function DiQingXiangLongCai takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 0)
	local location loc = GetUnitLoc(u)
	call CreateNUnitsAtLoc(1,'e000',GetOwningPlayer(u),loc,bj_UNIT_FACING)
    call ShowUnitHide(bj_lastCreatedUnit)
    call UnitAddAbility(bj_lastCreatedUnit, 'A050')
    call IssueImmediateOrderById(bj_lastCreatedUnit, $D0080)
    call UnitApplyTimedLife(bj_lastCreatedUnit,'BHwe',10.)
    call FlushChildHashtable(YDHT, GetHandleId(t))
	call DestroyTimer(t)
	set t = null
	set u = null
	set ut = null
	set loc = null
endfunction
function DiQingXiaoWu takes nothing returns nothing
	local timer t = GetExpiredTimer()
	local integer i = LoadInteger(YDHT, GetHandleId(t), 0)
	set udg_shanghaixishou[i] = udg_shanghaixishou[i] - .1
    call FlushChildHashtable(YDHT, GetHandleId(t))
	call DestroyTimer(t)
	set t = null
endfunction
function DiQingXiangLong takes nothing returns nothing
	local unit u = GetTriggerUnit()
	local unit ut = GetSpellTargetUnit()
	local player p = GetOwningPlayer(u)
	local integer i = 1 + GetPlayerId(p)
	local location loc = GetUnitLoc(u)
	local location loc2 = GetUnitLoc(ut)
	local timer t =CreateTimer()
	local timer tm =CreateTimer()
    local integer beishu = 1 // 偷木头和加内力倍数
    local integer gailv = 10 // 偷木头和内力概率
	call WuGongShengChong(u,'A051',150.)
	call WuGongShengChong(u,'A059',2500.)
    // 专属加成,5倍偷木加内力
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set beishu = beishu *5
        set gailv = gailv + 40
    endif
    // 神龙教主加成
    if isTitle(i, 32) then
        set beishu = beishu *2
        set gailv = gailv + 10
    endif
	if GetUnitAbilityLevel(u, 'A03O')!=0 and GetRandomInt(1, 100) <= gailv+GetUnitLevel(ut)/2 then //妙手空空偷珍稀币
		call AdjustPlayerStateBJ(beishu*GetRandomInt(1, 5),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
	endif
	if GetUnitAbilityLevel(u, 'A07R')!=0 and GetRandomInt(1, 100) <= gailv+GetUnitLevel(ut)/2 then //吸星大法加内力
		call ModifyHeroStat(1,u,0,beishu*GetRandomInt(1, 10))
	endif
	if GetUnitAbilityLevel(u, 'A083')!=0 and GetRandomInt(1, 100) <= gailv+GetUnitLevel(ut)/2 then //小无相加伤害吸收
		set udg_shanghaixishou[i] = udg_shanghaixishou[i] + .1
		call SaveInteger(YDHT, GetHandleId(tm), 0, i)
		call TimerStart(tm, 15, false, function DiQingXiaoWu)
	endif
	call YDWEJumpTimer( u,  AngleBetweenPoints(loc, loc2),DistanceBetweenPoints(loc, loc2), 0.70, 0.02, 500.00 )
	call SaveUnitHandle(YDHT, GetHandleId(t), 0, u)
	call TimerStart(t,0.7, false, function DiQingXiangLongCai)
    call RemoveLocation(loc)
    call RemoveLocation(loc2)
    set loc = null
    set loc2 = null
    set u = null
    set ut = null
    set p = null
    set t = null
    set tm = null
endfunction
function IsDiQingXiangLongSH takes nothing returns boolean
	return((GetEventDamage()==.97))
endfunction
function DiQingXiangLongSH takes nothing returns nothing
	local unit u=udg_hero[(1+GetPlayerId(GetOwningPlayer(GetEventDamageSource())))]
    local unit ut=GetTriggerUnit()
    local real shxishu= 1
    local real shanghai=0.
    if((GetUnitAbilityLevel(u,'A07M')!=0))then //加七伤拳
	    call WanBuff(u, ut, GetRandomInt(1, 13))
	else
		call WanBuff(u, ut, 9)
    endif

    if((GetUnitAbilityLevel(u,'A03T')!=0))then //加须弥山掌
        set shxishu=shxishu+1.2
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    set shanghai=ShangHaiGongShi(u,ut,100,140,shxishu,'A051')
    call WuGongShangHai(u,ut,shanghai)

    set u=null
    set ut=null
endfunction

//飞燕回翔
function IsFeiYanHuiXiang takes nothing returns boolean
    return ((GetSpellAbilityId() == 'A054'))
endfunction

function isBirdEnemy takes nothing returns boolean
    return IsUnitAliveBJ(GetFilterUnit()) and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(LoadUnitHandle(YDHT, GetHandleId(GetExpiredTimer()), 13)))
endfunction

function birdDamage takes unit u, unit ut returns nothing
	local real shxishu= 1
    local real shanghai=0.
    if((GetUnitAbilityLevel(u,'A07S')!=0))then//加九阴真经
        set shxishu=shxishu+.7
    endif
    if((GetUnitAbilityLevel(u,'A083')!=0))then//加小无相功
        set shxishu=shxishu+1.3
    endif
    if((GetUnitAbilityLevel(u,'A059')!=0))then//加神龙心法，破防
        call WanBuff(u, ut, 9)
    endif
    if((GetUnitAbilityLevel(u,'A057')!=0))then//加神龙八式
        set shxishu=shxishu+2.0
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    // 教主夫人加成
    if isTitle(1 + GetPlayerId(GetOwningPlayer(u)), 33) then
        set shxishu = shxishu * 2
    endif
    set shanghai=ShangHaiGongShi(u,ut,15,10,shxishu,'A054')
    call WuGongShangHai(u,ut,shanghai)
    call DestroyEffectEx( AddSpecialEffectTargetEx("Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl", GetEnumUnit(), "overhead") )
endfunction


function leftBirdDamage takes nothing returns nothing
    call birdDamage(LoadUnitHandle(YDHT, GetHandleId(GetExpiredTimer()), 9), GetEnumUnit())
endfunction

function rightBirdDamage takes nothing returns nothing
    call birdDamage(LoadUnitHandle(YDHT, GetHandleId(GetExpiredTimer()), 10), GetEnumUnit())
endfunction

function birdFlying takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local real array x
    local real array y
    local real comp = LoadReal(YDHT, GetHandleId(t), 8)
    local unit left = LoadUnitHandle(YDHT, GetHandleId(t), 9)
    local unit right = LoadUnitHandle(YDHT, GetHandleId(t), 10)
    local group leftGroup = CreateGroup()
    local group rightGroup = CreateGroup()
    local real a = LoadReal(YDHT, GetHandleId(t), 11)
    local real b = 1 - a
    local boolean front  = LoadBoolean(YDHT, GetHandleId(t), 12)
    local unit u = LoadUnitHandle(YDHT, GetHandleId(t), 13)

    set x[0] = LoadReal(YDHT, GetHandleId(t), 0)
    set x[1] = LoadReal(YDHT, GetHandleId(t), 1)
    set x[2] = LoadReal(YDHT, GetHandleId(t), 2)
    set x[3] = LoadReal(YDHT, GetHandleId(t), 3)
    set y[0] = LoadReal(YDHT, GetHandleId(t), 4)
    set y[1] = LoadReal(YDHT, GetHandleId(t), 5)
    set y[2] = LoadReal(YDHT, GetHandleId(t), 6)
    set y[3] = LoadReal(YDHT, GetHandleId(t), 7)


    call SetUnitX(left, x[0] * a * a + x[2] * 2 * a * b + x[1] * b * b)
    call SetUnitY(left, y[0] * a * a + y[2] * 2 * a * b + y[1] * b * b)
    call SetUnitX(right, x[0] * a * a + x[3] * 2 * a * b + x[1] * b * b)
    call SetUnitY(right, y[0] * a * a + y[3] * 2 * a * b + y[1] * b * b)
    if GetUnitX(left) > GetRectMaxX(bj_mapInitialPlayableArea) - 50 then
        call SetUnitX(left, GetRectMaxX(bj_mapInitialPlayableArea) - 50)
    endif
    if GetUnitX(left) < GetRectMinX(bj_mapInitialPlayableArea) + 50 then
        call SetUnitX(left, GetRectMinX(bj_mapInitialPlayableArea) + 50)
    endif
    if GetUnitY(left) > GetRectMaxY(bj_mapInitialPlayableArea) - 50 then
        call SetUnitY(left, GetRectMaxY(bj_mapInitialPlayableArea) - 50)
    endif
    if GetUnitY(left) < GetRectMinY(bj_mapInitialPlayableArea) + 50 then
        call SetUnitY(left, GetRectMinY(bj_mapInitialPlayableArea) + 50)
    endif

    if GetUnitX(right) > GetRectMaxX(bj_mapInitialPlayableArea) - 50 then
        call SetUnitX(right, GetRectMaxX(bj_mapInitialPlayableArea) - 50)
    endif
    if GetUnitX(right) < GetRectMinX(bj_mapInitialPlayableArea) + 50 then
        call SetUnitX(right, GetRectMinX(bj_mapInitialPlayableArea) + 50)
    endif
    if GetUnitY(right) > GetRectMaxY(bj_mapInitialPlayableArea) - 50 then
        call SetUnitY(right, GetRectMaxY(bj_mapInitialPlayableArea) - 50)
    endif
    if GetUnitY(right) < GetRectMinY(bj_mapInitialPlayableArea) + 50 then
        call SetUnitY(right, GetRectMinY(bj_mapInitialPlayableArea) + 50)
    endif

    call GroupEnumUnitsInRange(leftGroup, GetUnitX(left), GetUnitY(left), 115, Condition(function isBirdEnemy))
    call GroupEnumUnitsInRange(rightGroup, GetUnitX(right), GetUnitY(right), 115, Condition(function isBirdEnemy))
    call ForGroup(leftGroup, function leftBirdDamage )
    call ForGroup(leftGroup, function rightBirdDamage )
    call DestroyGroup(leftGroup)
    call DestroyGroup(rightGroup)


    if front then
        set a = a - 0.05
        call SaveReal(YDHT, GetHandleId(t), 11, a)
    else
        set x[0] = GetUnitX(u)
        set y[0] = GetUnitY(u)
        set a = a + 0.05
        call SaveReal(YDHT, GetHandleId(t), 11, a)
        call SaveReal(YDHT, GetHandleId(t), 0, x[0])
        call SaveReal(YDHT, GetHandleId(t), 4, y[0])
        set comp = Atan2(y[1] - y[0], x[1] - x[0])
        call SaveReal(YDHT, GetHandleId(t), 8, comp)
    endif

    if (a <= 0 and front) then
        set front = false
        call SaveBoolean(YDHT, GetHandleId(t), 12, front)
        set x[2] = x[0] + 300 * Cos(comp - 45)
        set y[2] = y[0] + 300 * Sin(comp - 45)
        set x[3] = x[0] + 300 * Cos(comp + 45)
        set y[3] = y[0] + 300 * Sin(comp + 45)
        call SaveReal(YDHT, GetHandleId(t), 2, x[2])
        call SaveReal(YDHT, GetHandleId(t), 3, x[3])
        call SaveReal(YDHT, GetHandleId(t), 6, y[2])
        call SaveReal(YDHT, GetHandleId(t), 7, y[3])
    endif

    if (a >= 1 and not front) then
        call RemoveUnit(left)
        call RemoveUnit(right)
        call DestroyTimer(t)
    endif

    set t = null
    set left = null
    set right = null
    set leftGroup = null
    set rightGroup = null
    set u = null

endfunction

function FeiYanHuiXiang takes nothing returns nothing
    local timer t = CreateTimer()
    local real array x
    local real array y
    local real comp
    local unit u = GetTriggerUnit()
    local unit left
    local unit right
    call WuGongShengChong(u,'A054',300.)
    call WuGongShengChong(u,'A059',1500.)
    set x[0] = GetUnitX(u)
    set y[0] = GetUnitY(u)
    set x[1] = GetSpellTargetX()
    set y[1] = GetSpellTargetY()
    set comp = Atan2(y[1] - y[0], x[1] - x[0])
    set x[2] = x[0] + 300 * Cos(comp + 45)
    set y[2] = y[0] + 300 * Sin(comp + 45)
    set x[3] = x[0] + 300 * Cos(comp - 45)
    set y[3] = y[0] + 300 * Sin(comp - 45)
    set left = CreateUnit(GetTriggerPlayer(), 'h00L', x[0], y[0], 270)
    set right = CreateUnit(GetTriggerPlayer(), 'h00L', x[0], y[0], 270)

    // 下标0是单位所在位置，1是目标位置，2是左鸟位置，3是右鸟位置
    call SaveReal(YDHT, GetHandleId(t), 0, x[0])
    call SaveReal(YDHT, GetHandleId(t), 1, x[1])
    call SaveReal(YDHT, GetHandleId(t), 2, x[2])
    call SaveReal(YDHT, GetHandleId(t), 3, x[3])
    call SaveReal(YDHT, GetHandleId(t), 4, y[0])
    call SaveReal(YDHT, GetHandleId(t), 5, y[1])
    call SaveReal(YDHT, GetHandleId(t), 6, y[2])
    call SaveReal(YDHT, GetHandleId(t), 7, y[3])
    call SaveReal(YDHT, GetHandleId(t), 8, comp)
    call SaveUnitHandle(YDHT, GetHandleId(t), 9, left)
    call SaveUnitHandle(YDHT, GetHandleId(t), 10, right)
    call SaveReal(YDHT, GetHandleId(t), 11, 1)
    call SaveBoolean(YDHT, GetHandleId(t), 12, true)
    call SaveUnitHandle(YDHT, GetHandleId(t), 13, u)

    call TimerStart(t, 0.025, true, function birdFlying)
    set t = null
    set u = null
    set left = null
    set right = null
endfunction

//神龙八式
function Trig_ciZhenSaoSheConditions takes nothing returns boolean
    return ((GetSpellAbilityId() == 'A057'))
endfunction

function Trig_ciZhenSaoSheFunc007Func001Func002Func007T takes nothing returns nothing
	local unit u = LoadUnitHandle(YDHT, GetHandleId(GetExpiredTimer()), 0)
    if LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000)>0 then
	    call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000, LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000)-1)
	    //call BJDebugMsg(I2S(LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000)))
    endif
    call DestroyTimer(GetExpiredTimer())
    set u = null
endfunction

function Trig_ciZhenSaoSheFunc007Conditions takes nothing returns boolean
	local timer ydl_timer
	local unit u = LoadUnitHandle(YDHT, GetHandleId(GetTriggeringTrigger()), 0)
	local unit ut = GetTriggerUnit()
	local integer i = LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000)
	local real shxishu=1.
	local real shanghai=0.
    
    if (YDWEIsTriggerEventId(EVENT_UNIT_DAMAGED) == false) then
	    //call BJDebugMsg("123")
	    call FlushChildHashtable(YDHT, GetHandleId(GetTriggeringTrigger()))
        call DestroyTrigger(GetTriggeringTrigger())
        call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000, 0)
    else
        if (GetEventDamage() == .98) and GetEventDamageSource()== u then
	        //call BJDebugMsg("456")
	        set shxishu = 1+I2R(i)*0.1
	        set shanghai=ShangHaiGongShi(u,ut,15,18,shxishu,'A057')
			call WuGongShangHai(u,ut,shanghai)
			if((GetUnitAbilityLevel(u,'A03L')!=0))then//加寒冰真气昏迷
	   			call WanBuff(u, ut, 5)
   			endif
   			if((GetUnitAbilityLevel(u,'A07W')!=0))then//加乾坤
    		    set shxishu=shxishu+.6
    		endif
    		if((GetUnitAbilityLevel(u,'A07R')!=0))then//加吸星
    		    set shxishu=shxishu+.7
    		endif
    		if((GetUnitAbilityLevel(u,'A084')!=0))then//加蛤蟆
    		    set shxishu=shxishu+1.2
    		endif
			call SaveInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000, i+1)
            set ydl_timer = CreateTimer()
            call SaveUnitHandle(YDHT, GetHandleId(ydl_timer), 0, u)
            call TimerStart(ydl_timer, 14.00, false, function Trig_ciZhenSaoSheFunc007Func001Func002Func007T)
        endif
    endif
    // 专属加成
	if UnitHasDenomWeapon(u, 'I0DZ') then
	    set shxishu = shxishu * 2
    endif
    // 神龙教主加成
    if isTitle(i, 32) then
        set shxishu = shxishu * 2
    endif
    // 教主夫人加成
    if isTitle(i, 33) then
        set shxishu = shxishu * 2
    endif
    set ydl_timer = null
    set u = null
    set ut = null
    return false
endfunction

function Trig_ciZhenSaoSheActions takes nothing returns nothing
    local trigger ydl_trigger
    local unit u = GetTriggerUnit()
     call WuGongShengChong(u,'A057',900.)
    if LoadInteger(YDHT, GetHandleId(GetOwningPlayer(u)), 20000)<=0 then
    	set ydl_trigger= CreateTrigger()
    	call SaveUnitHandle(YDHT, GetHandleId(ydl_trigger), 0, GetTriggerUnit())
    	call Ov( ydl_trigger )
    	call TriggerRegisterTimerEventSingle( ydl_trigger, 30.00 )
    	call TriggerAddCondition(ydl_trigger, Condition(function Trig_ciZhenSaoSheFunc007Conditions))
	endif
    set ydl_trigger = null
    set u = null
endfunction

//function IsShenLongBaShiSH takes nothing returns boolean
//	return((GetEventDamage()==.98))
//endfunction
//function ShenLongBaShiSH takes nothing returns nothing
//	local unit u=udg_hero[(1+GetPlayerId(GetOwningPlayer(GetEventDamageSource())))]
//    local unit ut=GetTriggerUnit()
//    local real shxishu= 1
//    local real shanghai=0.
//    set shanghai=ShangHaiGongShi(u,ut,7.2,8.9,shxishu,'A057')
//    call WuGongShangHai(u,ut,shanghai)

//    set u=null
//    set ut=null
//endfunction
function ShenLong_Trigger takes nothing returns nothing
	local trigger t=CreateTrigger()
	//子胥举鼎
	call Ov(t)
	call TriggerAddCondition(t,Condition(function IsZiXuJuDing))
    call TriggerAddAction(t,function ZiXuJuDing)
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t,Condition(function IsZiXuBeiDong))
    call TriggerAddAction(t,function ZiXuBeiDong)
    //贵妃回眸
    set t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function IsGuiFeiHuiMou))
    call TriggerAddAction(t,function GuiFeiHuiMou)
    set t= CreateTrigger()
    call Ov(t)
	call TriggerAddCondition(t,Condition(function IsGuiFeiHuiMouSH))
    call TriggerAddAction(t,function GuiFeiHuiMouSH)
    //鲁达拔柳
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t,Condition(function IsLuDaBaLiu))
    call TriggerAddAction(t,function LuDaBaLiu)
    //狄青降龙
    set t= CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddCondition(t, Condition(function IsDiQingXiangLong))
    call TriggerAddAction(t,function DiQingXiangLong)
    set t= CreateTrigger()
    call Ov(t)
	call TriggerAddCondition(t,Condition(function IsDiQingXiangLongSH))
    call TriggerAddAction(t,function DiQingXiangLongSH)

    //飞燕回翔
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition(t, Condition(function IsFeiYanHuiXiang))
    call TriggerAddAction(t, function FeiYanHuiXiang)
	//小怜横陈
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_ATTACKED)
    call TriggerAddCondition(t,Condition(function IsXiaoLianHengChen))
    call TriggerAddAction(t,function XiaoLianHengChen)
    //神龙八式
    set t = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( t, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition(t, Condition(function Trig_ciZhenSaoSheConditions))
    call TriggerAddAction(t, function Trig_ciZhenSaoSheActions)
 //    set t= CreateTrigger()
 //   call Ov(t)
	//call TriggerAddCondition(t,Condition(function IsShenLongBaShiSH))
 //   call TriggerAddAction(t,function ShenLongBaShiSH)
    //神龙心法
    set t = null
endfunction

