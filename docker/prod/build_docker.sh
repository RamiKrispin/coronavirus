#!/bin/bash

echo "Build the docker"

docker build . -t docker.io/rkrispin/coronavirus:prod.0.3.2

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
docker push docker.io/rkrispin/coronavirus:prod.0.3.2
else
echo "Docker build failed"
fi
