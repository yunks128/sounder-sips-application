#!/bin/bash
#
# wget https://observer.gsfc.nasa.gov/ftp/edhs/hdfeos/latest_release/HDF-EOS2.20v1.00.tar.Z
# 
tar zxf $SOURCES_PATH/HDF-EOS2.20v1.00.tar.Z
mv hdfeos hdfeos2.20v1.00
cd hdfeos2.20v1.00
export LD_LIBRARY_PATH=$INSTALL_PREFIX/jpeg-9b/lib:$INSTALL_PREFIX/szip-2.1.1/lib
./configure --prefix="$INSTALL_PREFIX/hdfeos2.20v1.00" \
--libdir=$INSTALL_PREFIX/hdfeos2.20v1.00/lib/linux64 \
--with-jpeg=$INSTALL_PREFIX/jpeg-9b \
--with-zlib=$INSTALL_PREFIX/zlib-1.2.11 \
--with-szlib=$INSTALL_PREFIX/szip-2.1.1 \
--with-hdf4=$INSTALL_PREFIX/hdf4-4.2.13 \
--enable-install-include \
--with-pic \
CC="$INSTALL_PREFIX/hdf4-4.2.13/bin/h4cc" \
CFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
CXX="$GCC_PATH/bin/g++" \
CXXFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable -Wmissing-prototypes Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000" \
F77="$GCC_PATH/bin/gfortran" \
FFLAGS="-m64 -fPIC -pthread -s -ffixed-line-length-132 -mcmodel=large -fdec-structure -fdec -mlarge-data-threshold=90000000" \
LDFLAGS="-m64 -pthread -fPIC -Wl,-Map,hdf-eos2-20v1.00.map" 
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls $INSTALL_PREFIX/hdfeos2.20v1.00"
ls $INSTALL_PREFIX/hdfeos2.20v1.00
