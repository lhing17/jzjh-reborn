package.path = package.path .. ';scripts\\?.lua'



require 'utility'
require 'native'
require 'runtime'
require 'util.log'

local debug = require 'jass.debug'

local function main()
    et.loop(10 * 1000, function()
        --for k, v in pairs(debug) do
        --    print(k, v)
        --end
        --log.info('当前jass执行到的位置为：'..debug.currentpos())
        log.info('当前jass虚拟机最大的handle为：'..debug.handlemax())
        log.info('当前jass虚拟机的handle数为：'..debug.handlecount())
    end)
end

main()




