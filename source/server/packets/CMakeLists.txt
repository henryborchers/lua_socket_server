if (NOT Protobuf_FOUND)
    message(SEND_ERROR "Protocal Buffers not found")
elseif (NOT LUA_FOUND)
    message(SEND_ERROR "Lua not found")
else ()
    get_target_property(lua_include_dirs lua::lib INTERFACE_INCLUDE_DIRECTORIES)

    protobuf_generate_cpp(
            PACKETS_PROTO_SRCS
            PACKETS_PROTO_HDRS
            ${CMAKE_CURRENT_SOURCE_DIR}/../../common/packet.proto
    )

    ##################################################
    #        Create a module that LUA can import
    ##################################################
    add_library(packets MODULE
            packets.cpp
            packets.h
            ${PACKETS_PROTO_SRCS}
            ${PACKETS_PROTO_HDRS}
            )
    target_compile_features(packets PRIVATE cxx_range_for) # adds the correct compiler flags for Range-based for loop

    target_link_libraries(packets
            PUBLIC protobuf::libprotobuf
            )
    target_compile_definitions(packets PRIVATE LUA_MODULE)
    target_include_directories(packets PRIVATE ${lua_include_dirs})
    target_include_directories(packets PUBLIC
            ${CMAKE_CURRENT_SOURCE_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}
            )
    set_target_properties(packets PROPERTIES
            PREFIX ""
            LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/server/lib/lua/5.3/myserver/
            )
    if (APPLE)
        target_link_libraries(packets PRIVATE "-undefined dynamic_lookup")
    endif ()


    ##################################################
    #        Create an exact copy that can be tested
    ##################################################
    add_library(packets_test
            packets.cpp
            packets.h
            ${PACKETS_PROTO_SRCS}
            ${PACKETS_PROTO_HDRS}
            )
    target_compile_features(packets_test PRIVATE cxx_range_for) # adds the correct compiler flags for Range-based for loop

    target_link_libraries(packets_test
            PUBLIC protobuf::libprotobuf
            )

    target_include_directories(packets_test PUBLIC ${lua_include_dirs})

    target_include_directories(packets_test PUBLIC
            ${CMAKE_CURRENT_SOURCE_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}
            )

endif ()

