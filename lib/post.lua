
-- post.lua


local cjson = require "cjson"
local io    = require "io"

local config  = require "config"
local utils   = require "utils"


local M = {}



-- line feed = 10 and carriage return = 13. don't encode.
function _encode_extended_ascii_char(dec_char)
    if dec_char == 10 or dec_char == 13 then
        return utf8.char(dec_char)
    elseif dec_char >= 32 and dec_char <= 37 then -- skip the amper (38) because we want to encode it.
        return utf8.char(dec_char)
    elseif dec_char >= 39 and dec_char <= 126 then
        return utf8.char(dec_char)
    else 
        return "&#" .. dec_char .. ";"
    end
end



function _encode_extended_ascii(str) 
    local new_str = ""

    for i, c in utf8.codes(str) do
        local x = _encode_extended_ascii_char(c)
        new_str = new_str .. x
    end

    return new_str
end



function M.create(filename)

    local author       = config.get_value_for("author")
    local session_id   = config.get_value_for("session_id")
    local rev          = config.get_value_for("rev")

    local action = "create"

    local f = assert(io.open(filename, "r"))
    local original_markup = f:read("a")
    f:close()

    local markup = _encode_extended_ascii(original_markup)

    local tmp_hash = utils.calc_reading_time_and_word_count(markup)
    print("debug word count = " .. tmp_hash.word_count)

    local request_body = { 
        author      = author,
        session_id  = session_id,
        rev         = rev,
        action      = action,
        markup      = markup 
    }
    local json_text = cjson.encode(request_body)
   
    local response_body = utils.send_to_kranz_server(json_text)

    -- local h_json = cjson.decode(response_body)

    print("create function: " .. response_body) 
end



function M.update(filename, original_slug)

    local author       = config.get_value_for("author")
    local session_id   = config.get_value_for("session_id")
    local rev          = config.get_value_for("rev")

    local action = "update"

    local f = assert(io.open(filename, "r"))
    local original_markup = f:read("a")
    f:close()

    local markup = _encode_extended_ascii(original_markup)

    local tmp_hash = utils.calc_reading_time_and_word_count(markup)
    print("debug word count = " .. tmp_hash.word_count)

    local request_body = { 
        author      = author,
        session_id  = session_id,
        rev         = rev,
        action      = action,
        markup      = markup,
        original_slug = original_slug 
    }
    local json_text = cjson.encode(request_body)

    local response_body = utils.send_to_kranz_server(json_text)

    -- local h_json = cjson.decode(response_body)

    -- for k,v in pairs(h_json) do
    --    print(k, v)
    -- end

    print("update function: " .. response_body) 
end



function M.read(id)

    local author       = config.get_value_for("author")
    local session_id   = config.get_value_for("session_id")
    local rev          = config.get_value_for("rev")

    local action = "read"

    local request_body = { 
        author      = author,
        session_id  = session_id,
        rev         = rev,
        action      = action,
        post_id     = id 
    }
    local json_text = cjson.encode(request_body)

    local response_body = utils.send_to_kranz_server(json_text)

    -- local h_json = cjson.decode(response_body)

    print("read function: " .. response_body) 
end



return M
