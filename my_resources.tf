resource "github_repository_file" "ns" {
  repository          = var.FLUX_GITHUB_REPO
  branch              = "main"
  file                = "clusters/demo/ns.yaml"
  content             = file("${path.module}/clusters/demo/ns.yaml")

  commit_message      = "Managed by Terraform"
  commit_author       = var.GITHUB_OWNER
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [ module.flux_boostrap ]
}

resource "github_repository_file" "kbot-repo" {
  repository          = var.FLUX_GITHUB_REPO
  branch              = "main"
  file                = "clusters/demo/kbot-repo.yaml"
  content             = file("${path.module}/clusters/demo/kbot-repo.yaml")

  commit_message      = "Managed by Terraform"
  commit_author       = var.GITHUB_OWNER
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [ github_repository_file.ns ]
}

resource "github_repository_file" "kbot-helm" {
  repository          = var.FLUX_GITHUB_REPO
  branch              = "main"
  file                = "clusters/demo/kbot-helm.yaml"
  content             = file("${path.module}/clusters/demo/kbot-helm.yaml")

  commit_message      = "Managed by Terraform"
  commit_author       = var.GITHUB_OWNER
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
  depends_on = [ github_repository_file.kbot-repo ]
}