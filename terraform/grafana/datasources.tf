resource "grafana_data_source" "prometheus" {
  type       = "prometheus"
  name       = "Prometheus"
  url        = var.prometheus_url
  access_mode = "proxy"
  is_default = true

  json_data_encoded = jsonencode({
    httpMethod = "POST"
  })
}

resource "grafana_data_source" "loki" {
  type       = "loki"
  name       = "Loki"
  url        = var.loki_url
  access_mode = "proxy"
  is_default = false
}
