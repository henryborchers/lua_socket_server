add_executable(busted::busted IMPORTED)

if (Lua_UseExternalLuaRocks)
    add_custom_target(lualuasockets
            DEPENDS lua::luarocks
            DEPENDS ${CMAKE_BINARY_DIR}/share/lua/${LUA_VERSION_STRING}/socket.lua
            COMMENT "Adding Luasocket"
            )


    add_custom_command(
            OUTPUT ${CMAKE_BINARY_DIR}/share/lua/${LUA_VERSION_STRING}/socket.lua
            COMMAND lua::luarocks
            ARGS install --tree ${CMAKE_BINARY_DIR}/ luasocket
            COMMENT "Adding luasocket to ${CMAKE_BINARY_DIR}/"
    )


    add_dependencies(lualuasockets lua::luarocks)
    add_custom_target(luaBusted
            DEPENDS lua::luarocks
            DEPENDS ${CMAKE_BINARY_DIR}/bin/busted
            COMMENT "Adding Luasocks"
            )


    add_custom_command(
            OUTPUT ${CMAKE_BINARY_DIR}/bin/busted
            COMMAND lua::luarocks
            ARGS install --tree ${CMAKE_BINARY_DIR}/ busted
            COMMENT "Adding Busted to ${CMAKE_BINARY_DIR}/"
    )
    add_dependencies(luaBusted lua::luarocks)
    set_target_properties(busted::busted PROPERTIES
            IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/bin/busted${CMAKE_EXECUTABLE_SUFFIX}
            )
    add_dependencies(busted::busted luaBusted)
else ()
    find_program(busted busted)
    set_target_properties(busted::busted PROPERTIES
            IMPORTED_LOCATION busted
            )
endif ()
#add_custom_command(
##        POST_BUILD
#        TARGET luaBusted
#        COMMAND lua::luarocks
#        ARGS install --tree ${CMAKE_BINARY_DIR} busted
#        COMMENT "Adding busted"
#        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/busted

#)
install(DIRECTORY ${CMAKE_BINARY_DIR}/lib/ DESTINATION lib)
install(DIRECTORY ${CMAKE_BINARY_DIR}/bin/ DESTINATION bin)
install(DIRECTORY ${CMAKE_BINARY_DIR}/share/ DESTINATION share)