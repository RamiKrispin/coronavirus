
<!-- README.md is generated from README.Rmd. Please edit that file -->

# coronavirus <a href='https://RamiKrispin.github.io/coronavirus/'><img src='man/figures/coronavirus.png' align="right"  /></a>

<!-- badges: start --->

[![build](https://github.com/RamiKrispin/coronavirus/workflows/build/badge.svg?branch=master)](https://github.com/RamiKrispin/coronavirus/actions?query=workflow%3Abuild)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/coronavirus)](https://cran.r-project.org/package=coronavirus)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![License:
MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub
commit](https://img.shields.io/github/last-commit/RamiKrispin/coronavirus)](https://github.com/RamiKrispin/coronavirus/commit/master)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/coronavirus)](https://cran.r-project.org/package=coronavirus)

<!-- badges: end -->

The coronavirus package provides a tidy format dataset of the 2019 Novel
Coronavirus COVID-19 (2019-nCoV) epidemic and the vaccination efforts by
country. The raw data is being pulled from the Johns Hopkins University
Center for Systems Science and Engineering (JHU CCSE) Coronavirus
[repository](https://github.com/CSSEGISandData/COVID-19).

More details available
[here](https://RamiKrispin.github.io/coronavirus/), and a `csv` format
of the package dataset available
[here](https://github.com/RamiKrispin/coronavirus/tree/master/csv)

<img src="man/figures/2019-nCoV-CDC-23312_without_background.png" width="65%" align="center"/></a>

<figcaption>
Source: Centers for Disease Control and Prevention’s Public Health Image
Library
</figcaption>

## Important Notes

-   As this an ongoing situation, frequent changes in the data format
    may occur, please visit the package
    [changelog](https://ramikrispin.github.io/coronavirus/news/index.html)
    (e.g., News) and/or see pinned
    [issues](https://github.com/RamiKrispin/coronavirus/issues) to get
    updates about those changes
-   As of Auguest 4th JHU CCSE stopped track recovery cases, please see
    this [issue](https://github.com/RamiKrispin/coronavirus/issues/71)
    for more details
-   Negative values and/or anomalies may occurred in the data for the
    following reasons:
    -   The calculation of the daily cases from the raw data which is in
        cumulative format is done by taking the daily difference. In
        some cases, some retro updates not tie to the day that they
        actually occurred such as removing false positive cases
    -   Anomalies or error in the raw data
    -   Please see this
        [issue](https://github.com/RamiKrispin/coronavirus/issues/55)
        for more details

## Vignettes

Additional documentation available on the followng vignettes:

-   [Introduction to the Coronavirus
    Dataset](https://ramikrispin.github.io/coronavirus/articles/intro_coronavirus_dataset.html)
-   [Covid19R Project Data
    Format](https://ramikrispin.github.io/coronavirus/articles/covid19R.html)
-   [Update the coronavirus
    Dataset](https://ramikrispin.github.io/coronavirus/articles/update_dataset_function.html)
-   [Covid19 Vaccine
    Data](https://ramikrispin.github.io/coronavirus/articles/covid19_vaccine.html)
-   [Geospatial
    Visualization](https://ramikrispin.github.io/coronavirus/articles/geospatial_visualization.html)

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

## Datasets

The package provides the following two datasets:

-   **coronavirus** - tidy (long) format of the JHU CCSE
    [datasets](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series).
    That includes the following columns:

    -   `date` - The date of the observation, using `Date` class
    -   `province` - Name of province/state, for countries where data is
        provided split across multiple provinces/states
    -   `country` - Name of country/region
    -   `lat` - The latitude code
    -   `long` - The longitude code
    -   `type` - An indicator for the type of cases (confirmed, death,
        recovered)
    -   `cases` - Number of cases on given date
    -   `uid` - Country code
    -   `province_state` - Province or state if applicable
    -   `iso2` - Officially assigned country code identifiers with
        two-letter
    -   `iso3` - Officially assigned country code identifiers with
        three-letter
    -   `code3` - UN country code
    -   `fips` - Federal Information Processing Standards code that
        uniquely identifies counties within the USA
    -   `combined_key` - Country and province (if applicable)
    -   `population` - Country or province population
    -   `continent_name` - Continent name
    -   `continent_code` - Continent code

-   **covid19\_vaccine** - a tidy (long) format of the the Johns Hopkins
    [Centers for Civic Impact](https://civicimpact.jhu.edu/) global
    vaccination
    [dataset](https://github.com/govex/COVID-19/tree/master/data_tables/vaccine_data)
    by country. This dataset includes the following columns:

    -   `country_region` - Country or region name
    -   `date` - Data collection date in YYYY-MM-DD format
    -   `doses_admin` - Cumulative number of doses administered. When a
        vaccine requires multiple doses, each one is counted
        independently
    -   `people_partially_vaccinated` - Cumulative number of people who
        received at least one vaccine dose. When the person receives a
        prescribed second dose, it is not counted twice
    -   `people_fully_vaccinated` - Cumulative number of people who
        received all prescribed doses necessary to be considered fully
        vaccinated
    -   `report_date_string` - Data report date in YYYY-MM-DD format
    -   `uid` - Country code
    -   `province_state` - Province or state if applicable
    -   `iso2` - Officially assigned country code identifiers with
        two-letter
    -   `iso3` - Officially assigned country code identifiers with
        three-letter
    -   `code3` - UN country code
    -   `fips` - Federal Information Processing Standards code that
        uniquely identifies counties within the USA
    -   `lat` - Latitude
    -   `long` - Longitude
    -   `combined_key` - Country and province (if applicable)
    -   `population` - Country or province population
    -   `continent_name` - Continent name
    -   `continent_code` - Continent code

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

Alternatively, you can pull the data using the
[Covid19R](https://covid19r.github.io/documentation/) project [data
standard
format](https://covid19r.github.io/documentation/data-format-standard.html)
with the `refresh_coronavirus_jhu` function:

``` r
covid19_df <- refresh_coronavirus_jhu()
head(covid19_df)
#>         date    location location_type location_code location_code_type data_type value      lat      long
#> 1 2020-12-30 Afghanistan       country            AF         iso_3166_2 cases_new   183 33.93911 67.709953
#> 2 2021-02-20 Afghanistan       country            AF         iso_3166_2 cases_new     5 33.93911 67.709953
#> 3 2021-02-08 Afghanistan       country            AF         iso_3166_2 cases_new    24 33.93911 67.709953
#> 4 2021-02-11 Afghanistan       country            AF         iso_3166_2 cases_new    18 33.93911 67.709953
#> 5 2021-02-06 Afghanistan       country            AF         iso_3166_2 cases_new    65 33.93911 67.709953
#> 6 2021-02-10 Afghanistan       country            AF         iso_3166_2 cases_new    18 33.93911 67.709953
```

## Usage

``` r
data("coronavirus")

head(coronavirus)
#>         date province country     lat      long      type cases   uid iso2 iso3 code3 fips admin2    combined_key population continent_name continent_code
#> 1 2020-01-22  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN   124   NA   <NA> Alberta, Canada    4413146  North America             NA
#> 2 2020-01-23  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN   124   NA   <NA> Alberta, Canada    4413146  North America             NA
#> 3 2020-01-24  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN   124   NA   <NA> Alberta, Canada    4413146  North America             NA
#> 4 2020-01-25  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN   124   NA   <NA> Alberta, Canada    4413146  North America             NA
#> 5 2020-01-26  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN   124   NA   <NA> Alberta, Canada    4413146  North America             NA
#> 6 2020-01-27  Alberta  Canada 53.9333 -116.5765 confirmed     0 12401   CA  CAN   124   NA   <NA> Alberta, Canada    4413146  North America             NA
```

Summary of the total confrimed cases by country (top 20):

``` r
library(dplyr)

summary_df <- coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases)

summary_df %>% head(20) 
#> # A tibble: 20 x 2
#>    country        total_cases
#>    <chr>                <int>
#>  1 US                42410607
#>  2 India             33531498
#>  3 Brazil            21247094
#>  4 Russia            14416482
#>  5 Turkey            13808510
#>  6 United Kingdom     7531922
#>  7 France             7054198
#>  8 Iran               5459796
#>  9 Argentina          5243231
#> 10 Colombia           4943622
#> 11 Spain              4937984
#> 12 Italy              4641890
#> 13 Indonesia          4195958
#> 14 Germany            4162437
#> 15 Mexico             3585565
#> 16 Poland             2899008
#> 17 South Africa       2886331
#> 18 Ukraine            2461415
#> 19 Philippines        2401916
#> 20 Peru               2168431
```

Summary of new cases during the past 24 hours by country and type (as of
2021-09-21):

``` r
library(tidyr)

coronavirus %>% 
  filter(date == max(date)) %>%
  select(country, type, cases) %>%
  group_by(country, type) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type,
              values_from = total_cases) %>%
  arrange(-confirmed)
#> # A tibble: 195 x 4
#> # Groups:   country [195]
#>    country            confirmed death recovered
#>    <chr>                  <int> <int>     <int>
#>  1 US                    120788  2331        NA
#>  2 Turkey                 58676   520        NA
#>  3 Russia                 37592  1594        NA
#>  4 United Kingdom         31188   204        NA
#>  5 India                  26964   383        NA
#>  6 Iran                   17564   379        NA
#>  7 Philippines            16300   140        NA
#>  8 Malaysia               15759   334        NA
#>  9 Mexico                 12521   815        NA
#> 10 Vietnam                11692   240        NA
#> 11 Thailand               10919   143        NA
#> 12 France                  8776   136        NA
#> 13 Cuba                    8289    63        NA
#> 14 Germany                 7277    71        NA
#> 15 Serbia                  7232    38        NA
#> 16 Israel                  7198    12        NA
#> 17 Romania                 6789   129        NA
#> 18 Ukraine                 5542   152        NA
#> 19 Kazakhstan              5456     0        NA
#> 20 Georgia                 4940    92        NA
#> 21 Guatemala               3718    54        NA
#> 22 Greece                  3688    43        NA
#> 23 Canada                  3685    52        NA
#> 24 Italy                   3374    67        NA
#> 25 Indonesia               3263   171        NA
#> 26 Azerbaijan              3188    52        NA
#> 27 Iraq                    3081    42        NA
#> 28 Costa Rica              2731    42        NA
#> 29 Mongolia                2543    13        NA
#> 30 Spain                   2450    82        NA
#> 31 Pakistan                2333    47        NA
#> 32 South Africa            2197   160        NA
#> 33 Bulgaria                2192    58        NA
#> 34 Singapore               2095     5        NA
#> 35 Sweden                  1986    15        NA
#> 36 West Bank and Gaza      1977    17        NA
#> 37 Jordan                  1945    17        NA
#> 38 Belarus                 1917    12        NA
#> 39 Morocco                 1848    51        NA
#> 40 Argentina               1837    61        NA
#> # … with 155 more rows
```

Plotting daily confirmed and death cases in Brazil:

``` r
library(plotly)

coronavirus %>% 
  group_by(type, date) %>%
  summarise(total_cases = sum(cases)) %>%
  pivot_wider(names_from = type, values_from = total_cases) %>%
  arrange(date) %>%
  mutate(active = confirmed - death - recovered) %>%
  mutate(active_total = cumsum(active),
                recovered_total = cumsum(recovered),
                death_total = cumsum(death)) %>%
  plot_ly(x = ~ date,
                  y = ~ active_total,
                  name = 'Active', 
                  fillcolor = '#1f77b4',
                  type = 'scatter',
                  mode = 'none', 
                  stackgroup = 'one') %>%
  add_trace(y = ~ death_total, 
             name = "Death",
             fillcolor = '#E41317') %>%
  add_trace(y = ~recovered_total, 
            name = 'Recovered', 
            fillcolor = 'forestgreen') %>%
  layout(title = "Distribution of Covid19 Cases Worldwide",
         legend = list(x = 0.1, y = 0.9),
         yaxis = list(title = "Number of Cases"),
         xaxis = list(title = "Source: Johns Hopkins University Center for Systems Science and Engineering"))
```

<img src="man/figures/brazil_cases.svg" width="100%" />

Plot the confirmed cases distribution by counrty with treemap plot:

``` r
conf_df <- coronavirus %>% 
  filter(type == "confirmed") %>%
  group_by(country) %>%
  summarise(total_cases = sum(cases)) %>%
  arrange(-total_cases) %>%
  mutate(parents = "Confirmed") %>%
  ungroup() 
  
  plot_ly(data = conf_df,
          type= "treemap",
          values = ~total_cases,
          labels= ~ country,
          parents=  ~parents,
          domain = list(column=0),
          name = "Confirmed",
          textinfo="label+value+percent parent")
```

<img src="man/figures/treemap_conf.svg" width="100%" />

``` r
data(covid19_vaccine)

head(covid19_vaccine)
#>   country_region       date doses_admin people_partially_vaccinated people_fully_vaccinated report_date_string uid province_state iso2 iso3 code3 fips      lat      long combined_key population
#> 1    Afghanistan 2021-02-22           0                           0                       0         2021-02-22   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 2    Afghanistan 2021-02-23           0                           0                       0         2021-02-23   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 3    Afghanistan 2021-02-24           0                           0                       0         2021-02-24   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 4    Afghanistan 2021-02-25           0                           0                       0         2021-02-25   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 5    Afghanistan 2021-02-26           0                           0                       0         2021-02-26   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#> 6    Afghanistan 2021-02-27           0                           0                       0         2021-02-27   4           <NA>   AF  AFG     4 <NA> 33.93911 67.709953  Afghanistan   38928341
#>   continent_name continent_code
#> 1           Asia             AS
#> 2           Asia             AS
#> 3           Asia             AS
#> 4           Asia             AS
#> 5           Asia             AS
#> 6           Asia             AS
```

Plot the top 20 vaccinated countries:

``` r
covid19_vaccine %>% 
  filter(date == max(date),
         !is.na(population)) %>% 
  mutate(fully_vaccinated_ratio = people_fully_vaccinated / population) %>%
  arrange(- fully_vaccinated_ratio) %>%
  slice_head(n = 20) %>%
  arrange(fully_vaccinated_ratio) %>%
  mutate(country = factor(country_region, levels = country_region)) %>%
  plot_ly(y = ~ country,
          x = ~ round(100 * fully_vaccinated_ratio, 2),
          text = ~ paste(round(100 * fully_vaccinated_ratio, 1), "%"),
          textposition = 'auto',
          orientation = "h",
          type = "bar") %>%
  layout(title = "Percentage of Fully Vaccineted Population - Top 20 Countries",
         yaxis = list(title = ""),
         xaxis = list(title = "Source: Johns Hopkins Centers for Civic Impact",
                      ticksuffix = "%"))

```

<img src="man/figures/top20_countries.svg" width="100%" />

## Dashboard

**Note:** Currently, the dashboard is under maintenance due to recent
changes in the data structure. Please see this
[issue](https://github.com/RamiKrispin/coronavirus_dashboard/issues/25)

A supporting dashboard is available
[here](https://ramikrispin.github.io/coronavirus_dashboard/)

[<img src="man/figures/dashboard.png" width="100%" />](https://ramikrispin.github.io/coronavirus_dashboard/)

## Data Sources

The raw data pulled and arranged by the Johns Hopkins University Center
for Systems Science and Engineering (JHU CCSE) from the following
resources:

-   World Health Organization (WHO): <https://www.who.int/> <br>
-   DXY.cn. Pneumonia. 2020.
    <https://ncov.dxy.cn/ncovh5/view/pneumonia>. <br>
-   BNO News:
    <https://bnonews.com/index.php/2020/04/the-latest-coronavirus-cases/>
    <br>
-   National Health Commission of the People’s Republic of China (NHC):
    <br> http:://www.nhc.gov.cn/xcs/yqtb/list\_gzbd.shtml <br>
-   China CDC (CCDC):
    http:://weekly.chinacdc.cn/news/TrackingtheEpidemic.htm <br>
-   Hong Kong Department of Health:
    <https://www.chp.gov.hk/en/features/102465.html> <br>
-   Macau Government: <https://www.ssm.gov.mo/portal/> <br>
-   Taiwan CDC:
    <https://sites.google.com/cdc.gov.tw/2019ncov/taiwan?authuser=0>
    <br>
-   US CDC: <https://www.cdc.gov/coronavirus/2019-ncov/index.html> <br>
-   Government of Canada:
    <https://www.canada.ca/en/public-health/services/diseases/2019-novel-coronavirus-infection/symptoms.html>
    <br>
-   Australia Government Department of
    Health:<https://www.health.gov.au/news/health-alerts/novel-coronavirus-2019-ncov-health-alert>
    <br>
-   European Centre for Disease Prevention and Control (ECDC):
    <https://www.ecdc.europa.eu/en/geographical-distribution-2019-ncov-cases>
-   Ministry of Health Singapore (MOH):
    <https://www.moh.gov.sg/covid-19>
-   Italy Ministry of Health:
    <https://www.salute.gov.it/nuovocoronavirus>
-   1Point3Arces: <https://coronavirus.1point3acres.com/en>
-   WorldoMeters: <https://www.worldometers.info/coronavirus/>
-   COVID Tracking Project: <https://covidtracking.com/data>. (US
    Testing and Hospitalization Data. We use the maximum reported value
    from “Currently” and “Cumulative” Hospitalized for our
    hospitalization number reported for each state.)
-   French Government: <https://dashboard.covid19.data.gouv.fr/>
-   COVID Live (Australia): <https://covidlive.com.au/>
-   Washington State Department of
    Health:<https://www.doh.wa.gov/Emergencies/COVID19>
-   Maryland Department of Health: <https://coronavirus.maryland.gov/>
-   New York State Department of Health:
    <https://health.data.ny.gov/Health/New-York-State-Statewide-COVID-19-Testing/xdss-u53e/data>
-   NYC Department of Health and Mental Hygiene:
    <https://www1.nyc.gov/site/doh/covid/covid-19-data.page> and
    <https://github.com/nychealth/coronavirus-data>
-   Florida Department of Health Dashboard:
    <https://services1.arcgis.com/CY1LXxl9zlJeBuRZ/arcgis/rest/services/Florida_COVID19_Cases/FeatureServer/0>
    and
    <https://fdoh.maps.arcgis.com/apps/opsdashboard/index.html#/8d0de33f260d444c852a615dc7837c86>
-   Palestine (West Bank and Gaza): <https://corona.ps/details>
-   Israel:
    <https://govextra.gov.il/ministry-of-health/corona/corona-virus/>
-   Colorado: <https://covid19.colorado.gov/data>)
