--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/10/17
-- Time: 12:19 AM
-- To change this template use File | Settings | File Templates.
--
require("busted.runner")()
insulate("Import server", function()
    local server = require("server")
    it("has features", function()
        local func = server.run_server
        assert.is_not_nil(func)
    end)
    describe("get a new server", function()
        describe("with a specifc port", function()
            local my_server = server.Server:new { port = 8888 }
            it("valid", function()

                assert.is_not_nil(my_server)
                assert.is_equal(my_server.port, 8888)
            end)
        end)
        describe("with default port", function()
            local my_server = server.Server:new()
            it("valid", function()

                assert.is_not_nil(my_server)
                assert.is_equal(my_server.port, 8000)
            end)
        end)
    end)
end)

