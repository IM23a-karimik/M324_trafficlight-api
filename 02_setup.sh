#!/bin/bash
PARAMS="./01_params.sh"
if [ ! -f "$PARAMS" ]; then echo "Error: $PARAMS not found."; exit 1; fi
source "$PARAMS"

function buildImage () {
    local IMAGE=$1
    local DOCKERFILE=$2
    echo "--- Building $IMAGE using $DOCKERFILE ---"
    docker build -t "$IMAGE" -f "$DOCKERFILE" .
    echo "Pushing $IMAGE..."
    docker push "$IMAGE"
}

# Ensure you are logged in
# docker login

buildImage ${image1} ${file1}
buildImage ${image2} ${file2}
buildImage ${image3} ${file3}