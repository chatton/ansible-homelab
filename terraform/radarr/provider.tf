provider "radarr" {
  url     = "http://${var.qnap}:7878"
  api_key = var.radarr_api_key
}
