find_package(Doxygen)
if(DOXYGEN_FOUND)
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY IMMEDIATE)
  add_custom_target(doc ALL ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "Generating API documentation with Doxygen" VERBATIM
  )
  install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html
    DESTINATION doc
  )
else(DOXYGEN_FOUND)
  message(FATAL_ERROR "Doxygen is mandatory for doc generation.")
endif(DOXYGEN_FOUND)
