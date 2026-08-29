terraform {
  required_version = ">= 1.0"

  required_providers {
    sonarr = {
      source  = "devopsarr/sonarr"
      version = "~> 3.5"
    }
  }
}
