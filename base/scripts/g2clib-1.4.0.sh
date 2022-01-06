#!/bin/bash
#
# https://centos.pkgs.org/7/epel-x86_64/g2clib-devel-1.4.0-9.el7.x86_64.rpm.html
#
tar zxvf $SOURCES_PATH/g2clib-1.4.0.tar.gz
cd g2clib-1.4.0/src

# Remove makefile line that removes object files or else some 
# source code files will not be included in library
sed -i '/rm -f/d' makefile

export CC=$GCC_PATH/bin/gcc \
export CFLAGS="-m64 -fPIC -pthread -mcmodel=large -Wall -Wno-unused-variable \
        -DUSE_PNG -DUSE_JPEG2000 \
        -Wmissing-prototypes -Wmissing-declarations -m128bit-long-double -mlarge-data-threshold=90000000 \
        -I$INSTALL_PREFIX/jasper-1.900.1/include"
make CFLAGS="$CFLAGS" CC="$CC"
PREFIX=$INSTALL_PREFIX/g2clib-1.4.0
mkdir -p $PREFIX/{lib,include}
install -p -m0644 libgrib2c.a $PREFIX/lib
install -p -m0644 *.h $PREFIX/include
echo
echo "$ ls -l $INSTALL_PREFIX/g2clib-1.4.0"
ls -l $INSTALL_PREFIX/g2clib-1.4.0
echo
