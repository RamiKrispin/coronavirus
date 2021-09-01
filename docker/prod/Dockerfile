FROM docker.io/rkrispin/baser:v4.1.0

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"

# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R

