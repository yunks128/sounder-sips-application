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
export PGE_IN_DIR=$($READLINK_BIN -f $base_dir/in)
export PGE_OUT_DIR=$($READLINK_BIN -f $base_dir/out)

# Include variables from .env file so we have $DOCKER_TAG available
env_file=$($READLINK_BIN -f $base_dir/../../../.env)
. $env_file

# Find static files location
lcl_static_dir=$($READLINK_BIN -f $base_dir/../../../static)
if [ ! -z "$SIPS_STATIC_DIR" ]; then
    PGE_STATIC_DIR=$SIPS_STATIC_DIR
elif [ -e "$lcl_static_dir" ]; then
    PGE_STATIC_DIR=$lcl_static_dir
else
    echo "Could not find static files directory from either a \$SIPS_STATIC_DIR environment variable or at the path: $lcl_static_dir"
    exit 1
fi
export PGE_STATIC_DIR
