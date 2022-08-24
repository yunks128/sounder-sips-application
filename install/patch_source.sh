#!/bin/bash

# Modify build to point to correct libpng

usage () {
    echo "Usage:"
    echo "$0 <source_code_directory>"
    exit 1
}

src_dir=$1

if [ -z "$src_dir" ]; then
    usage
fi

modified_file="$src_dir/src/make/config.centos7.mk"
bak_file="${modified_file}.orig"

if [ ! -e "$bak_file" ]; then
    cp -v $modified_file $bak_file
fi

sed -i \
    -e '/PNG_HOME/s|$(LINUX_USER_LIBS_HOME)/lib64|/usr/lib/x86_64-linux-gnu|' \
    -e 's/libpng15.a/libpng16.a/' \
    $modified_file
    
# The || true here prevents exiting with a non-zero exit code
diff -u $bak_file $modified_file || true
