#!/bin/bash

# The possible arguments to pass to this script
BUILD_DEBUG_ARG="debug"
BUILD_RELEASE_ARG="release"
CLEAN_ARG="clean"

#
PROJECT_NAME="MyProject"
PROJECT_TARGET=${PROJECT_NAME}_exec
GTEST_TARGET=${PROJECT_NAME}_GTest

#
BASE_DIR=$(dirname "$(readlink -f $0)")
BUILD_DIR=${BASE_DIR}/build

SRC_DIR=${BASE_DIR}/src
UTILS_DIR=../utils # is relative to the build/ folder so the python scripts can be used

REPORTS_DIR=${BUILD_DIR}/reports
CPPLINT_REPORTS_DIR=${REPORTS_DIR}/cpplint-reports
CPPCHECK_REPORTS_DIR=${REPORTS_DIR}/cppcheck-reports
GCOVR_REPORTS_DIR=${REPORTS_DIR}/gcovr-reports

function attention_echo {
	echo -e "\n******************************************"
	echo -e "*\t$1 *"
	echo -e "******************************************\n"
}

function usage {
	echo "The correct usage of this script :"
	echo "./build.sh ${BUILD_DEBUG_ARG}"
	echo "./build.sh ${BUILD_RELEASE_ARG}"
	echo "./build.sh ${CLEAN_ARG}"
	exit 2
}

function code_analysis {
	# TODO make the cppcheck/cpplint htmls a little nicer

	attention_echo "cppcheck"
	# Generate cppcheck xml
	cppcheck -v --enable=all ${SRC_DIR} -I${SRC_DIR} --xml-version=2 2> cppcheck-only-result.xml
	# Generate html from it
	mkdir -p ${CPPCHECK_REPORTS_DIR} || exit $?
	./${UTILS_DIR}/cppcheck-htmlreport.py --file=cppcheck-only-result.xml --report-dir=${CPPCHECK_REPORTS_DIR} --source-dir=${BASE_DIR}

	attention_echo "cpplint.py"
	# Generate cppcheck-style xml from cpplint output
	./${UTILS_DIR}/cpplint.py --filter=-whitespace,-legal ${SRC_DIR}/*.cpp 2>&1| sed 's/"/\&quot;/g' >&1| ./${UTILS_DIR}/cpplint_to_cppcheckxml.py &> cpplint-cppcheck-result.xml
	# Generate html from it
	mkdir -p ${CPPLINT_REPORTS_DIR} || exit $?
	./${UTILS_DIR}/cppcheck-htmlreport.py --file=cpplint-cppcheck-result.xml --report-dir=${CPPLINT_REPORTS_DIR} --source-dir=${BASE_DIR}

	attention_echo "Valgrind"
	# Project valgrind report
	valgrind --xml=yes --xml-file=${REPORTS_DIR}/valgrind-${PROJECT_TARGET}-report.xml src/${PROJECT_TARGET}

	# Test suite valgrind report + Test report
	valgrind --xml=yes --xml-file=${REPORTS_DIR}/valgrind-${GTEST_TARGET}-report.xml test/${GTEST_TARGET} --gtest_output=xml:${REPORTS_DIR}/gtest-report.xml

	attention_echo "gcovr"
	# Cobertura
	mkdir -p ${GCOVR_REPORTS_DIR} || exit $?
	gcovr -r src/CMakeFiles/${PROJECT_TARGET}.dir/ -f ${BASE_DIR}/src --html --html-details -o ${GCOVR_REPORTS_DIR}/index.html
}

function prepare {
	# Clean the build folder first
	rm -f ${BUILD_DIR}/CMakeCache.txt

	mkdir -p ${BUILD_DIR} || exit $?
	pushd ${BUILD_DIR}
}

function build {
	if [ $1 == "DoDebug" ]
	then
		prepare
		attention_echo "Using CMake (build mode Debug)"
		cmake -DCMAKE_BUILD_TYPE=Debug ${BASE_DIR} || exit $?
	elif [ $1 == "DoRelease" ]
	then
		prepare
		attention_echo "Using CMake (build mode Release)"
		cmake -DCMAKE_BUILD_TYPE=Release ${BASE_DIR} || exit $?
	else
		attention_echo "Invalid parameter of '$1'"
		exit 1
	fi

	attention_echo "Running the makefile"
	make || exit $?

	code_analysis

	attention_echo "Packing with CPack"
	cpack || exit $?

	exit 0
}

function clean {
	echo "Cleaning build/ folder..."
	rm -rf build/
}

attention_echo "Beggining build script"

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

attention_echo "Finished build script"
