
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
#> 55475       Zhejiang          China 29.1832 120.0934 2020-03-29     0 recovered
#> 55476       Zhejiang          China 29.1832 120.0934 2020-03-30     0 recovered
#> 55477       Zhejiang          China 29.1832 120.0934 2020-03-31     1 recovered
#> 55478       Zhejiang          China 29.1832 120.0934 2020-04-01     0 recovered
#> 55479       Zhejiang          China 29.1832 120.0934 2020-04-02     2 recovered
#> 55480       Zhejiang          China 29.1832 120.0934 2020-04-03     0 recovered
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
#>  1 US             confirmed      275586
#>  2 Italy          confirmed      119827
#>  3 Spain          confirmed      119199
#>  4 Germany        confirmed       91159
#>  5 China          confirmed       82511
#>  6 China          recovered       76760
#>  7 France         confirmed       65202
#>  8 Iran           confirmed       53183
#>  9 United Kingdom confirmed       38689
#> 10 Spain          recovered       30513
#> 11 Germany        recovered       24575
#> 12 Turkey         confirmed       20921
#> 13 Italy          recovered       19758
#> 14 Switzerland    confirmed       19606
#> 15 Iran           recovered       17935
#> 16 Belgium        confirmed       16770
#> 17 Netherlands    confirmed       15821
#> 18 Italy          death           14681
#> 19 France         recovered       14135
#> 20 Canada         confirmed       12437
```

Summary of new cases during the past 24 hours by country and type (as of
2020-04-03):

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
#> # A tibble: 181 x 4
#> # Groups:   country [181]
#>    country              confirmed death recovered
#>    <chr>                    <int> <int>     <int>
#>  1 US                       32133  1161       706
#>  2 Spain                     7134   850      3770
#>  3 Germany                   6365   168      2135
#>  4 France                    5273  1122      1587
#>  5 Italy                     4585   766      1480
#>  6 United Kingdom            4516   685        16
#>  7 Turkey                    2786    69        69
#>  8 Iran                      2715   134      1224
#>  9 Belgium                   1422   132       377
#> 10 Canada                    1153    40       440
#> 11 Netherlands               1033   149         0
#> 12 Brazil                    1012    35         0
#> 13 Portugal                   852    37         0
#> 14 Switzerland                779    55       833
#> 15 Russia                     601     4        46
#> 16 Israel                     571     4        65
#> 17 Sweden                     563    50       102
#> 18 Romania                    445    18        16
#> 19 Poland                     437    14         0
#> 20 Ireland                    424    22         0
#> 21 Austria                    395    10       273
#> 22 Philippines                385    29         1
#> 23 Denmark                    373    16       115
#> 24 Chile                      333     4        92
#> 25 Serbia                     305     8         0
#> 26 Pakistan                   265     6         1
#> 27 United Arab Emirates       240     1        12
#> 28 Czechia                    233     9         5
#> 29 Norway                     223     9         0
#> 30 Malaysia                   217     3        60
#> 31 Australia                  214     4       129
#> 32 Ecuador                    205    25         0
#> 33 Cameroon                   203     1         7
#> 34 Indonesia                  196    11        22
#> 35 Algeria                    185    19         1
#> 36 Peru                       181     6         0
#> 37 Ukraine                    175     5         3
#> 38 Panama                     158     5         1
#> 39 Saudi Arabia               154     4        23
#> 40 Argentina                  132     3        10
#> # … with 141 more rows
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
