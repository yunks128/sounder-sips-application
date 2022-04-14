#!/bin/bash

# Source common variables
source $(dirname $0)/common/setup_env.sh $(dirname $0)

# Copy input L0 files from SPSS source tree
. $(dirname $0)/common/copy_l1a_input.sh

cwl_path=$(realpath "$(dirname $0)"/../cwl)

if [ -z "$(which cwltool)" ]; then
    echo "cwltool was not found and required."
    exit 1
fi

cwltool \
    --outdir ${PGE_OUT_DIR} \
    ${cwl_path}/l1a_package.cwl \
    --input_dir ${PGE_IN_DIR} \
    --static_dir ${PGE_STATIC_DIR} \
    --start_datetime $(grep start_datetime ${cwl_path}/l1a_package.yml | awk '{print $2}' | sed 's/\"//g') \
    --end_datetime $(grep end_datetime ${cwl_path}/l1a_package.yml | awk '{print $2}' | sed 's/\"//g') \
    $* |& tee ${PGE_OUT_DIR}/cwltool.log

echo "Output available at: $PGE_OUT_DIR"
