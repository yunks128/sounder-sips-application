#!/bin/bash
#
# https://sourceforge.net/projects/tinyxml/files/tinyxml/2.6.2/
#
mkdir -p $INSTALL_PREFIX/tinyxml-2.6.2/{include,lib,share,bin}
tar zxf $SOURCES_PATH/tinyxml-2.6.2.tar.gz
cd tinyxml-2.6.2
make -j $NUM_COMPILE_JOBS
ar cr libtinyxml.a *o
cp -a *.a $INSTALL_PREFIX/tinyxml-2.6.2/lib
cp -a *.h *.cpp $INSTALL_PREFIX/tinyxml-2.6.2/include
cp -a docs $INSTALL_PREFIX/tinyxml-2.6.2/share 
cp -a xmltest  $INSTALL_PREFIX/tinyxml-2.6.2/bin
echo
echo "$ ls -l $INSTALL_PREFIX/tinyxml-2.6.2/"
ls -l $INSTALL_PREFIX/tinyxml-2.6.2/
echo
