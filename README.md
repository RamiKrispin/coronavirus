
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://covid19r.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

<!-- badges: start --->

[![build](https://github.com/covid19r/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/covid19r/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/covid19r/coronavirus)](https://github.com/covid19r/coronavirus/commit/master)
<!-- badges: end -->

The coronavirus package provides a tidy format dataset of the 2019 Novel
Coronavirus COVID-19 (2019-nCoV) epidemic. The raw data pulled from the
Johns Hopkins University Center for Systems Science and Engineering (JHU
CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

More details available [here](https://covid19r.github.io/coronavirus/),
and a `csv` format of the package dataset available
[here](https://github.com/RamiKrispin/coronavirus-csv)

A summary dashboard is available
[here](https://ramikrispin.github.io/coronavirus_dashboard/)

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

<figcaption>

Source: Centers for Disease Control and Prevention’s Public Health Image
Library

</figcaption>

## Important Note

As this an ongoing situation, frequent changes in the data format may
occur, please visit the package news to get updates about those changes

## Installation

Install the CRAN version:

``` r
install.packages("coronavirus") 
```

Install the Github version (refreshed on a daily bases):

``` r
# install.packages("devtools")
devtools::install_github("covid19r/coronavirus")
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
#> 61220       Zhejiang          China 29.1832 120.0934 2020-04-04     1 recovered
#> 61221       Zhejiang          China 29.1832 120.0934 2020-04-05     1 recovered
#> 61222       Zhejiang          China 29.1832 120.0934 2020-04-06     0 recovered
#> 61223       Zhejiang          China 29.1832 120.0934 2020-04-07     0 recovered
#> 61224       Zhejiang          China 29.1832 120.0934 2020-04-08     2 recovered
#> 61225       Zhejiang          China 29.1832 120.0934 2020-04-09     3 recovered
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
#>  1 US             confirmed      461437
#>  2 Spain          confirmed      153222
#>  3 Italy          confirmed      143626
#>  4 France         confirmed      118781
#>  5 Germany        confirmed      118181
#>  6 China          confirmed       82883
#>  7 China          recovered       77679
#>  8 Iran           confirmed       66220
#>  9 United Kingdom confirmed       65872
#> 10 Germany        recovered       52407
#> 11 Spain          recovered       52165
#> 12 Turkey         confirmed       42282
#> 13 Iran           recovered       32309
#> 14 Italy          recovered       28470
#> 15 US             recovered       25410
#> 16 Belgium        confirmed       24983
#> 17 Switzerland    confirmed       24051
#> 18 France         recovered       23413
#> 19 Netherlands    confirmed       21903
#> 20 Canada         confirmed       20654
```

Summary of new cases during the past 24 hours by country and type (as of
2020-04-09):

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
#> # A tibble: 184 x 4
#> # Groups:   country [184]
#>    country              confirmed death recovered
#>    <chr>                    <int> <int>     <int>
#>  1 US                       32385  1783      1851
#>  2 Spain                     5002   655      4144
#>  3 Germany                   4885   258      6107
#>  4 France                    4822  1341      1961
#>  5 United Kingdom            4398   882        14
#>  6 Italy                     4204   610      1979
#>  7 Turkey                    4056    96       296
#>  8 Brazil                    1922   131        46
#>  9 Iran                      1634   117      2497
#> 10 Belgium                   1580   283       483
#> 11 Canada                    1513    96      1008
#> 12 Russia                    1459    13       118
#> 13 Netherlands               1221   148         6
#> 14 Peru                       914    17       105
#> 15 Portugal                   815    29         9
#> 16 India                      809    48       114
#> 17 Switzerland                771    53       800
#> 18 Sweden                     722   106         0
#> 19 Israel                     564    13       210
#> 20 Ecuador                    515    30       199
#> 21 Ireland                    500    28         0
#> 22 Romania                    441    28       119
#> 23 Chile                      426     9       159
#> 24 Belarus                    420     3        62
#> 25 Japan                      410     1        10
#> 26 Mexico                     396    33         0
#> 27 Poland                     370    15        62
#> 28 Saudi Arabia               355     3        35
#> 29 Indonesia                  337    40        30
#> 30 United Arab Emirates       331     2        29
#> 31 Austria                    302    22       728
#> 32 Singapore                  287     0        54
#> 33 Panama                     279     4         0
#> 34 Czechia                    257    13        68
#> 35 Dominican Republic         238    10        30
#> 36 Denmark                    233    19       120
#> 37 Pakistan                   226     4       105
#> 38 Ukraine                    224     5        10
#> 39 Philippines                206    21        28
#> 40 Serbia                     201     1         0
#> # … with 144 more rows
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
