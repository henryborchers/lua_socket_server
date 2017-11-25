set(SERVER_BUILD_SERVER ${CMAKE_BINARY_DIR}/server/)
file(GLOB PROJECT_LUA_SCRIPTS
        RELATIVE ${CMAKE_SOURCE_DIR}/source/server/
        ${CMAKE_SOURCE_DIR}/source/server/*.lua)
foreach (lua_project_script ${PROJECT_LUA_SCRIPTS})
    message(STATUS "Located lua script: ${lua_project_script}")
#    add_custom_command(
#            OUTPUT ${lua_project_script}
#            COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_SOURCE_DIR}/source/server/${lua_project_script} ${SERVER_BUILD_SERVER}/share/myserver/${lua_project_script}
#            COMMENT "Adding/updating ${lua_project_script}."
#    )
endforeach ()

add_custom_target(lua_scripts
        ALL
        COMMENT "Adding/updating Lua Scripts "
#        DEPENDS ${PROJECT_LUA_SCRIPTS}
        )

add_dependencies(lua_scripts lua::sockets)

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


