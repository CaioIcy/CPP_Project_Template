#!/bin/bash
echo "Hello World!"

mkdir .build || exit $?
mkdir .build/reports || exit $?
pushd .build

# debug to get code coverage.
# TODO OP how have both coverage and release? two sequential builds?
cmake -DCMAKE_BUILD_TYPE=Debug .. || exit $?
make || exit $?
./test/MyLib_GTest --gtest_output=xml:reports/xunit-report.xml || exit $?

popd

exit $?
