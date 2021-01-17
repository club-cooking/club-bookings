
# setup -------------------------------------------------------------------

# load packages
library(jsonlite)
library(dplyr)
library(tidyr)
library(lubridate)
library(readr)
library(tsibble)

# function for cumulative counting of distinct values
dist_cum <- function(var) {
  sapply(seq_along(var), function(x) length(unique(head(var, x))))
}

# load --------------------------------------------------------------------

fabric_lineups <- read_json(
  "https://github.com/club-cooking/ldn-venues/blob/master/data/lineups-club.json?raw=true",
  simplifyVector = TRUE, flatten = TRUE
)

# clean -------------------------------------------------------------------

fabric_lineups <- fabric_lineups[sapply(fabric_lineups$artists, length) == 2, ] # remove bad events
fabric_lineups <- fabric_lineups[!sapply(fabric_lineups$event_id, is.null), ] # remove bad events

fabric_lineups_long <- fabric_lineups %>% 
  dplyr::filter(venue_id == 237) %>% 
  unnest(artists) %>% 
  unnest(promoters) %>% 
  mutate_at(vars(-event_date), unlist) %>% 
  select(-venue_id, -venue_name)

# remove bad events
fabric_lineups_long <- fabric_lineups_long[sapply(fabric_lineups_long$event_date, length) == 1, ] 
fabric_lineups_long$event_date <- as.Date(unlist(fabric_lineups_long$event_date))
fabric_lineups_long <- mutate(fabric_lineups_long, day = wday(event_date, label = TRUE))

# reorder cols
fabric_lineups_long <- select(fabric_lineups_long, event_id:event_date, day, everything())

# create unique artists lookup, since 2012
fabric_artists <- fabric_lineups_long %>% 
  dplyr::filter(year(event_date) >= 2012) %>% 
  distinct(artist_name, artist_id)

# export ------------------------------------------------------------------

write_csv(fabric_lineups_long, "data/bookings.csv")
write_csv(fabric_artists, "data/artist-lookup.csv")
