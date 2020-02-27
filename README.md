
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
#> 2156         Shanxi Mainland China 37.57769 112.29220 2020-02-26     6 recovered
#> 2157        Sichuan Mainland China 30.61714 102.71030 2020-02-26    18 recovered
#> 2158        Tianjin Mainland China 39.29362 117.33300 2020-02-26     5 recovered
#> 2159       Xinjiang Mainland China 41.11981  85.17822 2020-02-26     4 recovered
#> 2160         Yunnan Mainland China 24.97411 101.48680 2020-02-26    15 recovered
#> 2161       Zhejiang Mainland China 29.18251 120.09850 2020-02-26    59 recovered
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
#>    <chr>          <chr>           <int>
#>  1 Mainland China confirmed       78065
#>  2 Mainland China recovered       30053
#>  3 Mainland China death            2715
#>  4 South Korea    confirmed        1261
#>  5 Others         confirmed         705
#>  6 Italy          confirmed         453
#>  7 Japan          confirmed         189
#>  8 Iran           confirmed         139
#>  9 Singapore      confirmed          93
#> 10 Hong Kong      confirmed          91
#> 11 Singapore      recovered          62
#> 12 US             confirmed          59
#> 13 Iran           recovered          49
#> 14 Thailand       confirmed          40
#> 15 Bahrain        confirmed          33
#> 16 Taiwan         confirmed          32
#> 17 Germany        confirmed          27
#> 18 Kuwait         confirmed          26
#> 19 Hong Kong      recovered          24
#> 20 Australia      confirmed          22
```

Summary of new cases during the past 24 hours by country and type (as of
2020-02-26):

``` r
library(tidyr)

coronavirus %>% 
  filter(date == max(date)) %>%
  select(country = Country.Region, type, cases) %>%
  group_by(country, type) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)
#> # A tibble: 30 x 4
#> # Groups:   country [30]
#>    country         confirmed death recovered
#>    <chr>               <int> <int>     <int>
#>  1 Mainland China        405    52      2403
#>  2 South Korea           284     2        NA
#>  3 Italy                 131     2         2
#>  4 Iran                   44     3        49
#>  5 Japan                  19     1        NA
#>  6 Kuwait                 15    NA        NA
#>  7 Others                 14     1        10
#>  8 Bahrain                10    NA        NA
#>  9 Germany                10    NA         1
#> 10 Hong Kong               7    NA         5
#> 11 Spain                   7    NA        NA
#> 12 US                      6    NA        NA
#> 13 France                  4     1        NA
#> 14 Iraq                    4    NA        NA
#> 15 Thailand                3    NA        NA
#> 16 Croatia                 2    NA        NA
#> 17 Oman                    2    NA        NA
#> 18 Pakistan                2    NA        NA
#> 19 Singapore               2    NA         9
#> 20 Brazil                  1    NA        NA
#> 21 Finland                 1    NA        NA
#> 22 Georgia                 1    NA        NA
#> 23 Greece                  1    NA        NA
#> 24 Israel                  1    NA        NA
#> 25 Lebanon                 1    NA        NA
#> 26 North Macedonia         1    NA        NA
#> 27 Norway                  1    NA        NA
#> 28 Romania                 1    NA        NA
#> 29 Sweden                  1    NA        NA
#> 30 Taiwan                  1    NA        NA
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
