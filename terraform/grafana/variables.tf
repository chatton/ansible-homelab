variable "grafana_url" {
  description = "Base URL of the Grafana instance (e.g. http://10.4.5.201:3030)"
  type        = string
}

variable "grafana_admin_user" {
  description = "Grafana admin username (must match GF_SECURITY_ADMIN_USER set by roles/portainer_grafana via vault_vars)"
  type        = string
  sensitive   = true
}

variable "grafana_admin_password" {
  description = "Grafana admin password (must match GF_SECURITY_ADMIN_PASSWORD set by roles/portainer_grafana via vault_vars)"
  type        = string
  sensitive   = true
}

variable "prometheus_url" {
  description = "URL of the Prometheus datasource, reachable from Grafana"
  type        = string
  default     = "http://10.4.5.201:9095"
}

variable "loki_url" {
  description = "URL of the Loki datasource, reachable from Grafana"
  type        = string
  default     = "http://10.4.5.201:3100"
}

variable "gotify_base_url" {
  description = "Internal LAN base URL of the Gotify instance (e.g. http://10.4.5.201:7875) used as the Grafana alerting contact point -- use the LAN address, not the public domain, since the request would otherwise NAT-hairpin through the router and can fail there"
  type        = string
}

variable "gotify_api_token" {
  description = "Gotify application API token used to authenticate the alert webhook"
  type        = string
  sensitive   = true
}
