if (PYTHONINTERP_FOUND)
    add_custom_target(visclient)
    add_custom_command(TARGET visclient
            COMMAND ${PYTHON_EXECUTABLE} setup.py build -b ${CMAKE_BINARY_DIR}/client/
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            COMMENT "Building visclient")
endif ()