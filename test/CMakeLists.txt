message(STATUS "CMAKE: Starting subdir 'test' cmake")

message(STATUS "CMAKE: Enable testing")
enable_testing()

# gtest definition
message(STATUS "CMAKE: Including ExternalProject")
include(ExternalProject)

ExternalProject_Add(
	gtest
	SVN_REPOSITORY http://googletest.googlecode.com/svn/tags/release-1.7.0
	TIMEOUT 10
	# Disable install step
	INSTALL_COMMAND ""
	# Wrap download, configure and build steps in a script to log output
	LOG_DOWNLOAD ON
	LOG_CONFIGURE ON
	LOG_BUILD ON
	PREFIX "gtest"
)

ExternalProject_Get_Property(gtest source_dir)
ExternalProject_Get_Property(gtest binary_dir)

# tests definition
set(TARGET MyProject)
set(GTEST_TARGET ${TARGET}_GTest)

# Getting the test files
file(GLOB_RECURSE TESTS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

# Getting the project source code
# set(IDKMAYBE "")
# message(STATUS ${CMAKE_SOURCE_DIR})
# get_directory_property(IDKMAYBE DIRECTORY ${CMAKE_SOURCE_DIR}/src DEFINITION MySourcesNoMain)
# message(STATUS "WOLOLOLOLO")
# message(STATUS ${IDKMAYBE})

message(STATUS "CMAKE: Adding gtest executable")
add_executable(${GTEST_TARGET} ${TESTS_FILES})
target_link_libraries(${GTEST_TARGET} ${MYPROJECT_LIB})


# message(STATUS "CMAKE: oooooooooooooooooooooo")
# message(STATUS ${TESTS_FILES})
# message(STATUS "CMAKE: oooooooooooooooooooooo")

include_directories(
	${source_dir}/include
	${PROJECT_SOURCE_DIR}/src # Used to be '/include', but is now '/src' due to remodeling of the project structure
)

add_dependencies(${GTEST_TARGET} gtest)

target_link_libraries(
	${GTEST_TARGET}
	# ${TARGET} # No longer link -lMyProject as it is an executable now, not a library
# TODO OP should work but with something around ENABLE_EXPORTS
#  gtest gtest_main
	${binary_dir}/${CMAKE_STATIC_LIBRARY_PREFIX}gtest${CMAKE_STATIC_LIBRARY_SUFFIX}
	${binary_dir}/${CMAKE_STATIC_LIBRARY_PREFIX}gtest_main${CMAKE_STATIC_LIBRARY_SUFFIX}
)

if(CMAKE_COMPILER_IS_GNUC OR CMAKE_COMPILER_IS_GNUCXX)
	target_link_libraries(${GTEST_TARGET} pthread)
endif()

# TODO use offline gtest (https://github.com/dmonopoly/gtest-cmake-example)
message(STATUS "CMAKE: Finish subdir 'test' cmake")
