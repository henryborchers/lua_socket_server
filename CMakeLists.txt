cmake_minimum_required(VERSION 3.8)
include(ExternalLuaUnix.cmake)
include(ExternalLuaRocksUnix.cmake)
add_executable(hello hello.cpp)
target_link_libraries(hello PRIVATE Lua::lib)
add_dependencies(hello lua_deps)
add_custom_target(lua_deps
        DEPENDS luarocks::luarocks
        COMMENT "Getting deps from lua rocks"
        )

add_custom_command(
        POST_BUILD
        TARGET lua_deps
        COMMAND luarocks::luarocks
        ARGS install --tree ${CMAKE_BINARY_DIR}/lua_modules luasocket
        COMMENT "Installing luasocket"
        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/luasocket
)

add_custom_command(
        POST_BUILD
        TARGET lua_deps
        COMMAND luarocks::luarocks
        ARGS install --tree ${CMAKE_BINARY_DIR}/lua_modules busted
        COMMENT "Installing busted"
        BYPRODUCTS cmake-build-debug/lua_modules/lib/luarocks/rocks/busted
)