add_executable(startserver hello.cpp)
install(TARGETS startserver DESTINATION bin)
target_link_libraries(startserver PRIVATE Lua::lib)
add_dependencies(startserver lua_scripts)