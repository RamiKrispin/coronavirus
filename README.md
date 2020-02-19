
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
#>      Province.State Country.Region      Lat     Long       date cases      type
#> 1636       Shanghai Mainland China 31.20327 121.4554 2020-02-18    16 recovered
#> 1637         Shanxi Mainland China 37.57769 112.2922 2020-02-18     8 recovered
#> 1638        Sichuan Mainland China 30.61714 102.7103 2020-02-18    13 recovered
#> 1639        Tianjin Mainland China 39.29362 117.3330 2020-02-18     2 recovered
#> 1640         Yunnan Mainland China 24.97411 101.4868 2020-02-18    10 recovered
#> 1641       Zhejiang Mainland China 29.18251 120.0985 2020-02-18    28 recovered
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20)
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [14]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <int>
#>  1 Mainland China confirmed       74139
#>  2 Mainland China recovered       14199
#>  3 Mainland China death            2002
#>  4 Others         confirmed         542
#>  5 Singapore      confirmed          81
#>  6 Japan          confirmed          74
#>  7 Hong Kong      confirmed          62
#>  8 Thailand       confirmed          35
#>  9 South Korea    confirmed          31
#> 10 Singapore      recovered          29
#> 11 US             confirmed          29
#> 12 Malaysia       confirmed          22
#> 13 Taiwan         confirmed          22
#> 14 Germany        confirmed          16
#> 15 Vietnam        confirmed          16
#> 16 Australia      confirmed          15
#> 17 Thailand       recovered          15
#> 18 Japan          recovered          13
#> 19 Malaysia       recovered          13
#> 20 France         confirmed          12
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
