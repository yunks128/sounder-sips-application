#!/bin/bash

usage () {
    echo "Usage:"
    echo "$0 <l0_file_directory>"
    exit 1
}

l0_in_dir=$1

if [ -z "$l0_in_dir" ]; then
    usage
    exit 1
fi

# Source common variables
source $(dirname $0)/setup_env.sh $(dirname $0)

# Copy input L0 files from source directory
cp -av $l0_in_dir/* $PGE_IN_DIR

cwl_path=$(realpath "$(dirname $0)"/../cwl)

if [ -z "$(which cwltool)" ]; then
    echo "cwltool was not found and required."
    exit 1
fi

cwltool \
    --outdir ${PGE_OUT_DIR} \
    ${cwl_path}/l1a_package.cwl \
    --input_ephatt_dir ${PGE_IN_DIR}/ephatt \
    --input_science_dir ${PGE_IN_DIR}/atms_science \
    --static_dir ${PGE_STATIC_DIR} \
    --start_datetime $(grep start_datetime ${cwl_path}/l1a_package.yml | awk '{print $2}' | sed 's/\"//g') \
    --end_datetime $(grep end_datetime ${cwl_path}/l1a_package.yml | awk '{print $2}' | sed 's/\"//g') \
    |& tee ${PGE_OUT_DIR}/cwltool.log

echo "Output available at: $PGE_OUT_DIR"
