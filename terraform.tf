terraform {
  backend "gcs" {
    bucket = "prom-tfstate"
    prefix = "terraform/state"
  }
}