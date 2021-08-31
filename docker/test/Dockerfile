FROM docker.io/rkrispin/coronavirus:dev.0.3.1.9000

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"
ENV DEB=/R-4.1.0/
# installing R packages
RUN echo $DEB
RUN apt-get update && apt-get install -y --no-install-recommends \
  pandoc \
  && rm -rf /var/lib/apt/lists/*


