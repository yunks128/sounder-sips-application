#!/bin/bash
#
# https://sourceforge.net/projects/boost/files/boost/1.58.0/
# WARNING: this will take more than 10 mins to build 
# 
tar zxf $SOURCES_PATH/boost_1_58_0.tar.gz
cd boost_1_58_0
./bootstrap.sh --prefix=$INSTALL_PREFIX/boost-1.58
./b2 install
echo
echo "$ ls -l $INSTALL_PREFIX/boost-1.58"
ls -l $INSTALL_PREFIX/boost-1.58
echo 
