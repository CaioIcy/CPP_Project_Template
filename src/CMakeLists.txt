message("*** Starting subdir 'src' cmake")

message(AUTHOR_WARNING "Getting source files by using glob")
file(GLOB_RECURSE MyCppSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

# Create a list with all cpp sources except for main, so the library doesn't contain it
set(MySourcesNoMain ${MyCppSources})
list(REMOVE_ITEM MySourcesNoMain main.cpp)

add_library(${MyProjectLib} STATIC ${MySourcesNoMain})
# add_library(${MyProjectLib}Shared SHARED ${MySourcesNoMain})
add_executable(${MyProjectName} ${MyCppSources})
target_link_libraries(${MyProjectName} ${MyProjectLib})

# Used to be '/include', but is now '/src' due to remodeling of the project structure
include_directories(
	${PROJECT_SOURCE_DIR}/src
)

# # TODO Review these installation steps, to see if necessary
# install(TARGETS ${MyProjectName} #${MyProjectName}Shared
# 	ARCHIVE DESTINATION lib
# 	LIBRARY DESTINATION lib
# 	COMPONENT libraries
# )

# install(DIRECTORY ${PROJECT_SOURCE_DIR}/include
# 	DESTINATION .
# 	COMPONENT headers
# )

message("*** Finish subdir 'src' cmake")
