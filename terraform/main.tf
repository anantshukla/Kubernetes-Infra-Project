terraform {
    backend "gcs" { 
      bucket  = "terraform-state-k8s-playfield"
      prefix  = "prod"
    }
}

provider "google" {
  project     = "k8s-playfield"
  region      = "us-west1"
}
