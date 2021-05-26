
# setup -------------------------------------------------------------------

# load packages
library(jsonlite)
library(purrr)
library(furrr)
library(readr)
library(dplyr)
library(tidyr)

# get clubs data
clubs <- read_json("data-raw/clubs.json", simplifyVector = TRUE)

# get events data
events <- read_json("data-raw/events.json", simplifyVector = TRUE)
events <- events[sapply(events, length) == 2] # remove missing records

# get lineups x club
lineups_club_files <- list.files("data-raw/lineups-club", full.names = TRUE)
lineups_club <- future_map_dfr(lineups_club_files, read_json, simplifyVector = TRUE)

# clean data --------------------------------------------------------------

# create lineups x month dataframe
lineups_club_df <- lineups_club

# remove bad events
lineups_club_df <- lineups_club_df[!sapply(lineups_club_df$artists, length) == 0, ]
lineups_club_df <- lineups_club_df[!sapply(lineups_club_df$promoters, length) == 0, ]
lineups_club_df <- lineups_club_df[!sapply(lineups_club_df$event_date, length) == 0, ]
lineups_club_df <- lineups_club_df[!sapply(lineups_club_df$venue_id, length) == 0, ]
lineups_club_df <- lineups_club_df %>%
  mutate(across(event_id:venue_name, ~unlist(.x)))

# create events dataframe
events_df <- future_map_dfr(events, function(x){
  df <- x[["events"]]
  df$club_id <- as.numeric(x[["club_id"]])
  df
})
events_df <- events_df[!sapply(events_df$event_id, is.null), ] # remove bad events
events_df <- mutate_all(events_df, unlist)
events_df$event_date <- as.Date(events_df$event_date)
events_df <- dplyr::filter(events_df, club_id %in% unique(lineups_club_df$venue_id))

# create club-level dataframe
clubs_df <- clubs %>%
  mutate_all(unlist) %>%
  select(club_id, everything()) %>% 
  dplyr::filter(club_id %in% unique(lineups_club_df$venue_id))

# create artist-level df
artists <- lineups_club_df[sapply(lineups_club_df$artists, length) == 2, ] %>% # remove bad events
  unnest(artists) %>%
  mutate(across(c(artist_name, artist_id), ~unlist(.x))) %>%
  select(artist_id, artist_name)

# create promoter-level df
promoters <- lineups_club_df[sapply(lineups_club_df$promoters, length) == 2, ] %>% # remove bad events
  unnest(promoters) %>%
  mutate(across(c(promoter_name, promoter_id), ~unlist(.x))) %>%
  select(promoter_id, promoter_name)

# export ------------------------------------------------------------------

write_csv(clubs_df, "data/clubs.csv")
write_csv(events_df, "data/events.csv")
write_csv(artists, "data/artists.csv")
write_csv(promoters, "data/promoters.csv")
