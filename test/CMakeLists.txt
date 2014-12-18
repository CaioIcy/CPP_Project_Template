message("*** Starting subdir 'test' cmake")

# Has project(gtest)
add_subdirectory(lib/gtest-1.7.0)

message("*** Enable testing")
enable_testing()

# gtest_SOURCE_DIR is available due to project(gtest)
include_directories(
	${gtest_SOURCE_DIR}/include
	${gtest_SOURCE_DIR}
	${PROJECT_SOURCE_DIR}/src # Used to be '/include', but is now '/src' due to remodeling of the project structure
)

# tests definition
set(GtestTarget ${MyProjectName}_GTest)

# Getting the test files
message(AUTHOR_WARNING "Getting test source files by using glob")
file(GLOB_RECURSE TESTS_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

message("-aaaaaaaaaaaaaaaaaaaaaaaaaa-")
message(${TESTS_FILES})
message("-aaaaaaaaaaaaaaaaaaaaaaaaaa-")

message("*** Adding gtest executable")
add_executable(${GtestTarget} ${TESTS_FILES})
target_link_libraries(${GtestTarget} )

# add_dependencies(${GtestTarget} gtest)

target_link_libraries(${GtestTarget}
	${MyProjectLib}
	gtest
	gtest_main
)

if(CMAKE_COMPILER_IS_GNUC OR CMAKE_COMPILER_IS_GNUCXX)
	target_link_libraries(${GtestTarget} pthread)
endif()

message("*** Finish subdir 'test' cmake")
