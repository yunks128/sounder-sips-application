#!/bin/bash
#
# wget https://download.osgeo.org/proj/proj-4.8.0.tar.gz
# 
tar zxf $SOURCES_PATH/proj-4.8.0.tar.gz
cd proj-4.8.0
./configure --prefix=$INSTALL_PREFIX/proj-4.8.0
make
make install
echo
echo "$ ls -l $INSTALL_PREFIX/proj-4.8.0"
ls -l $INSTALL_PREFIX/proj-4.8.0
