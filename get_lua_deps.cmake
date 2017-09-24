add_custom_target(lua_deps
        DEPENDS luarocks::luarocks
        COMMENT "Getting deps from lua rocks"
        )

add_custom_command(
        POST_BUILD
        TARGET lua_deps
        COMMAND luarocks::luarocks
        ARGS install --tree ${CMAKE_BINARY_DIR}/ luasocket
        COMMENT "Adding luasocket"
        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/luasocket
)

add_custom_command(
        POST_BUILD
        TARGET lua_deps
        COMMAND luarocks::luarocks
        ARGS install --tree ${CMAKE_BINARY_DIR} busted
        COMMENT "Adding busted"
        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/busted
)
add_executable(busted::busted IMPORTED)
set_target_properties(busted::busted PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/bin/busted${CMAKE_EXECUTABLE_SUFFIX}
        )
add_dependencies(busted::busted lua_deps)
install(DIRECTORY ${CMAKE_BINARY_DIR}/lib/ DESTINATION lib)
install(DIRECTORY ${CMAKE_BINARY_DIR}/bin/ DESTINATION bin)
install(DIRECTORY ${CMAKE_BINARY_DIR}/share/ DESTINATION share)