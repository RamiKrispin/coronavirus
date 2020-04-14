
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
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/coronavirus)](https://cran.r-project.org/package=coronavirus)

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
#> 64569       Zhejiang          China 29.1832 120.0934 2020-04-08     2 recovered
#> 64570       Zhejiang          China 29.1832 120.0934 2020-04-09     3 recovered
#> 64571       Zhejiang          China 29.1832 120.0934 2020-04-10     0 recovered
#> 64572       Zhejiang          China 29.1832 120.0934 2020-04-11     1 recovered
#> 64573       Zhejiang          China 29.1832 120.0934 2020-04-12     2 recovered
#> 64574       Zhejiang          China 29.1832 120.0934 2020-04-13     1 recovered
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
#>  1 US             confirmed      580619
#>  2 Spain          confirmed      170099
#>  3 Italy          confirmed      159516
#>  4 France         confirmed      137875
#>  5 Germany        confirmed      130072
#>  6 United Kingdom confirmed       89570
#>  7 China          confirmed       83213
#>  8 China          recovered       78039
#>  9 Iran           confirmed       73303
#> 10 Spain          recovered       64727
#> 11 Germany        recovered       64300
#> 12 Turkey         confirmed       61049
#> 13 Iran           recovered       45983
#> 14 US             recovered       43482
#> 15 Italy          recovered       35435
#> 16 Belgium        confirmed       30589
#> 17 France         recovered       28001
#> 18 Netherlands    confirmed       26710
#> 19 Switzerland    confirmed       25688
#> 20 Canada         confirmed       25679
```

Summary of new cases during the past 24 hours by country and type (as of
2020-04-13):

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
#> # A tibble: 185 x 4
#> # Groups:   country [185]
#>    country              confirmed death recovered
#>    <chr>                    <int> <int>     <int>
#>  1 US                       25306  1509     10494
#>  2 United Kingdom            4364   718      -322
#>  3 France                    4205   574       532
#>  4 Turkey                    4093    98       511
#>  5 Spain                     3268   547      2336
#>  6 Italy                     3153   566      1224
#>  7 Russia                    2558    18       179
#>  8 Peru                      2265    23       844
#>  9 Germany                   2218   172      4000
#> 10 Iran                      1617   111      2089
#> 11 Canada                    1381    65       635
#> 12 India                     1248    27       101
#> 13 Brazil                    1238   105         0
#> 14 Ireland                    992    31         0
#> 15 Netherlands                964    86         0
#> 16 Belgium                    942   303       244
#> 17 Japan                      622    15        22
#> 18 Saudi Arabia               472     6        44
#> 19 Sweden                     465    20         0
#> 20 Mexico                     442    23        71
#> 21 Israel                     441    13       228
#> 22 Serbia                     424     5         0
#> 23 United Arab Emirates       398     3       172
#> 24 Singapore                  386     1        26
#> 25 Portugal                   349    31         0
#> 26 Belarus                    341     3         0
#> 27 Romania                    333    15        62
#> 28 Ukraine                    325    10         8
#> 29 Indonesia                  316    26        21
#> 30 Chile                      312     2       308
#> 31 Philippines                284    18        45
#> 32 Switzerland                273    32      1000
#> 33 Pakistan                   266     2        67
#> 34 Poland                     260    13        48
#> 35 Qatar                      252     0        59
#> 36 Bahrain                    225     0        33
#> 37 Dominican Republic         200     4        21
#> 38 Bangladesh                 182     5         3
#> 39 Panama                     166     8         6
#> 40 Denmark                    144    12       112
#> # … with 145 more rows
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
