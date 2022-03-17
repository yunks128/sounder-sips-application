#!/bin/bash

# Source common variables
source $(dirname $0)/common/setup_env.sh $(dirname $0)

# Copy input L1A files from SPSS source tree
. $(dirname $0)/common/copy_l1b_input.sh

docker run --rm \
    -v ${PGE_IN_DIR}:${PGE_IN_DIR} \
    -v ${PGE_OUT_DIR}:${PGE_OUT_DIR} \
    -v ${PGE_STATIC_DIR}:${temp_dir}/static \
    unity-sds/sounder_sips_l1b_pge:${DOCKER_TAG} \
    -p input_path ${PGE_IN_DIR} \
    -p output_path ${PGE_OUT_DIR} \
    -p data_static_path ${temp_dir}/static $
    $*

echo "Output available at: $PGE_OUT_DIR"
