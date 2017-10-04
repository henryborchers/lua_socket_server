include(ExternalProject)
if (APPLE)
    set(lua_build_arch macosx)
elseif (MINGW)
    set(lua_build_arch mingw)
elseif (UNIX AND NOT APPLE) # Linux
    set(lua_build_arch linux)

else ()
    MESSAGE(FATAL "Unable to build Lua with current configuration")
endif ()
ExternalProject_Add(LuaProject
        URL https://github.com/LuaDist/lua/archive/5.3.2.tar.gz
#        URL https://www.lua.org/ftp/lua-5.3.4.tar.gz
        CONFIGURE_COMMAND ""
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR} -DBUILD_SHARED_LIB=NO
#        BUILD_COMMAND ""
#        BUILD_COMMAND make ${lua_build_arch}
#        INSTALL_COMMAND make local
#        INSTALL_COMMAND ""
#        BUILD_IN_SOURCE 1
        )
ExternalProject_Get_Property(LuaProject SOURCE_DIR)

add_library(Lua::lib STATIC IMPORTED)
set_target_properties(Lua::lib PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}lua${CMAKE_STATIC_LIBRARY_SUFFIX}
        INCLUDE_DIRECTORIES ${CMAKE_BINARY_DIR}/install/include
        FOLDER ${CMAKE_BINARY_DIR}
        )
add_dependencies(Lua::lib LuaProject)

add_executable(Lua::lua IMPORTED)
set_target_properties(Lua::lua PROPERTIES
        IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/bin/lua${CMAKE_EXECUTABLE_SUFFIX}
        )