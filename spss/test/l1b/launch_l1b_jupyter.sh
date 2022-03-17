#!/bin/bash

JUPYTER_PORT=8888

# Source common variables
. $(dirname $0)/../common/setup_env.sh $(dirname $0)

interface_dir=$($READLINK_BIN -f "$(dirname $0)/../../interface")

docker run --rm \
    --user $(id -u $USER) \
    -e HOME=/pge/interface \
    -v ${PGE_IN_DIR}:/pge/in \
    -v ${PGE_OUT_DIR}:/pge/out \
    -v ${PGE_STATIC_DIR}:/tmp/static \
    -v ${interface_dir}:/pge/interface \
    -p 127.0.0.1:$JUPYTER_PORT:$JUPYTER_PORT \
    --entrypoint jupyter \
    unity-sds/sounder_sips_l1b_pge:${DOCKER_TAG} \
    notebook --ip 0.0.0.0 --port $JUPYTER_PORT --notebook-dir=/pge/interface
