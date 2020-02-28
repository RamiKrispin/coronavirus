
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
#>   Province.State Country.Region     Lat     Long       date cases      type
#> 1                         Japan 36.0000 138.0000 2020-01-22     2 confirmed
#> 2                   South Korea 36.0000 128.0000 2020-01-22     1 confirmed
#> 3                      Thailand 15.0000 101.0000 2020-01-22     2 confirmed
#> 4          Anhui Mainland China 31.8257 117.2264 2020-01-22     1 confirmed
#> 5        Beijing Mainland China 40.1824 116.4142 2020-01-22    14 confirmed
#> 6      Chongqing Mainland China 30.0572 107.8740 2020-01-22     6 confirmed
tail(coronavirus)
#>      Province.State Country.Region     Lat     Long       date cases      type
#> 2230         Shanxi Mainland China 37.5777 112.2922 2020-02-27     3 recovered
#> 2231        Sichuan Mainland China 30.6171 102.7103 2020-02-27    14 recovered
#> 2232        Tianjin Mainland China 39.3054 117.3230 2020-02-27     6 recovered
#> 2233       Xinjiang Mainland China 41.1129  85.2401 2020-02-27     9 recovered
#> 2234         Yunnan Mainland China 24.9740 101.4870 2020-02-27     6 recovered
#> 2235       Zhejiang Mainland China 29.1832 120.0934 2020-02-27    65 recovered
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
#>  1 Mainland China confirmed       78498
#>  2 Mainland China recovered       32898
#>  3 Mainland China death            2744
#>  4 South Korea    confirmed        1766
#>  5 Others         confirmed         705
#>  6 Italy          confirmed         655
#>  7 Iran           confirmed         245
#>  8 Japan          confirmed         214
#>  9 Singapore      confirmed          93
#> 10 Hong Kong      confirmed          92
#> 11 Singapore      recovered          62
#> 12 US             confirmed          60
#> 13 Iran           recovered          49
#> 14 Germany        confirmed          46
#> 15 Italy          recovered          45
#> 16 Kuwait         confirmed          43
#> 17 Thailand       confirmed          40
#> 18 France         confirmed          38
#> 19 Bahrain        confirmed          33
#> 20 Taiwan         confirmed          32
```

Summary of new cases during the past 24 hours by country and type (as of
2020-02-27):

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
#> # A tibble: 26 x 4
#> # Groups:   country [26]
#>    country        confirmed recovered death
#>    <chr>              <int>     <int> <int>
#>  1 South Korea          505        NA     1
#>  2 Mainland China       433      2845    29
#>  3 Italy                202        42     5
#>  4 Iran                 106        NA     7
#>  5 Japan                 25        NA     2
#>  6 France                20        NA    NA
#>  7 Germany               19         1    NA
#>  8 Kuwait                17        NA    NA
#>  9 Switzerland            7        NA    NA
#> 10 Sweden                 5        NA    NA
#> 11 Canada                 2         3    NA
#> 12 Greece                 2        NA    NA
#> 13 Iraq                   2        NA    NA
#> 14 Spain                  2        NA    NA
#> 15 UK                     2        NA    NA
#> 16 Australia              1        NA    NA
#> 17 Austria                1        NA    NA
#> 18 Denmark                1        NA    NA
#> 19 Estonia                1        NA    NA
#> 20 Hong Kong              1        NA    NA
#> 21 Israel                 1         1    NA
#> 22 Malaysia               1        NA    NA
#> 23 Netherlands            1        NA    NA
#> 24 San Marino             1        NA    NA
#> 25 US                     1        NA    NA
#> 26 Macau                 NA         1    NA
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
