#!/bin/bash

echo "Build the docker"

docker build . --progress=plain \
               --build-arg QUARTO_VERSION=1.2.313 \
               -t rkrispin/coronavirus:dev.0.3.34




if [[ $? = 0 ]] ; then
echo "Pushing docker..."
docker push rkrispin/coronavirus:dev.0.3.34
else
echo "Docker build failed"
fi
