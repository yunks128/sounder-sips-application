#!/bin/bash
# https://www.unidata.ucar.edu/downloads/netcdf/
# https://github.com/Unidata/netcdf-cxx4/releases
# https://github.com/Unidata/netcdf-cxx4/releases/tag/v4.3.1
# wget https://github.com/Unidata/netcdf-cxx4/archive/v4.3.1.tar.gz -O netcdf-cxx4-4.3.1.tar.gz

tar zxf $SOURCES_PATH/netcdf-cxx4-4.3.1.tar.gz
cd netcdf-cxx4-4.3.1
LD_LIBRARY_PATH="$INSTALL_PREFIX/netcdf-c-4.7.4/lib"
./configure --prefix=$INSTALL_PREFIX/netcdf-cxx4-4.3.1 \
CC="$GCC_PATH/bin/gcc" \
CCFLAGS=-I$INSTALL_PREFIX/netcdf-c-4.7.4/include \
CXX="$GCC_PATH/bin/g++" \
CXXFLAGS=-I$INSTALL_PREFIX/netcdf-c-4.7.4/include \
CPP="$GCC_PATH/bin/g++ -E" \
CPPFLAGS="-I$INSTALL_PREFIX/netcdf-c-4.7.4/include -I$INSTALL_PREFIX/hdf5-1.8.16/include" \
LDFLAGS="-L/$INSTALL_PREFIX/netcdf-c-4.7.4/lib -L$INSTALL_PREFIX/hdf5-1.8.16/lib"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/netcdf-cxx4-4.3.1"
ls -l $INSTALL_PREFIX/netcdf-cxx4-4.3.1
