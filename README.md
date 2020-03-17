
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
#> 45040       Zhejiang          China 29.1832 120.0934 2020-03-11     4 recovered
#> 45041       Zhejiang          China 29.1832 120.0934 2020-03-12     2 recovered
#> 45042       Zhejiang          China 29.1832 120.0934 2020-03-13     0 recovered
#> 45043       Zhejiang          China 29.1832 120.0934 2020-03-14    14 recovered
#> 45044       Zhejiang          China 29.1832 120.0934 2020-03-15     0 recovered
#> 45045       Zhejiang          China 29.1832 120.0934 2020-03-16     5 recovered
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
#>  1 China          confirmed       81033
#>  2 China          recovered       67910
#>  3 Italy          confirmed       27980
#>  4 Iran           confirmed       14991
#>  5 Spain          confirmed        9942
#>  6 Korea, South   confirmed        8236
#>  7 Germany        confirmed        7272
#>  8 France         confirmed        6650
#>  9 US             confirmed        4632
#> 10 Iran           recovered        4590
#> 11 China          death            3217
#> 12 Italy          recovered        2749
#> 13 Switzerland    confirmed        2200
#> 14 Italy          death            2158
#> 15 United Kingdom confirmed        1551
#> 16 Netherlands    confirmed        1414
#> 17 Norway         confirmed        1333
#> 18 Korea, South   recovered        1137
#> 19 Sweden         confirmed        1103
#> 20 Belgium        confirmed        1058
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-16):

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
#> # A tibble: 156 x 4
#> # Groups:   country [156]
#>    country        confirmed death recovered
#>    <chr>              <int> <int>     <int>
#>  1 Italy               3233   349       414
#>  2 Spain               2144    53        13
#>  3 France              2137    57         0
#>  4 Germany             1477     6        21
#>  5 US                  1133    22         5
#>  6 Iran                1053   129         0
#>  7 United Kingdom       406    35         2
#>  8 Netherlands          278     4         0
#>  9 Belgium              172     1         0
#> 10 Canada               163     3         1
#> 11 Austria              158     2         0
#> 12 Malaysia             138     0         0
#> 13 Norway               112     0         0
#> 14 Portugal              86     0         1
#> 15 Pakistan              83     0         0
#> 16 Chile                 81     0         0
#> 17 Sweden                81     3         0
#> 18 Australia             80     0         0
#> 19 Korea, South          74     0       627
#> 20 Poland                58     1        13
#> 21 Denmark               57     1         0
#> 22 Czechia               45     0         3
#> 23 Peru                  43     0         0
#> 24 Egypt                 40     0         6
#> 25 Ireland               40     0         0
#> 26 Brazil                38     0         1
#> 27 Qatar                 38     0         0
#> 28 Estonia               34     0         0
#> 29 Slovenia              34     0         0
#> 30 Finland               33     0         0
#> 31 Thailand              33     0         0
#> 32 China                 30    14       893
#> 33 Romania               27     0         0
#> 34 Russia                27     0         0
#> 35 Armenia               26     0         0
#> 36 Colombia              20     0         0
#> 37 Luxembourg            18     0         0
#> 38 Indonesia             17     0         0
#> 39 Singapore             17     0         4
#> 40 Saudi Arabia          15     0         1
#> # … with 116 more rows
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
