#!/bin/bash

BASE_DIR=$(dirname "$(readlink -f $0)")
BASE_NAME=$(basename "${BASE_DIR}")

BUILD_DIR=${BASE_DIR}/../${BASE_NAME}_bin
REPORTS_DIR=${BASE_DIR}/../${BASE_NAME}_reports

mkdir -p ${BUILD_DIR} || exit $?
pushd ${BUILD_DIR}

mkdir -p ${REPORTS_DIR} || exit $?

# debug to get code coverage.
# TODO OP refer to test binary output from CMake infos
# TODO OP how have both coverage and release? two sequential builds?
cmake -DCMAKE_BUILD_TYPE=Debug ${BASE_DIR} || exit $?
make || exit $?
valgrind --xml=yes --xml-file=${REPORTS_DIR}/valgrind-report.xml test/MyProject_GTest --gtest_output=xml:${REPORTS_DIR}/xunit-report.xml || exit $?

# Code Coverage report (Cobertura) (handled by jenkins)
# TODO OP configure where .gcna files are stored from CMake and Lib name
gcovr -x -r test/CMakeFiles/MyProject_GTest.dir/myproject -f ${BASE_DIR}/src > ${REPORTS_DIR}/gcov-report.xml || exit $?

# CPP Check report (handled by jenkins)
# TODO OP configure where includes and source are stored from CMake
pushd ${BASE_DIR}
cppcheck -v --enable=all --xml -Iinclude src 2> ${REPORTS_DIR}/cppcheck-report.xml || exit $?
popd

cpack || exit $? # archived by jenkins

popd

exit $?
