
-- search.lua

local cjson   = require "cjson"

local config  = require "config"
local utils   = require "utils"


local M = {}


function M.search(search_string)

    local author       = config.get_value_for("author")
    local session_id   = config.get_value_for("session_id")
    local rev          = config.get_value_for("rev")

    local action = "search"

    local request_method = os.getenv("REQUEST_METHOD")

    search_string = utils.trim_spaces(search_string)

    if search_string == nil or search_string == "" then
        error("Missing data. Enter keyword(s) to search on.")
    end

    local request_body = { 
        author      = author,
        session_id  = session_id,
        rev         = rev,
        action      = action,
        search_string = search_string 
    }

    local json_text = cjson.encode(request_body)

    local response_body = utils.send_to_kranz_server(json_text)

    print("search function: " .. response_body) 
 
end

return M

