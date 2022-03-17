#!/bin/bash

temp_dir=$(mktemp -d)

echo "Outputting files to temporary dir: $temp_dir"

export PGE_IN_DIR=${temp_dir}/in
export PGE_OUT_DIR=${temp_dir}/out

mkdir -p $PGE_IN_DIR
mkdir -p $PGE_OUT_DIR

# Source common variables
source $(dirname $0)/../common/setup_env.sh $(dirname $0)

# Copy input files from SPSS repo
acc_case_in_dir=$($READLINK_BIN -f $(dirname $0)/../../src/src/sips_pge/l1a_atms_snpp/acctest/spdc_nominal2/in/)

# Copy the input files referenced by the test XML file1
for src_fn in $acc_case_in_dir/atms_science $acc_case_in_dir/ephatt; do
    dest_fn=${PGE_IN_DIR}/$(basename $src_fn)
    if [ ! -e "$dest_fn" ]; then
        cp -a $src_fn $dest_fn
    fi
done

docker run --rm \
    -v ${PGE_IN_DIR}:${PGE_IN_DIR} \
    -v ${PGE_OUT_DIR}:${PGE_OUT_DIR} \
    -v ${PGE_STATIC_DIR}:${temp_dir}/static \
    unity-sds/sounder_sips_l1a_pge:${DOCKER_TAG} \
    -p input_path ${PGE_IN_DIR} \
    -p output_path ${PGE_OUT_DIR} \
    -p data_static_path ${temp_dir}/static $
    $*

echo "Results available in temporary dir: $temp_dir"
