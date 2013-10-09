#!/bin/bash
echo "Hello World!"

BUILD_DIR=.build

rm -Rf ${BUILD_DIR} || exit $?
mkdir ${BUILD_DIR} || exit $?
pushd ${BUILD_DIR}

mkdir reports || exit $?

# debug to get code coverage.
# TODO OP how have both coverage and release? two sequential builds?
cmake -DCMAKE_BUILD_TYPE=Debug .. || exit $?
make || exit $?
./test/MyLib_GTest --gtest_output=xml:reports/xunit-report.xml || exit $?

popd

exit $?
