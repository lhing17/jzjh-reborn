
/*
 * 已知点(x0, y0)和由点(x1, y1) (x2, y2)确定的直线，求点到直线间的距离
 */
function getDistanceBetweenPointAndLine takes real x0, real y0, real x1, real y1, real x2, real y2 returns real
    local real A = y2 - y1
    local real B = x1 - x2
    local real C = x2 * y1 - x1 * y2
    local real distance = 0
    local real divisor = SquareRoot(A * A + B * B)
    local real dividend = A * x0 + B * y0 + C
    set distance = RAbsBJ(dividend / divisor)
    return distance
endfunction

