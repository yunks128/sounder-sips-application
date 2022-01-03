#!/bin/bash
# https://github.com/Unidata/netcdf-fortran/releases
# https://github.com/Unidata/netcdf-fortran/releases/tag/v4.4.5
# wget https://github.com/Unidata/netcdf-fortran/archive/v4.4.5.tar.gz -O netcdf-fortran-4.4.5.tar.gz
#
# diff -u configure configure.new > netcdf-fortran-4.4.5.patch
#
# nm $INSTALL_PREFIX/netcdf-fortran-4.4.5/lib/libnetcdff.a | grep nf_def_grp
# 

tar zxf $SOURCES_PATH/netcdf-fortran-4.4.5.tar.gz
cd netcdf-fortran-4.4.5
patch < $SOURCES_PATH/netcdf-fortran-4.4.5.patch
./configure --prefix=$INSTALL_PREFIX/netcdf-fortran-4.4.5 \
CC="$GCC_PATH/bin/gcc" \
CXX="$GCC_PATH/bin/g++" \
CPP="$GCC_PATH/bin/g++ -E" \
CPPFLAGS=-I$INSTALL_PREFIX/netcdf-c-4.7.4/include \
FC="$GCC_PATH/bin/gfortran" 
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/netcdf-fortran-4.4.5"
ls -l $INSTALL_PREFIX/netcdf-fortran-4.4.5
