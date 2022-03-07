terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.12"
    }
  }
}

provider "google" {
  project = var.project
}
