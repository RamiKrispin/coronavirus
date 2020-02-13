
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus

<!-- badges: start --->

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

<figcaption>

Source: Centers for Disease Control and Prevention’s Public Health Image
Library

</figcaption>

## Installation

Currently, the package available only on Github version:

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
#> 1                         Japan 35.67620 139.6503 2020-01-21     1 confirmed
#> 2                      Thailand 13.75630 100.5018 2020-01-21     2 confirmed
#> 3        Beijing Mainland China 40.18238 116.4142 2020-01-21    10 confirmed
#> 4      Chongqing Mainland China 30.05718 107.8740 2020-01-21     5 confirmed
#> 5      Guangdong Mainland China 23.33841 113.4220 2020-01-21    17 confirmed
#> 6          Hubei Mainland China 30.97564 112.2707 2020-01-21   270 confirmed
tail(coronavirus)
#>      Province.State Country.Region      Lat     Long       date cases      type
#> 1162         Shanxi Mainland China 37.57769 112.2922 2020-02-12     3 recovered
#> 1163        Sichuan Mainland China 30.61714 102.7103 2020-02-12     8 recovered
#> 1164        Tianjin Mainland China 39.29362 117.3330 2020-02-12     1 recovered
#> 1165          Tibet Mainland China 30.15340  88.7879 2020-02-12     1 recovered
#> 1166         Yunnan Mainland China 24.97411 101.4868 2020-02-12     3 recovered
#> 1167       Zhejiang Mainland China 29.18251 120.0985 2020-02-12    48 recovered
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20)
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [15]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <dbl>
#>  1 Mainland China confirmed       59805
#>  2 Mainland China recovered        5915
#>  3 Mainland China death            1366
#>  4 Others         confirmed         175
#>  5 Hong Kong      confirmed          50
#>  6 Singapore      confirmed          50
#>  7 Thailand       confirmed          33
#>  8 Japan          confirmed          28
#>  9 South Korea    confirmed          28
#> 10 Malaysia       confirmed          18
#> 11 Taiwan         confirmed          18
#> 12 Germany        confirmed          16
#> 13 Australia      confirmed          15
#> 14 Singapore      recovered          15
#> 15 Vietnam        confirmed          15
#> 16 US             confirmed          13
#> 17 France         confirmed          11
#> 18 Macau          confirmed          10
#> 19 Thailand       recovered          10
#> 20 Japan          recovered           9
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
