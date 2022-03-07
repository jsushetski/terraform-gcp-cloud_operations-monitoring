terraform {
  experiments = [
    module_variable_optional_attrs,
  ]

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.65"
    }
  }
}

provider "google" {
  project = var.project
}
