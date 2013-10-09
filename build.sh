#!/bin/bash
echo "Hello World!"

mkdir .build
pushd .build

# debug to get code coverage.
# TODO OP how have both coverage and release? two sequential builds?
cmake -DCMAKE_BUILD_TYPE=Debug .. || exit $?
make || exit $?
./test/MyLib_GTest || exit $?

popd

exit $?
