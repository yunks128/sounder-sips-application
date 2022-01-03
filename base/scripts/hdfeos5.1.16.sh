#!/bin/bash
#
# wget https://observer.gsfc.nasa.gov/ftp/edhs/hdfeos5/latest_release/HDF-EOS5.1.16.tar.Z 
# 
tar zxf $SOURCES_PATH/HDF-EOS5.1.16.tar.Z
mv hdfeos5 hdfeos5.1.16
cd hdfeos5.1.16
export LD_LIBRARY_PATH=$INSTALL_PREFIX/szip-2.1.1/lib
./configure --prefix="$INSTALL_PREFIX/hdfeos5.1.16" \
--libdir="$INSTALL_PREFIX/hdfeos5.1.16/lib/linux64" \
--with-hdf5=$INSTALL_PREFIX/hdf5-1.8.19 \
--with-zlib=$INSTALL_PREFIX/zlib-1.2.11 \
--with-szlib=$INSTALL_PREFIX/szip-2.1.1 \
--enable-install-include \
CC=$INSTALL_PREFIX/hdf5-1.8.19/bin/h5cc \
CFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
F77=$GCC_PATH/bin/gfortran \
FFLAGS="-m64 -fPIC -pthread -s -ffixed-line-length-132 -mcmodel=large -fdec-structure -fdec -mlarge-data-threshold=90000000 -fno-underscoring -fno-second-underscore" \
LDFLAGS="-m64 -pthread -fPIC -Wl,-Map,hdfeos5.1.16.map" 
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/hdfeos5.1.16"
ls -l $INSTALL_PREFIX/hdfeos5.1.16
