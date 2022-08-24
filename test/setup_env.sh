base_dir=$1

if [ -z "$base_dir" ]; then
    echo "No base directory specified, usage:"
    echo "$(dirname $0) <base_dir>"
    exit 1
fi

# Create temporary directory for IN/OUT if not otherwise specified
temp_dir=$(mktemp -d)

# Map subdirectories of the scripts' directory as in and out paths
if [ -z "$PGE_IN_DIR" ]; then
    export PGE_IN_DIR="${temp_dir}/in"

    echo "Using temporary directory for \$PGE_IN_DIR: $PGE_IN_DIR"

    mkdir -p $PGE_IN_DIR

    use_temp=1
fi

if [ ! -e "$PGE_IN_DIR" ]; then
    echo "Can not find PGE_IN_DIR: $PGE_IN_DIR"
    exit 1
fi

if [ -z "$PGE_OUT_DIR" ]; then
    export PGE_OUT_DIR="${temp_dir}/out"

    echo "Using temporary directory for \$PGE_OUT_DIR: $PGE_OUT_DIR"

    mkdir -p $PGE_OUT_DIR

    use_temp=1
fi

if [ ! -e "$PGE_OUT_DIR" ]; then
    echo "Can not find PGE_OUT_DIR: $PGE_OUT_DIR"
    exit 1
fi

# Delete temporary directory if unused
if [ -z "$use_temp" ]; then
    rmdir $temp_dir
fi

# Include variables from .env file so we have $DOCKER_TAG available
env_file=$(realpath $base_dir/../.env)
. $env_file

# Find static files location
lcl_static_dir=$(realpath $base_dir/../static)
if [ -z "$PGE_STATIC_DIR" ] && [ -e "$lcl_static_dir" ]; then
    PGE_STATIC_DIR=$lcl_static_dir
else
    echo "Could not find static files directory from either a \$PGE_STATIC_DIR environment variable or at the path: $lcl_static_dir"
    exit 1
fi
export PGE_STATIC_DIR
