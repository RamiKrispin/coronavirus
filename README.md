
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
#> 45355       Zhejiang          China 29.1832 120.0934 2020-03-12     2 recovered
#> 45356       Zhejiang          China 29.1832 120.0934 2020-03-13     0 recovered
#> 45357       Zhejiang          China 29.1832 120.0934 2020-03-14    14 recovered
#> 45358       Zhejiang          China 29.1832 120.0934 2020-03-15     0 recovered
#> 45359       Zhejiang          China 29.1832 120.0934 2020-03-16     5 recovered
#> 45360       Zhejiang          China 29.1832 120.0934 2020-03-17     0 recovered
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
#>  1 China          confirmed       81058
#>  2 China          recovered       68798
#>  3 Italy          confirmed       31506
#>  4 Iran           confirmed       16169
#>  5 Spain          confirmed       11748
#>  6 Germany        confirmed        9257
#>  7 Korea, South   confirmed        8320
#>  8 France         confirmed        7699
#>  9 US             confirmed        6421
#> 10 Iran           recovered        5389
#> 11 China          death            3230
#> 12 Italy          recovered        2941
#> 13 Switzerland    confirmed        2700
#> 14 Italy          death            2503
#> 15 United Kingdom confirmed        1960
#> 16 Netherlands    confirmed        1708
#> 17 Norway         confirmed        1463
#> 18 Korea, South   recovered        1407
#> 19 Austria        confirmed        1332
#> 20 Belgium        confirmed        1243
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-17):

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
#> # A tibble: 152 x 4
#> # Groups:   country [152]
#>    country        confirmed death recovered
#>    <chr>              <int> <int>     <int>
#>  1 Italy               3526   345       192
#>  2 Germany             1985     7         0
#>  3 Spain               1806   191       498
#>  4 US                  1789    23         0
#>  5 Iran                1178   135       799
#>  6 France              1031     0         0
#>  7 Switzerland          500    13         0
#>  8 United Kingdom       409     0        32
#>  9 Austria              314     0        -5
#> 10 Netherlands          294    19         0
#> 11 Belgium              185     5         0
#> 12 Norway               130     0         0
#> 13 Brazil               121     1         1
#> 14 Portugal             117     1         0
#> 15 Malaysia             107     2         7
#> 16 Pakistan             100     0         0
#> 17 Czechia               98     0         0
#> 18 Denmark               92     1         0
#> 19 Sweden                87     1         0
#> 20 Korea, South          84     6       270
#> 21 Israel                82     0         7
#> 22 Australia             75     2         0
#> 23 Canada                63     1         0
#> 24 Luxembourg            63     0         0
#> 25 Poland                61     1         0
#> 26 Greece                56     1         0
#> 27 Ireland               54     0         5
#> 28 Japan                 53     2         0
#> 29 Saudi Arabia          53     0         4
#> 30 Chile                 46     0         0
#> 31 Egypt                 46     2         5
#> 32 Philippines           45     0         3
#> 33 Finland               44     0         0
#> 34 Iceland               40     1         0
#> 35 Indonesia             38     0         0
#> 36 Andorra               37     0         0
#> 37 Peru                  31     0         1
#> 38 Iraq                  30     1         6
#> 39 Thailand              30     0         6
#> 40 Mexico                29     0         0
#> # … with 112 more rows
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
