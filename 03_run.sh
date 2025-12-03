#!/bin/bash
PARAMS="./01_params.sh"
if [ ! -f "$PARAMS" ]; then echo "Error: $PARAMS not found."; exit 1; fi
source "$PARAMS"

# Cleanup
echo "Cleaning up..."
docker stop $container3 2>/dev/null || true
docker rm $container3 2>/dev/null || true
sudo rm -rf ./jenkins_home 2>/dev/null || true
mkdir ./jenkins_home
chmod 777 ./jenkins_home

# Run Container (Privileged for DinD)
echo "Running container..."
docker run -d \
  --privileged \
  --name $container3 \
  -p 8083:8080 \
  -v $(pwd)/jenkins_home:/var/jenkins_home \
  $image3

# Start dockerd inside
echo "Starting dockerd..."
docker exec -d $container3 dockerd