#!/bin/bash
set -o posix

##############################################################################
# These are needed for the C++ Project Template
sudo add-apt-repository --yes ppa:ubuntu-toolchain-r/test # g++-4.8
sudo add-apt-repository --yes ppa:kubuntu-ppa/backports   # cmake over 2.8.7
##############################################################################

##############################################################################
# Add your projects necessary "before_install" commands here
echo "Edit me!"
##############################################################################

##############################################################################
# This is needed for the C++ Project Template
sudo apt-get update -qq
##############################################################################
