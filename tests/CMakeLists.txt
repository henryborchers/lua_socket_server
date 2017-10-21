if (LuaServer_include-tests)
    file(GLOB LUA_TESTS
            RELATIVE ${CMAKE_SOURCE_DIR}/
            ${CMAKE_SOURCE_DIR}/tests/*.lua)

    foreach (lua_test_file ${LUA_TESTS})
        message(STATUS "Located Lua test file: ${lua_test_file}")
        add_custom_command(
                OUTPUT ${lua_test_file}
                COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/${lua_test_file} ${CMAKE_BINARY_DIR}/${lua_test_file}
                COMMENT "UPDATING ${lua_test_file}"
        )

    endforeach ()

    add_custom_target(lua_test_scripts
            ALL
            COMMENT "Adding/updating Lua test Scripts"
            DEPENDS lua_scripts lualuasockets
            DEPENDS ${LUA_TESTS}
            )
    add_dependencies(lua_test_scripts busted::busted)
    add_custom_target(runTests
            COMMENT "Running lua tests"
            DEPENDS busted::busted lua_test_scripts)


    add_custom_command(TARGET runTests
            #            COMMENT "Running tests inside "
            COMMAND busted::busted tests
            ARGS tests/*.lua --helper=share/myserver/set_paths -v
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            )
    add_dependencies(runTests luaBusted lua::sockets)


    add_test(NAME luaTests_commands
            COMMAND busted::busted tests/test_commands.lua --helper=share/myserver/set_paths
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            )

    add_test(NAME luaTests_server
            COMMAND busted::busted tests/test_server.lua --helper=share/myserver/set_paths
            WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
            )
endif ()