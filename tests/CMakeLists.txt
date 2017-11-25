if (LuaServer_include-tests)
    add_library(Catch INTERFACE)
    target_include_directories(Catch INTERFACE Catch2/single_include/)

    add_executable(protocal_test
            tests-main.cpp
            protocal_test.cpp
            )
#    target_link_libraries(protocal_test PRIVATE packets)
    set_target_properties(protocal_test PROPERTIES
            CXX_STANDARD 14
            )
    add_test(
            NAME packets
            COMMAND protocal_test
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    )

    target_link_libraries(protocal_test PRIVATE Catch packets_test)

    add_custom_target(lua_tests
            ALL
            COMMENT "Adding/updating Lua test Scripts"
            )
    add_dependencies(lua_tests busted::busted)

    file(GLOB LUA_TEST_FILES
            RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
            *_spec.lua)

    foreach(_lua_test ${LUA_TEST_FILES})
        message(STATUS "Adding ${_lua_test} to ctest")
        add_test(NAME luaTest_${_lua_test}
                COMMAND busted::busted ${CMAKE_CURRENT_SOURCE_DIR}/${_lua_test}
                --directory=${CMAKE_BINARY_DIR}/server/
                --config-file=${CMAKE_SOURCE_DIR}/tests/.busted
                --helper=${CMAKE_BINARY_DIR}/server/share/myserver/set_paths.lua
                )
    endforeach()
endif ()