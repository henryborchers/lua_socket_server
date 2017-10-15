--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 6:15 PM
-- To change this template use File | Settings | File Templates.
--
local server = require("server")
local commands = require("commands")


print("Starting!")
server.run_server(5555)
--local dummy = commands['foo']
--dummy.exec()
print("Lua is all done")

--getGoogle()