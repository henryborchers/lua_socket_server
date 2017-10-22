add_executable(busted::busted IMPORTED)

if (Lua_UseExternalLuaRocks)
    set(SERVER_BUILD_SERVER ${CMAKE_BINARY_DIR}/server/)
    set(UTILS_BUILT ${CMAKE_BINARY_DIR}/utils/)
    add_custom_target(lualuasockets
            DEPENDS lua::luarocks
            DEPENDS ${SERVER_BUILD_SERVER}/share/lua/${LUA_VERSION_STRING}/socket.lua
            COMMENT "Adding Luasocket"
            )


    add_custom_command(
            OUTPUT ${SERVER_BUILD_SERVER}/share/lua/${LUA_VERSION_STRING}/socket.lua
            COMMAND lua::luarocks
            ARGS install --tree ${SERVER_BUILD_SERVER}/ luasocket CC=${CMAKE_C_COMPILER} LD=${CMAKE_C_COMPILER}
            COMMENT "Adding luasocket to ${SERVER_BUILD_SERVER}/"
    )


    add_dependencies(lualuasockets lua::luarocks)
    add_library(lua::sockets SHARED IMPORTED)
    add_dependencies(lua::sockets lualuasockets)
    add_custom_target(luaBusted
            DEPENDS lua::luarocks
            DEPENDS ${UTILS_BUILT}/bin/busted
            COMMENT "Adding Luasocks"
            )


    add_custom_command(
            OUTPUT ${UTILS_BUILT}/bin/busted
            COMMAND lua::luarocks
            ARGS install --tree ${UTILS_BUILT}/ busted CC=${CMAKE_C_COMPILER} LD=${CMAKE_C_COMPILER}
            COMMENT "Adding Busted to ${UTILS_BUILT}/"
    )
    add_dependencies(luaBusted lua::luarocks lua::sockets)
    if (Win32)
        set_target_properties(busted::busted PROPERTIES
                IMPORTED_LOCATION ${UTILS_BUILT}/bin/busted.bat
                )
    else ()
        set_target_properties(busted::busted PROPERTIES
                IMPORTED_LOCATION ${UTILS_BUILT}/bin/busted
                )
    endif ()

    add_dependencies(busted::busted luaBusted)
else ()
    find_program(busted busted)
    set_target_properties(busted::busted PROPERTIES
            IMPORTED_LOCATION busted
            )
endif ()

install(DIRECTORY ${SERVER_BUILD_SERVER}/lib/ DESTINATION lib)
install(DIRECTORY ${SERVER_BUILD_SERVER}/bin/ DESTINATION bin)
install(DIRECTORY ${SERVER_BUILD_SERVER}/share/ DESTINATION share)