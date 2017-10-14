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
            COMMENT "Adding Lua test Scripts"
            DEPENDS lua_scripts busted::busted lualuasockets
            DEPENDS ${LUA_TESTS}
            )

    add_custom_target(runTests
            COMMENT "Running lua tests"
            COMMAND busted::busted
            ARGS tests/test_commands.lua --helper=set_paths
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            DEPENDS busted::busted luaBusted lua_test_scripts)

    add_dependencies(runTests luaBusted)


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
            COMMENT "Adding ${lua_project_script}."
    )
endforeach ()
add_custom_target(lua_scripts
        COMMENT "Adding Lua Scripts"
        DEPENDS busted::busted
        DEPENDS ${PROJECT_LUA_SCRIPTS}
        )

set(main.lua share/myserver/main.lua)
#set(LUA_SOURCE ${CMAKE_SOURCE_DIR}/source)
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


