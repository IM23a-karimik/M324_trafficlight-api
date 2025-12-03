#!/usr/bin/bash
# Attention:
# Change CRLF (Windows) to LF (Unix on AWS) in your Editor
#

# Set variable PARAMS
PARAMS="./01-params.sh"

# check if PARAMS is set else exit
if [ ! -f "$PARAMS" ]; then
    echo "Error: $PARAMS not found."
    exit 1
fi

# import PARAMS
source "$PARAMS"

# function building Image based on their Dockerfiles
function buildImage () {
    local IMAGE=$1
    local DOCKERFILE=$2

    echo "------------------------------------------------"
    echo "Building $IMAGE using $DOCKERFILE"

    # Build the image pointing to specific Dockerfile
    docker build -t "$IMAGE" -f "$DOCKERFILE" .

    # Push to Docker Hub so EC2 can see it
    echo "Pushing $IMAGE to Docker Hub..."
    docker push "$IMAGE"
}

# Build a dockerfiles with function
# (Note: make sure you run 'docker login' in your terminal before running this script)
buildImage ${image1} ${file1}
buildImage ${image2} ${file2}
buildImage ${image3} ${file3}