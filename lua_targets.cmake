add_custom_target(lua_test_scripts
        COMMENT "Adding Lua test Scripts"
        DEPENDS lua_scripts
        )
add_custom_command(
        TARGET lua_test_scripts
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/tests/test_commands.lua ${CMAKE_BINARY_DIR}/tests/test_commands.lua
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/tests/test_server.lua ${CMAKE_BINARY_DIR}/tests/test_server.lua
)
add_custom_target(lua_scripts
        COMMENT "Adding Lua Scripts"
        )

add_custom_command(
        TARGET lua_scripts
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/source/main.lua ${CMAKE_BINARY_DIR}/share/myserver/main.lua
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/source/commands.lua ${CMAKE_BINARY_DIR}/share/myserver/commands.lua
)
add_custom_target(runTests ALL
        COMMENT "Running lua tests"
        COMMAND busted::busted
        ARGS tests/test_commands.lua --helper=set_paths
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        DEPENDS busted::busted luaBusted)
add_dependencies(runTests luaBusted)
set(main.lua share/myserver/main.lua)
set(LUA_SOURCE ${CMAKE_SOURCE_DIR}/source)
#get_target_property(LUA_INTERP Lua::lua LOCATION)
configure_file(startserver.sh.in ${CMAKE_BINARY_DIR}/bin/startserver.sh)
install(FILES ${CMAKE_BINARY_DIR}/bin/startserver.sh
        DESTINATION bin
        PERMISSIONS
        OWNER_EXECUTE
        OWNER_READ
        OWNER_WRITE
        WORLD_READ
        WORLD_EXECUTE
        GROUP_READ
        GROUP_EXECUTE
        )


add_test(NAME luaTests_commands
        COMMAND bin/busted tests/test_commands.lua --helper=share/myserver/set_paths
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )
add_test(NAME luaTests_server
        COMMAND bin/busted tests/test_server.lua --helper=share/myserver/set_paths
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        )


