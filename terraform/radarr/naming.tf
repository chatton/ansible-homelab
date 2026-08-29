resource "radarr_naming" "current" {
  rename_movies              = false
  replace_illegal_characters = true
  colon_replacement_format   = "delete"
  standard_movie_format      = "{Movie Title} ({Release Year}) {Quality Full}"
  movie_folder_format        = "{Movie Title} ({Release Year})"
}
