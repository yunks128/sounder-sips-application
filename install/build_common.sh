#!/bin/bash

# Parallel build can cause the build to failr
export NUM_COMPILE_JOBS=1

usage () {
    echo "Usage:"
    echo "$0 <source_code_directory>"
    exit 1
}

src_dir=$1

if [ -z "$src_dir" ]; then
    usage
fi

# PGE common directories
cd $src_dir/src/common/make && make -j $NUM_COMPILE_JOBS
cd $src_dir/src/shared_io/make && make -j $NUM_COMPILE_JOBS
cd $src_dir/src/shared_alg/make && make -j $NUM_COMPILE_JOBS
cd $src_dir/src/pge_wrapper/make && make -j $NUM_COMPILE_JOBS

# MetExtractor compilation
cd $src_dir/src/scf_shared/make && make -j $NUM_COMPILE_JOBS
cd $src_dir/src/scf_pge/make && make -j $NUM_COMPILE_JOBS
cd $src_dir/src/scf_metextractors/make && make -j $NUM_COMPILE_JOBS
