--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 11/23/17
-- Time: 6:46 PM
-- To change this template use File | Settings | File Templates.
--
require("busted.runner")()
describe("load the packet module", function()
    local packets = require("packets")
    describe("Create a new_packet", function()
        local packet = {
            command = "help",
            args = {
                my_flag_arg = true,
                my_string_arg = "just a string"
            }
        }
        local encoded_packet = packets.create_packet(packet)
        it("got a packet data", function()
            assert.is_not_nil(encoded_packet)
        end)
        describe("decode a packet", function()

            local packet = packets.get_packet(encoded_packet)
            it("got a packet", function()
                assert.is_not_nil(packet)
            end)
            it("got a help command", function()
                assert.are_equal(packet['command'], "help")
                print("ALL DONE")
            end)
            it("got args", function()
                assert.is_not_nil(packet['args'])
            end)
            it("got a flag argument", function()
                assert.are_equal(packet.args['my_flag_arg'], true)
            end)
            it("got a string argument", function()
                assert.are_equal("just a string", packet.args['my_string_arg'])
            end)
        end)
    end)
end)

