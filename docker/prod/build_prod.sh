#!/bin/bash

echo "Build the docker"

docker build . -t docker.io/rkrispin/coronavirus:prod.0.3.31

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
docker push docker.io/rkrispin/coronavirus:prod.0.3.31
else
echo "Docker build failed"
fi
