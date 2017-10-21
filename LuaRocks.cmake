include(ExternalProject)
add_executable(lua::luarocks IMPORTED)
get_target_property(lua_root Lua::lib FOLDER)
if (Lua_UseExternalLuaRocks)

    if (UNIX)
        set(LUA_CONFIG_ARGS <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --with-lua=${lua_root})
        set(LUA_BUILD_ARGS make build)
        set(LUA_INSTALL_ARGS make install)
        ExternalProject_Add(LuaRocksProject
                #            GIT_REPOSITORY https://github.com/luarocks/luarocks.git
                URL https://github.com/luarocks/luarocks/archive/2.4.3.zip
                #            URL http://luarocks.github.io/luarocks/releases/luarocks-2.4.3.tar.gz
                CONFIGURE_COMMAND   ${LUA_CONFIG_ARGS}
                BUILD_COMMAND       ${LUA_BUILD_ARGS}
                INSTALL_COMMAND     ${LUA_INSTALL_ARGS}
                BUILD_IN_SOURCE 1
                DEPENDS Lua::lib
                )
    else ()
#        TODO:  in cfg.lua change defaults.variables.CC = "mingw32-gcc" to "C:/tools/msys64/mingw64/bin/gcc.exe" and defaults.variables.LD = "mingw32-gcc" to "C:/tools/msys64/mingw64/bin/gcc.exe"
        set(LUA_INSTALL_ARGS <SOURCE_DIR>/install.bat /MW /P <INSTALL_DIR>/installed /INC ${lua_root}/include /LIB ${lua_root}/lib /BIN ${lua_root}/bin /NOADMIN /NOREG /Q /F /FORCECONFIG
#                /SELFCONTAINED
                )
        ExternalProject_Add(LuaRocksProject
                #            GIT_REPOSITORY https://github.com/luarocks/luarocks.git
                URL https://github.com/luarocks/luarocks/archive/2.4.3.zip
                #            URL http://luarocks.github.io/luarocks/releases/luarocks-2.4.3.tar.gz
                CONFIGURE_COMMAND   ${LUA_INSTALL_ARGS}
                BUILD_COMMAND       ""
                INSTALL_COMMAND     ""
                BUILD_IN_SOURCE 1
                DEPENDS Lua::lib
                )
#        LIST(APPEND LUA_BUILD_ARGS)
#        list(APPEND LUA_CONFIG_ARGS)

#        find_program(SH sh)
#        if (NOT SH)
#            MESSAGE(SEND_ERROR "Required program sh not found")
#        endif ()
#        set(LUA_CONFIG_ARGS ${SH} -l -c "<SOURCE_DIR>/configure --help")

#        set(LUA_CONFIG_ARGS ${SH} -l -c " echo <SOURCE_DIR> && ./configure --prefix=<INSTALL_DIR> --with-lua=${lua_root}")
#        set(LUA_CONFIG_ARGS ${SH} -l -c "<SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --with-lua=${lua_root} --lua-suffix=${CMAKE_EXECUTABLE_SUFFIX} --lua-version=5.3 --with-lua-bin=${lua_root}/bin" --force-config)
    endif ()
#    message(WARNING "LUA_CONFIG_ARGS = ${LUA_CONFIG_ARGS}")
#    ExternalProject_Add(LuaRocksProject
##            GIT_REPOSITORY https://github.com/luarocks/luarocks.git
#            URL https://github.com/luarocks/luarocks/archive/2.4.3.zip
##            URL http://luarocks.github.io/luarocks/releases/luarocks-2.4.3.tar.gz
#            CONFIGURE_COMMAND   ${LUA_CONFIG_ARGS}
#            BUILD_COMMAND       ${LUA_BUILD_ARGS}
#            INSTALL_COMMAND     ${LUA_INSTALL_ARGS}
#            BUILD_IN_SOURCE 1
#            DEPENDS Lua::lib
#            )
    ExternalProject_Get_Property(LuaRocksProject INSTALL_DIR)

    set_target_properties(lua::luarocks PROPERTIES
            IMPORTED_LOCATION ${INSTALL_DIR}/installed/luarocks.bat
            )
    add_dependencies(lua::luarocks LuaRocksProject)
else ()
    find_program(luarocks luarocks REQUIRED)
    set_target_properties(lua::luarocks PROPERTIES
            IMPORTED_LOCATION ${luarocks}
            )
endif ()

