
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://ramikrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/RamiKrispin/coronavirus)](https://github.com/RamiKrispin/coronavirus/commit/master)
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
#>       Province.State Country.Region     Lat     Long       date cases  type
#> 32235       Zhejiang          China 29.1832 120.0934 2020-03-21     0 death
#> 32236       Zhejiang          China 29.1832 120.0934 2020-03-22     0 death
#> 32237       Zhejiang          China 29.1832 120.0934 2020-03-23     0 death
#> 32238       Zhejiang          China 29.1832 120.0934 2020-03-24     0 death
#> 32239       Zhejiang          China 29.1832 120.0934 2020-03-25     0 death
#> 32240       Zhejiang          China 29.1832 120.0934 2020-03-26     0 death
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [17]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <int>
#>  1 US             confirmed       83836
#>  2 China          confirmed       81782
#>  3 Italy          confirmed       80589
#>  4 Spain          confirmed       57786
#>  5 Germany        confirmed       43938
#>  6 France         confirmed       29551
#>  7 Iran           confirmed       29406
#>  8 United Kingdom confirmed       11812
#>  9 Switzerland    confirmed       11811
#> 10 Korea, South   confirmed        9241
#> 11 Italy          death            8215
#> 12 Netherlands    confirmed        7468
#> 13 Austria        confirmed        6909
#> 14 Belgium        confirmed        6235
#> 15 Spain          death            4365
#> 16 Canada         confirmed        4042
#> 17 Turkey         confirmed        3629
#> 18 Portugal       confirmed        3544
#> 19 Norway         confirmed        3369
#> 20 China          death            3291
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-26):

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
#> # A tibble: 175 x 3
#> # Groups:   country [175]
#>    country        confirmed death
#>    <chr>              <int> <int>
#>  1 US                 18058   267
#>  2 Spain               8271   718
#>  3 Germany             6615    61
#>  4 Italy               6203   712
#>  5 France              3951   365
#>  6 Iran                2389   157
#>  7 United Kingdom      2172   114
#>  8 Austria             1321    19
#>  9 Belgium             1298    42
#> 10 Turkey              1196    16
#> 11 Netherlands         1030    78
#> 12 Switzerland          914    38
#> 13 Canada               791     8
#> 14 Portugal             549    17
#> 15 Australia            446     5
#> 16 Brazil               431    18
#> 17 Israel               324     3
#> 18 Sweden               314    15
#> 19 Norway               285     0
#> 20 Czechia              271     3
#> 21 Ireland              255    10
#> 22 Malaysia             235     3
#> 23 Ecuador              230     6
#> 24 South Africa         218     0
#> 25 Russia               182     0
#> 26 Poland               170     2
#> 27 Chile                164     1
#> 28 Denmark              161     7
#> 29 Pakistan             138     1
#> 30 Estonia              134     0
#> 31 Romania              123     6
#> 32 China                121     6
#> 33 Luxembourg           120     1
#> 34 Argentina            115     1
#> 35 Panama               115     0
#> 36 Saudi Arabia         112     1
#> 37 Thailand             111     0
#> 38 Korea, South         104     5
#> 39 Indonesia            103    20
#> 40 Peru                 100     0
#> # … with 135 more rows
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
