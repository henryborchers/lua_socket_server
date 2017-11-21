if (NOT Protobuf_FOUND)
    message(SEND_ERROR "Protocal Buffers not found")
else ()
    protobuf_generate_cpp(
            PACKETS_PROTO_SRCS
            PACKETS_PROTO_HDRS
            ${CMAKE_CURRENT_SOURCE_DIR}/../../common/packet.proto
    )
    add_library(packets
            packets.cpp
            packets.h
            ${PACKETS_PROTO_SRCS}
            ${PACKETS_PROTO_HDRS}
            )
    target_link_libraries(packets PUBLIC protobuf::libprotobuf)
    target_include_directories(packets PUBLIC
            ${CMAKE_CURRENT_SOURCE_DIR}
            ${CMAKE_CURRENT_BINARY_DIR}
            )
endif ()

