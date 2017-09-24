cmake_minimum_required(VERSION 3.8)
include(ExternalLuaUnix.cmake)
include(ExternalLuaRocksUnix.cmake)
include(get_lua_deps.cmake)
add_executable(hello hello.cpp)
install(TARGETS hello DESTINATION bin)
target_link_libraries(hello PRIVATE Lua::lib)
add_dependencies(hello lua_deps)
add_custom_target(runTests
        COMMENT "Running lua tests"
        COMMAND busted::busted
        ARGS tests/test_commands.lua --helper=set_paths
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        DEPENDS busted::busted)
set(main.lua share/myserver/main.lua)
set(LUA_SOURCE ${CMAKE_SOURCE_DIR}/source)
get_target_property(LUA_INTERP Lua::lua LOCATION)
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
install(DIRECTORY ${CMAKE_SOURCE_DIR}/source/ DESTINATION share/myserver)
configure_file(set_paths.lua.in ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua)
install(FILES ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua DESTINATION share/myserver)