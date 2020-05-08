
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://RamiKrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/RamiKrispin/coronavirus)](https://github.com/RamiKrispin/coronavirus/commit/master)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/coronavirus)](https://cran.r-project.org/package=coronavirus)

<!-- badges: end -->

The coronavirus package provides a tidy format dataset of the 2019 Novel
Coronavirus COVID-19 (2019-nCoV) epidemic. The raw data pulled from the
Johns Hopkins University Center for Systems Science and Engineering (JHU
CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

More details available
[here](https://RamiKrispin.github.io/coronavirus/), and a `csv` format
of the package dataset available
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
devtools::install_github("RamiKrispin/coronavirus")
```

## Data refresh

While the **coronavirus** [CRAN
version](https://cran.r-project.org/package=coronavirus) is updated
every month or two, the [Github (Dev)
version](https://github.com/RamiKrispin/coronavirus) is updated on a
daily bases. The `update_dataset` function enables to overcome this gap
and keep the installed version with the most recent data available on
the Github version:

``` r
library(coronavirus)
update_dataset()
```

**Note:** must restart the R session to have the updates available

## Usage

``` r
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
#> 83883       Zhejiang          China 29.1832 120.0934 2020-05-02     0 recovered
#> 83884       Zhejiang          China 29.1832 120.0934 2020-05-03     0 recovered
#> 83885       Zhejiang          China 29.1832 120.0934 2020-05-04     2 recovered
#> 83886       Zhejiang          China 29.1832 120.0934 2020-05-05     0 recovered
#> 83887       Zhejiang          China 29.1832 120.0934 2020-05-06     0 recovered
#> 83888       Zhejiang          China 29.1832 120.0934 2020-05-07     0 recovered
```

Here is an example of a summary total cases by region and type (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% group_by(Country.Region, type) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 3
#> # Groups:   Country.Region [12]
#>    Country.Region type      total_cases
#>    <chr>          <chr>           <int>
#>  1 US             confirmed     1257023
#>  2 Spain          confirmed      221447
#>  3 Italy          confirmed      215858
#>  4 United Kingdom confirmed      207977
#>  5 US             recovered      195036
#>  6 Russia         confirmed      177160
#>  7 France         confirmed      174918
#>  8 Germany        confirmed      169430
#>  9 Germany        recovered      141700
#> 10 Brazil         confirmed      135773
#> 11 Turkey         confirmed      133721
#> 12 Spain          recovered      128511
#> 13 Iran           confirmed      103135
#> 14 Italy          recovered       96276
#> 15 China          confirmed       83975
#> 16 Turkey         recovered       82984
#> 17 Iran           recovered       82744
#> 18 China          recovered       78977
#> 19 US             death           75662
#> 20 Canada         confirmed       66201
```

Summary of new cases during the past 24 hours by country and type (as of
2020-05-07):

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
#> # A tibble: 187 x 4
#> # Groups:   country [187]
#>    country              confirmed death recovered
#>    <chr>                    <int> <int>     <int>
#>  1 US                       28420  2231      5126
#>  2 Russia                   11231    88      2476
#>  3 Brazil                    9162   602      3980
#>  4 United Kingdom            5618   539        36
#>  5 Peru                      3709    94       861
#>  6 India                     3364   104      1445
#>  7 Mexico                    1982   257         0
#>  8 Turkey                    1977    57      4782
#>  9 Saudi Arabia              1793    10      1015
#> 10 Chile                     1533     4       475
#> 11 Canada                    1507   175      1076
#> 12 Iran                      1485    68      1157
#> 13 Italy                     1401   274      3031
#> 14 Germany                   1268   117      1800
#> 15 Spain                     1122   213      2509
#> 16 Qatar                      918     0       216
#> 17 Belarus                    913     4       679
#> 18 Singapore                  741     0        78
#> 19 Bangladesh                 706    13       507
#> 20 Sweden                     705    99       897
#> 21 France                     694   178      1112
#> 22 Belgium                    639    76       249
#> 23 Pakistan                   571    21         0
#> 24 Portugal                   533    16       182
#> 25 Ukraine                    507    13       299
#> 26 United Arab Emirates       502     8       213
#> 27 Colombia                   497    10       152
#> 28 Netherlands                455    85         1
#> 29 South Africa               424     8         0
#> 30 Egypt                      393    13        72
#> 31 Romania                    392    24       356
#> 32 Nigeria                    381     4        67
#> 33 Philippines                339    27       112
#> 34 Indonesia                  338    35        64
#> 35 Poland                     307    22       207
#> 36 Dominican Republic         288    11       104
#> 37 Kuwait                     278     2       162
#> 38 Bahrain                    265     0       140
#> 39 Honduras                   224     6        22
#> 40 Japan                      224    21       422
#> # … with 147 more rows
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
