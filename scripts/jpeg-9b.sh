#!/bin/bash
#
# wget http://www.ijg.org/files/jpegsrc.v9b.tar.gz
# 
tar zxf $SOURCES_PATH/jpegsrc.v9b.tar.gz
cd jpeg-9b
./configure --prefix=$INSTALL_PREFIX/jpeg-9b \
--enable-static --enable-shared \
CC=$GCC_PATH/bin/gcc \
FLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/jpeg-9b"
ls -l $INSTALL_PREFIX/jpeg-9b
