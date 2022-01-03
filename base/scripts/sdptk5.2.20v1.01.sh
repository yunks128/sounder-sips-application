#!/bin/bash
#
# wget https://observer.gsfc.nasa.gov/ftp/edhs/sdptk/latest_release/SDPTK5.2.20v1.01.tar.Z
#
# see sdptk5.2.20v1.01.txt
# fix PGSHOME in $INSTALL_PREFIX/sdptk5.2.20v1.01/TOOLKIT/bin/linux/pgs-env.csh
# confirm with nm $INSTALL_PREFIX/sdptk5.2.20v1.01/TOOLKIT/lib/linux64/libPGSTK.a | grep PGS_EPH_getToken
#
mkdir -p $INSTALL_PREFIX/sdptk5.2.20v1.01/TOOLKIT
tar zxf $SOURCES_PATH/SDPTK5.2.20v1.01.tar.Z
cd TOOLKIT
./bin/INSTALL \
-pgshome "$INSTALL_PREFIX/sdptk5.2.20v1.01/TOOLKIT" \
-log sdptk.log \
-hdfhome "$INSTALL_PREFIX/hdf4-4.2.13" \
-hdf5home "$INSTALL_PREFIX/hdf5-1.8.19" \
-hdfeos_home "$INSTALL_PREFIX/hdfeos2.20v1.00" \
-hdfeos5_home "$INSTALL_PREFIX/hdfeos5.1.16" \
-netcdfhome "$INSTALL_PREFIX/netcdf-c-4.7.4" \
-fc_path "$GCC_PATH/bin/gfortran" \
-cc_path "$GCC_PATH/bin/gcc" \
-cpp_path "$GCC_PATH/bin/g++" \
-cc_flags "-m64 -fPIC -pthread -s -m128bit-long-double -mcmodel=large -mlarge-data-threshold=90000000 -I$INSTALL_PREFIX/zlib-1.2.11/include" \
-cpp_flags "-m64 -fPIC -pthread -s -m128bit-long-double -mcmodel=large -mlarge-data-threshold=90000000 -I$INSTALL_PREFIX/zlib-1.2.11/include" \
-fc_flags "-ff2c -m64 -fPIC -pthread -s -m128bit-long-double -fdec-structure -fdec -mcmodel=large -mlarge-data-threshold=90000000" \
-c_rlib < $SCRIPTS_PATH/sdptk5.2.20v1.01.txt
cd ..
cp -a TOOLKIT $INSTALL_PREFIX/sdptk5.2.20v1.01
