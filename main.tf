module "github_repository" {
  #source = "github.com/den-vasyliev/tf-github-repository"
  source = "./modules/github_repository"
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
#   source         = "github.com/den-vasyliev/tf-google-gke-cluster?ref=gke_auth"
#   GOOGLE_REGION  = var.GOOGLE_REGION
#   GOOGLE_PROJECT = var.GOOGLE_PROJECT
#   GKE_NUM_NODES  = var.GKE_NUM_NODES
#   GKE_MACHINE_TYPE    = var.GKE_MACHINE_TYPE
#   GKE_CLUSTER_NAME    = var.GKE_CLUSTER_NAME
#   }


module "flux_boostrap" {
  # For GKE cluster
  # source = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap?ref=gke_auth"
  # config_host       = module.gke_cluster.config_host
  # config_token       = module.gke_cluster.config_token
  # config_ca         = module.gke_cluster.config_ca
  
  # For kind cluster
  source = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap?ref=kind_auth"
  config_host       = module.kind_cluster.endpoint
  config_client_key = module.kind_cluster.client_key
  config_ca         = module.kind_cluster.ca
  config_crt        = module.kind_cluster.crt
  
  
  github_repository = "${var.GITHUB_OWNER}/${module.github_repository.name}"
  #github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key = module.tls_private_key.private_key_pem
  github_token      = var.GITHUB_TOKEN
  #config_path = module.gke_cluster.gke_auth.kubeconfig_raw

}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"  
  algorithm = "RSA"
}

