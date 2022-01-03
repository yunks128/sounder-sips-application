#!/bin/bash
#
# https://www.unidata.ucar.edu/downloads/netcdf/
# https://github.com/Unidata/netcdf-c/releases
# https://github.com/Unidata/netcdf-c/releases/tag/v4.7.4
# wget https://github.com/Unidata/netcdf-c/archive/v4.7.4.tar.gz -O netcdf-c-4.7.4.tar.gz
#
tar zxf $SOURCES_PATH/netcdf-c-4.7.4.tar.gz
cd netcdf-c-4.7.4
./configure --prefix="$INSTALL_PREFIX/netcdf-c-4.7.4" \
--disable-dap --enable-netcdf-4 --enable-shared \
--with-pic \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable \
	-Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000 \
    -I$INSTALL_PREFIX/hdf5-1.8.16/include" \
CXX=$GCC_PATH/bin/g++ \
CXXFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable \
	-Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000 \
    -I$INSTALL_PREFIX/hdf5-1.8.16/include" \
CPP="$GCC_PATH/bin/g++ -E" \
CPPFLAGS="-I$INSTALL_PREFIX/zlib-1.2.11/include -I$INSTALL_PREFIX/hdf5-1.8.16/include" \
LDFLAGS="-m64 -pthread -fPIC -Wl,-Map,netcdf-4.4.1.map \
    -L$INSTALL_PREFIX/hdf5-1.8.16/lib \
    -L$INSTALL_PREFIX/zlib-1.2.11/lib"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/netcdf-c-4.7.4"
ls -l $INSTALL_PREFIX/netcdf-c-4.7.4
