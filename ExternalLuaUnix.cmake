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
        URL https://www.lua.org/ftp/lua-5.3.4.tar.gz
        CONFIGURE_COMMAND ""
        BUILD_COMMAND make ${lua_build_arch}
        INSTALL_COMMAND make local
        BUILD_IN_SOURCE 1
        )
ExternalProject_Get_Property(LuaProject SOURCE_DIR)
add_library(Lua::lib STATIC IMPORTED)
set_target_properties(Lua::lib PROPERTIES
        IMPORTED_LOCATION ${SOURCE_DIR}/install/lib/${CMAKE_STATIC_LIBRARY_PREFIX}lua${CMAKE_STATIC_LIBRARY_SUFFIX}
        INCLUDE_DIRECTORIES ${SOURCE_DIR}/install/include
        FOLDER ${SOURCE_DIR}/install
        )
add_dependencies(Lua::lib LuaProject)