
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
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

More details available
[here](https://ramikrispin.github.io/coronavirus/), and a `csv` format
of the package dataset available
[here](https://github.com/RamiKrispin/coronavirus-csv)

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

<figcaption>

Source: Centers for Disease Control and Prevention’s Public Health Image
Library

</figcaption>

## Installation

Install the CRAN version:

``` r
install.packages("coronavirus")
```

Install the Github version (refreshed on a daily bases):

``` r
# install.packages("devtools")
devtools::install_github("RamiKrispin/coronavirus")
```

## Usage

The package contains a single dataset - `coronavirus`:

``` r
library(coronavirus)

data("coronavirus")
```

This `coronavirus` dataset has the following fields:

``` r
head(coronavirus)
#>   Province.State Country.Region      Lat     Long       date cases      type
#> 1                         Japan 35.67620 139.6503 2020-01-22     2 confirmed
#> 2                   South Korea 37.56650 126.9780 2020-01-22     1 confirmed
#> 3                      Thailand 13.75630 100.5018 2020-01-22     2 confirmed
#> 4          Anhui Mainland China 31.82571 117.2264 2020-01-22     1 confirmed
#> 5        Beijing Mainland China 40.18238 116.4142 2020-01-22    14 confirmed
#> 6      Chongqing Mainland China 30.05718 107.8740 2020-01-22     6 confirmed
tail(coronavirus)
#>      Province.State Country.Region      Lat      Long       date cases      type
#> 1770         Shanxi Mainland China 37.57769 112.29220 2020-02-20     8 recovered
#> 1771        Sichuan Mainland China 30.61714 102.71030 2020-02-20    29 recovered
#> 1772        Tianjin Mainland China 39.29362 117.33300 2020-02-20     5 recovered
#> 1773       Xinjiang Mainland China 41.11981  85.17822 2020-02-20     2 recovered
#> 1774         Yunnan Mainland China 24.97411 101.48680 2020-02-20    19 recovered
#> 1775       Zhejiang Mainland China 29.18251 120.09850 2020-02-20    29 recovered
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [13]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <int>
#>  1 Mainland China confirmed       74999
#>  2 Mainland China recovered       18002
#>  3 Mainland China death            2236
#>  4 Others         confirmed         634
#>  5 South Korea    confirmed         104
#>  6 Japan          confirmed          94
#>  7 Singapore      confirmed          84
#>  8 Hong Kong      confirmed          68
#>  9 Thailand       confirmed          35
#> 10 Singapore      recovered          34
#> 11 Taiwan         confirmed          24
#> 12 Malaysia       confirmed          22
#> 13 Japan          recovered          18
#> 14 Germany        confirmed          16
#> 15 South Korea    recovered          16
#> 16 Vietnam        confirmed          16
#> 17 Australia      confirmed          15
#> 18 Malaysia       recovered          15
#> 19 Thailand       recovered          15
#> 20 US             confirmed          15
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
    http:://www.nhc.gov.cn/xcs/yqtb/list\_gzbd.shtml
  - China CDC (CCDC):
    http:://weekly.chinacdc.cn/news/TrackingtheEpidemic.htm <br>
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
