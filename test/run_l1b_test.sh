#!/bin/bash

usage () {
    echo "Usage:"
    echo "$0 <l1a_file_directory>"
    exit 1
}

l1a_in_dir=$1

if [ -z "$l1a_in_dir" ]; then
    usage
    exit 1
fi

# Source common variables
source $(dirname $0)/setup_env.sh $(dirname $0)

# Copy input L1A files from source directory
cp -av $l1a_in_dir/* $PGE_IN_DIR

cwl_path=$(realpath "$(dirname $0)"/../cwl)

if [ -z "$(which cwltool)" ]; then
    echo "cwltool was not found and required."
    exit 1
fi

cwltool \
    --outdir ${PGE_OUT_DIR} \
    ${cwl_path}/l1b_package.cwl \
    --input_dir ${PGE_IN_DIR} \
    |& tee ${PGE_OUT_DIR}/cwltool.log

echo "Output available at: $PGE_OUT_DIR"
