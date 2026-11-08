
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "healthconnect-project-7009"
  region  = "us-central1"
}

resource "google_storage_bucket" "test_bucket" {
  name          = "healthconnect-test-bucket-7009"
  location      = "US"
  force_destroy = true
}
