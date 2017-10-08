include(ExternalProject)
add_executable(lua::luarocks IMPORTED)
get_target_property(lua_root Lua::lib FOLDER)
if (Lua_UseExternalLuaRocks)
    ExternalProject_Add(LuaRocksProject
            URL http://luarocks.github.io/luarocks/releases/luarocks-2.4.3.tar.gz
            CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --with-lua=${lua_root}
            BUILD_COMMAND make build
            INSTALL_COMMAND make install
            BUILD_IN_SOURCE 1
            DEPENDS Lua::lib
            )
    ExternalProject_Get_Property(LuaRocksProject INSTALL_DIR)

    set_target_properties(lua::luarocks PROPERTIES
            IMPORTED_LOCATION ${INSTALL_DIR}/bin/luarocks${CMAKE_EXECUTABLE_SUFFIX}
            )
    add_dependencies(lua::luarocks LuaRocksProject)
else ()
    find_program(luarocks luarocks REQUIRED)
    set_target_properties(lua::luarocks PROPERTIES
            IMPORTED_LOCATION ${luarocks}
            )
endif ()

