terraform {
  backend "gcs" {
    bucket = "prom-tfstate"
    prefix = "terraform/state"
  }
}


module "gke_cluster" {
  source         = "github.com/sedrikKH/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = var.GKE_NUM_NODES
  GKE_MACHINE_TYPE    = var.GKE_MACHINE_TYPE
  GKE_CLUSTER_NAME    = var.GKE_CLUSTER_NAME
  }
