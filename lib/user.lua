
-- user.lua module

local cjson   = require "cjson"

local config  = require "config"
local utils   = require "utils"


local M = {}


function M.request_login_link()
    local request_body = { 
        action = "request_login_link", 
        email  = config.get_value_for("email")
    }
    local json_text = cjson.encode(request_body)
    local response_body = utils.send_to_kranz_server(json_text)
    -- local h_json = cjson.decode(response_body)
    print("request login link function: " .. response_body) 
end


function M.activate_login(rev)
    local request_body = { 
        action = "activate_login", 
        rev = rev
    }
    local json_text = cjson.encode(request_body)
    local response_body = utils.send_to_kranz_server(json_text)
    -- local h_json = cjson.decode(response_body)
    print("activate login function: " .. response_body) 
end


function M.logout()

    local author       = config.get_value_for("author")
    local session_id   = config.get_value_for("session_id")
    local rev          = config.get_value_for("rev")

    local action = "logout"

    local request_body = { 
        author      = author,
        session_id  = session_id,
        rev         = rev,
        action      = action
    }
    local json_text = cjson.encode(request_body)

    local response_body = utils.send_to_kranz_server(json_text)

    -- local h_json = cjson.decode(response_body)

    print("logout function: " .. response_body) 

end


return M
