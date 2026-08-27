resource "nginxproxymanager_certificate_letsencrypt" "bookstack" {
  domain_names      = ["bookstack.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "bookstack" {
  domain_names   = ["bookstack.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.dell_host
  forward_port   = 6875

  certificate_id          = nginxproxymanager_certificate_letsencrypt.bookstack.id
  ssl_forced              = false
  caching_enabled         = false
  block_exploits          = true
  allow_websocket_upgrade = true
  http2_support           = false
  hsts_enabled            = false
  hsts_subdomains         = false
  advanced_config         = ""
  enabled                 = true
}
