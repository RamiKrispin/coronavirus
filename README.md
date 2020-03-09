
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
#> 3314       Shandong Mainland China 36.3427 118.1498 2020-03-08    15 recovered
#> 3315       Shanghai Mainland China 31.2020 121.4491 2020-03-08     1 recovered
#> 3316        Sichuan Mainland China 30.6171 102.7103 2020-03-08    10 recovered
#> 3317         Taiwan         Taiwan 23.7000 121.0000 2020-03-08     1 recovered
#> 3318       Xinjiang Mainland China 41.1129  85.2401 2020-03-08     1 recovered
#> 3319       Zhejiang Mainland China 29.1832 120.0934 2020-03-08     7 recovered
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
#>  1 Mainland China confirmed       80699
#>  2 Mainland China recovered       57320
#>  3 Italy          confirmed        7375
#>  4 South Korea    confirmed        7314
#>  5 Iran           confirmed        6566
#>  6 Mainland China death            3097
#>  7 Iran           recovered        2134
#>  8 France         confirmed        1126
#>  9 Germany        confirmed        1040
#> 10 Others         confirmed         696
#> 11 Spain          confirmed         673
#> 12 Italy          recovered         622
#> 13 US             confirmed         538
#> 14 Japan          confirmed         502
#> 15 Italy          death             366
#> 16 Switzerland    confirmed         337
#> 17 UK             confirmed         273
#> 18 Netherlands    confirmed         265
#> 19 Sweden         confirmed         203
#> 20 Belgium        confirmed         200
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-08):

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
#> # A tibble: 72 x 4
#> # Groups:   country [72]
#>    country             confirmed death recovered
#>    <chr>                   <int> <int>     <int>
#>  1 Italy                    1492   133        33
#>  2 Iran                      743    49       465
#>  3 South Korea               273     6       -17
#>  4 Germany                   241    NA        NA
#>  5 France                    177     8        NA
#>  6 Spain                     173     7        NA
#>  7 US                        122     4        NA
#>  8 Netherlands                77     2        NA
#>  9 Switzerland                69     1        NA
#> 10 UK                         67     1        NA
#> 11 Mainland China             47    27      1842
#> 12 Sweden                     42    NA        NA
#> 13 Japan                      41    NA        NA
#> 14 Egypt                      34     1        NA
#> 15 Belgium                    31    NA        NA
#> 16 Norway                     29    NA        NA
#> 17 Greece                     27    NA        NA
#> 18 Austria                    25    NA        NA
#> 19 Republic of Ireland        21    NA        NA
#> 20 Israel                     18    NA        NA
#> 21 Australia                  13     2        NA
#> 22 San Marino                 13    NA        NA
#> 23 Czech Republic             12    NA        NA
#> 24 Denmark                    12    NA        NA
#> 25 Singapore                  12    NA        NA
#> 26 Vietnam                    12    NA        NA
#> 27 Canada                     10    NA        NA
#> 28 Lebanon                    10    NA        NA
#> 29 Portugal                   10    NA        NA
#> 30 Georgia                     9    NA        NA
#> 31 Slovenia                    9    NA        NA
#> 32 Finland                     8    NA        NA
#> 33 Brazil                      7    NA        NA
#> 34 Qatar                       7    NA        NA
#> 35 Hong Kong                   6     1         7
#> 36 Iraq                        6     2        NA
#> 37 Malaysia                    6    NA         1
#> 38 Poland                      6    NA        NA
#> 39 Romania                     6    NA        NA
#> 40 Saudi Arabia                6    NA        NA
#> 41 India                       5    NA        NA
#> 42 Peru                        5    NA        NA
#> 43 Argentina                   4     1        NA
#> 44 Bulgaria                    4    NA        NA
#> 45 Chile                       4    NA        NA
#> 46 Costa Rica                  4    NA        NA
#> 47 Maldives                    4    NA        NA
#> 48 Philippines                 4    NA        NA
#> 49 Russia                      4    NA         1
#> 50 Afghanistan                 3    NA        NA
#> 51 Bangladesh                  3    NA        NA
#> 52 Dominican Republic          3    NA        NA
#> 53 Hungary                     3    NA        NA
#> 54 Kuwait                      3    NA         1
#> 55 Algeria                     2    NA        NA
#> 56 Indonesia                   2    NA        NA
#> 57 Slovakia                    2    NA        NA
#> 58 South Africa                2    NA        NA
#> 59 Cambodia                    1    NA        NA
#> 60 Cameroon                    1    NA        NA
#> 61 Ecuador                     1    NA        NA
#> 62 Faroe Islands               1    NA        NA
#> 63 Ireland                     1    NA        NA
#> 64 Latvia                      1    NA        NA
#> 65 Luxembourg                  1    NA        NA
#> 66 Mexico                      1    NA        NA
#> 67 Moldova                     1    NA        NA
#> 68 Paraguay                    1    NA        NA
#> 69 Tunisia                     1    NA        NA
#> 70 Pakistan                   NA    NA         1
#> 71 Senegal                    NA    NA         1
#> 72 Taiwan                     NA    NA         1
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
