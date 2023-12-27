variable "GOOGLE_REGION" {
  type        = string
  description = "The Google Cloud region in which to create the GKE cluster."
}

variable "GOOGLE_PROJECT" {
  type        = string
  description = "The Google Cloud project in which to create the GKE cluster."
}

variable "GKE_NUM_NODES" {
  type        = number
  description = "The number of nodes to create in the GKE cluster."
}

variable "GKE_MACHINE_TYPE" {
  type        = string
   description = "Machine type"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  description = "GKE cluster name"
}
