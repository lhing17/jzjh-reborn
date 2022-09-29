package.path = package.path .. ';scripts\\?.lua'



require 'utility'
require 'native'
require 'runtime'
require 'util.log'

local debug = require 'jass.debug'
local jass = require 'jass.common'

local function main()
    -- local t = jass.CreateTimer()
    -- jass.TimerStart(t, 10, true, function()
    --     log.info('当前jass虚拟机最大的handle为：'..debug.handlemax())
    --     log.info('当前jass虚拟机的handle数为：'..debug.handlecount())
    --     local counter = {}
    --     for handle_id = 0x100000, 0x100000 + debug.handlemax() do
    --         local handle = debug.i2h(handle_id)
    --         if handle then
    --             local def = debug.handledef(handle)
    --             if def.type then
    --                 counter[def.type] = (counter[def.type] or 0) + 1
    --             end
    --             if def.type == '+loc' then
    --                 log.info('泄漏location的位置为：' .. jass.GetLocationX(handle) .. ',' .. jass.GetLocationY(handle))
    --             end
    --             if def.type == '+w3u' then
    --                 log.info('泄漏unit的信息为：' .. jass.I2S(jass.GetUnitTypeId(handle)) .. ',' .. jass.GetUnitName(handle) .. ',' .. jass.GetUnitX(handle) .. ',' .. jass.GetUnitY(handle))
    --             end
    --             if def.type == 'item' then
    --                 log.info('泄漏的item的名称为: ' .. jass.GetItemName(handle) .. ', 位置为: ' .. jass.GetItemX(handle) .. ', ' .. jass.GetItemY(handle))
    --             end
    --         end
    --     end
    --     for k, v in pairs(counter) do
    --         log.info(k .. ": " .. v)
    --     end
    -- end)
    --et.loop(10 * 1000, function()
    --    --for k, v in pairs(debug) do
    --    --    print(k, v)
    --    --end
    --    --log.info('当前jass执行到的位置为：'..debug.currentpos())
    --    log.info('当前jass虚拟机最大的handle为：'..debug.handlemax())
    --    log.info('当前jass虚拟机的handle数为：'..debug.handlecount())
    --end)
end

main()




