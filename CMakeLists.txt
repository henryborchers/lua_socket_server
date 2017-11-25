cmake_minimum_required(VERSION 3.8)
project(visserver VERSION 0.0.1)

find_package(PythonInterp 3)
find_package(Protobuf REQUIRED)

option(Lua_UseExternalLuaRocks "download and build an copy of Lua Rocks" ON)
option(LuaServer_include-tests "Include tests" ON)
option(python_client "build python client" ON)

if (LuaServer_include-tests)
    enable_testing()
endif ()

#include(${PROJECT_SOURCE_DIR}/cmake/ExternalLuaUnix.cmake)
#include(${PROJECT_SOURCE_DIR}/cmake/LuaRocks.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/get_lua.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/get_lua_deps.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/lua_targets.cmake)
add_subdirectory(source)
add_subdirectory(tests)
