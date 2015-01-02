message("*** Starting subdir 'src' cmake")

message(AUTHOR_WARNING "Getting source files by using glob")
file(GLOB_RECURSE MyCppSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

# Create a list with all cpp sources except for main, so the library doesn't contain it
set(MySourcesNoMain ${MyCppSources})
list(REMOVE_ITEM MySourcesNoMain main.cpp)

set(ExecTarget ${MyProjectName}_exec)

add_library(${MyProjectLib} STATIC ${MySourcesNoMain})
# add_library(${MyProjectLib}Shared SHARED ${MySourcesNoMain})
add_executable(${ExecTarget} ${MyCppSources})

# Adding warning and standard flags here so we don't get an insane amount of warnings from
# externals, just from our project
set_target_properties(${ExecTarget} PROPERTIES COMPILE_FLAGS "${FLAGS_WARNING} ${FLAG_CXX_STANDARD}")
target_link_libraries(${ExecTarget} ${MyProjectLib})

# Used to be '/include', but is now '/src' due to remodeling of the project structure
include_directories(
	${PROJECT_SOURCE_DIR}/src
)

# Files that are packed with CPack
install(TARGETS ${ExecTarget} #${MyProjectLib}Shared
	RUNTIME DESTINATION bin
	COMPONENT executables
)

# install(DIRECTORY ${PROJECT_SOURCE_DIR}/src
# 	DESTINATION .
# 	COMPONENT headers
# )

# Licensing and stuff like that
install(FILES
	${ReadmeFile}
	${LicenseFile}
	DESTINATION .
)

message("*** Finish subdir 'src' cmake")
