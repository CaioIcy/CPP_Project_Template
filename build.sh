#!/bin/bash

# The possible arguments to pass to this script
BUILD_DEBUG_ARG="debug"
BUILD_RELEASE_ARG="release"
CLEAN_ARG="clean"

#
BASE_DIR=$(dirname "$(readlink -f $0)")
BUILD_DIR=${BASE_DIR}/build

function usage {
	echo "The correct usage of this script :"
	echo "./build.sh ${BUILD_DEBUG_ARG}"
	echo "./build.sh ${BUILD_RELEASE_ARG}"
	echo "./build.sh ${CLEAN_ARG}"
}

function prepare {
	# Clean the build folder first
	rm -f ${BUILD_DIR}/CMakeCache.txt

	mkdir -p ${BUILD_DIR} || exit $?
	pushd ${BUILD_DIR}
}

function build_debug {
	echo "Building debug..."

	prepare

	cmake -DCMAKE_BUILD_TYPE=Debug ${BASE_DIR} || exit $?
	make || exit $?
}

function build_release {
	echo "Building release..."

	prepare

	cmake -DCMAKE_BUILD_TYPE=Release ${BASE_DIR} || exit $?
	make || exit $?
}

function clean {
	echo "Cleaning build/ folder"
	rm -rf build/
}

echo "--------------------------------------"

if [ ! -z $1 ] # If the first argument is not empty
then
	if [ $1 == "${BUILD_DEBUG_ARG}" ] # If ./build.sh debug
	then
		build_debug
	elif [ $1 == "${BUILD_RELEASE_ARG}" ] # If ./build.sh release
	then
		build_release
	elif [ $1 == "${CLEAN_ARG}" ] # If ./build.sh clean
	then
		clean
	else
		usage
	fi
else
	usage
fi

echo "--------------------------------------"
