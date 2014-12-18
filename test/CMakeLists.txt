message("*** Starting subdir 'test' cmake")

message("*** Enable testing")
enable_testing()

message("*** Including ExternalProject")
include(ExternalProject)

# Downloads gtest 1.7.0 with SVN
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
set(GtestTarget ${MyProjectName}_GTest)

# Getting the test files
file(GLOB_RECURSE TESTS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

message("*** Adding gtest executable")
add_executable(${GtestTarget} ${TESTS_FILES})
target_link_libraries(${GtestTarget} )

include_directories(
	${source_dir}/include
	${PROJECT_SOURCE_DIR}/src # Used to be '/include', but is now '/src' due to remodeling of the project structure
)

add_dependencies(${GtestTarget} gtest)

target_link_libraries(${GtestTarget}
	${MyProjectLib}
	${binary_dir}/${CMAKE_STATIC_LIBRARY_PREFIX}gtest${CMAKE_STATIC_LIBRARY_SUFFIX}
	${binary_dir}/${CMAKE_STATIC_LIBRARY_PREFIX}gtest_main${CMAKE_STATIC_LIBRARY_SUFFIX}
)

if(CMAKE_COMPILER_IS_GNUC OR CMAKE_COMPILER_IS_GNUCXX)
	target_link_libraries(${GtestTarget} pthread)
endif()

# TODO use offline gtest (https://github.com/dmonopoly/gtest-cmake-example)
message("*** Finish subdir 'test' cmake")
