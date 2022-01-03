#!/bin/bash
#
# wget https://github.com/blitzpp/blitz/archive/1.0.1.tar.gz -O blitz-1.0.1.tar.gz
# https://src.fedoraproject.org/rpms/blitz/blob/master/f/blitz.spec
# 
tar zxf $SOURCES_PATH/blitz-1.0.1.tar.gz
cd blitz-1.0.1
patch -p1 <$SOURCES_PATH/blitz-python2.patch
./configure --prefix=$INSTALL_PREFIX/blitz-1.0.1 \
--enable-shared \
--enable-static \
--disable-cxx-flags-preset \
--enable-64bit 
--enable-fortran \
--disable-fortran-flags-preset \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
F77=$GCC_PATH/bin/gfortran \
FFLAGS="-O -fPIC -pthread -m64 -ffixed-line-length-132 -mcmodel=large \
	-fdec-structure -fdec -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/blitz-1.0.1"
ls -l $INSTALL_PREFIX/blitz-1.0.1
echo 
