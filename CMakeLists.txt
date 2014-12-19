cmake_minimum_required(VERSION 2.8.7 FATAL_ERROR)

project(MyProject)

message("*** Starting root cmake")

# Setting the build number
if($ENV{BUILD_NUMBER})
	set(BUILD_NUMBER $ENV{BUILD_NUMBER})
else()
	set(BUILD_NUMBER 0)
endif()

# Setting some project information
set(MyProjectName "MyProject")
set(MyProjectVersion "0.0.7-${BUILD_NUMBER}")
set(MyProjectBrief "${MyProjectName} is a toy project to illustrate a full featured C++ CMake project.")
set(MyProjectLib ${MyProjectName}-lib)

# Options (-Dvarname=ON/OFF)
option(MYPROJECT_TESTS_ENABLED "Enable tests build" ON)

##
set(GCOV_FLAGS "-fprofile-arcs -ftest-coverage -fPIC")

# Debug build info
set(DEBUG_FLAGS "-O0 -g -W -Wall -pedantic -ansi -std=c++11 -Wextra -Wshadow -Wno-long-long")
set(CMAKE_CXX_FLAGS_DEBUG ${DEBUG_FLAGS})
set(CMAKE_C_FLAGS_DEBUG ${DEBUG_FLAGS})

# Release build info
set(RELEASE_FLAGS "-O3 -std=c++11")
set(CMAKE_CXX_FLAGS ${RELEASE_FLAGS})
set(CMAKE_C_FLAGS ${RELEASE_FLAGS})

set(CMAKE_CXX_FLAGS_DEBUG ${GCOV_FLAGS})
set(CMAKE_C_FLAGS_DEBUG ${GCOV_FLAGS})
set(CMAKE_EXE_LINKER_FLAGS_DEBUG ${GCOV_FLAGS})


# TODO OP check how this works on multiple configurations generators
# available configurations in multiple configurations enabled generators
set(CMAKE_CONFIGURATION_TYPES Debug Release)
# message("CMAKE_CFG_INTDIR = ${CMAKE_CFG_INTDIR}")

# Build project libraries and executable
add_subdirectory(src)

# Used by documentation home and in packaging
set(ReadmeFile ${PROJECT_SOURCE_DIR}/README.md)
set(LicenseFile ${PROJECT_SOURCE_DIR}/LICENSE)

# Generate documentation
if(NOT DOC_DISABLED)
	add_subdirectory(doc)
endif()

# Licensing and stuff like that
install(FILES
	${ReadmeFile}
	${LicenseFile}
	DESTINATION .
)

# Packaging steps
#set(CPACK_SYSTEM_NAME ${CMAKE_SYSTEM_NAME}_${CMAKE_SYSTEM_PROCESSOR})
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
set(CPACK_PACKAGE_DESCRIPTION_FILE ${ReadmeFile})
set(CPACK_RESOURCE_FILE_LICENSE ${LicenseFile})
set(CPACK_GENERATOR "ZIP") #;TGZ;STGZ")
set(CPACK_COMPONENT_LIBRARIES_DISPLAY_NAME "Libraries")
set(CPACK_COMPONENT_HEADERS_DISPLAY_NAME "C++ Headers")
set(CPACK_COMPONENTS_ALL libraries headers)
set(CPACK_PACKAGE_NAME ${MyProjectName})
set(CPACK_PACKAGE_VENDOR "MyVendor")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "${MyProjectName} - ${MyProjectBrief}")
set(CPACK_PACKAGE_VERSION ${MyProjectVersion})
set(CPACK_PACKAGE_INSTALL_DIRECTORY "TODO")

# must be executed after CPACK properties definition
message("*** Including CPack")
include(CPack)

# Build test executable
if(MYPROJECT_TESTS_ENABLED) # ON
	add_subdirectory(test)
endif()

message("*** Finish root cmake")
