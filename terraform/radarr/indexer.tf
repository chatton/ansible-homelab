resource "radarr_indexer_newznab" "nzbgeek" {
  name                      = "NZBgeek"
  enable_rss                = true
  enable_automatic_search   = true
  enable_interactive_search = true
  priority                  = 25

  base_url              = "https://api.nzbgeek.info"
  api_path              = "/api"
  api_key               = var.nzbgeek_api_key
  categories            = [2000, 2010, 2020, 2030, 2040, 2045, 2050, 2060]
  remove_year           = false
  additional_parameters = ""
  multi_languages       = []
  download_client_id    = 0
  tags                  = []
}
