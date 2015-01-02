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
set(MyProjectLib ${MyProjectName}-lib)
# set(MyProjectVendor "IcyWare")

set(ExternalLibsDir "externals")

# Used by documentation home and in packaging
set(ReadmeFile "${PROJECT_SOURCE_DIR}/doc/README.txt")	# README file that goes into the package. NOT git's readme
set(LicenseFile "${PROJECT_SOURCE_DIR}/LICENSE") 		# Legal info file
set(WelcomeFile "${PROJECT_SOURCE_DIR}/doc/WELCOME.md")	# Doxygen main page file
