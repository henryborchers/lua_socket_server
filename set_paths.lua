--
-- Created by IntelliJ IDEA.
-- User: hborcher
-- Date: 9/9/17
-- Time: 7:34 PM
-- To change this template use File | Settings | File Templates.
--
local version = _VERSION:match("%d+%.%d+")
package.path = 'lua_modules/share/lua/' .. version .. '/?.lua;lua_modules/share/lua/' .. version .. '/?/init.lua;share/lua/' .. version .. '/?.lua;source/?.lua;share/lua/' .. version .. '/?.lua;share/lua/' .. version .. '/?/init.lua;' .. package.path