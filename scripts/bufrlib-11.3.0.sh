#!/bin/bash
# 
# wget https://www.emc.ncep.noaa.gov/BUFRLIB/docs/BUFRLIB_v11-3-0.tar
#
mkdir bufrlib-11.3.0
tar zxf $SOURCES_PATH/BUFRLIB_v11-3-0.tar.gz -C bufrlib-11.3.0
cd bufrlib-11.3.0
patch getdefflags_F.sh $SOURCES_PATH/bufrlib-11.3.0.patch
CC=$GCC_PATH/bin/gcc
FC=$GCC_PATH/bin/gfortran
AR=/usr/bin/ar
BUFRLIB=bufrlib-11.3.0.a
$CC -c -DUNDERSCORE `./getdefflags_C.sh` *.c
$FC -c `./getdefflags_F.sh` modv*.F moda*.F `ls -1 *.F *.f | grep -v "mod[av]_"`
$AR cr $BUFRLIB *.o
mkdir -p $INSTALL_PREFIX/bufrlib-11.3.0/lib
cp $BUFRLIB $INSTALL_PREFIX/bufrlib-11.3.0/lib
ln -s $INSTALL_PREFIX/bufrlib-11.3.0/lib/$BUFRLIB $INSTALL_PREFIX/bufrlib-11.3.0/lib/libbufr.a
echo
echo "ls -l $INSTALL_PREFIX/bufrlib-11.3.0/lib"
ls -l $INSTALL_PREFIX/bufrlib-11.3.0/lib
echo
