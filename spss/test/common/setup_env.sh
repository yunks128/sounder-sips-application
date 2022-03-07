base_dir=$1

if [ -z "$base_dir" ]; then
    echo "No base directory specified, usage:"
    echo "$(dirname $0) <base_dir>"
    exit 1
fi

if [ ! -z "$(which greadlink 2>/dev/null)" ]; then
    READLINK_BIN=$(which greadlink)
else
    READLINK_BIN=$(which readlink)
fi
export READLINK_BIN

# Map subdirectories of the scripts' directory as in and out paths
if [ -z "$PGE_IN_DIR" ]; then
    export PGE_IN_DIR=$($READLINK_BIN -f $base_dir/in)
fi

if [ ! -e "$PGE_IN_DIR" ]; then
    echo "Can not find PGE_IN_DIR: $PGE_IN_DIR"
    exit 1
fi

if [ -z "$PGE_OUT_DIR" ]; then
    export PGE_OUT_DIR=$($READLINK_BIN -f $base_dir/out)
fi

if [ ! -e "$PGE_OUT_DIR" ]; then
    echo "Can not find PGE_OUT_DIR: $PGE_OUT_DIR"
    exit 1
fi

# Include variables from .env file so we have $DOCKER_TAG available
env_file=$($READLINK_BIN -f $base_dir/../../../.env)
. $env_file

# Find static files location
lcl_static_dir=$($READLINK_BIN -f $base_dir/../../../static)
if [ -z "$PGE_STATIC_DIR" ] && [ -e "$lcl_static_dir" ]; then
    PGE_STATIC_DIR=$lcl_static_dir
else
    echo "Could not find static files directory from either a \$PGE_STATIC_DIR environment variable or at the path: $lcl_static_dir"
    exit 1
fi
export PGE_STATIC_DIR
