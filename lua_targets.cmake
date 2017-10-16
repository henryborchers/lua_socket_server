if (LuaServer_include-tests)
    file(GLOB LUA_TESTS
            RELATIVE ${CMAKE_SOURCE_DIR}/
            ${CMAKE_SOURCE_DIR}/tests/*.lua)

    foreach (lua_test_file ${LUA_TESTS})
        message(STATUS "Located Lua test file = ${lua_test_file}")
        add_custom_command(
                OUTPUT ${lua_test_file}
                COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/${lua_test_file} ${CMAKE_BINARY_DIR}/${lua_test_file}
                COMMENT "UPDATING ${lua_test_file}"
        )

    endforeach ()

    add_custom_target(lua_test_scripts
            ALL
            COMMENT "Adding/updating Lua test Scripts"
            DEPENDS lua_scripts busted::busted lualuasockets
            DEPENDS ${LUA_TESTS}
            )

    add_custom_target(runTests
            COMMENT "Running lua tests"
            DEPENDS busted::busted lua_test_scripts)


    add_custom_command(TARGET runTests
            COMMENT "Running tests inside "
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

file(GLOB PROJECT_LUA_SCRIPTS
        RELATIVE ${CMAKE_SOURCE_DIR}/source
        ${CMAKE_SOURCE_DIR}/source/*.lua)
foreach (lua_project_script ${PROJECT_LUA_SCRIPTS})
    message(STATUS "Located lua script: ${CMAKE_SOURCE_DIR}/source/${lua_project_script}")
    add_custom_command(
            OUTPUT ${lua_project_script}
            COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/source/${lua_project_script} ${CMAKE_BINARY_DIR}/share/myserver/${lua_project_script}
            COMMENT "Adding/updating ${lua_project_script}."
    )
endforeach ()
add_custom_target(lua_scripts
        ALL
        COMMENT "Adding/updating Lua Scripts "
        DEPENDS ${PROJECT_LUA_SCRIPTS}
        )
add_dependencies(lua_scripts lua::sockets)

set(main.lua share/myserver/main.lua)
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


