#make an iso-3166-2 table
#some things we need
`%>%` <- magrittr::`%>%`
setwd(here::here())
#source("data-raw/dplyr::left_join")


get_code_table <- function() {
  # get iso 3166 2 codes
  iso_codes <-
    read.csv(
      "https://github.com/olahol/iso-3166-2.js/raw/master/data.csv",
      col.names = c(
        "Country",
        "iso_3166_2",
        "name",
        "type",
        "Country_iso_3166_2"
      ),
      na.strings = "."
    ) %>%
    dplyr::mutate(
      name = ifelse(
        iso_3166_2 == "NL-BQ1",
        "Bonaire and Sint Eustatius and Saba",
        name
      ),
      Country = ifelse(iso_3166_2 == "VG-VG", "British Virgin Islands", Country),
      Country = ifelse(
        Country_iso_3166_2 == "CD",
        "The Democratic Republic Of The Congo",
        Country
      ),
      Country = ifelse(Country_iso_3166_2 == "CZ", "Czechia", Country),
    )

  country_code <- iso_codes %>%
    dplyr::mutate(location = Country) %>%
    dplyr::group_by(location) %>%
    dplyr::summarize(location_code = Country_iso_3166_2[1]) %>%
    dplyr::bind_rows(
      data.frame(location = "Cabo Verde", location_code = "CV"),
      data.frame(location = "Greenland, Denmark", location_code = "GL"),
      data.frame(location = "Cote d'Ivoire", location_code = "CI")
    ) #do not know why these were missing

  province_code <- iso_codes %>%
    dplyr::mutate(type = ifelse(iso_3166_2 == "NL-AW", "Province", type)) %>% # problem with Aruba
    dplyr::filter(type != "Country") %>%
    dplyr::mutate(location = paste(name, Country, sep = ", ")) %>%
    dplyr::group_by(location) %>%
    dplyr::summarize(location_code = iso_3166_2[1]) %>%
    dplyr::bind_rows(
      data.frame(location = "Channel Islands, United Kingdom", location_code = "GB-CHA"),
      data.frame(location = "Tibet, China", location_code = "CN-XZ"),
      data.frame(location = "Inner Mongolia, China", location_code = "CN-NM")
    )

  code_table <- dplyr::bind_rows(country_code, province_code) %>%
    dplyr::mutate(
      location_code_type = "iso_3166_2",
      location = dplyr::case_when(
        location == "Cayman Islands" ~ "Cayman Islands, United Kingdom",
        location == "Anguilla" ~ "Anguilla, United Kingdom",
        location == "Kinshasa, The Democratic Republic Of The Congo" ~ "Congo (Kinshasa)",
        location == "Brazzaville, Congo" ~ "Congo (Brazzaville)",
        location == "Brunei Darussalam" ~ "Brunei",
        location == "Myanmar" ~ "Burma",
        location ==  "Falkland Islands" ~ "Falkland Islands (Malvinas), United Kingdom",
        location == "Swaziland" ~ "Eswatini",
        location == "Bermuda" ~ "Bermuda, United Kingdom",
        location == "Curaçao" ~ "Curacao, Netherlands",
        location == "French Polynesia" ~ "French Polynesia, France",
        location == "British Virgin Islands" ~ "British Virgin Islands, United Kingdom",
        location == "Faroe Islands" ~ "Faroe Islands, Denmark",
        location == "French Guiana" ~ "French Guiana, France",
        location == "French Guiana" ~ "French Guiana, France",
        location == "Gibraltar" ~ "Gibraltar, United Kingdom",
        location == "Vatican City" ~ "Holy See",
        location == "Vatican City" ~ "Holy See",
        location == "Isle of Man" ~ "Isle of Man, United Kingdom",
        location == "Kosovo-Metohija, Serbia" ~ "Kosovo",
        location == "Macau" ~ "Macau, China",
        location == "Montserrat" ~ "Montserrat, United Kingdom",
        location == "New Caledonia" ~ "New Caledonia, France",
        location == "Macedonia, the Former Yugoslav Republic Of" ~ "North Macedonia",
        location == "Reunion" ~ "Reunion, France",
        location == "Saint-Barthélemy, France" ~ "Saint Barthelemy, France",
        location == "Saint Kitts And Nevis" ~ "Saint Kitts and Nevis",
        location == "Saint-Pierre-et-Miquelon, France" ~ "Saint Pierre and Miquelon, France",
        location == "Saint Vincent And The Grenadines" ~ "Saint Vincent and the Grenadines",
        location == "St. Maarten" ~ "Sint Maarten, Netherlands",
        location == "Korea, Republic of" ~ "South Korea",
        location == "Saint-Martin, France" ~ "St Martin, France",
        location == "Taiwan" ~ "Taiwan*",
        location == "East Timor" ~ "Timor-Leste",
        location == "Turks & Caicos Islands" ~ "Turks and Caicos Islands, United Kingdom",
        location == "United States" ~ "US",
        location == "Viet Nam" ~ "Vietnam",
        location == "Gaza, Palestine" ~ "West Bank and Gaza",
        TRUE ~ location
      )
    )


  code_table
}

iso_3166_2_code_table <- get_code_table()
readr::write_csv(iso_3166_2_code_table, "data_raw/iso_3166_2_code_table.csv")
#usethis::use_data(iso_3166_2_code_table)
