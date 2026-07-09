provider "github" {
  owner = local.github_organization
  app_auth {
    id              = local.app_id
    installation_id = local.app_installation_id
    pem_file        = var.app_pem_file
  }
}