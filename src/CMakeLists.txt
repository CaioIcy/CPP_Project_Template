message("*** Starting subdir 'src' cmake")

###################################################################
message(AUTHOR_WARNING "Getting source files by using glob")
file(GLOB_RECURSE MyCppSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

# Create a list with all cpp sources except for main, so the library doesn't contain it
set(MySourcesNoMain ${MyCppSources})
list(REMOVE_ITEM MySourcesNoMain main.cpp)

set(ExecTarget ${MyProjectName}_exec)

###################################################################
# Adding warning and standard flags here so we don't get an insane amount of warnings from
# externals, just from our project
if(MY_SHARED_LIB_ENABLED)
	add_library(${MyProjectLib} SHARED ${MySourcesNoMain})
else()
	add_library(${MyProjectLib} STATIC ${MySourcesNoMain})
endif()
set_target_properties(${MyProjectLib} PROPERTIES COMPILE_FLAGS "${FLAGS_MY_PROJECT}")

###################################################################
# Adding warning and standard flags here so we don't get an insane amount of warnings from
# externals, just from our project
add_executable(${ExecTarget} ${MyCppSources})
set_target_properties(${ExecTarget} PROPERTIES COMPILE_FLAGS "${FLAGS_MY_PROJECT}")

###################################################################
# Used to be '/include', but is now '/src' due to remodeling of the project structure
include_directories(
	${PROJECT_SOURCE_DIR}/src
)

# Files that are packed with CPack
install(TARGETS ${ExecTarget}
	RUNTIME DESTINATION bin
	COMPONENT executables
)

if(MY_SHARED_LIB_ENABLED)
	install(TARGETS ${MyProjectLib}
		LIBRARY DESTINATION bin
		COMPONENT executables
	)
endif()

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
