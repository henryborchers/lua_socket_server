cmake_minimum_required(VERSION 3.8)
include(ExternalLuaUnix.cmake)
include(ExternalLuaRocksUnix.cmake)
include(get_lua_deps.cmake)
add_executable(hello hello.cpp)
target_link_libraries(hello PRIVATE Lua::lib)
add_dependencies(hello lua_deps)
add_custom_target(runTests
        COMMENT "Running lua tests"
        COMMAND busted::busted
        ARGS tests/test_commands.lua --helper=set_paths
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        DEPENDS busted::busted)