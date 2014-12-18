cmake_minimum_required(VERSION 2.8.7 FATAL_ERROR)

project(MyProject)

message(STATUS "CMAKE: Starting root cmake")

# Setting the build number
if($ENV{BUILD_NUMBER})
	set(BUILD_NUMBER $ENV{BUILD_NUMBER})
else()
	set(BUILD_NUMBER 0)
endif()

# Setting some project information
set(MYPROJECT_NAME "MyProject")
set(MYPROJECT_VERSION "0.3.0-${BUILD_NUMBER}")
set(MYPROJECT_BRIEF "${MYPROJECT_NAME} is a toy project to illustrate a full featured C++ CMake project.")
set(MYPROJECT_LIB ${MYPROJECT_NAME}-lib)

# Options
option(MYPROJECT_TESTS_ENABLED "Enable tests build" ON)

# Debug build info
set(DEBUG_FLAGS "-O0 -g -W -Wall -pedantic -ansi -std=c++11 -Wextra -Wshadow -Wno-long-long")
set(CMAKE_CXX_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_C_FLAGS_DEBUG ${DEBUG_FLAGS})

# Release build info
set(RELEASE_FLAGS "-O3 -std=c++11")
set(CMAKE_CXX_FLAGS ${RELEASE_FLAGS})
set(CMAKE_C_FLAGS ${RELEASE_FLAGS})

# TODO OP check how this works on multiple configurations generators
# available configurations in multiple configurations enabled generators
set(CMAKE_CONFIGURATION_TYPES Debug Release)
#message("CMAKE_CFG_INTDIR = ${CMAKE_CFG_INTDIR}")

message(STATUS "CMAKE: Adding src subdirectory")
add_subdirectory(src)

# used by doc home and in packaging
set(README_FILE ${PROJECT_SOURCE_DIR}/README.md)

# documentation
if(NOT DOC_DISABLED)
	message(STATUS "CMAKE: Adding doc subdirectory")
	add_subdirectory(doc)
endif()

# Licensing and stuff like that
set(LICENSE_FILE ${PROJECT_SOURCE_DIR}/LICENSE)
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
set(CPACK_PACKAGE_VENDOR "MyVendor")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${MYPROJECT_NAME} - ${MYPROJECT_BRIEF}")
set(CPACK_PACKAGE_VERSION ${MYPROJECT_VERSION})
set(CPACK_PACKAGE_INSTALL_DIRECTORY "TODO")

# must be executed after CPACK properties definition
message(STATUS "CMAKE: Including CPack")
include(CPack)

# TODO sonar requirements

if(MYPROJECT_TESTS_ENABLED) # ON
	message(STATUS "CMAKE: Adding test subdirectory")
	add_subdirectory(test)
endif()

message(STATUS "CMAKE: Finish root cmake")
