provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
}

terraform {
  backend "gcs" {
    bucket      = "altschool-tfstate"
    prefix      = "terraform/state"
    credentials = "../.secrets/serviceaccount.json"
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.27.0"
    }
  }

  required_version = ">= 0.14"
}
