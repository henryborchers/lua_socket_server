--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 8:10 PM
-- To change this template use File | Settings | File Templates.
--
local socket = require("socket")
local commands = require("commands")
local Server = { port = 8000 }
local Client = {}

--local function run_server_client(client)
--    while 1 do
--        local line, erro = client:receive()
--        if commands.contains(line) then
--            print("yes")
--        end
--        if line == "quit" then
--            print("got a line")
--            return false
--        end
--        if line == "shutdown" then
--            print("shutting down")
--            return true
--        end
--        if not err then client:send(line .. "\n") end
--    end
--end

function Server:new(t)
    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end

function Server:start()
    self.server = assert(socket.bind("*", self.port))
    self.ip, self.port = self.server:getsockname()
end

function Server:login()
    local connection = self.server:accept()
    connection:settimeout(10)
    local client = Client:new { connection = connection }
    return client
end

local function format_return_message(text)
    local head = "+"..string.rep("=", 79)
    local side = "| "
    local tail = "+"..string.rep("=", 79)
    local message = side .. string.gsub(text, "\n", "\n" .. side)
    return head .. "\n" .. message .. "\n" .. tail .. "\n\n"
end


function Client:run()
    local connection = self['connection']

    while 1 do
        local line, erro = connection:receive()
        if line then

            local my_command = commands.get(line)
            my_command:exec()
            --            connection:send("\n"..my_command.response .. "\n\n")
            if line == "quit" then
                print("got a line")
                break
            end
            if line == "shutdown" then
                print("shutting down")
                self.abort = true
                break
            end
            if my_command.response ~= "" then connection:send(format_return_message(my_command.response)) end
            --            if not err then connection:send(line .. "\n") end
            self.abort = false
        else
            print("did nothing")
        end
    end
end

function Client:logout()
    self['connection']:close()
end

function Client:new(t)
    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end



local function run_server()
    print("Running a local server")
    local my_server = Server:new { port = 5555 }
    my_server:start()
    print("telnet into " .. my_server.port)
    while 1 do
        local client = my_server:login()
        print("logged in")
        client:run()
        client:logout()
        print("client closed")
        if client.abort == true then
            print("Called abort")
            break
        end
    end
    print("Server closed")
end


return {
    run_server = run_server,
    Server = Server
}