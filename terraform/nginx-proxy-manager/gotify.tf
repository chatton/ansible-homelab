resource "nginxproxymanager_certificate_letsencrypt" "gotify" {
  domain_names      = ["gotify.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "gotify" {
  domain_names   = ["gotify.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.dell_host
  forward_port   = 7875

  certificate_id          = nginxproxymanager_certificate_letsencrypt.gotify.id
  ssl_forced              = true
  caching_enabled         = false
  block_exploits          = true
  allow_websocket_upgrade = true
  http2_support           = false
  hsts_enabled            = false
  hsts_subdomains         = false
  advanced_config         = ""
  enabled                 = true
}
