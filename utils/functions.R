
# get detailed club events info
get_club_lineups <- function(x, club_id) {

  if (file.exists(glue("data-raw/lineups-club/{club_id}.json"))) return()

  club_pos <- future_map_lgl(x, function(y) {

    if (length(y) != 2) return(FALSE)

    y[["club_id"]] == club_id
  })

  club_events <- x[club_pos]

  lineups <- future_map(club_events[[1]]$events$event_id, ra_get_event)

  write_json(lineups, path = glue("data-raw/lineups-club/{club_id}.json"))

  lineups
}
