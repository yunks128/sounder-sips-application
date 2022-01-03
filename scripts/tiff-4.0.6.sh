#!/bin/bash
#
# http://www.linuxfromscratch.org/blfs/view/7.10/general/libtiff.html
# 
tar zxf $SOURCES_PATH/tiff-4.0.6.tar.gz
cd tiff-4.0.6
sed -i "/seems to be moved/s/^/#/" config/ltmain.sh 
./configure --prefix=$INSTALL_PREFIX/tiff-4.0.6 \
--enable-static --enable-shared \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "ls -l $INSTALL_PREFIX/tiff-4.0.6"
ls -l $INSTALL_PREFIX/tiff-4.0.6
echo
