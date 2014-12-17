cmake_minimum_required(VERSION 2.8.7 FATAL_ERROR)
project(MyProject)

if($ENV{BUILD_NUMBER})
	set(BUILD_NUMBER $ENV{BUILD_NUMBER})
else()
	set(BUILD_NUMBER 0)
endif()

set(MYPROJECT_NAME "MyProject")
set(MYPROJECT_VERSION "0.3.0.${BUILD_NUMBER}")
set(MYPROJECT_BRIEF "${MYPROJECT_NAME} is a toy project to illustrate a full featured C++ CMake project.")

# Options. Turn on with 'cmake -Dmyvarname=ON'.
option(MYPROJECT_TESTS_ENABLED "Enable tests build" ON)

# code coverage options
set(GCOV_FLAGS "-fprofile-arcs -ftest-coverage")

set(DEBUG_FLAGS "-g -O0 -Wall")
set(RELEASE_FLAGS "-O3")

set(CMAKE_CXX_FLAGS ${RELEASE_FLAGS})
set(CMAKE_C_FLAGS ${RELEASE_FLAGS})

set(CMAKE_CXX_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_CXX_FLAGS_DEBUG ${GCOV_FLAGS})
set(CMAKE_C_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_C_FLAGS_DEBUG ${GCOV_FLAGS})
set(CMAKE_EXE_LINKER_FLAGS_DEBUG ${GCOV_FLAGS})

# TODO OP check how this works on multiple configurations generators
# available configurations in multiple configurations enabled generators
set(CMAKE_CONFIGURATION_TYPES Debug Release)
#message("CMAKE_CFG_INTDIR = ${CMAKE_CFG_INTDIR}")

add_subdirectory(src)

if(MYPROJECT_TESTS_ENABLED)
	add_subdirectory(test)
endif()

# used by doc home and in packaging
set(README_FILE ${PROJECT_SOURCE_DIR}/README.md)

# documentation
if(NOT DOC_DISABLED)
	add_subdirectory(doc)
endif()

# Licensing and stuff like that
set(LICENSE_FILE ${PROJECT_SOURCE_DIR}/LICENSE-MIT)
install(FILES
	${README_FILE}
	${LICENSE_FILE}
	DESTINATION .
)

# Packaging steps
#set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR})
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
set(CPACK_PACKAGE_DESCRIPTION_FILE ${README_FILE})
set(CPACK_RESOURCE_FILE_LICENSE ${LICENSE_FILE})
set(CPACK_GENERATOR "ZIP") #;TGZ;STGZ")
set(CPACK_COMPONENT_LIBRARIES_DISPLAY_NAME "Libraries")
set(CPACK_COMPONENT_HEADERS_DISPLAY_NAME "C++ Headers")
set(CPACK_COMPONENTS_ALL libraries headers)
set(CPACK_PACKAGE_NAME ${MYPROJECT_NAME})
set(CPACK_PACKAGE_VENDOR "Acme")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${MYPROJECT_NAME} - ${MYPROJECT_BRIEF}")
set(CPACK_PACKAGE_VERSION ${MYPROJECT_VERSION})
set(CPACK_PACKAGE_INSTALL_DIRECTORY "TODO")

# must be executed after CPACK properties definition
include(CPack)

# TODO sonar requirements
