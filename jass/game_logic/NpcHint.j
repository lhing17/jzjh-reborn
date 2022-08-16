// NPC提示

function createTagForNpc0 takes string text, real x, real y, real size, real zOffset, integer r, integer g, integer b, integer transparency returns nothing
    local texttag last = CreateTextTag()
    local real height = size * 0.023 / 10
    call SetTextTagText(last, text, height)
    call SetTextTagPos(last, x, y, zOffset)
    call SetTextTagColor(last, r * 255 / 100, g * 255 / 100, b * 255 / 100,  (100 - transparency) * 255 / 100)
    set last = null
endfunction

function createTagForNpc takes string s, real x, real y returns nothing
    call createTagForNpc0(s, x-50, y, 13, 100, 100, 100, 0, 50)
endfunction


function npcHint takes nothing returns nothing
    // 新手教官
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N007_0055, "[ch]1.mdl")
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N012_0095, "[ch]1.mdl")
    // 积分商店
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N00P_0084, "[ch]2.mdl")
    // 道具商城
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N00U_0092, "[ch]3.mdl")
    // 等级奖励
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N00F_0085, "[ch]4.mdl")
    // 驿站
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_o02D_0069, "[ch]5.mdl")
    // 古董商人
    call AddSpecialEffectTargetUnitBJEx("overhead", GU_DONG_SHANG_REN, "[ch]6.mdl")
    // 练功木桩
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N008_0054, "[ch]7.mdl")
    // 副本传送
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_o00K_0126, "[ch]8.mdl")
    // 贼哥
    call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N00B_0086, "[ch]9.mdl")
    // 炼制丹药
    call AddSpecialEffectTargetUnitBJEx("overhead", PING_YI_ZHI, "[ch]10.mdl")
    // 历练传送
    call AddSpecialEffectTargetUnitBJEx("overhead", SHI_PO_TIAN, "[ch]11.mdl")
    // 宝石商人
    call AddSpecialEffectTargetUnitBJEx("overhead", BAO_SHI_SHANG_REN, "[ch]12.mdl")
    // 选择副职
    call AddSpecialEffectTargetUnitBJEx("overhead", nt, "[ch]13.mdl")
    // 新手任务
    call AddSpecialEffectTargetUnitBJEx("overhead", Ts, "[ch]14.mdl")
endfunction