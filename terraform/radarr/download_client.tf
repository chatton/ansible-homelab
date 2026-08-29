resource "radarr_download_client_nzbget" "nzbget" {
  enable         = true
  priority       = 1
  name           = "NZBGet"
  host           = var.qnap
  port           = 6789
  use_ssl        = false
  username       = "nzbget"
  password       = var.nzbget_password
  movie_category = "Movies"
  url_base       = ""
  tags           = []

  recent_movie_priority = 0
  older_movie_priority  = 0
  add_paused            = false

  remove_completed_downloads = true
  remove_failed_downloads    = true
}
