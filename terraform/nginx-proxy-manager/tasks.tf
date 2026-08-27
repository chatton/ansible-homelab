resource "nginxproxymanager_certificate_letsencrypt" "tasks" {
  domain_names      = ["tasks.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "tasks" {
  domain_names   = ["tasks.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.dell_host
  forward_port   = 3457

  certificate_id          = nginxproxymanager_certificate_letsencrypt.tasks.id
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
