if (python_client)
    if (PYTHONINTERP_FOUND)
        if (NOT Protobuf_FOUND)
            message(SEND_ERROR "Protocal Buffers not found")
        else ()
            protobuf_generate_python(PACKETS_PROTO_PY ${CMAKE_CURRENT_SOURCE_DIR}/../common/packet.proto)
        endif ()

        get_filename_component(VENV_PATH ${CMAKE_BINARY_DIR}/client/venv ABSOLUTE)
        set(VENV_PYTHON ${VENV_PATH}/bin/python${CMAKE_EXECUTABLE_SUFFIX})
        set(VENV_SITE_PACKAGES ${VENV_PATH}/lib/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}/site-packages)

        add_custom_target(visclient
                ALL
                DEPENDS
                    ${VENV_PYTHON}
                    ${PACKETS_PROTO_PY}
                )
        add_custom_command(
                OUTPUT ${VENV_PYTHON}
                COMMAND ${PYTHON_EXECUTABLE} -m venv ${CMAKE_BINARY_DIR}/client/venv
                COMMENT "Generating Python virtual environment"
        )
        add_custom_command(TARGET visclient
                COMMAND ${VENV_PYTHON} -m pip install -r ${CMAKE_CURRENT_SOURCE_DIR}/requirements.txt
                COMMENT "Installing requirements to Python virtual enviroment"
                DEPENDS ${VENV_PYTHON}
                )

        file(WRITE ${VENV_SITE_PACKAGES}/visclient.pth "# This is a helper file to aid in development only. Do not install this file.\n")
        file(APPEND ${VENV_SITE_PACKAGES}/visclient.pth "${CMAKE_SOURCE_DIR}/source/client\n")
        file(APPEND ${VENV_SITE_PACKAGES}/visclient.pth "import visclient; visclient.__path__.append('${CMAKE_CURRENT_BINARY_DIR}')")

        if (WIN32)
            configure_file(${CMAKE_CURRENT_SOURCE_DIR}/runclient.bat.in ${CMAKE_BINARY_DIR}/client/runclient.bat)
        else ()
            configure_file(${CMAKE_CURRENT_SOURCE_DIR}/runclient.sh.in ${CMAKE_BINARY_DIR}/client/runclient.sh)
        endif ()
    endif ()
endif ()