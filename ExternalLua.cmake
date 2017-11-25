include(ExternalProject)
ExternalProject_Add(LuaSource
        URL https://www.lua.org/ftp/lua-5.3.4.tar.gz
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND ""
        BUILD_IN_SOURCE 1
        )
ExternalProject_Get_Property(LuaSource SOURCE_DIR)
set(LuaSourceDir ${SOURCE_DIR}/src)
set(lua_lib_source ${LuaSourceDir}/lapi.c
        ${LuaSourceDir}/lauxlib.c
        ${LuaSourceDir}/lbaselib.c
        ${LuaSourceDir}/lbitlib.c
        ${LuaSourceDir}/lcode.c
        ${LuaSourceDir}/lcorolib.c
        ${LuaSourceDir}/lctype.c
        ${LuaSourceDir}/ldblib.c
        ${LuaSourceDir}/ldebug.c
        ${LuaSourceDir}/ldo.c
        ${LuaSourceDir}/ldump.c
        ${LuaSourceDir}/lfunc.c
        ${LuaSourceDir}/lgc.c
        ${LuaSourceDir}/linit.c
        ${LuaSourceDir}/liolib.c
        ${LuaSourceDir}/llex.c
        ${LuaSourceDir}/lmathlib.c
        ${LuaSourceDir}/lmem.c
        ${LuaSourceDir}/loadlib.c
        ${LuaSourceDir}/lobject.c
        ${LuaSourceDir}/lopcodes.c
        ${LuaSourceDir}/loslib.c
        ${LuaSourceDir}/lparser.c
        ${LuaSourceDir}/lstate.c
        ${LuaSourceDir}/lstring.c
        ${LuaSourceDir}/lstrlib.c
        ${LuaSourceDir}/ltable.c
        ${LuaSourceDir}/ltablib.c
        ${LuaSourceDir}/ltm.c
        ${LuaSourceDir}/lundump.c
        ${LuaSourceDir}/lutf8lib.c
        ${LuaSourceDir}/lvm.c
        ${LuaSourceDir}/lzio.c
        )
add_custom_command(OUTPUT ${lua_lib_source} ${LuaSourceDir}/lua.c ${LuaSourceDir}/luac.c
        DEPENDS LuaSource COMMAND ""
        )

add_library(LuaLib STATIC
        ${lua_lib_source}
        )
set_target_properties(LuaLib PROPERTIES
        OUTPUT_NAME lua)
add_executable(lua ${LuaSourceDir}/lua.c)
target_link_libraries(lua PRIVATE LuaLib)
add_executable(luac ${LuaSourceDir}/luac.c)
target_link_libraries(luac PRIVATE LuaLib)
