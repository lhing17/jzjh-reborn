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