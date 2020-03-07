
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
#>          Province.State Country.Region     Lat     Long       date cases      type
#> 3028           Shanghai Mainland China 31.2020 121.4491 2020-03-06     3 recovered
#> 3029            Sichuan Mainland China 30.6171 102.7103 2020-03-06    17 recovered
#> 3030 Suffolk County, MA             US 42.3601 -71.0589 2020-03-06     1 recovered
#> 3031           Xinjiang Mainland China 41.1129  85.2401 2020-03-06     1 recovered
#> 3032             Yunnan Mainland China 24.9740 101.4870 2020-03-06     1 recovered
#> 3033           Zhejiang Mainland China 29.1832 120.0934 2020-03-06    23 recovered
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
#>    <chr>          <chr>           <dbl>
#>  1 Mainland China confirmed       80573
#>  2 Mainland China recovered       53888
#>  3 South Korea    confirmed        6593
#>  4 Iran           confirmed        4747
#>  5 Italy          confirmed        4636
#>  6 Mainland China death            3042
#>  7 Iran           recovered         913
#>  8 Others         confirmed         696
#>  9 Germany        confirmed         670
#> 10 France         confirmed         653
#> 11 Italy          recovered         523
#> 12 Japan          confirmed         420
#> 13 Spain          confirmed         400
#> 14 US             confirmed         278
#> 15 Switzerland    confirmed         214
#> 16 Italy          death             197
#> 17 UK             confirmed         163
#> 18 South Korea    recovered         135
#> 19 Singapore      confirmed         130
#> 20 Netherlands    confirmed         128
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-06):

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
#> # A tibble: 65 x 4
#> # Groups:   country [65]
#>    country            confirmed recovered death
#>    <chr>                  <dbl>     <dbl> <dbl>
#>  1 Iran                    1234       174    17
#>  2 Italy                    778       109    49
#>  3 South Korea              505        94     7
#>  4 France                   276        NA     3
#>  5 Germany                  188         1    NA
#>  6 Mainland China           151      1648    29
#>  7 Spain                    141        NA     2
#>  8 Switzerland              100        NA    NA
#>  9 Japan                     60         3    NA
#> 10 Belgium                   59        NA    NA
#> 11 US                        57         0     2
#> 12 UK                        48        NA     1
#> 13 Netherlands               46        NA     1
#> 14 Malaysia                  33        NA    NA
#> 15 Norway                    21        NA    NA
#> 16 Austria                   14        NA    NA
#> 17 Greece                    14        NA    NA
#> 18 Denmark                   13         1    NA
#> 19 Singapore                 13        NA    NA
#> 20 Canada                    12        NA    NA
#> 21 Egypt                     12        NA    NA
#> 22 Ireland                   12        NA    NA
#> 23 Palestine                 12        NA    NA
#> 24 Brazil                     9        NA    NA
#> 25 Iceland                    9        NA    NA
#> 26 Russia                     9        NA    NA
#> 27 Estonia                    7        NA    NA
#> 28 Sweden                     7        NA    NA
#> 29 Czech Republic             6        NA    NA
#> 30 Lebanon                    6        NA    NA
#> 31 Algeria                    5        NA    NA
#> 32 Australia                  5        NA    NA
#> 33 Bahrain                    5         4    NA
#> 34 Iraq                       5        NA     1
#> 35 Israel                     5         1    NA
#> 36 Portugal                   5        NA    NA
#> 37 Slovenia                   5        NA    NA
#> 38 Poland                     4        NA    NA
#> 39 Finland                    3        NA    NA
#> 40 Romania                    3        NA    NA
#> 41 Hong Kong                  2         3    NA
#> 42 Indonesia                  2        NA    NA
#> 43 North Macedonia            2        NA    NA
#> 44 Philippines                2        NA    NA
#> 45 Argentina                  1        NA    NA
#> 46 Bhutan                     1        NA    NA
#> 47 Cameroon                   1        NA    NA
#> 48 Colombia                   1        NA    NA
#> 49 Costa Rica                 1        NA    NA
#> 50 Croatia                    1        NA    NA
#> 51 Dominican Republic         1        NA    NA
#> 52 India                      1        NA    NA
#> 53 Luxembourg                 1        NA    NA
#> 54 Mexico                     1        NA    NA
#> 55 New Zealand                1        NA    NA
#> 56 Pakistan                   1        NA    NA
#> 57 Peru                       1        NA    NA
#> 58 Serbia                     1        NA    NA
#> 59 Slovakia                   1        NA    NA
#> 60 Taiwan                     1        NA    NA
#> 61 Thailand                   1        NA    NA
#> 62 Togo                       1        NA    NA
#> 63 Vatican City               1        NA    NA
#> 64 Others                   -10        30    NA
#> 65 Macau                     NA         1    NA
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
