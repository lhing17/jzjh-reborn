local jass    = require 'jass.common'
local japi    = require 'jass.japi'
local ai      = require 'jass.ai'
local console = require 'jass.console'
local runtime = require 'jass.runtime'

local setmetatable = setmetatable
local tostring     = tostring
local debug        = debug
local rawset       = rawset
local rawget       = rawget
local error        = error

local function warning(msg)
    console.write("---------------------------------------")
    console.write("             LUA WARNING!!             ")
    console.write("---------------------------------------")
    console.write(tostring(msg) .. "\n")
    console.write(debug.traceback())
    console.write("---------------------------------------")
end

local mt = {}
function mt:__index(i)
    if i < 0 or i > 8191 then
        warning('数组索引越界:'..i)
    end
    return rawget(self, '_default')
end

function mt:__newindex(i, v)
    if i < 0 then
        error('数组索引越界:'..i)
    elseif i > 8191 then
        warning('数组索引越界:'..i)
    end
    rawset(self, i, v)
end

function _native_(name)
    return _G[name] or japi[name] or jass[name] or ai[name]
end

function _array_(default)
    return setmetatable({ _default = default }, mt)
end

function _loop_()
    local i = 0
    return function()
        if i > 1000000 then
            error('循环次数太多')
        end
        i = i + 1
        return true
    end
end


local rawpairs = pairs
-------------------------------------------
---
-- 可以按指定顺序遍历的map迭代器
--- @param tbl table  要迭代的表
--- @param func  function 比较函数
--- @return function
--      for k,v in pairs(tbl,defaultComp) do print(k,v) end
function pairs(tbl, func)
    if func == nil then
        return rawpairs(tbl)
    end

    -- 为tbl创建一个对key排序的数组
    -- 自己实现插入排序，table.sort遇到nil时会失效
    local ary = {}
    local lastUsed = 0
    for key --[[, val--]] in rawpairs(tbl) do
        if (lastUsed == 0) then
            ary[1] = key
        else
            local done = false
            for j=1,lastUsed do  -- 进行插入排序
                if (func(key, ary[j]) == true) then
                    table.insert( ary, j, key )
                    done = true
                    break
                end
            end
            if (done == false) then
                ary[lastUsed + 1] = key
            end
        end
        lastUsed = lastUsed + 1
    end

    -- 定义并返回迭代器
    local i = 0
    local iter = function ()
        i = i + 1
        if ary[i] == nil then
            return nil
        else
            return ary[i], tbl[ary[i]]
        end
    end
    return iter
end

--------------------------------
-- 通用比较器(Comparator)
-- @return 对比结果
function defaultComp( op1, op2 )
    local type1, type2 = type(op1), type(op2)
    local num1,  num2  = tonumber(op1), tonumber(op2)

    if ( num1 ~= nil) and (num2 ~= nil) then
        return  num1 < num2
    elseif type1 ~= type2 then
        return type1 < type2
    elseif type1 == "string"  then
        return op1 < op2
    elseif type1 == "boolean" then
        return op1
        -- 以上处理: number, string, boolean
    elseif type1 == "userdata" then
        return jass.GetHandleId(op1) < jass.GetHandleId(op2)
        -- 处理剩下的:  function, table, thread, userdata
    else
        return tostring(op1) < tostring(op2)  -- tostring后比较字符串
    end
end
