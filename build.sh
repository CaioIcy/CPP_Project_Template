#!/bin/bash

BASE_DIR=$(dirname "$(readlink -f $0)")

BUILD_DIR=${BASE_DIR}/build~
REPORTS_DIR=${BUILD_DIR}/reports

rm -Rf ${BUILD_DIR} || exit $?
mkdir -p ${BUILD_DIR} || exit $?
pushd ${BUILD_DIR}

mkdir -p ${REPORTS_DIR} || exit $?

# debug to get code coverage.
# TODO OP refer to test binary output from CMake infos
# TODO OP how have both coverage and release? two sequential builds?
cmake -DCMAKE_BUILD_TYPE=Debug .. || exit $?
make || exit $?
valgrind --xml=yes --xml-file=${REPORTS_DIR}/valgrind-report.xml test/MyLib_GTest --gtest_output=xml:${REPORTS_DIR}/xunit-report.xml || exit $?

# Code Coverage report (Cobertura) (handled by jenkins)
# TODO OP configure where .gcna files are stored from CMake and Lib name
gcovr -x -r test/CMakeFiles/MyLib_GTest.dir/mylib -f ${BASE_DIR}/src > ${REPORTS_DIR}/gcov-report.xml || exit $?

# CPP Check report (handled by jenkins)
# TODO OP configure where includes and source are stored from CMake
pushd ${BASE_DIR}
cppcheck -v --enable=all --xml -Iinclude src 2> ${REPORTS_DIR}/cppcheck-report.xml || exit $?
popd

make doc || exit $? # included in archive
make package || exit $? # archived by jenkins

popd

exit $?
