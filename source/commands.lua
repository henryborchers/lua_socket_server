--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 8:31 PM
-- To change this template use File | Settings | File Templates.
--
local list_commands
local Command = { help_message = "", server_message = "" }
local server_commands = {}
function Command:exec()
    error("Override this function")
end

function Command:new(t)

    local t = t or {}
    t.response = ""
    t.args = {}
    t.valid_arguments = {}
    setmetatable(t, self)
    self.__index = self
    return t
end

local Foo = Command:new { help_message = "Does nothing" }

function Foo:exec()
    print("You called a foo")
    self.message = "You called a foo"
end

local Help = Command:new { help_message = "get this help message" }

function Help:exec()
    local message = "Help Information:"
    if #self.args == 0 then
        message = message .. "\nAvailable commands:"
        for key, value in pairs(list_commands()) do
            message = message .. "\n  " .. key
        end
        message = message .. "\n\nTo shutdown the server use the command, shutdown."
    elseif #self.args == 1 then
        if server_commands[self.args[1]] ~= nil then
            message = message .. "\n" .. server_commands[self.args[1]].help_message
        else
            message = message .. "\nNo help found"
        end
    else
        self.reponse = "Syntax error"
        return
    end

    self.response = message
end


local InvalidCommand = Command:new { help_message = "Invalid command" }
function InvalidCommand:exec()
    local message = "Invalid command. Use help to see valid command"
    print(message)
    self.response = message
end




local function contains(key)
    return server_commands[key] ~= nil
end

local function parse_command(text)
    local words = {}
    for word in text:gmatch("%w+") do
        table.insert(words, word)
    end
    local root_command = words[1]
    table.remove(words, 1)
    local args = words
    --    local args = table.splice(words, 2, #words)
    return root_command, args
end

-- factory function for building commands
local function get(text)
    local command_root, args = parse_command(text)

    if contains(command_root) then
        local command = server_commands[command_root]
        command.args = args
        return command
    else
        return InvalidCommand
    end
end


server_commands = {
    foo = Foo,
    help = Help
}

list_commands = function()
    return server_commands
end
return {
    get = get
}
