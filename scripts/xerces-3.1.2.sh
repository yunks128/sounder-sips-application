#!/bin/bash
#
# wget https://archive.apache.org/dist/xerces/c/3/sources/xerces-c-3.1.2.tar.gz
# 
tar zxf $SOURCES_PATH/xerces-c-3.1.2.tar.gz
cd xerces-c-3.1.2
./configure --prefix=$INSTALL_PREFIX/xerces-3.1.2 \
--enable-static --enable-shared \
--without-icu \
--disable-network \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
F77=$GCC_PATH/bin/gfortran \
FFLAGS="-O -fPIC -pthread -m64 -ffixed-line-length-132 -mcmodel=large \
	-fdec-structure -fdec -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/xerces-3.1.2"
ls -l $INSTALL_PREFIX/xerces-3.1.2
echo
