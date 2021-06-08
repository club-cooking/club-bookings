
# setup -------------------------------------------------------------------

# source packages
library(ahhray) # devtools::install_github("club-cooking/ahhray")
library(jsonlite)
library(dplyr)
library(tidyr)
library(purrr)
library(furrr)
library(glue)
library(readr)
library(yaml)

# get local functions
source("utils/functions.R")

# get selected clubs' lineup history
club_config <- read_yaml("config/club-config.yml") %>% 
  bind_rows()

# get clubs ---------------------------------------------------------------

clubs <- ra_get_region_clubs(ai = 13, include_closed = TRUE)
write_json(clubs$clubs, path = "data-raw/clubs.json")

# get events --------------------------------------------------------------

future_map(clubs$club_id, possibly(ra_get_club_events, NA_real_)) %>%
  write_json(path = "data-raw/events.json")

# get club lineups --------------------------------------------------------

# get events data
events <- read_json("data/events.json", simplifyVector = TRUE)

# get detailed event info
future_map(club_config$club_id, ~get_club_lineups(events, club_id = .x))
