#!/usr/local/bin/lua

-- sep 22, 2020
--
-- cootclient.lua
--
-- renamed kranzclientcli.lua on oct 2, 2020


package.path = package.path .. ';/home/john/Kranz/KranzClientCLI/lib/?.lua'


local user   = require "user"
local post   = require "post"
local search = require "search"



if #arg < 1 then
    error("missing parameters. use ./kranzclientcli.lua help for info.")
end


if #arg == 1 and arg[1] == "login" then
    user.request_login_link()
elseif #arg == 2 and arg[1] == "activate" then
    user.activate_login(arg[2])  
elseif #arg == 2 and arg[1] == "create" then
    post.create(arg[2])    
elseif #arg == 3 and arg[1] == "update" then
    post.update(arg[2], arg[3])
elseif #arg == 2 and arg[1] == "read" then
    post.read(arg[2])
elseif #arg == 1 and arg[1] == "logout" then
    user.logout()
elseif #arg == 2 and arg[1] == "search" then
    search.search(arg[2])
else
    print("nothing to do for: " .. arg[1])
end


