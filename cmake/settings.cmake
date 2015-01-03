# Setting the build number according to TravisCI
if($ENV{TRAVIS_BUILD_NUMBER})
	set(BUILD_NUMBER $ENV{TRAVIS_BUILD_NUMBER})
else()
	set(BUILD_NUMBER "?")
endif()

# Setting some project information
set(MyProjectName ${SH_NAME_PROJECT})
set(MyProjectVersion "v${BUILD_NUMBER}")
set(MyProjectBrief "${MyProjectName} is a toy project to illustrate a full featured C++ CMake project.")
set(MyProjectLib ${MyProjectName})
# set(MyProjectVendor "IcyWare")

# Stripping leading and trailing spaces, all to lowercase, and removing underscores from lib names
string(STRIP ${MyProjectLib} MyProjectLib)
string(TOLOWER ${MyProjectLib} MyProjectLib)
string(REPLACE "_" "" MyProjectLib ${MyProjectLib})

set(ExternalLibsDir "externals")

# Used by documentation home and in packaging
set(LicenseFile "${PROJECT_SOURCE_DIR}/LICENSE") 	# Legal info file
set(ReadmeFile "${MY_CMAKE_INPUT}/README.txt")	# README file that goes into the package. NOT git's readme
set(WelcomeFile "${MY_CMAKE_INPUT}/WELCOME.md")	# Doxygen main page file
