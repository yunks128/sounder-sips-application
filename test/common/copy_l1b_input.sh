# Copy input files from SPSS repo
acc_case_in_dir=$(realpath $(dirname $0)/../src/src/sips_pge/l1b_atms_snpp/acctest/in/l1a/)

# Copy the input files referenced by the test XML file
for src_fn in $acc_case_in_dir/*.nc; do
    dest_fn=${PGE_IN_DIR}/$(basename $src_fn)
    if [ ! -e "$dest_fn" ]; then
        cp -a $src_fn $dest_fn
    fi
done
