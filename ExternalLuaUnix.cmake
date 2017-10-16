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
        # URL https://www.lua.org/ftp/lua-5.3.4.tar.gz
#        CONFIGURE_COMMAND ""
        CMAKE_ARGS -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DLUA_COMPAT_5_1=OFF -DLUA_COMPAT_5_2=OFF
#        BUILD_COMMAND make ${lua_build_arch}
#        INSTALL_COMMAND make local
#        BUILD_IN_SOURCE 1
        )
ExternalProject_Get_Property(LuaProject SOURCE_DIR)
ExternalProject_Get_Property(LuaProject INSTALL_DIR)

add_library(Lua::lib STATIC IMPORTED)
set_target_properties(Lua::lib PROPERTIES
        IMPORTED_LOCATION ${INSTALL_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}lua${CMAKE_STATIC_LIBRARY_SUFFIX}
#        IMPORTED_LOCATION ${SOURCE_DIR}/install/lib/${CMAKE_STATIC_LIBRARY_PREFIX}lua${CMAKE_STATIC_LIBRARY_SUFFIX}
        INCLUDE_DIRECTORIES ${INSTALL_DIR}/include
#        INCLUDE_DIRECTORIES ${SOURCE_DIR}/install/include
        FOLDER ${INSTALL_DIR}
        )
set(LUA_VERSION_STRING 5.3)
add_dependencies(Lua::lib LuaProject)

add_executable(Lua::lua IMPORTED)
set_target_properties(Lua::lua PROPERTIES
        IMPORTED_LOCATION ${INSTALL_DIR}/bin/lua${CMAKE_EXECUTABLE_SUFFIX}
#        IMPORTED_LOCATION ${SOURCE_DIR}/install/bin/lua${CMAKE_EXECUTABLE_SUFFIX}
        )