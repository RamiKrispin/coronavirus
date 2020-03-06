
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

A summary dashboard is available
[here](https://ramikrispin.github.io/coronavirus_dashboard/)

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
#>      Province.State Country.Region      Lat     Long       date cases      type
#> 2881         Shanxi Mainland China  37.5777 112.2922 2020-03-05     2 recovered
#> 2882        Sichuan Mainland China  30.6171 102.7103 2020-03-05    19 recovered
#> 2883        Tianjin Mainland China  39.3054 117.3230 2020-03-05     4 recovered
#> 2884       Victoria      Australia -37.8136 144.9631 2020-03-05     3 recovered
#> 2885       Xinjiang Mainland China  41.1129  85.2401 2020-03-05     1 recovered
#> 2886       Zhejiang Mainland China  29.1832 120.0934 2020-03-05    10 recovered
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
#>  1 Mainland China confirmed       80422
#>  2 Mainland China recovered       52240
#>  3 South Korea    confirmed        6088
#>  4 Italy          confirmed        3858
#>  5 Iran           confirmed        3513
#>  6 Mainland China death            3013
#>  7 Iran           recovered         739
#>  8 Others         confirmed         706
#>  9 Germany        confirmed         482
#> 10 Italy          recovered         414
#> 11 France         confirmed         377
#> 12 Japan          confirmed         360
#> 13 Spain          confirmed         259
#> 14 US             confirmed         221
#> 15 Italy          death             148
#> 16 Singapore      confirmed         117
#> 17 UK             confirmed         115
#> 18 Switzerland    confirmed         114
#> 19 Iran           death             107
#> 20 Hong Kong      confirmed         105
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-05):

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
#> # A tibble: 49 x 4
#> # Groups:   country [49]
#>    country                confirmed recovered death
#>    <chr>                      <int>     <int> <int>
#>  1 Italy                        769       138    41
#>  2 Iran                         591       187    15
#>  3 South Korea                  467        NA    NA
#>  4 Germany                      220        NA    NA
#>  5 Mainland China               151      2285    32
#>  6 France                        92        NA     2
#>  7 US                            68        NA     1
#>  8 Sweden                        59        NA    NA
#>  9 Netherlands                   44        NA    NA
#> 10 Spain                         37        NA     1
#> 11 Norway                        31        NA    NA
#> 12 UK                            30        NA     1
#> 13 Japan                         29        NA    NA
#> 14 Belgium                       27        NA    NA
#> 15 Switzerland                   24        NA     1
#> 16 Greece                        22        NA    NA
#> 17 Austria                       12        NA    NA
#> 18 Iceland                        8        NA    NA
#> 19 Singapore                      7        NA    NA
#> 20 Finland                        6        NA    NA
#> 21 San Marino                     5        NA    NA
#> 22 Canada                         4        NA    NA
#> 23 Czech Republic                 4        NA    NA
#> 24 Palestine                      4        NA    NA
#> 25 Saudi Arabia                   4        NA    NA
#> 26 Thailand                       4        NA    NA
#> 27 Australia                      3        10    NA
#> 28 Azerbaijan                     3        NA    NA
#> 29 Bahrain                        3        NA    NA
#> 30 Chile                          3        NA    NA
#> 31 Ecuador                        3        NA    NA
#> 32 Lebanon                        3        NA    NA
#> 33 Portugal                       3        NA    NA
#> 34 Bosnia and Herzegovina         2        NA    NA
#> 35 India                          2        NA    NA
#> 36 Kuwait                         2        NA    NA
#> 37 Romania                        2        NA    NA
#> 38 Slovenia                       2        NA    NA
#> 39 Taiwan                         2        NA    NA
#> 40 United Arab Emirates           2        NA    NA
#> 41 Egypt                          1        NA    NA
#> 42 Estonia                        1        NA    NA
#> 43 Georgia                        1        NA    NA
#> 44 Israel                         1        NA    NA
#> 45 Morocco                        1        NA    NA
#> 46 Oman                           1        NA    NA
#> 47 Russia                         1        NA    NA
#> 48 South Africa                   1        NA    NA
#> 49 Hong Kong                     NA         6    NA
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
