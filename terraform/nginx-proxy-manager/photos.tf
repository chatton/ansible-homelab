resource "nginxproxymanager_certificate_letsencrypt" "photos" {
  domain_names      = ["photos.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "photos" {
  domain_names   = ["photos.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.qnap_host
  forward_port   = 2342

  certificate_id          = nginxproxymanager_certificate_letsencrypt.photos.id
  ssl_forced              = true
  caching_enabled         = false
  block_exploits          = true
  allow_websocket_upgrade = false
  http2_support           = true
  hsts_enabled            = false
  hsts_subdomains         = false
  advanced_config         = ""
  enabled                 = true
}
