resource "nginxproxymanager_certificate_letsencrypt" "paste" {
  domain_names      = ["paste.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "paste" {
  domain_names   = ["paste.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = "192.168.178.46"
  forward_port   = 8000

  certificate_id          = nginxproxymanager_certificate_letsencrypt.paste.id
  ssl_forced              = true
  caching_enabled         = false
  block_exploits          = true
  allow_websocket_upgrade = false
  http2_support           = false
  hsts_enabled            = false
  hsts_subdomains         = false
  advanced_config         = ""
  enabled                 = true
}
