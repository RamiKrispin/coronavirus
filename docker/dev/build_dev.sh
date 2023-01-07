#!/bin/bash

echo "Build the docker"

docker build . -t docker.io/rkrispin/coronavirus:dev.0.3.30.9000

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
docker push docker.io/rkrispin/coronavirus:dev.0.3.30.9000
else
echo "Docker build failed"
fi
