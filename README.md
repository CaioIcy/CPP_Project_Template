# C++ Project Template
[![Travis CI Build Status](https://travis-ci.org/CaioIcy/CPP_Project_Template.svg?branch=master)](https://travis-ci.org/CaioIcy/CPP_Project_Template)
[![Coverage Status](https://img.shields.io/coveralls/CaioIcy/CPP_Project_Template.svg)](https://coveralls.io/r/CaioIcy/CPP_Project_Template)

Forked from [opatry's template]:
> "This project is used as a basis for any C++ project built with CMake. Its purpose is to provide a full featured (code coverage, unit tests, static analysis, …) and cross platform build. It tries to use CMake in the most effective way."

# What is contained

Technology     |                    Description                 | Links
---------------|------------------------------------------------|-------------
**C++11**      | Supported standard. Will add C++14 eventually. | [*](https://en.wikipedia.org/wiki/C%2B%2B11)
**CMake**      | Build system                                   | [*](http://www.cmake.org/)
**CPack**      | Packaging system integrated with CMake         | [*](http://www.cmake.org/Wiki/CMake:Packaging_With_CPack)
**Google Test**| Google's C++ Testing Framework                 | [*](https://code.google.com/p/googletest/)
**Doxygen**    | Code documentation                             | [*](http://www.stack.nl/~dimitri/doxygen/)
**cpplint**    | Open source lint-like tool from Google         | [*](https://en.wikipedia.org/wiki/Cpplint) [*](https://google-styleguide.googlecode.com/svn/trunk/cpplint/cpplint.py)
**Cppcheck**   | A tool for static C/C++ code analysis          | [*](http://cppcheck.sourceforge.net/)
**gcov/gcovr** | Code coverage                                  | [*](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html) [*](http://gcovr.com/)
**Travis CI**  | Continuous integration                         | [*](https://travis-ci.org/)
**Coveralls**  | Code coverage history and stats                | [*](https://coveralls.io/) [*](https://github.com/eddyxu/cpp-coveralls)

# Dependencies

From **[.travis.yml](.travis.yml)** (_Ubuntu_):  
```
sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -qq
sudo apt-get install -qq cmake doxygen g++-4.8 python-pip cppcheck valgrind ggcov
sudo pip install Pygments
sudo pip install gcovr
sudo pip install cpp-coveralls
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 90
sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 80
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

All the documentation and reports are automatically published to it with **Travis-CI**, using the **[publish to gh-pages](utils/publish_to_ghpages.sh)** script. The idea is that every project derived from this template can also have this format of auto-publishing stuff.

To achieve this, you must have an access token to your repository, so **Travis-CI** can push to the gh-pages branch. A nice tutorial can be found [here](http://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/) in steps 1 through 4.

# Notes

The Google Test framework was originally downloaded through SVN on every build, but I didn't want any internet connection dependency.  
Through [dmonopoly's project] I learned how to include it with my project (so thanks).

#License

See [LICENSE](LICENSE) file.

[Project Webpage]:https://caioicy.github.io/CPP_Project_Template/
[opatry's template]:https://github.com/opatry/CPP_Project_Template
[dmonopoly's project]:https://github.com/dmonopoly/gtest-cmake-example
