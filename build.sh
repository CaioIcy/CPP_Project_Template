#!/bin/bash

# The possible arguments to pass to this script
BUILD_DEBUG_ARG="debug"
BUILD_RELEASE_ARG="release"
CLEAN_ARG="clean"

#
BASE_DIR=$(dirname "$(readlink -f $0)")
BUILD_DIR=${BASE_DIR}/build
SRC_DIR=${BASE_DIR}/src
UTILS_DIR=../utils
REPORTS_DIR=${BUILD_DIR}/reports
CPPLINT_REPORTS_DIR=${REPORTS_DIR}/cpplint-reports
CPPCHECK_REPORTS_DIR=${REPORTS_DIR}/cppcheck-reports

function usage {
	echo "The correct usage of this script :"
	echo "./build.sh ${BUILD_DEBUG_ARG}"
	echo "./build.sh ${BUILD_RELEASE_ARG}"
	echo "./build.sh ${CLEAN_ARG}"
}

function code_analysis {
	# TODO make the htmls a little nicer

	# Generate cppcheck xml
	cppcheck --enable=warning,style,performance,portability ${SRC_DIR} --xml-version=2 2> cppcheck-only-result.xml
	# Generate html from it
	mkdir -p ${CPPLINT_REPORTS_DIR} || exit $?
	./${UTILS_DIR}/cppcheck-htmlreport.py --file=cppcheck-only-result.xml --report-dir=${CPPCHECK_REPORTS_DIR} --source-dir=${BASE_DIR}

	# Generate cppcheck-style xml from cpplint output
	./${UTILS_DIR}/cpplint.py --filter=-whitespace,-legal ${SRC_DIR}/*.cpp 2>&1| sed 's/"/\&quot;/g' >&1| ./${UTILS_DIR}/cpplint_to_cppcheckxml.py &> cpplint-cppcheck-result.xml
	# Generate html from it
	mkdir -p ${CPPCHECK_REPORTS_DIR} || exit $?
	./${UTILS_DIR}/cppcheck-htmlreport.py --file=cpplint-cppcheck-result.xml --report-dir=${CPPLINT_REPORTS_DIR} --source-dir=${BASE_DIR}
}

function prepare {
	# Clean the build folder first
	rm -f ${BUILD_DIR}/CMakeCache.txt

	mkdir -p ${BUILD_DIR} || exit $?
	pushd ${BUILD_DIR}
}

function build {
	echo "Preparing project and test building..."

	if [ $1 == "DoDebug" ]
	then
		echo "Chosen build: Debug"
		prepare
		cmake -DCMAKE_BUILD_TYPE=Debug ${BASE_DIR} || exit $?
	elif [ $1 == "DoRelease" ]
	then
		echo "Chosen build: Release"
		prepare
		cmake -DCMAKE_BUILD_TYPE=Release ${BASE_DIR} || exit $?
	else
		echo "Invalid parameter of '$1'"
		exit 1
	fi

	make || exit $?

	code_analysis
}

function clean {
	echo "Cleaning build/ folder..."
	rm -rf build/
}

echo "--------------------------------------"

if [ ! -z $1 ] # If the first argument is not empty
then
	if [ $1 == "${BUILD_DEBUG_ARG}" ] # If ./build.sh debug
	then
		build "DoDebug"
	elif [ $1 == "${BUILD_RELEASE_ARG}" ] # If ./build.sh release
	then
		build "DoRelease"
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
