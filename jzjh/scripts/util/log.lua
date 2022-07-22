
log = require 'jass.log'

local console = require 'jass.console'
console.write('加载日志系统')

local log = log

local runtime = require 'jass.runtime'
local debug = debug

local function split(str, p)
	local rt = {}
	string.gsub(str, '[^]' .. p .. ']+', function (w) table.insert(rt, w) end)
	return rt
end

--for k, v in pairs(log) do
--	print(k, v)
--end

if base.release then
	log.level = 'info'
else
	log.level = 'debug'
end
console.write(log.path)
log.path = 'E:\\jzjh\\logs\\' .. split(log.path, '\\')[2]
log.debug '日志系统装载完毕,向着星辰大海出击!'
log.info('当前lua引擎的版本为'..runtime.version)

local std_print = print
function print(...)
	log.info(...)
    console.write(...)
	return std_print(...)
end

local log_error = log.error
function log.error(...)
	local trc = debug.traceback()
	log_error(...)
	log_error(trc)
	std_print(...)
	std_print(trc)
end

local error_handle = runtime.error_handle
runtime.error_handle = function(msg)
	error_handle(msg)
	log_error("---------------------------------------")
	log_error("              LUA ERROR!!              ")
	log_error("---------------------------------------")
	log_error(tostring(msg) .. "\n")
	log_error(debug.traceback())
	log_error("---------------------------------------")
end
