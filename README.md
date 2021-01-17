
# who-plays-fabric

Data and code used in the *who plays fabric* project.

## related work

Data is sourced from the [ldn-venues](https://github.com/club-cooking/ldn-venues) project.

## data

This folder contains the data, detailed below.

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

### `artists.csv`

2,762 artists who have played at fabric (2012-2020). 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| artist_name | The name of the artist |
| artist_id | A numeric identifier used for the artist on RA |

### `artists-augmented.csv`

2,762 artists who have played at fabric (2012-2020), with self-collected fields (inc. demographic data). 

Data dictionary:

| Column    | Description                                                                                                                                                                |
|:----------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| artist_name | The name of the artist |
| artist_id | A numeric identifier used for the artist on RA |
| ethnicity | Estimate of artist's ethnic group |
| gender | Estimate of artist's gender identification |
| genre | Estimate of genre the artist is most known for |

