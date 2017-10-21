cmake_minimum_required(VERSION 3.8)
project(visserver)

option(Lua_UseExternalLuaRocks "download and build an copy of Lua Rocks" ON)
option(LuaServer_include-tests "Include tests" ON)

if (LuaServer_include-tests)
    enable_testing()
endif ()

include(cmake/ExternalLuaUnix.cmake)
include(cmake/LuaRocks.cmake)
include(cmake/get_lua_deps.cmake)
include(cmake/lua_targets.cmake)

add_subdirectory(source)
add_subdirectory(tests)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/source/ DESTINATION share/myserver)
install(FILES ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua DESTINATION share/myserver)
