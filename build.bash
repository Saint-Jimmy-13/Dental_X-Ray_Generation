# !/bin/bash
# Usage: ./build.bash [Dockerfile] [version]

IMAGENAME=dental-xray-gan-seg

DOCKERFILE=${1:-Dockerfile}
VERSION=${2:-latest}

echo "Building image: $IMAGENAME:$VERSION using $DOCKERFILE"
echo "UID=$(id -u), GID=$(id -g)"

docker build \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    -t $IMAGENAME:$VERSION \
    -f $DOCKERFILE .

