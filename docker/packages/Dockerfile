FROM rkrispin/baser:v.4.0.0

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"

# Updating pandoc
RUN apt-get update && \
        apt-get -y install pandoc

# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R
