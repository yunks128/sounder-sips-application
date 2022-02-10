#!/bin/sh

# Map subdirectories of the scripts' directory as in and out paths
in_dir=$(readlink -f $(dirname $0)/in)
out_dir=$(readlink -f $(dirname $0)/out)

# Include variables from .env file so we have $DOCKER_TAG available
env_file=$(readlink -f $(dirname $0)/../../../.env)
. $env_file

# Find static files location
lcl_static_dir=$(readlink -f $(dirname $0)/../../../static)
if [ ! -z "$SIPS_STATIC_DIR" ]; then
    static_dir=$SIPS_STATIC_DIR
elif [ -e "$lcl_static_dir" ]; then
    static_dir=$lcl_static_dir
else
    echo "Could not find static files directory from either a \$SIPS_STATIC_DIR environment variable or at the path: $lcl_static_dir"
    exit 1
fi

# Copy input files from SPSS repo
acc_case_in_dir=$(readlink -f $(dirname $0)/../../src/src/sips_pge/l1a_atms_snpp/acctest/spdc_nominal2/in/)

# Copy the input files referenced by the test XML file1
for src_fn in $acc_case_in_dir/atms_science $acc_case_in_dir/ephatt; do
    dest_fn=${in_dir}/$(basename $src_fn)
    if [ ! -e "$dest_fn" ]; then
        cp -a $src_fn $dest_fn
    fi
done

docker run --rm \
    -v ${in_dir}:/pge/in \
    -v ${out_dir}:/pge/out \
    -v ${static_dir}/dem:/peate/support/static/dem \
    -v ${static_dir}/mcf:/ref/devstable/STORE/mcf \
    unity-sds/sounder_sips_l1a_pge:${DOCKER_TAG} \
    /pge/bin/l1amw_run.py /pge/in/SNDR.SNPP.ATMS.L1A.nominal2.config_201214135000.xml /pge/out/SNDR.SNPP.ATMS.L1A.nominal2.log_201214135000.txt
