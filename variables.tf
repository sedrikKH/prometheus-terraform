variable "GOOGLE_REGION" {
  type        = string
  description = "The Google Cloud region in which to create the GKE cluster."
}

variable "GOOGLE_PROJECT" {
  type        = string
  default = "us-central1-c"
  description = "The Google Cloud project in which to create the GKE cluster."
}

variable "GKE_NUM_NODES" {
  type        = number
  default = 2
  description = "The number of nodes to create in the GKE cluster."
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default = "g1-small"
  description = "Machine type"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default = "test"
  description = "GKE cluster name"
}

variable "GITHUB_OWNER" {
  type = string
  description = "Github owner repo to use"
}

variable "GITHUB_TOKEN" {
  type = string
  description = "Github personal access token"
}

variable "FLUX_GITHUB_REPO" {
  type = string
  default = "flux-gitops"
  description = "Flux Gitops repo"
}

variable "FLUX_GITHUB_TARGET_PATH" {
  type = string
  default = "clusters"
  description = "Flux manifest subdirectory"
  
}