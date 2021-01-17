
# setup -------------------------------------------------------------------

library(googlesheets4)

# load --------------------------------------------------------------------

artists <- read_sheet(
  "https://docs.google.com/spreadsheets/d/1hkqQG5VA7XLGadcRqy-66BW-97rHqPJyHHrKikbRyIw",
  sheet = "artists",
  col_types = "ccccc"
  )

# export ------------------------------------------------------------------

write_csv(artists, "data/artists-augmented.csv")

