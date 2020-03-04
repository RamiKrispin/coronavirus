
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
#> 2675         Shanxi Mainland China 37.5777 112.2922 2020-03-03     5 recovered
#> 2676        Sichuan Mainland China 30.6171 102.7103 2020-03-03     8 recovered
#> 2677        Tianjin Mainland China 39.3054 117.3230 2020-03-03    13 recovered
#> 2678       Xinjiang Mainland China 41.1129  85.2401 2020-03-03     2 recovered
#> 2679         Yunnan Mainland China 24.9740 101.4870 2020-03-03     1 recovered
#> 2680       Zhejiang Mainland China 29.1832 120.0934 2020-03-03    24 recovered
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
#>  1 Mainland China confirmed       80151
#>  2 Mainland China recovered       47404
#>  3 South Korea    confirmed        5186
#>  4 Mainland China death            2945
#>  5 Italy          confirmed        2502
#>  6 Iran           confirmed        2336
#>  7 Others         confirmed         706
#>  8 Japan          confirmed         293
#>  9 Iran           recovered         291
#> 10 France         confirmed         204
#> 11 Germany        confirmed         196
#> 12 Spain          confirmed         165
#> 13 Italy          recovered         160
#> 14 US             confirmed         122
#> 15 Singapore      confirmed         110
#> 16 Hong Kong      confirmed         100
#> 17 Italy          death              79
#> 18 Singapore      recovered          78
#> 19 Iran           death              77
#> 20 Kuwait         confirmed          56
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-03):

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
#>    country              confirmed death recovered
#>    <chr>                    <int> <int>     <int>
#>  1 South Korea                851    NA        NA
#>  2 Iran                       835    11        NA
#>  3 Italy                      466    27        11
#>  4 Mainland China             125    33      2594
#>  5 Spain                       45     1        NA
#>  6 Germany                     37    NA        NA
#>  7 US                          21     1         1
#>  8 Japan                       19    NA        11
#>  9 Switzerland                 14    NA         2
#> 10 France                      13     1        NA
#> 11 UK                          11    NA        NA
#> 12 Australia                    9    NA        NA
#> 13 Malaysia                     7    NA         4
#> 14 Norway                       7    NA        NA
#> 15 Iraq                         6    NA        NA
#> 16 Netherlands                  6    NA        NA
#> 17 Oman                         6    NA         1
#> 18 Sweden                       6    NA        NA
#> 19 United Arab Emirates         6    NA        NA
#> 20 Belgium                      5    NA        NA
#> 21 Iceland                      5    NA        NA
#> 22 Qatar                        4    NA        NA
#> 23 Austria                      3    NA        NA
#> 24 Canada                       3    NA        NA
#> 25 Algeria                      2    NA        NA
#> 26 Croatia                      2    NA        NA
#> 27 Czech Republic               2    NA        NA
#> 28 Denmark                      2    NA        NA
#> 29 Israel                       2    NA        NA
#> 30 San Marino                   2     1        NA
#> 31 Singapore                    2    NA        NA
#> 32 Argentina                    1    NA        NA
#> 33 Chile                        1    NA        NA
#> 34 Ecuador                      1    NA        NA
#> 35 Estonia                      1    NA        NA
#> 36 Ireland                      1    NA        NA
#> 37 Jordan                       1    NA        NA
#> 38 Others                       1    NA        NA
#> 39 Pakistan                     1    NA        NA
#> 40 Senegal                      1    NA        NA
#> 41 Taiwan                       1    NA        NA
#> 42 Ukraine                      1    NA        NA
#> 43 Hong Kong                   NA    NA         1
#> 44 Macau                       NA    NA         1
#> 45 Mexico                      NA    NA         1
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
