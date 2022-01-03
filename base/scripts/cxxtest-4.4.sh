#!/bin/bash
#
# wget https://github.com/CxxTest/cxxtest/releases/download/4.4/cxxtest-4.4.tar.gz
# 

mkdir -p $INSTALL_PREFIX/cxxtest-4.4
tar zxf $SOURCES_PATH/cxxtest-4.4.tar.gz
cd cxxtest-4.4
cp -a * $INSTALL_PREFIX/cxxtest-4.4
echo
echo "$ ls -l $INSTALL_PREFIX/cxxtest-4.4"
ls -l $INSTALL_PREFIX/cxxtest-4.4
echo
