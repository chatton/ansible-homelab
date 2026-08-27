resource "nginxproxymanager_certificate_letsencrypt" "bookmarks" {
  domain_names      = ["bookmarks.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "bookmarks" {
  domain_names    = ["bookmarks.cianhatton.ie"]
  forward_scheme  = "http"
  forward_host    = "192.168.0.101"
  forward_port    = 9090

  certificate_id          = nginxproxymanager_certificate_letsencrypt.bookmarks.id
  ssl_forced              = false
  caching_enabled         = false
  block_exploits          = true
  allow_websocket_upgrade = false
  http2_support           = false
  hsts_enabled            = false
  hsts_subdomains         = false
  advanced_config         = ""
  enabled                 = true
}
