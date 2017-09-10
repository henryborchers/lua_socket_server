--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 8:31 PM
-- To change this template use File | Settings | File Templates.
--


local Command = { help_message = "", server_message = "" }

function Command:exec()
    error("override this function")
end

function Command:new(t)

    t = t or {}
    setmetatable(t, self)
    self.__index = self
    return t
end

local Foo = Command:new { help_message = "does nothing" }

function Foo:exec()
    print("You called a foo")
end

local Help = Command:new { help_message = "get this help message" }

function Help:exec()
    local message = "Help message goes here"
    --    for k,v in pairs(commands) do
    --        print
    print(message)
end


local function list()
    print(#commands)
end


local commands = {
    foo = Foo,
    help = Help
}
function commands.contains(key)
    return commands[key] ~= nil
end

return commands
