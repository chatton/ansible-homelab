# qnap/dell come from ../common.tfvars, shared across every terraform/*
# project. Not auto-loaded - pass explicitly with -var-file (see `make
# radarr-tf-plan`/`radarr-tf-apply` in the repo root Makefile).
variable "qnap" {
  description = "qnap host LAN IP"
  type        = string
}

variable "dell" {
  description = "dell host LAN IP (unused here, declared for consistency with the shared vars file)"
  type        = string
}

variable "radarr_api_key" {
  description = "Radarr REST API key (from /config/config.xml or Settings > General)"
  type        = string
  sensitive   = true
}

variable "nzbgeek_api_key" {
  description = "NZBgeek indexer API key (from the NZBgeek account page - the Radarr API masks this on read, so it can't be captured automatically)"
  type        = string
  sensitive   = true
}

variable "nzbget_username" {
  description = "NZBGet download client username (must match roles/portainer_arr's nzbget_username vault var)"
  type        = string
  sensitive   = true
}

variable "nzbget_password" {
  description = "NZBGet download client password (must match roles/portainer_arr's nzbget_password vault var)"
  type        = string
  sensitive   = true
}
