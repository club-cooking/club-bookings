
# who-plays-fabric

Data and code used in the *who play's fabric* project.

## related work

Data is sourced from the [ldn-venues](https://github.com/club-cooking/ldn-venues) project.

## data-raw

This folder contains raw data files, detailed below.

### `bookings.csv`

18,193 historic fabric bookings (1999-2020). 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| event_id   | A numeric identifier used for the event on RA  |
| event_name | The name of the event |
| event_date | The date of the event |
| day | The weekday of the event |
| artist_name | The name of the artist |
| artist_id | A numeric identifier used for the artist on RA |
| promoter_name | The name of the promoter |
| promoter_id | A numeric identifier used for the promoter on RA |

### `artist-lookup.csv`

2,762 artists who have played at fabric (2012-2020). 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| artist_name | The name of the artist |
| artist_id | A numeric identifier used for the artist on RA |
