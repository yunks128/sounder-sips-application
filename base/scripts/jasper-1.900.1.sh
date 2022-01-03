#!/bin/bash
#
# http://www.linuxfromscratch.org/blfs/view/7.10/general/jasper.html
# wget http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-1.900.1.zip
# http://www.linuxfromscratch.org/patches/blfs/7.10/jasper-1.900.1-security_fixes-2.patch
#
unzip -q $SOURCES_PATH/jasper-1.900.1.zip
chmod 755 jasper-1.900.1
cd jasper-1.900.1
patch -Np1 -i $SOURCES_PATH/jasper-1.900.1-security_fixes-2.patch
./configure --prefix=$INSTALL_PREFIX/jasper-1.900.1    \
            --enable-shared  \
            --enable-static \
            --mandir=$INSTALL_PREFIX/jasper-1.900.1/share/man \
CC=$GCC_PATH/bin/gcc \
CFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000"
make -j $NUM_COMPILE_JOBS
make install
echo
echo "$ ls -l $INSTALL_PREFIX/jasper-1.900.1"
ls -l $INSTALL_PREFIX/jasper-1.900.1
echo
