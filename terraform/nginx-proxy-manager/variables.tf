variable "npm_url" {
  description = "Full Nginx Proxy Manager URL with protocol and port (e.g. http://qnap:8181)"
  type        = string
}

variable "npm_username" {
  description = "Nginx Proxy Manager admin login email"
  type        = string
  sensitive   = true
}

variable "npm_password" {
  description = "Nginx Proxy Manager admin password"
  type        = string
  sensitive   = true
}

variable "letsencrypt_email" {
  description = "Email address used for Let's Encrypt certificate registration/notifications"
  type        = string
}

variable "dell_host" {
  description = "LAN IP of the dell host - forward target for services running there"
  type        = string
  default     = "10.4.5.201"
}

variable "qnap_host" {
  description = "LAN IP of the qnap host - forward target for services running there"
  type        = string
  default     = "10.4.5.200"
}
