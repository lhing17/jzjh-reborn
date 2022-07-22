/*
 * 万能状态系统：
 * 1 内伤 处于内伤状态下，每次发起攻击扣除自身气血1/1000
 * 2 走火入魔 该单位受到了走火入魔的作用，每次发起攻击会扣除自身3/1000的气血
 * 3 流血 处于流血状态下，每秒扣除气血2/1000
 * 4 混乱 该单位受到了混乱的作用，因此失去了控制
 * 5 昏迷 该单位被昏迷了，其移动速度下降很多
 * 6 重伤 该单位被重伤了，其攻击速度都会下降
 * 7 血流不止 处于血流不止状态下，每秒扣除气血3/1000
 * 8 麻痹 该单位受到了麻痹效果，因此攻击命中率从下降60%
 * 9 破防 降低400点护甲
 * 10 神经错乱 释放技能和触发招式扣血气血5%
 * 11 封穴 眩晕3秒
 * 12 穴位全封 眩晕6秒
 * 13 中毒 处于中毒状态下，减少移动速度并且每秒扣除气血1/1000
 * 14 深度中毒 处于深度中毒状态下，减少移动速度并且每秒扣除气血3/1000
 * 15 致盲 处于致盲状态下，攻击命中率大幅下降
 * 16 虚弱 单位的特防失效
 */
function WanBuff_1 takes integer buffnum, integer num, unit uc, integer id, integer orderid, unit ut, string s returns nothing
	local unit u
	local player p
	local location loc
	if (buffnum==num) then
		set p = GetOwningPlayer(uc)
		set loc = GetUnitLoc(ut)
		call CreateNUnitsAtLoc(1,'e000',p,loc,bj_UNIT_FACING)
    	set u = bj_lastCreatedUnit
    	call ShowUnitHide(u)
		call UnitAddAbility(u, id)
		if (num==12 or num==14) then
			call IncUnitAbilityLevel(u,id)
		endif
    	call IssueTargetOrderById(u, orderid, ut)
    	call UnitApplyTimedLife(u,'BHwe',2.)
    	call CreateTextTagLocBJ(s,loc,60.,12.,65.,55.,42.,0)
		call Nw(3.,bj_lastCreatedTextTag)
    	call SetTextTagVelocityBJ(bj_lastCreatedTextTag,100.,90)
		call RemoveLocation(loc)
	endif
	set loc = null
	set p = null
	set u = null
endfunction

function WanBuff takes unit u, unit ut, integer buffnum returns nothing
    call WanBuff_1(buffnum, 1, u, 'A077', $D008F, ut, "内伤")
    call WanBuff_1(buffnum, 2, u, 'A079', $D02BC, ut, "走火入魔")
    call WanBuff_1(buffnum, 3, u, 'A075', $D022F, ut, "流血")
    call WanBuff_1(buffnum, 4, u, 'A06I', $D00DD, ut, "混乱")
    call WanBuff_1(buffnum, 5, u, 'A0AZ', $D006B, ut, "昏迷")
    call WanBuff_1(buffnum, 6, u, 'A076', $D006B, ut, "重伤")
    call WanBuff_1(buffnum, 7, u, 'A078', $D022F, ut, "血流不止")
    call WanBuff_1(buffnum, 8, u, 'A0AY', $D00DE, ut, "麻痹")
    call WanBuff_1(buffnum, 9, u, 'A019', $D00B5, ut, "破防")
    call WanBuff_1(buffnum, 10, u, 'A05N', $D00DE, ut, "神经错乱")
    call WanBuff_1(buffnum, 11, u, 'A05L', $D007F, ut, "封穴")
    call WanBuff_1(buffnum, 12, u, 'A05L', $D007F, ut, "穴位全封")
	call WanBuff_1(buffnum, 13, u, 'A074', $D022F, ut, "中毒")
	call WanBuff_1(buffnum, 14, u, 'A074', $D022F, ut, "深度中毒")
    call WanBuff_1(buffnum, 15, u, 'A097', $D00DE, ut, "致盲")
    call WanBuff_1(buffnum, 16, u, 'A0DV', $D00DE, ut, "虚弱")
    call WanBuff_1(buffnum, 17, u, 'A0EW', $D007F, ut, "冰冻")
endfunction
