#!/bin/bash

set -e

DEFAULT_STATIC_FILES_DIR="/unity/ads/sounder_sips/static_files/"

usage () {
    echo "Usage:"
    echo "$0 <source_code_directory> <static_config_directory> [<static_data_directory>]"
    exit 1
}

script_dir=$(dirname $0)

src_dir=$1
dst_dir=$2
static_dir=$3

if [ -z "$src_dir" ]; then
    usage
fi

if [ -z "$dst_dir" ]; then
    usage
fi

if [ ! -e "$dst_dir" ]; then
    mkdir -p $dst_dir
fi

if [ -z "$static_dir" ]; then
    static_dir=$DEFAULT_STATIC_FILES_DIR
fi

# Copy files from acceptance test directories, these are referenced by the input XML file
cp $src_dir/pcf/SNDR.PGSToolkit_ProcessControlFile.pcf $dst_dir
cp $src_dir/src/sips_pge/l1b_atms_snpp/acctest/in/SNDR.SNPP.L1bMw.sfif.acctest.xml $dst_dir
cp $src_dir/src/sips_pge/l1b_atms_snpp/acctest/in/SNDR.SchemaParameterfile.060401120000.xsd $dst_dir

# Modify SFIF file to point to destination paths
sed -i 's|../../../static|'$dst_dir'|' $dst_dir/SNDR.SNPP.L1bMw.sfif.acctest.xml

# Modify to point DEMs to a path controlled by Docker
sed -i -e 's|/peate/support/static/dem|'$static_dir'/dem|' \
       -e 's|/ref/devstable/STORE/mcf|'$static_dir'/mcf|' \
       $dst_dir/SNDR.PGSToolkit_ProcessControlFile.pcf
       

# Static files referenced in SFIF file
cp $src_dir/src/sips_pge/l1b_atms_snpp/static/SNDR.SNPP.L1bMw.template.201217000000.nc $dst_dir
cp $src_dir/src/sips_pge/l1b_atms_snpp/static/SNDR.SNPP.L1bMw.apf.171115000000.xml $dst_dir
cp $src_dir/src/sips_pge/l1b_atms_snpp/static/SNDR.SIPS.SNPP.ATMS.L1B.SPDCMetConstants_170801000000.pev $dst_dir
cp $src_dir/src/sips_pge/l1b_atms_snpp/static/SNDR.SIPS.SNPP.ATMS.L1B.SPDCMetMappings_171115000000.xml $dst_dir
cp $src_dir/src/sips_pge/l1b_atms_snpp/static/SNDR.SIPS.ATMS.L1B.SPDCMetStructure_171115000000.xml $dst_dir

# Template PGE configuration file to be modified by the Jupyter notebook
cp $src_dir/src/sips_pge/l1b_atms_snpp/acctest/spdc_nominal/in/SNDR.SNPP.L1bMw.nominal.config.xml $dst_dir/pge_config_template.xml