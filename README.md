# C++ / CMake / gtest Project Template
[![Travis CI Build Status](https://travis-ci.org/CaioIcy/cpp-cmake-template.svg?branch=master)](https://travis-ci.org/CaioIcy/cpp-cmake-template)

Forked from [opatry's template]:
> This project is used as a basis for any C++ project built with CMake. Its purpose is to provide a full featured (code coverage, unit tests, static analysis, …) and cross platform build. It tries to use CMake in the most effective way.

# What is contained

Technology     | Description
---------------|----------
**C++11**      | Supported language. Will add C++14 eventually.
**CMake**      | Build system
**CPack**      | Packaging system integrated with CMake
**Google Test**| Google's C++ Testing Framework
**Doxygen**    | Code documentation
**cpplint**    | Open source lint-like tool from Google
**Cppcheck**   | Static analysis tool
**Travis CI**  | Continuous integration

# Dependencies

See the **.travis.yml** file to see what it downloads, I'll list them here later.

# Building

 `./build.sh debug`   
 or
 `./build.sh release`
 
This will produce:
- Project Executable (_build/src/MyProject_exec_)
- Test Executable (_build/src/MyProject_GTest_)
- Doxygen documentation (_build/doc/html/_)
- Several reports (_/build/reports/_)

# Webpage

It is available here: [Project Webpage]  
All the documentation and reports are automatically published to it with **Travis-CI**, using the **utils/publish_to_ghpages.sh** script.  
The idea is that every project derived from this template can also has this format of auto-publishing stuff.

# Notes

The Google Test framework was originally downloaded through SVN on every build, but I didn't want any internet connection dependency.  
Through [dmonopoly's project] I learned how to include it with my project (so thanks).

#License

See LICENSE file.

[Project Webpage]:https://caioicy.github.io/cpp-cmake-template/
[opatry's template]:https://github.com/opatry/cpp-cmake-template
[dmonopoly's project]:https://github.com/dmonopoly/gtest-cmake-example
