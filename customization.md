# Using this template for your project
---

Here I will explain what needs to be changed, and what needs to stay the same in case you want to use this template for a project of your own.  
If there is any doubt, or any problems please open an **issue**.

#### Project directory structure
```
├──  cmake {All the modularized CMake files}
│    ├── input {Everything CMake will use as a template or place somewhere else}
│    └── modules {The CMake modules directory [CMAKE_MODULE_PATH]}
├── externals {The external libraries and projects you will use}
├── src {All the headers (.h) and source code (.cpp)}
├── test {All the test source code}
└── utils {Everything else}
    └── travis {Scripts that Travis-CI will use}
```

#### What should be changed
In the [.travis.yml](.travis.yml) file, modify these variables:
-   **secure** ~ the encrypted personal access token of your repo
-   **GH_USR** ~ your GitHub username
-   **GH_REF** ~ the GitHub link to your project (_github.com/username/project.git_)
-   **T_NAME_PROJECT** ~ the name of your project (no spaces)
-   **T_DO_PUBLISH_GH_COV** ~ whether you want TravisCI to publish things or not (_Yes/No_)

In the [src/](src/) directory, erase all the example code (_Widget/Feature_). Be sure to keep **CMakeLists.txt**.  
In the [test/](test/) directory, erase all the example code. Be sure to keep **CMakeLists.txt**. Here there is no need for a main, just the gtest tests.

#### What should stay the same

The source code extensions must all be either **.h** or **.cpp**.  
In your project, _main.cpp_ **needs** to be directly inside [src/](src/) and not in any subfolder, even though other source files can be separated in folders.

#### Options

**CMake** options are in [options.cmake](cmake/options.cmake). These are passed through the _cmake_ command, issued through the [build script](build.sh).  
**CPack** configurations are in [cpack.cmake](cmake/cpack.cmake).  
All the compiler flags can be found in [cpp.cmake](cmake/cpp.cmake). Do not alter _FLAGS_MY_PROJECT_ and _FLAGS_GCOV_ unless you know what you're doing.  
And pretty much anything else you are capable of changing, so enjoy.
