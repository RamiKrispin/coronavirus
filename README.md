
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
#>      Province.State Country.Region     Lat     Long       date cases      type
#> 3147       Shandong Mainland China 36.3427 118.1498 2020-03-07     9 recovered
#> 3148       Shanghai Mainland China 31.2020 121.4491 2020-03-07     7 recovered
#> 3149        Sichuan Mainland China 30.6171 102.7103 2020-03-07    12 recovered
#> 3150    Toronto, ON         Canada 43.6532 -79.3832 2020-03-07     1 recovered
#> 3151       Xinjiang Mainland China 41.1129  85.2401 2020-03-07     1 recovered
#> 3152       Zhejiang Mainland China 29.1832 120.0934 2020-03-07     7 recovered
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
#>  1 Mainland China confirmed       80652
#>  2 Mainland China recovered       55478
#>  3 South Korea    confirmed        7041
#>  4 Italy          confirmed        5883
#>  5 Iran           confirmed        5823
#>  6 Mainland China death            3070
#>  7 Iran           recovered        1669
#>  8 France         confirmed         949
#>  9 Germany        confirmed         799
#> 10 Others         confirmed         696
#> 11 Italy          recovered         589
#> 12 Spain          confirmed         500
#> 13 Japan          confirmed         461
#> 14 US             confirmed         417
#> 15 Switzerland    confirmed         268
#> 16 Italy          death             233
#> 17 UK             confirmed         206
#> 18 Netherlands    confirmed         188
#> 19 Belgium        confirmed         169
#> 20 Sweden         confirmed         161
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-07):

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
#> # A tibble: 45 x 4
#> # Groups:   country [45]
#>    country                confirmed recovered death
#>    <chr>                      <int>     <int> <int>
#>  1 Italy                       1247        66    36
#>  2 Iran                        1076       756    21
#>  3 South Korea                  448        NA     2
#>  4 France                       296        NA     2
#>  5 US                           140        NA     3
#>  6 Germany                      129         1    NA
#>  7 Spain                        100        28     5
#>  8 Mainland China                79      1590    28
#>  9 Belgium                       60        NA    NA
#> 10 Netherlands                   60        NA    NA
#> 11 Sweden                        60        NA    NA
#> 12 Switzerland                   54        NA    NA
#> 13 UK                            43        10    NA
#> 14 Japan                         41        30    NA
#> 15 Norway                        39        NA    NA
#> 16 Bahrain                       25        NA    NA
#> 17 Austria                       24        NA    NA
#> 18 United Arab Emirates          16         2    NA
#> 19 Iraq                          14        NA     1
#> 20 Malaysia                      10         1    NA
#> 21 Singapore                      8        NA    NA
#> 22 Iceland                        7        NA    NA
#> 23 Portugal                       7        NA    NA
#> 24 Argentina                      6        NA    NA
#> 25 Palestine                      6        NA    NA
#> 26 Canada                         5         2    NA
#> 27 French Guiana                  5        NA    NA
#> 28 Australia                      3        NA    NA
#> 29 Azerbaijan                     3        NA    NA
#> 30 India                          3        NA    NA
#> 31 Kuwait                         3        NA    NA
#> 32 Malta                          3        NA    NA
#> 33 Hungary                        2        NA    NA
#> 34 Martinique                     2        NA    NA
#> 35 San Marino                     2        NA    NA
#> 36 Thailand                       2        NA    NA
#> 37 Vietnam                        2        NA    NA
#> 38 Bosnia and Herzegovina         1        NA    NA
#> 39 Croatia                        1        NA    NA
#> 40 Czech Republic                 1        NA    NA
#> 41 Greece                         1        NA    NA
#> 42 Hong Kong                      1         5    NA
#> 43 New Zealand                    1        NA    NA
#> 44 Philippines                    1        NA    NA
#> 45 Romania                       NA         2    NA
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
