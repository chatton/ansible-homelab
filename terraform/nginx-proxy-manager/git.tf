resource "nginxproxymanager_certificate_letsencrypt" "git" {
  domain_names      = ["git.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "git" {
  domain_names   = ["git.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.dell_host
  forward_port   = 3000

  certificate_id          = nginxproxymanager_certificate_letsencrypt.git.id
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
