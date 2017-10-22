add_executable(startserver hello.cpp)
set_target_properties(startserver PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/server/bin)
install(TARGETS startserver DESTINATION bin)
target_link_libraries(startserver PRIVATE Lua::lib)
add_dependencies(startserver lua_scripts)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/source/ DESTINATION share/myserver)
install(FILES ${CMAKE_BINARY_DIR}/share/myserver/set_paths.lua DESTINATION share/myserver)
