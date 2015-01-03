#!/bin/bash
set -o posix

function attention_echo {
	echo -e "\n******************************************"
	echo -e "*\t$1 *"
	echo -e "******************************************\n"
}

# Default project name (no spaces)
NAME_PROJECT="Default_Project_Name"
# If there is a T_NAME_PROJECT, assign it to NAME_PROJECT
if [ ! -z $T_NAME_PROJECT ]
then
	NAME_PROJECT=${T_NAME_PROJECT}
else
	attention_echo "No T_NAME_PROJECT set"
fi

# The possible arguments to pass to this script
ARG_BUILD_DEBUG="debug"
ARG_BUILD_RELEASE="release"
ARG_CLEAN="clean"

# Some directories
DIR_PROJECT_ROOT=$(dirname "$(readlink -f $0)")
DIR_BUILD=${DIR_PROJECT_ROOT}/build

function build {
	prepare_build

	# Target is for DEBUG
	if [ $1 == "Do${ARG_BUILD_DEBUG}" ]
	then
		attention_echo "Using CMake (build mode Debug)"
		cmake -DSH_NAME_PROJECT=${NAME_PROJECT}\
			-DCMAKE_BUILD_TYPE=Debug\
			${DIR_PROJECT_ROOT} || exit $?

	# Target is for RELEASE
	elif [ $1 == "Do${ARG_BUILD_RELEASE}" ]
	then		
		attention_echo "Using CMake (build mode Release)"
		cmake -DSH_NAME_PROJECT=${NAME_PROJECT}\
			-DCMAKE_BUILD_TYPE=Release\
			${DIR_PROJECT_ROOT} || exit $?

	# Invalid target for argument
	else
		attention_echo "Invalid parameter of '$1'"
		exit 1
	fi

	attention_echo "Running the makefile"
	make || exit $?

	popd
	success_exit
}

function usage {
	echo "The correct usage of this script:"
	echo -e "\t./build.sh ${ARG_BUILD_DEBUG}"
	echo -e "\t./build.sh ${ARG_BUILD_RELEASE}"
	echo -e "\t./build.sh ${ARG_CLEAN}"
	exit 2
}

function prepare_build {
	# Clean the build folder first
	rm -f ${DIR_BUILD}/CMakeCache.txt

	mkdir -p ${DIR_BUILD} || exit $?
	pushd ${DIR_BUILD}
}

function clean {
	echo "Cleaning build/ folder..."
	rm -rf build/
	success_exit
}

function success_exit {
	attention_echo "Finished build script"
	exit 0
}

#########################################
################ "Main" #################
#########################################

attention_echo "Beggining build script"

# If the first argument is not empty
if [ ! -z $1 ]
then

	# Target build is for DEBUG
	if [ $1 == "${ARG_BUILD_DEBUG}" ] 
	then
		build "Do${ARG_BUILD_DEBUG}"

	# Target build is for RELEASE
	elif [ $1 == "${ARG_BUILD_RELEASE}" ]
	then
		build "Do${ARG_BUILD_RELEASE}"

	# Clean the workspace
	elif [ $1 == "${ARG_CLEAN}" ]
	then
		clean

	# Improper usage
	else
		usage
	fi

# If the first argument is empty
else
	usage
fi
