FROM rkrispin/baser4:v4.0.0

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    git \
    libapparmor1 \
    libclang-dev \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    multiarch-support \
    psmisc \
    procps \
    python-setuptools \
    sudo \
    wget
# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R
RUN git --version

