library(jsonlite)
library(dplyr)
library(tidyr)
library(lubridate)
library(readr)
library(tsibble)

dist_cum <- function(var)
  sapply(seq_along(var), function(x) length(unique(head(var, x))))

fabric_lineups <- read_json(
  "https://github.com/club-cooking/ldn-venues/blob/master/data/lineups-club.json?raw=true",
  simplifyVector = TRUE, flatten = TRUE
)
fabric_lineups <- fabric_lineups[sapply(fabric_lineups$artists, length) == 2, ] # remove bad events
fabric_lineups <- fabric_lineups[!sapply(fabric_lineups$event_id, is.null), ] # remove bad events

fabric_lineups_long <- fabric_lineups %>% 
  dplyr::filter(venue_id == 237) %>% 
  unnest(artists) %>% 
  mutate_at(vars(-event_date, -promoters), unlist) %>% 
  select(-promoters, -venue_id, -venue_name)

# remove bad events
fabric_lineups_long <- fabric_lineups_long[sapply(fabric_lineups_long$event_date, length) == 1, ] 
fabric_lineups_long$event_date <- as.Date(unlist(fabric_lineups_long$event_date))
fabric_lineups_long <- mutate(fabric_lineups_long, day = wday(event_date, label = TRUE))

# create unique artists lookup
fabric_artists <- distinct(fabric_lineups_long, artist_name, artist_id)

write_csv(fabric_lineups_long, "data-raw/bookings.csv")
write_csv(fabric_lineups_long, "data-raw/artists.csv")
