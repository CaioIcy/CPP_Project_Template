#!/bin/bash
set -o posix

##############################################################################
# These are needed for the C++ Project Template
sudo apt-get install -qq cmake doxygen g++-4.8 python-pip cppcheck valgrind ggcov
sudo pip install Pygments
sudo pip install gcovr
sudo pip install cpp-coveralls
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 90
sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 80
##############################################################################

##############################################################################
# Add your projects necessary "install" commands here
echo "Edit me!"
##############################################################################
