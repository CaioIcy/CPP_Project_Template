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

# TODO OP do something with the package (upload in an artifact repository?)
make package || exit $?

popd

exit $?
