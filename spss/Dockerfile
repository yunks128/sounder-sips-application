FROM unity-sds/sounder_sips_base:r0.1.0

ENV BUILD_PATH /build

WORKDIR $BUILD_PATH

# Some of the SPSS algorithms rely upon the system boost instead of the one in /opt/packages
RUN yum install -y boost-devel python36-netcdf4

COPY src/ /build/spss

RUN cd /build/spss/make && make -j 10 
