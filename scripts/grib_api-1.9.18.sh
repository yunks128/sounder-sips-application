#!/bin/bash
#
# wget https://confluence.ecmwf.int/download/attachments/3473437/grib_api-1.9.18.tar.gz?api=v2
#
tar zxf $SOURCES_PATH/grib_api-1.9.18.tar.gz
cd grib_api-1.9.18
./configure --prefix=$INSTALL_PREFIX/grib_api-1.9.18 \
--enable-static \
--enable-shared \
--disable-jpeg \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
F77=$GCC_PATH/bin/gfortran \
FFLAGS="-O -fPIC -pthread -m64 -ffixed-line-length-132 -mcmodel=large \
	-fdec-structure -fdec -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/grib_api-1.9.18"
ls -l $INSTALL_PREFIX/grib_api-1.9.18
echo
