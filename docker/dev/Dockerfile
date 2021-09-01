<<<<<<< HEAD:docker/packages/Dockerfile
FROM rkrispin/baser:v.4.0.0
=======
FROM docker.io/rkrispin/baser:v4.1.0
>>>>>>> staging:docker/dev/Dockerfile

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"

# Updating pandoc
RUN apt-get update && \
        apt-get -y install pandoc

# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R
<<<<<<< HEAD:docker/packages/Dockerfile
=======

>>>>>>> staging:docker/dev/Dockerfile
