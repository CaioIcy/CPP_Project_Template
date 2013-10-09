# Build steps
file(GLOB_RECURSE MYLIB_SRC_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp)

add_library(${MYLIB_NAME} STATIC ${MYLIB_SRC_FILES})
include_directories(
  ${PROJECT_SOURCE_DIR}/include
)

# Installation steps
install(TARGETS ${MYLIB_NAME}
  ARCHIVE
  DESTINATION lib
  COMPONENT libraries
)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include
  DESTINATION .
  COMPONENT headers
)