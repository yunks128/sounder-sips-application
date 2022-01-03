#!/bin/bash
#
# wget https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz
# 
tar zxf $SOURCES_PATH/szip-2.1.1.tar.gz
cd szip-2.1.1
./configure --prefix=$INSTALL_PREFIX/szip-2.1.1 \
--enable-static --enable-shared \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
F77=$GCC_PATH/bin/gfortran \
FFLAGS="-O -fPIC -pthread -m64 -ffixed-line-length-132 -mcmodel=large \
	-fdec-structure -fdec -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/szip-2.1.1"
ls -l $INSTALL_PREFIX/szip-2.1.1
