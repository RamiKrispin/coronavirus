
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
#>   Province.State Country.Region     Lat     Long       date cases      type
#> 1                       Belgium 50.5039   4.4699 2020-01-21     0 confirmed
#> 2                      Cambodia 12.5657 104.9910 2020-01-21     0 confirmed
#> 3                       Finland 61.9241  25.7482 2020-01-21     0 confirmed
#> 4                        France 46.2276   2.2137 2020-01-21     0 confirmed
#> 5                       Germany 51.1657  10.4515 2020-01-21     0 confirmed
#> 6                         India 20.5937  78.9629 2020-01-21     0 confirmed
tail(coronavirus)
#>      Province.State Country.Region       Lat      Long       date cases      type
#> 5032          Tibet Mainland China  30.15340  88.78790 2020-02-12     1 recovered
#> 5033    Toronto, ON         Canada  43.65320 -79.38320 2020-02-12     0 recovered
#> 5034       Victoria      Australia -37.81360 144.96310 2020-02-12     0 recovered
#> 5035       Xinjiang Mainland China  41.11981  85.17822 2020-02-12     0 recovered
#> 5036         Yunnan Mainland China  24.97411 101.48680 2020-02-12     6 recovered
#> 5037       Zhejiang Mainland China  29.18251 120.09850 2020-02-12    42 recovered
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
#>  1 Mainland China confirmed       44687
#>  2 Mainland China recovered        5062
#>  3 Mainland China death            1115
#>  4 Others         confirmed         175
#>  5 Hong Kong      confirmed          50
#>  6 Singapore      confirmed          47
#>  7 Thailand       confirmed          33
#>  8 Japan          confirmed          28
#>  9 South Korea    confirmed          28
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
