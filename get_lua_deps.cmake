add_custom_target(lualuasockets
        DEPENDS lua::luarocks
        COMMENT "Adding Luasocks"
        )


add_custom_command(
        POST_BUILD
        TARGET lualuasockets
        COMMAND lua::luarocks
        ARGS install --tree ${CMAKE_BINARY_DIR}/ luasocket
        COMMENT "Adding luasocket"
        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/luasocket
)
add_dependencies(lualuasockets lua::luarocks )
add_custom_target(luaBusted
        DEPENDS lua::luarocks
        COMMENT "Adding Luasocks"
        )
add_custom_command(
#        POST_BUILD
        TARGET luaBusted
        COMMAND lua::luarocks
        ARGS install --tree ${CMAKE_BINARY_DIR} busted
        COMMENT "Adding busted"
        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/busted
)
add_executable(busted::busted IMPORTED)
add_dependencies(luaBusted lua::luarocks)
set_target_properties(busted::busted PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/bin/busted${CMAKE_EXECUTABLE_SUFFIX}
        )
add_dependencies(busted::busted luaBusted)
install(DIRECTORY ${CMAKE_BINARY_DIR}/lib/ DESTINATION lib)
install(DIRECTORY ${CMAKE_BINARY_DIR}/bin/ DESTINATION bin)
install(DIRECTORY ${CMAKE_BINARY_DIR}/share/ DESTINATION share)