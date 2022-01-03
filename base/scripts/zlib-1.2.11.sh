#!/bin/bash
#
# wget https://www.zlib.net/fossils/zlib-1.2.11.tar.gz
#
tar zxf $SOURCES_PATH/zlib-1.2.11.tar.gz
cd zlib-1.2.11
CC="/opt/gcc/gcc-8.2.0/bin/gcc" \
CFLAGS="-m64 -fPIC -pthread -s -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000"
./configure --prefix=$INSTALL_PREFIX/zlib-1.2.11 \
-64
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/zlib-1.2.11"
ls -l $INSTALL_PREFIX/zlib-1.2.11
