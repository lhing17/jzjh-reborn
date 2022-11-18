// 彩蛋系统
globals
    // 英雄死亡五次 复活时间减少2秒
    integer array heroDeathCounter
    // 英雄杀敌数
    integer array heroKillCounter
endglobals


// 初始化彩蛋系统
function initEgg takes nothing returns nothing
    local integer i = 1
    loop
        exitwhen i > 5
        set heroDeathCounter[i] = 0
        set heroKillCounter[i] = 0
        set i = i + 1
    endloop
endfunction

