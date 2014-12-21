# C++ Project Template
[![Travis CI Build Status](https://travis-ci.org/CaioIcy/CPP_Project_Template.svg?branch=master)](https://travis-ci.org/CaioIcy/CPP_Project_Template)

Forked from [opatry's template]:
> "This project is used as a basis for any C++ project built with CMake. Its purpose is to provide a full featured (code coverage, unit tests, static analysis, …) and cross platform build. It tries to use CMake in the most effective way."

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

From **.travis.yml** (_Ubuntu_):  
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -qq
sudo apt-get install -qq cmake doxygen g++-4.8 python-pip cppcheck valgrind
sudo pip install Pygments
sudo pip install gcovr
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 90
```

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

The GitHub webpage is available here: [Project Webpage]  

All the documentation and reports are automatically published to it with **Travis-CI**, using the **utils/publish_to_ghpages.sh** script. The idea is that every project derived from this template can also have this format of auto-publishing stuff.

# Notes

The Google Test framework was originally downloaded through SVN on every build, but I didn't want any internet connection dependency.  
Through [dmonopoly's project] I learned how to include it with my project (so thanks).

#License

See [LICENSE](LICENSE) file.

[Project Webpage]:https://caioicy.github.io/CPP_Project_Template/
[opatry's template]:https://github.com/opatry/CPP_Project_Template
[dmonopoly's project]:https://github.com/dmonopoly/gtest-cmake-example
