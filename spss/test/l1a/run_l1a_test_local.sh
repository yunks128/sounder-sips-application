#!/bin/bash

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
    -v ${PGE_IN_DIR}:/pge/in \
    -v ${PGE_OUT_DIR}:/pge/out \
    -v ${PGE_STATIC_DIR}:/tmp/static \
    unity-sds/sounder_sips_l1a_pge:${DOCKER_TAG} \
    $*
