# Installing R version 3.6.1 from rocker
FROM rocker/r-ver:3.6.1

LABEL maintainer="Rami Krispin <rami.krispin@gmail.com>"

# Installing R external dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgit2-dev \
        libxml2-dev \
        libudunits2-dev \
        libgdal-dev \
        libcairo2-dev \
        libxt-dev \
        libv8-dev \
        libssl-dev \
        r-cran-rcpp \
        r-cran-inline \
        libpoppler-cpp-dev \
        libtesseract-dev \
        libleptonica-dev \
        tesseract-ocr-eng \
        libmagick++-dev \
        libavfilter-dev \
        libzmq3-dev \
        cargo

# Installing required packages
RUN install2.r -r https://cran.microsoft.com/snapshot/2020-03-01 \
        --error \
#        --deps TRUE \
        dplyr \
        devtools \
        magrittr \
        rnaturalearth \
        sf


# Example shiny application
RUN mkdir /root/shiny
COPY app.R /root/shiny

# Setting the Rprofile.site file
RUN echo "options(repos = c(CRAN='https://mran.microsoft.com/snapshot/2019-10-01'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site

RUN echo "local({ options(shiny.port = 3838, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site
