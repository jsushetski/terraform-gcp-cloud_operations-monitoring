terraform {
  experiments = [
    module_variable_optional_attrs,
  ]

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.1.7"
}

provider "google" {
  project = var.project
}
