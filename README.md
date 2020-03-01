
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
#> 2395        Sichuan Mainland China 30.6171 102.7103 2020-02-29    13 recovered
#> 2396         Taiwan         Taiwan 23.7000 121.0000 2020-02-29     3 recovered
#> 2397        Tianjin Mainland China 39.3054 117.3230 2020-02-29     7 recovered
#> 2398       Xinjiang Mainland China 41.1129  85.2401 2020-02-29    10 recovered
#> 2399         Yunnan Mainland China 24.9740 101.4870 2020-02-29     1 recovered
#> 2400       Zhejiang Mainland China 29.1832 120.0934 2020-02-29    41 recovered
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
#>  1 Mainland China confirmed       79251
#>  2 Mainland China recovered       39279
#>  3 South Korea    confirmed        3150
#>  4 Mainland China death            2835
#>  5 Italy          confirmed        1128
#>  6 Others         confirmed         705
#>  7 Iran           confirmed         593
#>  8 Japan          confirmed         241
#>  9 Iran           recovered         123
#> 10 Singapore      confirmed         102
#> 11 France         confirmed         100
#> 12 Hong Kong      confirmed          95
#> 13 Germany        confirmed          79
#> 14 Singapore      recovered          72
#> 15 US             confirmed          70
#> 16 Italy          recovered          46
#> 17 Kuwait         confirmed          45
#> 18 Spain          confirmed          45
#> 19 Iran           death              43
#> 20 Thailand       confirmed          42
```

Summary of new cases during the past 24 hours by country and type (as of
2020-02-29):

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
#> # A tibble: 38 x 4
#> # Groups:   country [38]
#>    country              confirmed recovered death
#>    <chr>                    <int>     <int> <int>
#>  1 South Korea                813         5     3
#>  2 Mainland China             427      2988    47
#>  3 Italy                      240        NA     8
#>  4 Iran                       205        50     9
#>  5 France                      43         1    NA
#>  6 Germany                     31        NA    NA
#>  7 Japan                       13        10     1
#>  8 Spain                       13        NA    NA
#>  9 Switzerland                 10        NA    NA
#> 10 Norway                       9        NA    NA
#> 11 Singapore                    9        10    NA
#> 12 US                           8        NA     1
#> 13 Austria                      6        NA    NA
#> 14 Canada                       6        NA    NA
#> 15 Iraq                         6        NA    NA
#> 16 Bahrain                      5        NA    NA
#> 17 Netherlands                  5        NA    NA
#> 18 Sweden                       5        NA    NA
#> 19 Taiwan                       5         3    NA
#> 20 Israel                       3        NA    NA
#> 21 Mexico                       3        NA    NA
#> 22 UK                           3        NA    NA
#> 23 Australia                    2        NA    NA
#> 24 Denmark                      2        NA    NA
#> 25 Lebanon                      2        NA    NA
#> 26 Malaysia                     2        NA    NA
#> 27 Oman                         2         1    NA
#> 28 Pakistan                     2        NA    NA
#> 29 United Arab Emirates         2        NA    NA
#> 30 Brazil                       1        NA    NA
#> 31 Croatia                      1        NA    NA
#> 32 Finland                      1        NA    NA
#> 33 Hong Kong                    1         3    NA
#> 34 Ireland                      1        NA    NA
#> 35 Luxembourg                   1        NA    NA
#> 36 Monaco                       1        NA    NA
#> 37 Qatar                        1        NA    NA
#> 38 Thailand                     1        NA    NA
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
