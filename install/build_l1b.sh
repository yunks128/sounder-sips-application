#!/bin/bash

# Parallel build can cause the build to failr
export NUM_COMPILE_JOBS=1

usage () {
    echo "Usage:"
    echo "$0 <source_code_directory> [<destination_binary_directory>]"
    exit 1
}

src_dir=$1
dst_dir=$2

if [ -z "$src_dir" ]; then
    usage
fi

cd $src_dir/src/sips_pge/l1b_atms/make && make -j $NUM_COMPILE_JOBS

if [ ! -z "$dst_dir" ]; then
    mkdir -p $dst_dir
    cp $src_dir/src/sips_pge/l1b_atms/main/bin/L1BMw_main $dst_dir
    cp $src_dir/src/scf_metextractors/main/bin/MetExtractor $dst_dir
fi