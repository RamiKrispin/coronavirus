FROM docker.io/rkrispin/baser:v4.1.0


LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"


ARG QUARTO_VERSION=1.2.313
ENV QUARTO_VERSION=$QUARTO_VERSION

# Updating pandoc
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
        pandoc \
        wget \
        sudo \
        && rm -rf /var/lib/apt/lists/*

# Installing Quarto
RUN TEMP_QUARTO="$(mktemp)" && \
    wget -O "$TEMP_QUARTO" https://github.com/quarto-dev/quarto-cli/releases/download/v$QUARTO_VERSION/quarto-${QUARTO_VERSION}-linux-amd64.deb && \
    sudo dpkg -i "$TEMP_QUARTO" && \
    rm -f "$TEMP_QUARTO"

# installing R packages
RUN mkdir packages
COPY install_packages.R packages/
RUN Rscript packages/install_packages.R
