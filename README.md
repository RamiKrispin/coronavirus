
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
#> 2772        Shaanxi Mainland China 35.1917 108.8701 2020-03-04     7 recovered
#> 2773       Shandong Mainland China 36.3427 118.1498 2020-03-04     5 recovered
#> 2774       Shanghai Mainland China 31.2020 121.4491 2020-03-04     4 recovered
#> 2775        Sichuan Mainland China 30.6171 102.7103 2020-03-04    12 recovered
#> 2776       Xinjiang Mainland China 41.1129  85.2401 2020-03-04     1 recovered
#> 2777       Zhejiang Mainland China 29.1832 120.0934 2020-03-04    21 recovered
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
#>  1 Mainland China confirmed       80271
#>  2 Mainland China recovered       49955
#>  3 South Korea    confirmed        5621
#>  4 Italy          confirmed        3089
#>  5 Mainland China death            2981
#>  6 Iran           confirmed        2922
#>  7 Others         confirmed         706
#>  8 Iran           recovered         552
#>  9 Japan          confirmed         331
#> 10 France         confirmed         285
#> 11 Italy          recovered         276
#> 12 Germany        confirmed         262
#> 13 Spain          confirmed         222
#> 14 US             confirmed         153
#> 15 Singapore      confirmed         110
#> 16 Italy          death             107
#> 17 Hong Kong      confirmed         105
#> 18 Iran           death              92
#> 19 Switzerland    confirmed          90
#> 20 UK             confirmed          85
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-04):

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
#> # A tibble: 49 x 4
#> # Groups:   country [49]
#>    country          confirmed death recovered
#>    <chr>                <int> <int>     <int>
#>  1 Italy                  587    28       116
#>  2 Iran                   586    15       261
#>  3 South Korea            435     7        11
#>  4 Mainland China         120    36      2551
#>  5 France                  81    NA        NA
#>  6 Germany                 66    NA        NA
#>  7 Spain                   57     1        NA
#>  8 Japan                   38    NA        NA
#>  9 Switzerland             34    NA         1
#> 10 UK                      34    NA        NA
#> 11 US                      31     4        NA
#> 12 Norway                  24    NA        NA
#> 13 India                   23    NA        NA
#> 14 Iceland                 15    NA        NA
#> 15 Malaysia                14    NA        NA
#> 16 Netherlands             14    NA        NA
#> 17 Sweden                  14    NA        NA
#> 18 Australia               13     1        NA
#> 19 Belgium                 10    NA        NA
#> 20 Austria                  8    NA        NA
#> 21 Algeria                  7    NA        NA
#> 22 San Marino               6    NA        NA
#> 23 Belarus                  5    NA        NA
#> 24 Hong Kong                5    NA        NA
#> 25 Denmark                  4    NA        NA
#> 26 Ireland                  4    NA        NA
#> 27 Bahrain                  3    NA        NA
#> 28 Canada                   3    NA        NA
#> 29 Czech Republic           3    NA        NA
#> 30 Ecuador                  3    NA        NA
#> 31 Iraq                     3     2        NA
#> 32 Israel                   3    NA        NA
#> 33 Oman                     3    NA        NA
#> 34 Portugal                 3    NA        NA
#> 35 Saint Barthelemy         3    NA        NA
#> 36 Brazil                   2    NA        NA
#> 37 Greece                   2    NA        NA
#> 38 Hungary                  2    NA        NA
#> 39 New Zealand              2    NA        NA
#> 40 Senegal                  2    NA        NA
#> 41 Croatia                  1    NA        NA
#> 42 Faroe Islands            1    NA        NA
#> 43 Gibraltar                1    NA        NA
#> 44 Liechtenstein            1    NA        NA
#> 45 Poland                   1    NA        NA
#> 46 Qatar                    1    NA        NA
#> 47 Romania                  1    NA         1
#> 48 Tunisia                  1    NA        NA
#> 49 Lebanon                 NA    NA         1
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
