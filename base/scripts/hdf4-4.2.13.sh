#!/bin/bash
#
# wget https://support.hdfgroup.org/ftp/HDF/releases/HDF4.2.13/src/hdf-4.2.13.tar.gz
# confirm: nm $INSTALL_PREFIX/hdf4-4.2.13/lib/libmfhdf.a | grep NC_check_id
#
tar zxf $SOURCES_PATH/hdf-4.2.13.tar.gz
cd hdf-4.2.13
./configure --prefix=$INSTALL_PREFIX/hdf4-4.2.13 \
--with-zlib=$INSTALL_PREFIX/zlib-1.2.11 \
--with-szlib=$INSTALL_PREFIX/szip-2.1.1 \
--enable-netcdf=no  \
CC="$GCC_PATH/bin/gcc" \
CFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
LDFLAGS="-m64 -pthread -fPIC -Wl,-Map,hdf-4.2.13.map" \
F77="$GCC_PATH/bin/gfortran" \
FFLAGS="-m64 -s -fPIC -pthread -ffixed-line-length-132 -mcmodel=large -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/hdf4-4.2.13"
ls -l $INSTALL_PREFIX/hdf4-4.2.13
