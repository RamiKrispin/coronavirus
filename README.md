
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
#>   Province.State    Country.Region     Lat     Long       date cases      type
#> 1                            Japan 36.0000 138.0000 2020-01-22     2 confirmed
#> 2                Republic of Korea 36.0000 128.0000 2020-01-22     1 confirmed
#> 3                         Thailand 15.0000 101.0000 2020-01-22     2 confirmed
#> 4          Anhui    Mainland China 31.8257 117.2264 2020-01-22     1 confirmed
#> 5        Beijing    Mainland China 40.1824 116.4142 2020-01-22    14 confirmed
#> 6      Chongqing    Mainland China 30.0572 107.8740 2020-01-22     6 confirmed
tail(coronavirus) 
#>      Province.State      Country.Region     Lat     Long       date cases      type
#> 3622       Shanghai      Mainland China 31.2020 121.4491 2020-03-10     4 recovered
#> 3623         Shanxi      Mainland China 37.5777 112.2922 2020-03-10     4 recovered
#> 3624        Sichuan      Mainland China 30.6171 102.7103 2020-03-10    12 recovered
#> 3625         Taiwan Taipei and environs 23.7000 121.0000 2020-03-10     2 recovered
#> 3626        Tianjin      Mainland China 39.3054 117.3230 2020-03-10     1 recovered
#> 3627       Zhejiang      Mainland China 29.1832 120.0934 2020-03-10    15 recovered
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
#>    Country.Region             type      total_cases
#>    <chr>                      <chr>           <int>
#>  1 Mainland China             confirmed       80757
#>  2 Mainland China             recovered       60106
#>  3 Italy                      confirmed       10149
#>  4 Iran (Islamic Republic of) confirmed        8042
#>  5 Republic of Korea          confirmed        7513
#>  6 Mainland China             death            3136
#>  7 Iran (Islamic Republic of) recovered        2731
#>  8 France                     confirmed        1784
#>  9 Spain                      confirmed        1695
#> 10 Germany                    confirmed        1457
#> 11 US                         confirmed         777
#> 12 Italy                      recovered         724
#> 13 Others                     confirmed         696
#> 14 Italy                      death             631
#> 15 Japan                      confirmed         581
#> 16 Switzerland                confirmed         491
#> 17 Norway                     confirmed         400
#> 18 Netherlands                confirmed         382
#> 19 UK                         confirmed         382
#> 20 Sweden                     confirmed         355
```

Summary of new cases during the past 24 hours by country and type (as of
2020-03-10):

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
#> # A tibble: 81 x 4
#> # Groups:   country [81]
#>    country                        confirmed recovered death
#>    <chr>                              <int>     <int> <int>
#>  1 Italy                                977        NA   168
#>  2 Iran (Islamic Republic of)           881       337    54
#>  3 Spain                                622        NA     7
#>  4 France                               575        NA    14
#>  5 Germany                              281        NA    NA
#>  6 Norway                               195        NA    NA
#>  7 US                                   193        NA     6
#>  8 Denmark                              172        NA    NA
#>  9 Switzerland                          117        NA     1
#> 10 Sweden                               107        NA    NA
#> 11 Japan                                 70        25    NA
#> 12 Netherlands                           61        NA     1
#> 13 UK                                    61        NA     2
#> 14 Austria                               51         2    NA
#> 15 Republic of Korea                     35       129     1
#> 16 United Arab Emirates                  29         5    NA
#> 17 Belgium                               28        NA    NA
#> 18 Mainland China                        22      1371    16
#> 19 Israel                                19         2    NA
#> 20 Australia                             16        NA    NA
#> 21 Greece                                16        NA    NA
#> 22 Bahrain                               15         8    NA
#> 23 San Marino                            15        NA     1
#> 24 Slovenia                              15        NA    NA
#> 25 India                                 13         1    NA
#> 26 Ireland                               13        NA    NA
#> 27 Philippines                           13         1    NA
#> 28 Malaysia                              12        NA    NA
#> 29 Iceland                               11         1    NA
#> 30 Iraq                                  11        NA     1
#> 31 Portugal                              11        NA    NA
#> 32 Czech Republic                        10        NA    NA
#> 33 Finland                               10        NA    NA
#> 34 Pakistan                              10        NA    NA
#> 35 Romania                               10        NA    NA
#> 36 Singapore                             10        NA    NA
#> 37 Lebanon                                9        NA     1
#> 38 Albania                                8        NA    NA
#> 39 Indonesia                              8         2    NA
#> 40 Brazil                                 6        NA    NA
#> 41 Poland                                 6        NA    NA
#> 42 Qatar                                  6        NA    NA
#> 43 Argentina                              5        NA    NA
#> 44 Chile                                  5        NA    NA
#> 45 Hong Kong SAR                          5         6    NA
#> 46 Kuwait                                 5        NA    NA
#> 47 Saudi Arabia                           5         1    NA
#> 48 Egypt                                  4        NA    NA
#> 49 North Macedonia                        4        NA    NA
#> 50 Peru                                   4        NA    NA
#> 51 Serbia                                 4        NA    NA
#> 52 Slovakia                               4        NA    NA
#> 53 South Africa                           4        NA    NA
#> 54 Belarus                                3         2    NA
#> 55 occupied Palestinian territory         3        NA    NA
#> 56 Russian Federation                     3        NA    NA
#> 57 Thailand                               3         2    NA
#> 58 Tunisia                                3        NA    NA
#> 59 Azerbaijan                             2        NA    NA
#> 60 Bosnia and Herzegovina                 2        NA    NA
#> 61 Canada                                 2        NA    NA
#> 62 Colombia                               2        NA    NA
#> 63 Croatia                                2        NA    NA
#> 64 Estonia                                2        NA    NA
#> 65 Latvia                                 2         1    NA
#> 66 Luxembourg                             2        NA    NA
#> 67 Maldives                               2        NA    NA
#> 68 Malta                                  2        NA    NA
#> 69 Oman                                   2         7    NA
#> 70 Republic of Moldova                    2        NA    NA
#> 71 Taipei and environs                    2         2    NA
#> 72 Afghanistan                            1        NA    NA
#> 73 Burkina Faso                           1        NA    NA
#> 74 Channel Islands                        1        NA    NA
#> 75 Cyprus                                 1        NA    NA
#> 76 Mongolia                               1        NA    NA
#> 77 Morocco                                1        NA     1
#> 78 Panama                                 1        NA    NA
#> 79 Viet Nam                               1        NA    NA
#> 80 Gibraltar                             NA         1    NA
#> 81 Mexico                                NA         3    NA
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
