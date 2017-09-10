--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 6:15 PM
-- To change this template use File | Settings | File Templates.
--
local server = require("server")
local commands = require("commands")

--local function run_server(in_port)
--    print("Running a local server")
--    local socket = require("socket")
--    local server = assert(socket.bind("*", in_port))
--    local ip, port = server:getsockname()
--    print("telnet into " .. port)
--    while 1 do
--        local client = server:accept()
--        print("logged in")
--        client:settimeout(10)
--        local abort = run_server_client(client)
--        if abort then
--            print("Called abort")
--            break
--        end
--
--        client:close()
--        print("client closed")
--    end
--    print("Server closed")
--
--    --    local client
--end

server.run_server(5555)
--local dummy = commands['foo']
--dummy.exec()
print("all done")

--getGoogle()