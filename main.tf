# terraform {
#   backend "gcs" {
#     bucket = "prom-tfstate"
#     prefix = "terraform/state"
#   }
# }

module "github_repository" {
  source = "github.com/den-vasyliev/tf-github-repository"
  github_owner = var.GITHUB_OWNER
  github_token = var.GITHUB_TOKEN
  repository_name = var.FLUX_GITHUB_REPO
  public_key_openssh = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}


module "kind_cluster" {
  source = "github.com/den-vasyliev/tf-kind-cluster?ref=cert_auth"
}

# module "gke_cluster" {
#   source         = "github.com/sedrikKH/tf-google-gke-cluster"
#   GOOGLE_REGION  = var.GOOGLE_REGION
#   GOOGLE_PROJECT = var.GOOGLE_PROJECT
#   GKE_NUM_NODES  = var.GKE_NUM_NODES
#   GKE_MACHINE_TYPE    = var.GKE_MACHINE_TYPE
#   GKE_CLUSTER_NAME    = var.GKE_CLUSTER_NAME
#   }


module "flux_boostrap" {
  source = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap?ref=kind_auth"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key = module.tls_private_key.private_key_pem
  config_host       = module.kind_cluster.endpoint
  config_client_key = module.kind_cluster.client_key
  config_ca         = module.kind_cluster.ca
  config_crt        = module.kind_cluster.crt
  github_token      = var.GITHUB_TOKEN
  #config_path = module.gke_cluster.kubeconfig
}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"  
  algorithm = "RSA"
}
