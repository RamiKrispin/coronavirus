
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus

<!-- badges: start -->

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
<!-- badges: end -->

The coronavirus package provides a tidy format dataset of the 2019 Novel
Coronavirus COVID-19 (2019-nCoV) epidemic. The raw data pulled from the
Johns Hopkins University Center for Systems Science and Engineering (JHU
CCSE) Coronavirus
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

library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

summary_df <- coronvirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20)
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [15]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <dbl>
#>  1 Mainland China confirmed       44641
#>  2 Mainland China recovered        4730
#>  3 Mainland China death            1113
#>  4 Others         confirmed         135
#>  5 Hong Kong      confirmed          49
#>  6 Singapore      confirmed          47
#>  7 Thailand       confirmed          33
#>  8 South Korea    confirmed          28
#>  9 Japan          confirmed          26
#> 10 Malaysia       confirmed          18
#> 11 Taiwan         confirmed          18
#> 12 Germany        confirmed          16
#> 13 Australia      confirmed          15
#> 14 Vietnam        confirmed          15
#> 15 US             confirmed          13
#> 16 France         confirmed          11
#> 17 Macau          confirmed          10
#> 18 Thailand       recovered          10
#> 19 Japan          recovered           9
#> 20 Singapore      recovered           9
```

## Data Sources

The raw data pulled and arranged by the Johns Hopkins University Center
for Systems Science and Engineering (JHU CCSE) from the following
resources:

  - World Health Organization (WHO): <https://www.who.int/> <br>
  - DXY.cn. Pneumonia. 2020. <http://3g.dxy.cn/newh5/view/pneumonia>.
    <br>
  - BNO News:
    <https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/>
    <br>
  - National Health Commission of the People’s Republic of China (NHC):
    <br> <http://www.nhc.gov.cn/xcs/yqtb/list_gzbd.shtml> <br>
  - China CDC (CCDC):
    <http://weekly.chinacdc.cn/news/TrackingtheEpidemic.htm> <br>
  - Hong Kong Department of Health:
    <https://www.chp.gov.hk/en/features/102465.html> <br>
  - Macau Government: <https://www.ssm.gov.mo/portal/> <br>
  - Taiwan CDC:
    <https://sites.google.com/cdc.gov.tw/2019ncov/taiwan?authuser=0>
    <br>
  - US CDC: <https://www.cdc.gov/coronavirus/2019-ncov/index.html> <br>
  - Government of Canada:
    <https://www.canada.ca/en/public-health/services/diseases/coronavirus.html>
    <br>
  - Australia Government Department of Health:
    <https://www.health.gov.au/news/coronavirus-update-at-a-glance> <br>
  - European Centre for Disease Prevention and Control (ECDC):
    <https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases>
    <br>

<br>
