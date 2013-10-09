#!/bin/bash

BASE_DIR=$(dirname $(readlink -f $0))

BUILD_DIR=${BASE_DIR}/build~

rm -Rf ${BUILD_DIR} || exit $?
mkdir ${BUILD_DIR} || exit $?
pushd ${BUILD_DIR}

mkdir reports || exit $?

# debug to get code coverage.
# TODO OP how have both coverage and release? two sequential builds?
cmake -DCMAKE_BUILD_TYPE=Debug .. || exit $?
make || exit $?
./test/MyLib_GTest --gtest_output=xml:reports/xunit-report.xml || exit $?

# Code Coverage report (Cobertura) (handled by jenkins)
# TODO OP configure where .gcna files are stored from CMake
gcovr -x test/CMakeFiles/MyLib_GTest.dir/mylib > reports/gcov-report.xml || exit $?

# CPP Check report (handled by jenkins)
# TODO OP configure where includes and source are stored from CMake
cppcheck -v --enable=all --xml ${BASE_DIR}/include ${BASE_DIR}/src 2> reports/cppcheck-report.xml || exit $?

make doc || exit $? # included in archive
make package || exit $? # archived by jenkins

popd

exit $?
