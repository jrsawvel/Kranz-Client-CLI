local M = {}


local ltn12     = require "ltn12"
local socket    = require "socket"
local socketurl = require "socket.url"


local config    = require "config"



function M.trim_spaces (str)
    if (str == nil) then
        return ""
    end
   
    -- remove leading spaces 
    str = string.gsub(str, "^%s+", "")

    -- remove trailing spaces.
    str = string.gsub(str, "%s+$", "")

    return str
end



function M.calc_reading_time_and_word_count(text)

    local hash = {}

    local dummy, n = text:gsub("%S+","") -- n = substitutions

    hash.word_count   = n or 0

    hash.reading_time = 0  -- minutes

    if hash.word_count >= 180 then
        hash.reading_time = math.floor(hash.word_count / 180)
    end

    return hash

end


function _receive(c)
    local body = ""
    while true do
        local line, err = c:receive("*l")
        if line:len() > 0 and line ~= nil then
            body = body .. line .. "\n"
        else
            break
        end
	end
    return body
end



function M.send_to_kranz_server(content)

    local server_domain = config.get_value_for("kranz_server_domain")
    local server_port   = config.get_value_for("kranz_server_port")

--    print("server domain = " .. server_domain)
--    print("server port   = " .. server_port)
--    print("content = " .. content)

    -- Open connection
    local conn = socket.tcp()

    local ret, str = conn:connect(server_domain, server_port)

    if ret == nil then
        error("unable to connect.")
    end

    conn:send(content .. "\n")
    -- print(_receive(conn))

    local msg, err = conn:receive()

    if msg:len() > 0 and msg ~= nil then
--        print(line)        
    else
        print(err)
    end

    return msg
end



return M


