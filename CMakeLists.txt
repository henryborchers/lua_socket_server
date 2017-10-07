cmake_minimum_required(VERSION 3.8)
option(Lua_UseExternalLuaRocks  "download and build an copy of Lua Rocks"    OFF)

include(ExternalLuaUnix.cmake)
include(ExternalLuaRocksUnix.cmake)
include(get_lua_deps.cmake)
include(lua_targets.cmake)
enable_testing()

add_executable(hello hello.cpp)
install(TARGETS hello DESTINATION bin)
target_link_libraries(hello PRIVATE Lua::lib)
add_dependencies(hello lualuasockets)


install(DIRECTORY ${CMAKE_SOURCE_DIR}/source/ DESTINATION share/myserver)
configure_file(set_paths.lua.in ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua)
install(FILES ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua DESTINATION share/myserver)
