if(NOT CMAKE_BUILD_TYPE OR NOT CMAKE_BUILD_TYPE MATCHES "Debug|Release")
	message(FATAL_ERROR "Build type was not chosen. Choose either Debug or Release (-DCMAKE_BUILD_TYPE=).")
else()
	message("Building for ${CMAKE_BUILD_TYPE}")
endif()

set(CMAKE_CONFIGURATION_TYPES Debug Release)

message("Setting compiler flags")

set(FLAG_CXX_STANDARD "-std=c++11")
set(FLAGS_WARNING "-ansi -pedantic -W -Wall -Wextra -Wshadow -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Wlogical-op -Wmissing-declarations -Wmissing-include-dirs -Wnoexcept -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wsign-conversion -Wsign-promo -Wstrict-null-sentinel -Wswitch-default -Wundef -Wzero-as-null-pointer-constant -Wuseless-cast -Wnon-virtual-dtor")
set(FLAGS_GCOV "-fprofile-arcs -ftest-coverage -fPIC")
set(FLAGS_MY_PROJECT "${FLAGS_WARNING} ${FLAG_CXX_STANDARD}")

# Debug build info
set(FLAGS_DEBUG "-O0 -g ${FLAGS_GCOV}")
set(CMAKE_CXX_FLAGS_DEBUG ${FLAGS_DEBUG})
set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS} --coverage")

# Release build info
set(FLAGS_RELEASE "-O3 -Werror")
set(CMAKE_CXX_FLAGS_RELEASE ${FLAGS_RELEASE})

# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
# https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html#C_002b_002b-Dialect-Options
