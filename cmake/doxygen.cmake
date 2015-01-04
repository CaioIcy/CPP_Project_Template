find_package(Doxygen)

if(DOXYGEN_FOUND)
	configure_file(${MY_CMAKE_INPUT}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)

	add_custom_target(
		doc ALL ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Generating project documentation with Doxygen" VERBATIM
	)

	# Uncomment if you want to pack the Doxygen documentation
	# install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/html
	# 	DESTINATION doc
	# )

else(DOXYGEN_FOUND)
	message(FATAL_ERROR "Doxygen was not found.")
endif(DOXYGEN_FOUND)
