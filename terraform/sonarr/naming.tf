resource "sonarr_naming" "current" {
  rename_episodes            = true
  replace_illegal_characters = true
  colon_replacement_format   = 4
  multi_episode_style        = 0
  standard_episode_format    = "{Series Title} - S{season:00}E{episode:00} - {Episode Title} {Quality Full}"
  daily_episode_format       = "{Series Title} - {Air-Date} - {Episode Title} {Quality Full}"
  anime_episode_format       = "{Series Title} - S{season:00}E{episode:00} - {Episode Title} {Quality Full}"
  series_folder_format       = "{Series Title}"
  season_folder_format       = "Season {season}"
  specials_folder_format     = "Specials"
}
