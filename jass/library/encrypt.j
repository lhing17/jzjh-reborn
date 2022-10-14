// 加密
globals
	string priKey
endglobals
function encryptInt takes integer src, player p returns string
	local string playerName = LoadStr(YDHT, GetHandleId(p), GetHandleId(p))
	local integer hash = StringHash(playerName + priKey)
	return I2S(hash + src)
endfunction

function decryptInt takes string src, player p returns integer
	local string playerName = LoadStr(YDHT, GetHandleId(p), GetHandleId(p))
    local integer hash = StringHash(playerName + priKey)
    local integer decrypt = S2I(src) - hash
    if decrypt > 90000000 or decrypt < 0 then
        return 0
    endif
    return decrypt
endfunction

function transformInt takes integer i returns integer
    local string s = DzAPI_Map_GetMapConfig("hashKey")
    local integer hash = 0
    if s == null or s == "" then
        set hash = 68
    else
        set hash = S2I(s)
    endif
    return i * hash + GetRandomInt(1, 63)
endfunction

function untransformInt takes integer i returns integer
    local string s = DzAPI_Map_GetMapConfig("hashKey")
    local integer hash = 0
    if s == null or s == "" then
        set hash = 68
    else
        set hash = S2I(s)
    endif
    return i / hash
endfunction

// 将整数转换为62进制字符
function encodeChar takes integer i returns string
    if i == 0 then
        return "a"
    elseif i == 1 then
        return "b"
    elseif i == 2 then
        return "c"
    elseif i == 3 then
        return "d"
    elseif i == 4 then
        return "e"
    elseif i == 5 then
        return "f"
    elseif i == 6 then
        return "g"
    elseif i == 7 then
        return "h"
    elseif i == 8 then
        return "i"
    elseif i == 9 then
        return "j"
    elseif i == 10 then
        return "k"
    elseif i == 11 then
        return "l"
    elseif i == 12 then
        return "m"
    elseif i == 13 then
        return "n"
    elseif i == 14 then
        return "o"
    elseif i == 15 then
        return "p"
    elseif i == 16 then
        return "q"
    elseif i == 17 then
        return "r"
    elseif i == 18 then
        return "s"
    elseif i == 19 then
        return "t"
    elseif i == 20 then
        return "u"
    elseif i == 21 then
        return "v"
    elseif i == 22 then
        return "w"
    elseif i == 23 then
        return "x"
    elseif i == 24 then
        return "y"
    elseif i == 25 then
        return "z"
    elseif i == 26 then
        return "A"
    elseif i == 27 then
        return "B"
    elseif i == 28 then
        return "C"
    elseif i == 29 then
        return "D"
    elseif i == 30 then
        return "E"
    elseif i == 31 then
        return "F"
    elseif i == 32 then
        return "G"
    elseif i == 33 then
        return "H"
    elseif i == 34 then
        return "I"
    elseif i == 35 then
        return "J"
    elseif i == 36 then
        return "K"
    elseif i == 37 then
        return "L"
    elseif i == 38 then
        return "M"
    elseif i == 39 then
        return "N"
    elseif i == 40 then
        return "O"
    elseif i == 41 then
        return "P"
    elseif i == 42 then
        return "Q"
    elseif i == 43 then
        return "R"
    elseif i == 44 then
        return "S"
    elseif i == 45 then
        return "T"
    elseif i == 46 then
        return "U"
    elseif i == 47 then
        return "V"
    elseif i == 48 then
        return "W"
    elseif i == 49 then
        return "X"
    elseif i == 50 then
        return "Y"
    elseif i == 51 then
        return "Z"
    elseif i == 52 then
        return "0"
    elseif i == 53 then
        return "1"
    elseif i == 54 then
        return "2"
    elseif i == 55 then
        return "3"
    elseif i == 56 then
        return "4"
    elseif i == 57 then
        return "5"
    elseif i == 58 then
        return "6"
    elseif i == 59 then
        return "7"
    elseif i == 60 then
        return "8"
    elseif i == 61 then
        return "9"
    endif
    return ""
endfunction

// 将62进制字符转换为整数
function decodeChar takes string s returns integer
    if s == "a" then
        return 0
    elseif s == "b" then
        return 1
    elseif s == "c" then
        return 2
    elseif s == "d" then
        return 3
    elseif s == "e" then
        return 4
    elseif s == "f" then
        return 5
    elseif s == "g" then
        return 6
    elseif s == "h" then
        return 7
    elseif s == "i" then
        return 8
    elseif s == "j" then
        return 9
    elseif s == "k" then
        return 10
    elseif s == "l" then
        return 11
    elseif s == "m" then
        return 12
    elseif s == "n" then
        return 13
    elseif s == "o" then
        return 14
    elseif s == "p" then
        return 15
    elseif s == "q" then
        return 16
    elseif s == "r" then
        return 17
    elseif s == "s" then
        return 18
    elseif s == "t" then
        return 19
    elseif s == "u" then
        return 20
    elseif s == "v" then
        return 21
    elseif s == "w" then
        return 22
    elseif s == "x" then
        return 23
    elseif s == "y" then
        return 24
    elseif s == "z" then
        return 25
    elseif s == "A" then
        return 26
    elseif s == "B" then
        return 27
    elseif s == "C" then
        return 28
    elseif s == "D" then
        return 29
    elseif s == "E" then
        return 30
    elseif s == "F" then
        return 31
    elseif s == "G" then
        return 32
    elseif s == "H" then
        return 33
    elseif s == "I" then
        return 34
    elseif s == "J" then
        return 35
    elseif s == "K" then
        return 36
    elseif s == "L" then
        return 37
    elseif s == "M" then
        return 38
    elseif s == "N" then
        return 39
    elseif s == "O" then
        return 40
    elseif s == "P" then
        return 41
    elseif s == "Q" then
        return 42
    elseif s == "R" then
        return 43
    elseif s == "S" then
        return 44
    elseif s == "T" then
        return 45
    elseif s == "U" then
        return 46
    elseif s == "V" then
        return 47
    elseif s == "W" then
        return 48
    elseif s == "X" then
        return 49
    elseif s == "Y" then
        return 50
    elseif s == "Z" then
        return 51
    elseif s == "0" then
        return 52
    elseif s == "1" then
        return 53
    elseif s == "2" then
        return 54
    elseif s == "3" then
        return 55
    elseif s == "4" then
        return 56
    elseif s == "5" then
        return 57
    elseif s == "6" then
        return 58
    elseif s == "7" then
        return 59
    elseif s == "8" then
        return 60
    elseif s == "9" then
        return 61
    endif
    return - 1
endfunction


// 将整数转换为62进制字符串
function encodeInt takes integer i returns string
    local string result = ""
    local integer temp = i
    local integer remainder
    loop
        set remainder = ModuloInteger(temp, 62)
        set temp = temp / 62
        set result = result + encodeChar(remainder)
        if temp < 1 then
            exitwhen true
        endif
    endloop
    return result
endfunction

// 将62进制字符串转为整数
function decodeInt takes string s returns integer
    local integer result = 0
    local integer i = 0
    local integer temp
    local integer char
    local integer k = 1
    loop
        exitwhen i > StringLength(s) - 1
        set char = decodeChar(SubString(s, i, i + 1))
        set temp = char * k
        set result = result + temp
        set k = k * 62
        set i = i + 1
    endloop

    return result

endfunction

function newEncryptInt takes integer i returns string
    return encodeInt(transformInt(i))
endfunction

function newDecryptInt takes string s returns integer
    if s == "" or s == null then
        return 0
    endif
    return untransformInt(decodeInt(s))
endfunction