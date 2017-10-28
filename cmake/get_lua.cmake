if (PYTHONINTERP_FOUND)
    add_library(lua::lib STATIC IMPORTED)
    add_executable(lua::luarocks IMPORTED)

    add_custom_target(LuaRocks_hererocks
            DEPENDS ${CMAKE_BINARY_DIR}/lua/bin/luarocks
            )
    add_custom_command(
            OUTPUT ${CMAKE_BINARY_DIR}/lua/bin/luarocks
#            TARGET LuaRocks_hererocks
            COMMAND ${PYTHON_EXECUTABLE}
            ARGS -m hererocks ${CMAKE_BINARY_DIR}/lua --lua 5.3 --patch --luarocks 2.4.3
            COMMENT "Adding lua and luarocks"
    )
    if(WIN32)
        set_target_properties(lua::luarocks PROPERTIES
                IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/lua/bin/luarocks.bat
                )
    else()
        set_target_properties(lua::luarocks PROPERTIES
            IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/lua/bin/luarocks
            )
    endif()
    set_target_properties(lua::lib PROPERTIES
            IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/lua/lib/${CMAKE_STATIC_LIBRARY_PREFIX}lua53${CMAKE_STATIC_LIBRARY_SUFFIX}
            INTERFACE_INCLUDE_DIRECTORIES ${CMAKE_BINARY_DIR}/lua/include
            )
    add_dependencies(lua::luarocks LuaRocks_hererocks)
    set(LUA_VERSION_STRING "5.3")
endif ()