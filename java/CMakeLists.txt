file(GLOB_RECURSE MYLIB_SWIG_FILES ${CMAKE_CURRENT_SOURCE_DIR} *.i)

find_package(SWIG REQUIRED)
find_package(Java REQUIRED)
find_package(JNI REQUIRED)
include(UseJava)
include(UseSWIG)

set(MYLIB_PACKAGE_NAME "org.acme")
string(REPLACE "." "/" MYLIB_PACKAGE_DIR ${MYLIB_PACKAGE_NAME})

set(CMAKE_SWIG_FLAGS -package ${MYLIB_PACKAGE_NAME})
set(CMAKE_SWIG_OUTDIR ${CMAKE_CURRENT_BINARY_DIR}/src/${MYLIB_PACKAGE_DIR})

set_source_files_properties(${MYLIB_SWIG_FILES} PROPERTIES CPLUSPLUS ON)

include_directories(
  ${PROJECT_SOURCE_DIR}/include
  ${JNI_INCLUDE_DIRS}
)

swig_add_module(MyLibSWIG java ${MYLIB_SWIG_FILES})

swig_link_libraries(MyLibSWIG MyLib)

set(CMAKE_JAVA_TARGET_VERSION ${MYLIB_VERSION})
set(CMAKE_JNI_TARGET TRUE)
add_jar(MyLibJNI ${CMAKE_SWIG_OUTDIR}/*.java)
install_jar(MyLibJNI jlib)

create_javadoc(MyLibJavadoc
  PACKAGES ${MYLIB_PACKAGE_NAME}
  SOURCEPATH ${CMAKE_CURRENT_BINARY_DIR}/src
  CLASSPATH ${CMAKE_JAVA_INCLUDE_PATH}
  INSTALLPATH ${CMAKE_CURRENT_BINARY_DIR}/javadoc
  WINDOWTITLE ${MYLIB_NAME}
  DOCTITLE "<h1>${MYLIB_NAME}</h1>"
  AUTHOR TRUE
  USE TRUE
  VERSION TRUE
)
# TODO OP add javadoc to CPack
# TODO OP retrieve Doxygen doc in Javadoc?

add_dependencies(MyLibJNI MyLibSWIG)