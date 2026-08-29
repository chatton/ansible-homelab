provider "sonarr" {
  url     = "http://${var.qnap}:8989"
  api_key = var.sonarr_api_key
}
