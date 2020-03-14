#libraries for data processing
library(sf)
library(dplyr)

#For the data
library(rnaturalearth)
#devtools::install_github("ropensci/rnaturalearthhires)
library(rnaturalearthhires)

all_states_rnaturalearth <- ne_states(returnclass="sf")

states_info_select <- all_states_rnaturalearth %>%
  select(name, type,  admin, iso_3166_2) %>%
  rename(Region.Type = type)

saveRDS(states_info_select, "./data_raw/select_info_states_rnaturalearth_sf.Rds")
