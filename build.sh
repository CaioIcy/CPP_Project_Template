#!/bin/bash
set -o posix

## Edit your projects name here, try to not put spaces
NAME_PROJECT="My_Project"

# The possible arguments to pass to this script
ARG_BUILD_DEBUG="debug"
ARG_BUILD_RELEASE="release"
ARG_CLEAN="clean"

# Target names
TARGET_PROJECT=${NAME_PROJECT}_exec
TARGET_GTEST=${NAME_PROJECT}_GTest

# Some directories
DIR_PROJECT_ROOT=$(dirname "$(readlink -f $0)")
DIR_BUILD=${DIR_PROJECT_ROOT}/build
DIR_SRC=${DIR_PROJECT_ROOT}/src
DIR_BUILD_SRC=${DIR_BUILD}/src
DIR_BUILD_TEST=${DIR_BUILD}/test
DIR_REPORTS=${DIR_BUILD}/reports
DIR_REPORTS_CPPLINT=${DIR_REPORTS}/cpplint-reports
DIR_REPORTS_CPPCHECK=${DIR_REPORTS}/cppcheck-reports
DIR_REPORTS_GCOVR=${DIR_REPORTS}/gcovr-reports
DIR_GCOVR_FILES=${DIR_BUILD_SRC}/CMakeFiles/${TARGET_PROJECT}.dir/
DIR_UTILS=${DIR_PROJECT_ROOT}/utils

function do_cppcheck {
	attention_echo "cppcheck"

	mkdir -p ${DIR_REPORTS_CPPCHECK} || exit $?

	# Generate cppcheck xml
	cppcheck -v --enable=all ${DIR_SRC} -I${DIR_SRC} --xml-version=2 2> cppcheck-only-result.xml

	# Generate html from it
	${DIR_UTILS}/cppcheck-htmlreport.py\
		--file=cppcheck-only-result.xml\
		--report-dir=${DIR_REPORTS_CPPCHECK}\
		--source-dir=${DIR_PROJECT_ROOT}\
		--title=${NAME_PROJECT}
}

function do_cpplint {
	attention_echo "cpplint.py"

	mkdir -p ${DIR_REPORTS_CPPLINT} || exit $?

	# Generate cppcheck-style xml from cpplint output
	${DIR_UTILS}/cpplint.py --filter=-whitespace,-legal ${DIR_SRC}/*.cpp 2>&1|\
		sed 's/"/\&quot;/g' >&1| sed 's/</\&lt;/g' >&1| sed 's/>/\&gt;/g' >&1|\
		sed "s/'/\&apos;/g" >&1| sed 's/\&/\&amp;/g' >&1|\
		${DIR_UTILS}/cpplint_to_cppcheckxml.py &> cpplint-cppcheck-result.xml

	# Generate html from it
	${DIR_UTILS}/cppcheck-htmlreport.py\
		--file=cpplint-cppcheck-result.xml\
		--report-dir=${DIR_REPORTS_CPPLINT}\
		--source-dir=${DIR_PROJECT_ROOT}\
		--title=${NAME_PROJECT}

	# Change Cppcheck things to cpplint
	sed -i 's/Cppcheck/cpplint/g' ${DIR_REPORTS_CPPLINT}/index.html
	sed -i 's/a\ tool\ for\ static\ C\/C++\ code\ analysis/an\ open\ source\ lint\-like\ tool\ from\ Google/g' ${DIR_REPORTS_CPPLINT}/index.html
	sed -i 's/http:\/\/cppcheck.sourceforge.net/http:\/\/google\-styleguide.googlecode.com\/svn\/trunk\/cpplint\/cpplint.py/g' ${DIR_REPORTS_CPPLINT}/index.html
	sed -i 's/IRC: <a href=\"irc:\/\/irc.freenode.net\/cppcheck\">irc:\/\/irc.freenode.net\/cppcheck<\/a>/\ /g' ${DIR_REPORTS_CPPLINT}/index.html
}

function do_valgrind {
	attention_echo "Valgrind"

	# Project valgrind report
	valgrind --xml=yes\
		--xml-file=${DIR_REPORTS}/valgrind-${TARGET_PROJECT}-report.xml\
		${DIR_BUILD_SRC}/${TARGET_PROJECT}

	# Test suite valgrind report + Test report
	valgrind --xml=yes\
		--xml-file=${DIR_REPORTS}/valgrind-${TARGET_GTEST}-report.xml\
		${DIR_BUILD_TEST}/${TARGET_GTEST}\
		--gtest_output=xml:${DIR_REPORTS}/gtest-report.xml
}

function do_gcovr {
	attention_echo "gcovr"

	mkdir -p ${DIR_REPORTS_GCOVR} || exit $?

	gcovr --verbose\
		--root=${DIR_GCOVR_FILES}\
		--filter=${DIR_PROJECT_ROOT}/src\
		--html --html-details --output=${DIR_REPORTS_GCOVR}/index.html
}

function code_analysis {
	do_cppcheck
	do_cpplint
	do_valgrind
	do_gcovr
}

function build {
	prepare_build

	# Target is for DEBUG
	if [ $1 == "Do${ARG_BUILD_DEBUG}" ]
	then
		attention_echo "Using CMake (build mode Debug)"
		cmake -DSH_NAME_PROJECT=${NAME_PROJECT} -DCMAKE_BUILD_TYPE=Debug ${DIR_PROJECT_ROOT} || exit $?

	# Target is for RELEASE
	elif [ $1 == "Do${ARG_BUILD_RELEASE}" ]
	then		
		attention_echo "Using CMake (build mode Release)"
		cmake -DSH_NAME_PROJECT=${NAME_PROJECT} -DCMAKE_BUILD_TYPE=Release ${DIR_PROJECT_ROOT} || exit $?

	# Invalid target for argument
	else
		attention_echo "Invalid parameter of '$1'"
		exit 1
	fi

	attention_echo "Running the makefile"
	make || exit $?

	code_analysis

	attention_echo "Packing with CPack"
	cpack || exit $?

	attention_echo "cpp-coveralls (muted)"
	coveralls --verbose\
		--root ${DIR_PROJECT_ROOT} -E ".*externals*" -E ".*CMakeFiles.*" -E ".*test/.*.cpp.*" > /dev/null 2>&1

	popd
	success_exit
}

function usage {
	echo "The correct usage of this script:"
	echo -e "\t./build.sh ${ARG_BUILD_DEBUG}"
	echo -e "\t./build.sh ${ARG_BUILD_RELEASE}"
	echo -e "\t./build.sh ${ARG_CLEAN}"
	exit 2
}

function prepare_build {
	# Clean the build folder first
	rm -f ${DIR_BUILD}/CMakeCache.txt

	mkdir -p ${DIR_BUILD} || exit $?
	pushd ${DIR_BUILD}
}

function clean {
	echo "Cleaning build/ folder..."
	rm -rf build/
	success_exit
}

function attention_echo {
	echo -e "\n******************************************"
	echo -e "*\t$1 *"
	echo -e "******************************************\n"
}

function success_exit {
	attention_echo "Finished build script"
	exit 0
}

#########################################
################ "Main" #################
#########################################

attention_echo "Beggining build script"

# If the first argument is not empty
if [ ! -z $1 ]
then

	# Target build is for DEBUG
	if [ $1 == "${ARG_BUILD_DEBUG}" ] 
	then
		build "Do${ARG_BUILD_DEBUG}"

	# Target build is for RELEASE
	elif [ $1 == "${ARG_BUILD_RELEASE}" ]
	then
		build "Do${ARG_BUILD_RELEASE}"

	# Clean the workspace
	elif [ $1 == "${ARG_CLEAN}" ]
	then
		clean

	# Improper usage
	else
		usage
	fi

# If the first argument is empty
else
	usage
fi
