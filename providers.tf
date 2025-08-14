terraform {
  required_version = ">= 1.0"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 5.3.0"
    }
  }
}