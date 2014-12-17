execute_process(COMMAND echo "CMAKE: Starting subdir 'src' cmake")

# Build steps
file(GLOB_RECURSE MYPROJECT_SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

# add_library(${MYPROJECT_NAME} STATIC ${MYPROJECT_SRC_FILES})
add_executable(${MYPROJECT_NAME} ${MYPROJECT_SRC_FILES})
# add_library(${MYPROJECT_NAME}Shared SHARED ${MYPROJECT_SRC_FILES})

include_directories(
	${PROJECT_SOURCE_DIR}/include
)

# Installation steps
# install(TARGETS ${MYPROJECT_NAME} #${MYPROJECT_NAME}Shared
# 	ARCHIVE DESTINATION lib
# 	LIBRARY DESTINATION lib
# 	COMPONENT libraries
# )

# install(DIRECTORY ${PROJECT_SOURCE_DIR}/include
# 	DESTINATION .
# 	COMPONENT headers
# )

execute_process(COMMAND echo "CMAKE: Finish subdir 'src' cmake")
