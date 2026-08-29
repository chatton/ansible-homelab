resource "sonarr_indexer_newznab" "nzbgeek" {
  name                      = "NZBgeek"
  enable_rss                = true
  enable_automatic_search   = true
  enable_interactive_search = true
  priority                  = 25

  base_url                     = "https://api.nzbgeek.info"
  api_path                     = "/api"
  api_key                      = var.nzbgeek_api_key
  categories                   = [5030, 5040]
  anime_categories             = []
  anime_standard_format_search = false
  additional_parameters        = ""
  download_client_id           = 0
  tags                         = []
}
