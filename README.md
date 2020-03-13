
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://ramikrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

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
#>   Province.State Country.Region Lat Long       date cases      type
#> 1                   Afghanistan  33   65 2020-01-22     0 confirmed
#> 2                   Afghanistan  33   65 2020-01-23     0 confirmed
#> 3                   Afghanistan  33   65 2020-01-24     0 confirmed
#> 4                   Afghanistan  33   65 2020-01-25     0 confirmed
#> 5                   Afghanistan  33   65 2020-01-26     0 confirmed
#> 6                   Afghanistan  33   65 2020-01-27     0 confirmed
tail(coronavirus) 
#>       Province.State Country.Region     Lat     Long       date cases      type
#> 33043       Zhejiang          China 29.1832 120.0934 2020-03-07     7 recovered
#> 33044       Zhejiang          China 29.1832 120.0934 2020-03-08     7 recovered
#> 33045       Zhejiang          China 29.1832 120.0934 2020-03-09    15 recovered
#> 33046       Zhejiang          China 29.1832 120.0934 2020-03-10    15 recovered
#> 33047       Zhejiang          China 29.1832 120.0934 2020-03-11     4 recovered
#> 33048       Zhejiang          China 29.1832 120.0934 2020-03-12     2 recovered
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
#>  1 China          confirmed       80932
#>  2 China          recovered       62901
#>  3 Italy          confirmed       12462
#>  4 Iran           confirmed       10075
#>  5 Korea, South   confirmed        7869
#>  6 China          death            3172
#>  7 Iran           recovered        2959
#>  8 France         confirmed        2284
#>  9 Spain          confirmed        2277
#> 10 Germany        confirmed        2078
#> 11 US             confirmed        1663
#> 12 Italy          recovered        1045
#> 13 Italy          death             827
#> 14 Norway         confirmed         702
#> 15 Cruise Ship    confirmed         696
#> 16 Switzerland    confirmed         652
#> 17 Japan          confirmed         639
#> 18 Denmark        confirmed         617
#> 19 Sweden         confirmed         599
#> 20 Netherlands    confirmed         503
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-12):

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
#> # A tibble: 116 x 4
#> # Groups:   country [116]
#>    country                confirmed death recovered
#>    <chr>                      <int> <int>     <int>
#>  1 Iran                        1075    75         0
#>  2 US                           382     4         4
#>  3 Denmark                      173     0         0
#>  4 Germany                      170     0         0
#>  5 Korea, South                 114     6        45
#>  6 Norway                       104     0         0
#>  7 Sweden                        99     0         0
#>  8 Austria                       56     1         0
#>  9 Slovenia                      32     0         0
#> 10 Saudi Arabia                  24     0         0
#> 11 Israel                        22     0         0
#> 12 Iceland                       18     0         0
#> 13 Poland                        18     1         0
#> 14 Brazil                        14     0         0
#> 15 Luxembourg                    12     0         0
#> 16 Albania                       11     0         0
#> 17 China                         11    11      1257
#> 18 India                         11     0         0
#> 19 Thailand                      11     0         0
#> 20 United Arab Emirates          11     0         0
#> 21 Canada                         9     0         0
#> 22 Costa Rica                     9     0         0
#> 23 Kuwait                         8     0         3
#> 24 Russia                         8     0         0
#> 25 Egypt                          7     0         0
#> 26 San Marino                     7     1         0
#> 27 Serbia                         7     0         0
#> 28 Slovakia                       6     0         0
#> 29 Algeria                        4     1         8
#> 30 Bosnia and Herzegovina         4     0         0
#> 31 Mexico                         4     0         0
#> 32 Peru                           4     0         0
#> 33 Romania                        4     0         0
#> 34 South Africa                   4     0         0
#> 35 Armenia                        3     0         0
#> 36 Belarus                        3     0         0
#> 37 Cuba                           3     0         0
#> 38 Czechia                        3     0         0
#> 39 Panama                         3     0         0
#> 40 Philippines                    3     1         0
#> # … with 76 more rows
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
