--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 7:29 PM
-- To change this template use File | Settings | File Templates.
--
--package.path = "lua_modules/share.lua.5.3"
require("busted.runner")()

insulate("When importing the commands module", function()
    local commands = require("commands")

    describe("and use the get function", function()

        describe("and you ask for help on a valid argument", function()
            local my_command = commands.get("help foo")
            it("it gets a command that puts the help information in the message property when you run the exec method", function()
                my_command:exec()
                assert.are_equal("Help Information:\n\nDoes nothing", my_command.response)
            end)
        end)

        describe("asks for a valid command with no arguments", function()
            local my_command = commands.get("foo")
            it("gets a command which has a help_message", function()
                assert.is_string(my_command.help_message)
                assert.are_equal(my_command.help_message, "Does nothing")
            end)
        end)
        describe("asks for a invalid command with no arguments", function()
            local my_command = commands.get("dummy")
            it("gets a the invalid command object", function()
                assert.are_equal(my_command.help_message, "Invalid command")
                my_command:exec()
            end)
        end)
    end)
end)

