if (LuaServer_include-tests)
    add_custom_target(lua_tests
            ALL
            COMMENT "Adding/updating Lua test Scripts"
            )
    add_dependencies(lua_tests busted::busted)
    add_test(NAME luaTests_server
            COMMAND busted::busted test_server.lua
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            )
    add_test(NAME luaTests_commands
            COMMAND busted::busted test_commands.lua
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            )

    set_tests_properties(luaTests_commands luaTests_server PROPERTIES
            ENVIRONMENT LUA_PATH=${CMAKE_BINARY_DIR}/server/share/myserver/?.lua
            DEPENDS busted::busted
            )
endif ()