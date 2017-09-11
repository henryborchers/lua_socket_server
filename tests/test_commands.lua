--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 7:29 PM
-- To change this template use File | Settings | File Templates.
--
--package.path = "lua_modules/share.lua.5.3"
require("busted.runner")()



insulate("Import commands", function()
    local commands = require("commands")
    describe("Foo", function()
        local foo_command = commands['foo']
        it("create", function()
            assert.is_not_nil(foo_command)
        end)
        it("exec", function()
            assert.is_function(foo_command.exec)
        end)

        it("help_message", function()
            local help_message = foo_command['help_message']
            assert.is_string(help_message)
            assert.are_equal(help_message, "does nothing")
        end)
    end)

    describe("commands", function()
        describe("contain", function()
            it("valid", function()
                assert.is_true(commands.contains("foo"))
            end)
            it("invalid command", function()
                assert.is_false(commands.contains("bar"))
            end)
        end)
        it("exec", function()

            local x = commands['help']
            x.exec()
        end)
    end)
end)

