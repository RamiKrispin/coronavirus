
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

The coronavirus package provides a formated irregular time series
dataset of the 2019 Novel Coronavirus COVID-19 (2019-nCoV) epidemic. The
raw data pulled from the Johns Hopkins University Center for Systems
Science and Engineering (JHU CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

## Installation

Currently, the package available only on Github version:

``` r
# install.packages("devtools")
devtools::install_github("RamiKrispin/coronavirus")
```

## Usage

This is a basic example which shows you how to solve a common problem:

``` r
library(coronavirus)

data("coronvirus")
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
head(coronvirus)
#>   Province.State Country.Region     Lat     Long       date cases      type
#> 1                       Belgium 50.5039   4.4699 2020-01-21     0 confirmed
#> 2                      Cambodia 12.5657 104.9910 2020-01-21     0 confirmed
#> 3                       Finland 61.9241  25.7482 2020-01-21     0 confirmed
#> 4                        France 46.2276   2.2137 2020-01-21     0 confirmed
#> 5                       Germany 51.1657  10.4515 2020-01-21     0 confirmed
#> 6                         India 20.5937  78.9629 2020-01-21     0 confirmed
```
