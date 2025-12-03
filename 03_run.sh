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

# if exists remove old jenkins_home
# We stop the container and remove it to clear the state
echo "Cleaning up old container..."
docker stop $container3 2>/dev/null || true
docker rm $container3 2>/dev/null || true
# We remove the local directory to start fresh
sudo rm -rf ./jenkins_home 2>/dev/null || true
mkdir ./jenkins_home

# run image
echo "run now container"
# We run with --privileged (REQUIRED for DinD)
# We map host port 8083 to container port 8080
# We mount the local jenkins_home created above (optional but good practice)
docker run -d \
  --privileged \
  --name $container3 \
  -p 8083:8080 \
  $image3

# start docker environment in the container
# This starts the Docker Daemon in the background inside the container
# so you don't have to type 'dockerd &' manually every time.
echo "Starting dockerd inside container..."
docker exec -d $container3 dockerd