message("\n*** test/ subdir")

enable_testing()

# Has project(gtest)
set(GtestAndVersion gtest-1.7.0)
add_subdirectory(../${ExternalLibsDir}/${GtestAndVersion} "${CMAKE_CURRENT_BINARY_DIR}/${ExternalLibsDir}/${GtestAndVersion}")

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

add_executable(${GtestTarget} ${TESTS_FILES})
target_link_libraries(${GtestTarget} )

target_link_libraries(${GtestTarget}
	${MyProjectLib}
	gtest
	gtest_main
)

if(CMAKE_COMPILER_IS_GNUC OR CMAKE_COMPILER_IS_GNUCXX)
	target_link_libraries(${GtestTarget} pthread)
endif()
