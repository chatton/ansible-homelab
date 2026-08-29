terraform {
  required_version = ">= 1.0"

  required_providers {
    radarr = {
      source  = "devopsarr/radarr"
      version = "~> 2.5"
    }
  }
}
