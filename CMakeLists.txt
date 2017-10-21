cmake_minimum_required(VERSION 3.8)
project(visserver)
#if (UNIX)
#    set(default_use_external_lua_rocks ON)
#else ()
#    set(default_use_external_lua_rocks OFF)
#endif ()
#message(WARNING "default_use_external_lua_rocks = ${default_use_external_lua_rocks}")

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


install(DIRECTORY ${CMAKE_SOURCE_DIR}/source/ DESTINATION share/myserver)
#configure_file(set_paths.lua.in ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua)
install(FILES ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua DESTINATION share/myserver)
