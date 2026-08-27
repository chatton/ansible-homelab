resource "nginxproxymanager_certificate_letsencrypt" "vault" {
  domain_names      = ["vault.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "vault" {
  domain_names   = ["vault.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.dell_host
  forward_port   = 80

  certificate_id          = nginxproxymanager_certificate_letsencrypt.vault.id
  ssl_forced              = true
  caching_enabled         = false
  block_exploits          = true
  allow_websocket_upgrade = true
  http2_support           = true
  hsts_enabled            = true
  hsts_subdomains         = false
  advanced_config         = ""
  enabled                 = true
}
