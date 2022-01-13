FROM centos:7

ENV BUILD_PATH /build

WORKDIR $BUILD_PATH

ENV SOURCES_PATH=$BUILD_PATH/sources
ENV SCRIPTS_PATH=$BUILD_PATH/scripts
ENV INSTALL_PREFIX=/opt/packages
ENV GCC_PATH=/opt/gcc/gcc-8.2.0
ENV NUM_COMPILE_JOBS=4

# Install development tools
RUN yum -y group install "Development Tools"

# Install additional base packages
RUN yum -y install python3 wget epel-release

# Copy files
COPY sources $SOURCES_PATH
COPY scripts $SCRIPTS_PATH

# Install custom version of GCC
RUN yum -y install gmp gmp-devel mpfr mpfr-devel libmpc libmpc-devel
RUN $SCRIPTS_PATH/gcc-8.2.0.sh

# Install zlib library
# https://zlib.net/

RUN $SCRIPTS_PATH/zlib-1.2.11.sh

# Install libjpeg 
# https://ijg.org/

RUN $SCRIPTS_PATH/jpeg-9b.sh

# Install szip library
# https://support.hdfgroup.org/ftp/lib-external/szip/

RUN $SCRIPTS_PATH/szip-2.1.1.sh
 
# Install HDF4 library
# https://support.hdfgroup.org/ftp/HDF/releases/HDF4.2.13/src/

RUN $SCRIPTS_PATH/hdf4-4.2.13.sh

# Install HDF5 library
# https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.16/src/

# Two different versions linked to in SPSS scripts
RUN $SCRIPTS_PATH/hdf5-1.8.16.sh
RUN $SCRIPTS_PATH/hdf5-1.8.19.sh

# Install HDFEOS2 library
# https://wiki.earthdata.nasa.gov/display/DAS/Toolkit+Downloads+with+HDFEOS+v3.0
# https://hdfeos.org/software/hdfeos.php

RUN yum install -y ksh

RUN $SCRIPTS_PATH/hdfeos2.20v1.00.sh

# Install HDFEOS5 library
# https://wiki.earthdata.nasa.gov/display/DAS/Toolkit+Downloads

RUN $SCRIPTS_PATH/hdfeos5.1.16.sh

# Install netcdf libraries
# https://github.com/Unidata/netcdf-c/releases
# https://github.com/Unidata/netcdf-fortran/eleases
# https://github.com/Unidata/netcdf-cxx4/releases

RUN yum install -y libcurl-devel

RUN $SCRIPTS_PATH/netcdf-c-4.7.4.sh
RUN $SCRIPTS_PATH/netcdf-fortran-4.4.5.sh
RUN $SCRIPTS_PATH/netcdf-cxx4-4.3.1.sh

# Install SDPTK5.2.20v1.01 library
# All of the above are dependencies of SDPTK5.2.20v1.01
# https://wiki.earthdata.nasa.gov/display/DAS/Toolkit+Downloads

RUN yum install -y csh 
RUN $SCRIPTS_PATH/sdptk5.2.20v1.01.sh

# Update leap seconds file. This file needs to be periodically updated
COPY ephemeris/leapsec.dat /opt/packages/sdptk5.2.20v1.01/TOOLKIT/database/common/TD/leapsec.dat

# Install cxxtest
# This simply has the package expanded into the destination directory
# https://sourceforge.net/projects/cxxtest/files/cxxtest/

RUN $SCRIPTS_PATH/cxxtest-4.4.sh

# Install xerces library
# https://archive.apache.org/dist/xerces/c/3/sources/

RUN $SCRIPTS_PATH/xerces-3.1.2.sh

# Install boost libraries
# https://www.boost.org/users/history/version_1_58_0.html

RUN $SCRIPTS_PATH/boost-1.58.sh

# Install TinyXML library
# http://www.grinninglizard.com/tinyxml/
# https://sourceforge.net/projects/tinyxml/files/tinyxml/2.6.2/

RUN $SCRIPTS_PATH/tinyxml-2.6.2.sh

# Install Coda library
# https://github.com/stcorp/coda/releases

RUN $SCRIPTS_PATH/coda-2.21.sh

# Install grib_api
# https://github.com/weathersource/grib_api
# https://src.fedoraproject.org/lookaside/pkgs/grib_api/grib_api-1.9.18.tar.gz/94c03e18f4e1e166048057929feb0d1a/

RUN $SCRIPTS_PATH/grib_api-1.9.18.sh

# Install JAsPer Project
# https://www.ece.uvic.ca/~frodo/jasper/#doc 

RUN $SCRIPTS_PATH/jasper-1.900.1.sh

# Install g2clib
# https://github.com/weathersource/g2clib/tags

RUN yum install -y libpng-devel libpng-static
RUN $SCRIPTS_PATH/g2clib-1.4.0.sh

# Install bufrlib
# https://github.com/NOAA-EMC/NCEPLIBS-bufr
# https://github.com/JCSDA-internal/bufrlib/releases

RUN $SCRIPTS_PATH/bufrlib-11.3.0.sh

# Install LAPACK
# http://www.netlib.org/lapack/
# https://src.fedoraproject.org/lookaside/extras/lapack/lapack-3.5.0.tgz/e7ba742120bd75339ac4c6fbdd8bce92/

RUN yum install -y cmake
RUN $SCRIPTS_PATH/lapack-3.5.0.sh

# Install Blitz
# https://github.com/blitzpp/blitz
# https://src.fedoraproject.org/lookaside/pkgs/blitz/blitz-1.0.1.tar.gz/sha512/e217e016a651cc1b0fa5e625663a8ac8f96b1abbe03db92246b967f79b2285ee974e9090deecad05c2c559a30dbddfcc86dca6eb373cc47346810f35cffba265/

RUN $SCRIPTS_PATH/blitz-1.0.1.sh

# Install libtiff
# http://www.simplesystems.org/libtiff/
# http://download.osgeo.org/libtiff/

RUN $SCRIPTS_PATH/tiff-4.0.6.sh

# Install PROJ.4
# https://download.osgeo.org/proj/proj-4.8.0.tar.gz

RUN $SCRIPTS_PATH/proj-4.8.0.sh

# Install libgeotiff
# https://github.com/OSGeo/libgeotiff 
# https://download.osgeo.org/geotiff/libgeotiff/

RUN $SCRIPTS_PATH/libgeotiff-1.4.0.sh
