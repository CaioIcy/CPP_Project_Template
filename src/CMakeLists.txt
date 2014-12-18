message(STATUS "CMAKE: Starting subdir 'src' cmake")

# Build steps
file(GLOB_RECURSE MyCppSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

set(MySourcesNoMain ${MyCppSources})
list(REMOVE_ITEM MySourcesNoMain main.cpp)

add_library(${MYPROJECT_LIB} STATIC ${MySourcesNoMain})
# add_library(${MYPROJECT_LIB}Shared SHARED ${MySourcesNoMain})
add_executable(${MYPROJECT_NAME} ${MyCppSources})
target_link_libraries(${MYPROJECT_NAME} ${MYPROJECT_LIB})

# Used to be '/include', but is now '/src' due to remodeling of the project structure
include_directories(
	${PROJECT_SOURCE_DIR}/src
)

# # TODO Review these installation steps, to see if necessary
# install(TARGETS ${MYPROJECT_NAME} #${MYPROJECT_NAME}Shared
# 	ARCHIVE DESTINATION lib
# 	LIBRARY DESTINATION lib
# 	COMPONENT libraries
# )

# install(DIRECTORY ${PROJECT_SOURCE_DIR}/include
# 	DESTINATION .
# 	COMPONENT headers
# )

message(STATUS "CMAKE: Finish subdir 'src' cmake")
