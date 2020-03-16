#libraries for data processing
library(sf)
library(dplyr)

#For the data
library(rnaturalearth)
#devtools::install_github("ropensci/rnaturalearthhires)
library(rnaturalearthhires)

all_states_rnaturalearth <- ne_states(returnclass="sf")

states_of_the_world <- all_states_rnaturalearth %>%
  select(name, type,  admin, iso_3166_2) %>%
  rename(Region.Type = type)

world_map <- ne_countries(returnclass="sf") %>%
  select(name, iso_a3)


#saveRDS(states_info_select, "./data_raw/select_info_states_rnaturalearth_sf.Rds")
usethis::use_data(states_of_the_world, overwrite = TRUE)
usethis::use_data(world_map, overwrite = TRUE)
