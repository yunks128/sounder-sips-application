#!/bin/bash
#
# https://download.osgeo.org/geotiff/libgeotiff/
#
tar zxf $SOURCES_PATH/libgeotiff-1.4.0.tar.gz
cd libgeotiff-1.4.0 
./configure --prefix=$INSTALL_PREFIX/libgeotiff-1.4.0 \
--with-proj=$INSTALL_PREFIX/proj-4.8.0 \
--with-libtiff=$INSTALL_PREFIX/tiff-4.0.6 \
--with-jpeg \
--with-zip \
--enable-static --enable-shared \
CC=$GCC_PATH/bin/gcc \
FLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/libgeotiff-1.4.0"
ls -l $INSTALL_PREFIX/libgeotiff-1.4.0
echo
