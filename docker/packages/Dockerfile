FROM rkrispin/baser4:dev

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"

# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R


