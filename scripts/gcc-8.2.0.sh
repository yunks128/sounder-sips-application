#!/bin/bash
tar zxf $SOURCES_PATH/gcc-8.2.0.tar.gz
cd gcc-8.2.0
./configure \
    --enable-languages=c,c++,fortran \
    --disable-multilib \
    --prefix=$GCC_PATH
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $GCC_PATH"
ls -l $GCC_PATH
