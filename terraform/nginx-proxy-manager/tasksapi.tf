resource "nginxproxymanager_certificate_letsencrypt" "tasksapi" {
  domain_names      = ["tasksapi.cianhatton.ie"]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "tasksapi" {
  domain_names   = ["tasksapi.cianhatton.ie"]
  forward_scheme = "http"
  forward_host   = var.dell_host
  forward_port   = 3456

  certificate_id          = nginxproxymanager_certificate_letsencrypt.tasksapi.id
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
