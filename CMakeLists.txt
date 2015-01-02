cmake_minimum_required(VERSION 2.8.10 FATAL_ERROR)

##################################################

if(NOT SH_NAME_PROJECT)
	message(FATAL_ERROR "A project name was not specified! (-DSH_NAME_PROJECT=)")
endif()

project(${SH_NAME_PROJECT} CXX)

##################################################

set(MY_CMAKE_DIR "${CMAKE_SOURCE_DIR}/cmake/")
set(CMAKE_MODULE_PATH "${MY_CMAKE_DIR}/modules/")

include("${MY_CMAKE_DIR}/settings.cmake")
include("${MY_CMAKE_DIR}/options.cmake")
include("${MY_CMAKE_DIR}/cpp.cmake")
include("${MY_CMAKE_DIR}/cpack.cmake")

##################################################

add_subdirectory(src/)

if(NOT DOC_DISABLED)
	add_subdirectory(doc/)
endif()

if(MYPROJECT_TESTS_ENABLED)
	add_subdirectory(test/)
endif()
