#!/bin/bash
# 
# wget http://www.netlib.org/lapack/lapack-3.5.0.tgz
# 
tar zxf $SOURCES_PATH/lapack-3.5.0.tgz
cd lapack-3.5.0
export CC=$GCC_PATH/bin/gcc
export CXX=$GCC_PATH/bin/g++
export FC=$GCC_PATH/bin/gfortran
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX/lapack-3.5.0 \
-DCMAKE_Fortran_FLAGS=-mcmodel=large
make -j $NUM_COMPILE_JOBS 
make install
echo
echo "$ ls -l $INSTALL_PREFIX/lapack-3.5.0"
ls -l $INSTALL_PREFIX/lapack-3.5.0
echo
