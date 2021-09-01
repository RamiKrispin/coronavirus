df <- read.csv("~/coronavirus/csv/world_population.csv",
             stringsAsFactors = FALSE) |>
  dplyr::select(c(- Indicator.Code, - Indicator.Name)) |>
  tidyr::pivot_longer(cols = dplyr::starts_with(c("X")),
                      names_to = "year_temp",
                      values_to = "population") |>
  dplyr::mutate(year = as.numeric(substr(year_temp, start = 2, stop = 5))) |>
  dplyr::select(country_name = Country.Name, country_code = Country.Code, year, population)

head(df)


table(is.na(df$country_code))
table(is.na(df$country_name))
table(is.na(df$year))
table(is.na(df$population))
world_population <- df
usethis::use_data(world_population, overwrite = TRUE, compress = "xz")
