#!/bin/bash

echo "Build the docker"

docker build . -t docker.io/rkrispin/coronavirus:test.0.3.1.9000 --progress=plain --no-cache

if [[ $? = 0 ]] ; then
echo "Pushing docker..."
docker push docker.io/rkrispin/coronavirus:test.0.3.1.9000
else
echo "Docker build failed"
fi
