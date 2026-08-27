terraform {
  required_version = ">= 1.0"

  required_providers {
    nginxproxymanager = {
      source  = "Sander0542/nginxproxymanager"
      version = "~> 1.3"
    }
  }
}
