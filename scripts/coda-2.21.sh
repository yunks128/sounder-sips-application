#!/bin/bash
#
# https://github.com/stcorp/coda/releases/tag/2.21
# 
# 2020.02.20
# Apply patch on idl86 per Albert Chang
# diff /opt/idl/idl86/external/include/idl_export.h.orig /opt/idl/idl86/external/include/idl_export.h > idl86_idl_export.h.patch
# 
tar zxf $SOURCES_PATH/coda-2.21.tar.gz
cd coda-2.21 
patch libcoda/zlib/coda_zlib_mangle.h $SOURCES_PATH/coda_zlib_mangle.h.patch
./configure --prefix=$INSTALL_PREFIX/coda-2.21 \
--enable-shared \
--enable-static \
CC=$GCC_PATH/bin/gcc \
F77=$GCC_PATH/bin/gfortran
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/coda-2.21"
ls -l $INSTALL_PREFIX/coda-2.21
echo 

