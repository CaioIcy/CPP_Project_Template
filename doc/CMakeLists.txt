message("*** Starting subdir 'doc' cmake")

find_package(Doxygen)

if(DOXYGEN_FOUND)
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY IMMEDIATE)

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

message("*** Finish subdir 'doc' cmake")
