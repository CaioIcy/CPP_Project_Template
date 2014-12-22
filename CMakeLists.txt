cmake_minimum_required(VERSION 2.8.7 FATAL_ERROR)

project(MyProject)

message("*** Starting root cmake")

# Setting the build number
if($ENV{TRAVIS_BUILD_NUMBER})
	set(BUILD_NUMBER $ENV{TRAVIS_BUILD_NUMBER}) # Travis-CI
else()
	set(BUILD_NUMBER "?")
endif()

# Setting some project information
set(MyProjectName "My_Project") # Try not to put spaces in this name (and make sure its the same as build.sh)
set(MyProjectVersion "v${BUILD_NUMBER}")
set(MyProjectBrief "${MyProjectName} is a toy project to illustrate a full featured C++ CMake project.")
set(MyProjectLib ${MyProjectName}-lib)
set(MyProjectVendor "IcyWare")

# 
set(ExternalLibsDir "externals")

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
set(ReadmeFile ${PROJECT_SOURCE_DIR}/doc/README.txt) # README file that goes into the package. NOT git's readme
set(LicenseFile ${PROJECT_SOURCE_DIR}/LICENSE) # Legal info file
set(WelcomeFile ${PROJECT_SOURCE_DIR}/doc/WELCOME.md) # Doxygen main page file

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

# # Basic CPack settings
set(CPACK_GENERATOR 					"ZIP")
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY  	0)
# set(CPACK_INSTALL_CMAKE_PROJECTS  		NOTUSED_CHANGEME)
set(CPACK_PACKAGE_DESCRIPTION_FILE  	${ReadmeFile})
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY	"${MyProjectName} - ${MyProjectBrief}")
# set(CPACK_PACKAGE_EXECUTABLES  			NOTUSED_CHANGEME)
set(CPACK_PACKAGE_FILE_NAME  			"${MyProjectName}-${CMAKE_SYSTEM_NAME}")
# set(CPACK_PACKAGE_INSTALL_DIRECTORY  	NOTUSED_CHANGEME)
# set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY  NOTUSED_CHANGEME)
set(CPACK_PACKAGE_NAME  				${MyProjectName})
set(CPACK_PACKAGE_VENDOR  				${MyProjectVendor})
# set(CPACK_PACKAGE_VERSION_MAJOR  		NOTUSED_CHANGEME)
# set(CPACK_PACKAGE_VERSION_MINOR 		NOTUSED_CHANGEME)
# set(CPACK_PACKAGE_VERSION_PATCH  		NOTUSED_CHANGEME)
# set(CPACK_PROJECT_CONFIG_FILE  			NOTUSED_CHANGEME)
# set(CPACK_SOURCE_GENERATOR  			NOTUSED_CHANGEME)
# set(CPACK_SOURCE_IGNORE_FILES  			NOTUSED_CHANGEME)
# set(CPACK_SOURCE_PACKAGE_FILE_NAME  	NOTUSED_CHANGEME)
# set(CPACK_SOURCE_STRIP_FILES  			NOTUSED_CHANGEME)
# set(CPACK_STRIP_FILES  					NOTUSED_CHANGEME)
set(CPACK_SYSTEM_NAME  					"${CMAKE_SYSTEM_NAME}_CMAKE_SYSTEM_PROCESSOR")

# # Advanced CPack settings
# set(CPACK_CMAKE_GENERATOR  				NOTUSED_CHANGEME)
set(CPACK_RESOURCE_FILE_LICENSE  		${LicenseFile})
# set(CPACK_RESOURCE_FILE_README  		NOTUSED_CHANGEME)
set(CPACK_RESOURCE_FILE_WELCOME  		${WelcomeFile})
# set(CPACK_PACKAGE_VERSION  				NOTUSED_CHANGEME)
# set(CPACK_TOPLEVEL_TAG  				NOTUSED_CHANGEME)
# set(CPACK_INSTALL_COMMANDS  			NOTUSED_CHANGEME)
# set(CPACK_INSTALL_SCRIPT  				NOTUSED_CHANGEME)
# set(CPACK_INSTALLED_DIRECTORIES  		NOTUSED_CHANGEME)
# set(CPACK_MONOLITHIC_INSTALL  			NOTUSED_CHANGEME)
# set(CPACK_PACKAGING_INSTALL_PREFIX  	NOTUSED_CHANGEME)
# set(CPACK_OUTPUT_FILE_PREFIX  			NOTUSED_CHANGEME)


# must be executed after CPACK properties definition
message("*** Including CPack")
include(CPack)

# Build test executable
if(MYPROJECT_TESTS_ENABLED) # ON
	add_subdirectory(test)
endif()

message("*** Finish root cmake")
