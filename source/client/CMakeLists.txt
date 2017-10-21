if (python_client)
    if (PYTHONINTERP_FOUND)
        add_custom_target(visclient)
        add_custom_command(TARGET visclient
                COMMAND ${PYTHON_EXECUTABLE} setup.py build -b ${CMAKE_BINARY_DIR}/client/
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                COMMENT "Building visclient")
        configure_file(${CMAKE_CURRENT_SOURCE_DIR}/runclient.sh.in ${CMAKE_BINARY_DIR}/client/runclient.sh)
    endif ()
endif ()