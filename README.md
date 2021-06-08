
# club-bookings

Data on club bookings listed on Resident Advisor (RA). Full history for:

- Fabric
- Corsica Studios
- XOYO

N.B. This dataset was scraped from RA in mid-2020, prior to a major site overhaul. The code will need adapting to work with the current site.

## data-raw

This folder contains the raw data files scraped from RA, in .json format.

## data

This folder contains the processed data files, detailed below.

### `clubs.csv`

Data on clubs in London listed on RA. 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| club_name      | The name of the club                                                                                                                                 |
| club_address   | The address of the club                                                                                                                 |
| club_id     | A numeric identifier used for the club on RA                                                                                                                                |
| club_status  | Logical; is the club open or closed |

### `artists.csv`

Data on artists listed on RA. 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| artist_id      | A unique identifier used for the artist on RA                                                                                                                                 |
| artist_name   | The name of the artist                                                                                                                 |
| event_id     | A numeric identifier used for the event on RA                                                                                                                                |
| club_id  | A numeric identifier used for the club on RA |

### `promoters.csv`

Data on promoters listed on RA. 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| promoter_id      | A numeric identifier used for the promoter on RA                                                                                                                                 |
| promoter_name   | The name of the promoter                                                                                                                 |
| event_id     | A numeric identifier used for the event on RA                                                                                                                                |
| club_id  | A numeric identifier used for the club on RA |

### `events.csv`

Data on events in London listed on RA.

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| event_id   | A numeric identifier used for the event on RA                                                                                                               |
| event_name     | The name of the event                                                                                                                                |
| event_date  | The date of the event |
| club_id      | A numeric identifier used for the club on RA  |

## code

Follow numeric prefix for the correct order of running each .R script:

- `01-scrape.R`: create all raw data (`data-raw/`) files
- `02-tidy-data.R`: create final data (`data/`) files

## config

Config files to change the behaviour of the scraper, specifically the detailed event info (i.e. lineups). Edit `club-config.yml` if you want to pull line-ups for different clubs.
