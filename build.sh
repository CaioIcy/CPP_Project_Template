#!/bin/bash
echo -e "============================================"
echo -e "-----------------build.sh-------------------"
pwd

BASE_DIR=$(dirname "$(readlink -f $0)")
echo -e "BASE_DIR == ${BASE_DIR}"

BASE_NAME=$(basename "${BASE_DIR}")
echo -e "BASE_NAME == ${BASE_NAME}"

BUILD_DIR=${BASE_DIR}/build
echo -e "BUILD_DIR == ${BUILD_DIR}"

REPORTS_DIR=${BUILD_DIR}/reports
echo -e "REPORTS_DIR == ${REPORTS_DIR}"

mkdir -p ${BUILD_DIR} || exit $?
pushd ${BUILD_DIR}

mkdir -p ${REPORTS_DIR} || exit $?

# debug to get code coverage.
# TODO OP refer to test binary output from CMake infos
# TODO OP how have both coverage and release? two sequential builds?
echo -e "cmake dir is: ******************\n"
pwd
cmake -DCMAKE_BUILD_TYPE=Debug ${BASE_DIR} || exit $?
make || exit $?

# valgrind --xml=yes --xml-file=${REPORTS_DIR}/valgrind-report.xml test/MyProject_GTest --gtest_output=xml:${REPORTS_DIR}/xunit-report.xml || exit $?

# Code Coverage report (Cobertura) (handled by jenkins)
# TODO OP configure where .gcna files are stored from CMake and Lib name
# gcovr -x -r test/CMakeFiles/MyProject_GTest.dir/myproject -f ${BASE_DIR}/src > ${REPORTS_DIR}/gcov-report.xml || exit $?

echo -e "3============================================"

# CPP Check report (handled by jenkins)
# TODO OP configure where includes and source are stored from CMake
pushd ${BASE_DIR}
# cppcheck -v --enable=all --xml -Iinclude src 2> ${REPORTS_DIR}/cppcheck-report.xml || exit $?
popd

echo -e "2============================================"

cpack || exit $? # archived by jenkins

popd

echo -e "1============================================"
exit $?
